class PasswordStrengthValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    return true if value.blank?
    if !value.to_s.match(/\A.*(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).*\z/)
      record.errors[attribute] << "must contain at least one uppercase letter, at least one lower case letter and at least one number"
    end
  end
end
