import {
  checkIdReturnElem,
  checkEmailReturnElem,
  checkNameReturnElem,
  checkPhoneReturnElem,
} from "./commonCheckForm.js";

document.getElementById("id").addEventListener("change", (event) => {
  const msgElem = checkIdReturnElem(event);

  if (msgElem) {
    event.target.insertAdjacentElement("afterend", msgElem);
  }
});

document.getElementById("email").addEventListener("change", (event) => {
  const msgElem = checkEmailReturnElem(event);

  if (msgElem) {
    event.target.insertAdjacentElement("afterend", msgElem);
  }
});

document.getElementById("name").addEventListener("change", (event) => {
  const msgElem = checkNameReturnElem(event);

  if (msgElem) {
    event.target.insertAdjacentElement("afterend", msgElem);
  }
});

document.getElementById("phone").addEventListener("change", (event) => {
  const msgElem = checkPhoneReturnElem(event);

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

  const emailElem = document.getElementById("email");
  const emailErrElem = checkEmailReturnElem(emailElem.value);
  if (emailErrElem) {
    emailElem.insertAdjacentElement("afterend", emailErrElem);
  }

  const nameElem = document.getElementById("name");
  const nameErrElem = checkNameReturnElem(nameElem.value);
  if (nameErrElem) {
    nameElem.insertAdjacentElement("afterend", nameErrElem);
  }

  const phoneElem = document.getElementById("phone");
  const phoneErrElem = checkPhoneReturnElem(phoneElem.value);
  if (phoneErrElem) {
    phoneElem.insertAdjacentElement("afterend", phoneErrElem);
  }

  if (idErrElem || emailErrElem || nameErrElem || phoneErrElem) {
    return false;
  }

  event.target.submit();
});
