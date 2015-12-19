var noticeTimeout = null;
function updateFlash(notice_html_safe) {
  $('#notice').html(notice_html_safe).css({'display':'block'})
  if (noticeTimeout != null) {
    clearTimeout(noticeTimeout);
    noticeTimeout = null;
  }
  var noticeTimeout = setTimeout(function() {
    $('#notice').fadeOut(500);
  }, 5000);
}
