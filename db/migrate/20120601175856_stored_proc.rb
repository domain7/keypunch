class StoredProc < ActiveRecord::Migration
  def up
    execute <<-SQL
    CREATE EXTENSION IF NOT EXISTS pgcrypto;

    CREATE OR REPLACE FUNCTION entities_safe() RETURNS trigger AS
    $body$
    DECLARE
      V_ENC_KEY bytea;
    BEGIN
      SELECT INTO V_ENC_KEY key FROM pgp_keys ORDER BY id DESC LIMIT 1;
      IF (TG_OP = 'INSERT' OR NEW.password <> OLD.password) THEN
        NEW.password = armor(pgp_pub_encrypt(NEW.password, V_ENC_KEY));
      END IF;
      RETURN NEW;
    END;
    $body$ LANGUAGE plpgsql;

    CREATE TRIGGER entities_safe BEFORE INSERT OR UPDATE ON entities FOR EACH ROW EXECUTE PROCEDURE entities_safe();
    SQL
    #MOVED THIS TO THE rake task  rake keypunch:install
    #PgpKeys.new_key('KEYPUNCH SERVER', 'support@example.com')
  end

  def down
    execute <<-SQL
    DROP TRIGGER entities_safe ON entities;
    DROP FUNCTION entities_safe();
    SQL
  end
end
