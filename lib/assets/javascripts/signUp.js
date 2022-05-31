document.addEventListener("DOMContentLoaded", function(e) {  
  e.preventDefault(); 
    document.querySelector('#nextStage').addEventListener('click', function(e) {
      e.preventDefault();
      document.querySelector('#stageOne').classList.add('d-none');
      document.querySelector('#stageTwo').classList.remove('d-none');
    });
  });