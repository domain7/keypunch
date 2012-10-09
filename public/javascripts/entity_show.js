(function() {
  var ns = kp.namespace("kp.entities");

  ns.show = function() {
    var $button, $pwd, timeout;

    var constructor = function(init) {
      $button = $(init.button);
      $pwd = $(init.pwd);
      _bind_show();
    }

    var _bind_show = function() {
      $button.bind('click.show.entity.kp', function(evt) {
        _xhr($(evt.target));
        return false;
      }).html('Show');
    }

    var _bind_hide = function() {
      $button.bind('click.show.entity.kp', function(evt) {
        _hide();
        $button.unbind('click.show.entity.kp');
        _bind_show();
        return false;
      }).html('Hide');
    }

    var _hide = function() {
      $pwd.val('****************');
      clearTimeout(timeout);
    }

    var _xhr = function($elm) {
      $.ajax({
        url: e_path + '.json',
        cache: false,
        success: function(passwd) {
          $pwd.val(passwd);
          $pwd.focus().select();
          $button.unbind('click.show.entity.kp');
          _bind_hide();
          timeout = setTimeout(function(){
            _hide();
            $button.unbind('click.show.entity.kp');
            _bind_show();
          }, 15000);
        }
      });
    }

    return constructor;
  }
})();

$(function(){
  var setup_show = new kp.entities.show();

  setup_show({
    button: '#get_passwd',
    pwd: '#cpasswd'
  });
});
