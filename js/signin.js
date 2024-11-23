import { checkIdReturnElem, checkPasswordReturnElem } from "./commonCheckForm.js";

document.getElementById("id").addEventListener("change", (event) => {
  const msgElem = checkIdReturnElem(event);

  if (msgElem) {
    const target = document.getElementById("id");
    target.insertAdjacentElement("afterend", msgElem);
  }
});

document.getElementById("password").addEventListener("change", (event) => {
  const msgElem = checkPasswordReturnElem(event);

  if (msgElem) {
    const target = document.getElementById("password");
    target.insertAdjacentElement("afterend", msgElem);
  }
});

document.querySelector("form").addEventListener("submit", (event) => {
  event.preventDefault();

  const targetIdElem = document.getElementById("id");
  const idErrElem = checkIdReturnElem(targetIdElem.value);
  if (idErrElem) {
    targetIdElem.insertAdjacentElement("afterend", idErrElem);
  }

  const targetPasswordElem = document.getElementById("password");
  const passwordErrElem = checkPasswordReturnElem(targetPasswordElem.value);
  if (passwordErrElem) {
    targetPasswordElem.insertAdjacentElement("afterend", passwordErrElem);
  }

  if (passwordErrElem || idErrElem) {
    return false;
  }

  return true;
});
