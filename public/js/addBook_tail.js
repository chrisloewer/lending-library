window.onload = function() {
  document.getElementById('submitButton').addEventListener('click', function() {
    var input = document.getElementById('isbnInput').value;
    insertTemplateByPath('add_book_form', 'add_book_form', '/api/google-api/isbn-info?isbn='+input);
  });

  document.getElementById('scanButton').addEventListener('click', function() {
    document.getElementById('scan_barcode_lightbox').style.visibility = "visible";

    Quagga.init(
      {
        decoder: {
            drawBoundingBox: true,
            readers: ['ean_reader']
        }
      },
      function(error) {
        if(error) {
            console.log(error);
            return;
        }
        console.log("Starting Quagga...");

        Quagga.start();
        var previousCode = "";
        Quagga.onDetected(function(data) {
                            if(data.codeResult.code != previousCode) {
                                previousCode = data.codeResult.code;
                                alert(previousCode);
                            }
                        });
      }
    );
  });

  document.getElementById('closeLightboxButton').addEventListener('click', function() {
    document.getElementById('scan_barcode_lightbox').style.visibility = "hidden";

    Quagga.stop();
  })
};
