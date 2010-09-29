/* 
 * based on:
 * jQuery jqEasyCharCounter plugin (http://www.jqeasy.com/)
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */
(function($) {

$.fn.extend({
  jqCounter: function(givenOptions) {
    return this.each(function() {
      var $this = $(this),
        options = $.extend({
        maxChars        : 100,
        maxCharsWarning : 80,
        msgClass        : 'notice',
        msgWarningClass : 'warning',
        msgAppendMethod : 'insertBefore'
      }, givenOptions);

      if(options.maxChars <= 0) return;

      var jqCounterMsg = $("<div class=\"jqCounterMsg\">&nbsp;</div>");

      jqCounterMsg.css({'opacity':0});
      jqCounterMsg[options.msgAppendMethod]($this);

      $this
        .bind('keydown keyup keypress', doCount)
        .bind('focus paste', function(){setTimeout(doCount, 10);})
        .bind('blur', function(){jqCounterMsg.stop().fadeTo('fast', 0);return false;});

      function doCount(){
        var length = $this.val().length

        if (length > options.maxCharsWarning){
          jqCounterMsg.removeClass(options.msgClass);
          jqCounterMsg.addClass(options.msgWarningClass);
        } else {
          jqCounterMsg.removeClass(options.msgWarningClass);
          jqCounterMsg.addClass(options.msgClass);
        };

        jqCounterMsg.html($this.val().length + "/" + options.maxChars);
        jqCounterMsg.stop().fadeTo('fast', 1);
      };
    });
  }
});

})(jQuery);