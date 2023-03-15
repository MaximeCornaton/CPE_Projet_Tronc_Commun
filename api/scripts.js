document.getElementById('btn-up').addEventListener('click', function() {
    sendMove('up');
});

document.getElementById('btn-down').addEventListener('click', function() {
    sendMove('down');
});

document.getElementById('btn-right').addEventListener('click', function() {
    sendMove('right');
});

document.getElementById('btn-left').addEventListener('click', function() {
    sendMove('left');
});

document.addEventListener('keydown', function(event) {
    switch (event.key) {
        case 'z':
            sendMove('up');
            break;
        case 's':
            sendMove('down');
            break;
        case 'q':
            sendMove('left');
            break;
        case 'd':
            sendMove('right');
            break;
    }
});


function sendMove(direction) {
  // Requête GET
  // fetch('http://localhost:3000')
  //   .then(response => response.text())
  //   .then(data => {
  //     console.log(data);
  //   })
  //   .catch(error => {
  //     console.error('Error:', error);
  //   });

  // // Requête POST avec des données
  // const data = {
  //   key: 'value'
  // };

  const data = {
    direction: direction
  };

  fetch('http://localhost:3000/data', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(data)
  })
    .then(response => response.text())
    .then(data => {
      console.log(data);
    })
    .catch(error => {
      console.error('Error:', error);
    });

}