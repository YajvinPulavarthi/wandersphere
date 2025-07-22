function validateSelection() {
  const source = document.getElementById("source").value;
  const destination = document.getElementById("destination").value;

  if (source === destination) {
    alert("Source and destination cannot be the same!");
    return false;
  }
  return true;
}

function goBack() {
  window.history.back();
}

function logout() {
  window.location.href = "dashboard.jsp"; // change to your logout path if needed
}
/**
 * 
 *//**
 * 
 */