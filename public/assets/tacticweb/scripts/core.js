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

        // Página de Fotos [Renomear ou Adicionar um Álbum]
        var id_modal = null;

        $('[data-target="modal-fotos"]').on('click', function() {
            id_modal = $(this).attr('id');
        });

        var m = $(".modal").modal({
            'dismissible': $(m).data('dismissible') ? $(m).data('dismissible') : true,
            'onOpenStart': function() {

                $(m).find('form').resetForm();
                $(m).find('form').find('.input-field').removeClass('error').find('.error').remove();

                id_modal = parseInt(id_modal);

                if (id_modal !== null && /^[0-9]+$/i.test(id_modal)) {
                    Http.get('fotos/' + id_modal, {
                        'data': {
                            'action': 'rename'
                        },
                    }, (response) => {
                        $(m).find('input[type="text"]').val(response.nome).focus().select();
                        $(m).find('input[name="id"]').val(response.id);
                        $(m).find('input[name="_method"]').val('put');
                    });
                } else {

                    setTimeout(function() {

                        $(m).find('input[name="_method"]').val('post');

                        Http.get('fotos', {}, (response) => {

                            $(m).find('input[type="text"]').val('Novo álbum ' + (response.id + 1)).focus().select();

                        });

                    });

                }

            }
        });

    });

}