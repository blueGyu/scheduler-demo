import { checkIdReturnElem, checkPasswordReturnElem } from "./commonCheckForm.js";

document.getElementById("id").addEventListener("change", (event) => {
  const msgElem = checkIdReturnElem(event);

  if (msgElem) {
    event.target.insertAdjacentElement("afterend", msgElem);
  }
});

document.getElementById("password").addEventListener("change", (event) => {
  const msgElem = checkPasswordReturnElem(event);

  if (msgElem) {
    event.target.insertAdjacentElement("afterend", msgElem);
  }
});

document.querySelector("form").addEventListener("submit", (event) => {
  event.preventDefault();

  const idElem = document.getElementById("id");
  const idErrElem = checkIdReturnElem(idElem.value);
  if (idErrElem) {
    idElem.insertAdjacentElement("afterend", idErrElem);
  }

  const passwordElem = document.getElementById("password");
  const passwordErrElem = checkPasswordReturnElem(passwordElem.value);
  if (passwordErrElem) {
    passwordElem.insertAdjacentElement("afterend", passwordErrElem);
  }

  if (passwordErrElem || idErrElem) {
    return false;
  }

  return true;
});
