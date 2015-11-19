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

        Quagga.onProcessed(function(result) {
          var drawingCtx = Quagga.canvas.ctx.overlay,
              drawingCanvas = Quagga.canvas.dom.overlay;

          if (result) {
            if (result.boxes) {
              drawingCtx.clearRect(0, 0, parseInt(drawingCanvas.getAttribute("width")), parseInt(drawingCanvas.getAttribute("height")));
              result.boxes.filter(function (box) {
                return box !== result.box;
              }).forEach(function (box) {
                Quagga.ImageDebug.drawPath(box, {x: 0, y: 1}, drawingCtx, {color: "green", lineWidth: 2});
              });
            }

            if (result.box) {
              Quagga.ImageDebug.drawPath(result.box, {x: 0, y: 1}, drawingCtx, {color: "#00F", lineWidth: 2});
            }

            if (result.codeResult && result.codeResult.code) {
              Quagga.ImageDebug.drawPath(result.line, {x: 'x', y: 'y'}, drawingCtx, {color: 'red', lineWidth: 3});
            }
          }
        });

        Quagga.onDetected(function(data) {
          var input = data.codeResult.code;
          document.getElementById('isbnInput').value = input;
          insertTemplateByPath('add_book_form', 'add_book_form', '/api/google-api/isbn-info?isbn='+input);
      }
    );
  });

  document.getElementById('closeLightboxButton').addEventListener('click', function() {
    document.getElementById('scan_barcode_lightbox').style.visibility = "hidden";

    Quagga.stop();
  })
};
