window.SpeechRecognition = window.webkitSpeechRecognition || window.SpeechRecognition;

if ('SpeechRecognition' in window) {
  console.log("supported")


} else {
  // speech recognition API not supported
  console.log("Not supported")
}


// speech recognition API supported

const recognition = new window.SpeechRecognition();



recognition.onresult = (event) => {
  const speechToText = event.results[0][0].transcript;
    console.log(speechToText);
}
recognition.start();
