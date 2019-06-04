$(document).ready(function() {
  caculateBill();
  $('select[class="rooms-select"]').change(function() {
    caculateBill();
  });

  function parseCurrency(string) {
    return Number(string.replace(/[^0-9.-]+/g,""));
  }

  function showBill(total_rooms, total_bill) {
    var bill = total_rooms+I18n.t('javascripts.reservation.rooms_for')+I18n.toCurrency(total_bill);
    $('#bills').html(bill);
  }

  function lockBookButton() {
    $('#book-button').removeClass('primary').addClass('disable').prop('disabled', true);
  }

  function unLockBookButton() {
    $('#book-button').removeClass('disable').addClass('primary').prop('disabled', false);
  }

  function caculateBill() {
    var total_rooms = 0;
    var total_bill = 0;
    $('select[class="rooms-select"]').each(function() {
      total_rooms += parseInt($(this).val());
      total_bill += parseInt($(this).val()) * parseCurrency($(this).data('price'));
    });
    if (total_rooms) {
      unLockBookButton();
      showBill(total_rooms, total_bill);
    } else {
      lockBookButton();
      $('#bills').html('');
    }
  }
});
