init = () => {

    $(document).ready(function() {

        $('.tipo-pagina').find('input').on('change', function() {
            var value = $(this).val();

            if ($(this).is(':checked')) {
                $('#files_upload').hide();
                $('#galeria').show();
            } else {
                $('#files_upload').show();
                $('#galeria').hide();
            }
        });

        // var md_galeria = $('#modal-galeria').modal({
        //     'onCloseEnd': function() {
        //         md_galeria.find('input:checked').each(function() {
        //             var value = $(this).val();
        //             $(this).parents('form').find(':hidden[name="album[]"]').remove();
        //             $(this).parents('form').append('<input type="hidden" name="album[]" value="' + value + '">');
        //         });
        //     }
        // })

    });

}