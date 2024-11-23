import { checkIdReturnElem, checkPasswordReturnElem } from "./checkFormEvents.js";

document.getElementById("id").addEventListener("input", (event) => {
  const msgElem = checkIdReturnElem(event);

  if (msgElem) {
    const target = document.getElementById("id");
    target.insertAdjacentElement("afterend", msgElem);
  }
});

document.getElementById("password").addEventListener("input", (event) => {
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
    return false;
  }

  const targetPasswordElem = document.getElementById("password");
  const passwordErrElem = checkPasswordReturnElem(targetPasswordElem.value);
  if (passwordErrElem) {
    targetPasswordElem.insertAdjacentElement("afterend", passwordErrElem);
    return false;
  }

  return true;
});
