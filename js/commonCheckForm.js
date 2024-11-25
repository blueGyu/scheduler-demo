import {
  idRegex,
  passwordCapitalRegex,
  passwordSpeicalRegex,
  emailRegex,
  nameRegex,
  phoneRegex,
} from "./regex.js";

export function checkIdReturnElem(input) {
  const value = input.target ? input.target.value : input;

  const removeElem = document.getElementById("id_err_msg");
  if (removeElem) {
    removeElem.remove();
  }

  const span = document.createElement("span");
  span.id = "id_err_msg";
  span.className = "err";

  if (value === "") {
    span.innerHTML = "아이디를 확인해주세요.";
    return span;
  } else if (value.length > 20) {
    span.innerHTML = "아이디를 확인해주세요. 최대 20자로 구성되어야합니다.";
    return span;
  } else if (!idRegex.test(value)) {
    span.innerHTML = "아이디를 확인해주세요. 특수문자는 사용할 수 없습니다.";
    return span;
  } else {
    return "";
  }
}

export function checkPasswordReturnElem(input) {
  const value = input.target ? input.target.value : input;

  const removeElem = document.getElementById("pw_err_msg");
  if (removeElem) {
    removeElem.remove();
  }

  const span = document.createElement("span");
  span.id = "pw_err_msg";
  span.className = "err";

  if (value === "") {
    span.innerHTML = "비밀번호를 확인해주세요.";
    return span;
  } else if (value.length < 8 || value.length > 32) {
    span.innerHTML =
      "비밀번호를 확인해주세요. 비밀번호 길이는 최소 8자이상 32자 이하입니다.";
    return span;
  } else if (!passwordCapitalRegex.test(value)) {
    span.innerHTML = "비밀번호를 확인해주세요. 영대문자가 포함되어야합니다.";
    return span;
  } else if (!passwordSpeicalRegex.test(value)) {
    span.innerHTML = "비밀번호를 확인해주세요. 특수문자가 포함되어야합니다.";
    return span;
  } else {
    return "";
  }
}

export function checkConfirmReturnElem(input) {
  const value = input.target ? input.target.value : input;

  const removeElem = document.getElementById("confirm_err_msg");
  if (removeElem) {
    removeElem.remove();
  }

  const span = document.createElement("span");
  span.id = "confirm_err_msg";
  span.className = "err";

  const password = document.getElementById("password").value;
  if (value === password) {
    span.innerHTML = "비밀번호와 일치하지 않습니다.";
    return span;
  } else {
    return "";
  }
}

export function checkEmailReturnElem(input) {
  const value = input.target ? input.target.value : input;

  const removeElem = document.getElementById("email_err_msg");
  if (removeElem) {
    removeElem.remove();
  }

  const span = document.createElement("span");
  span.id = "email_err_msg";
  span.className = "err";

  if (value === "") {
    span.innerHTML = "이메일을 확인해주세요.";
    return span;
  } else if (value.length > 100) {
    span.innerHTML = "이메일을 확인해주세요. 최대 100자로 구성되어야합니다.";
    return span;
  } else if (!emailRegex.test(value)) {
    span.innerHTML = "이메일을 확인해주세요. 이메일 양식에 맞지 않습니다.";
    return span;
  } else {
    return "";
  }
}

export function checkNameReturnElem(input) {
  const value = input.target ? input.target.value : input;

  const removeElem = document.getElementById("name_err_msg");
  if (removeElem) {
    removeElem.remove();
  }

  const span = document.createElement("span");
  span.id = "name_err_msg";
  span.className = "err";

  if (value === "") {
    span.innerHTML = "이름을 확인해주세요.";
    return span;
  } else if (value.length > 10) {
    span.innerHTML = "이름을 확인해주세요. 최대 10자로 구성되어야합니다.";
    return span;
  } else if (!nameRegex.test(value)) {
    span.innerHTML = "이름을 확인해주세요. 특수문자는 사용할 수 없습니다.";
    return span;
  } else {
    return "";
  }
}

export function checkPhoneReturnElem(input) {
  const value = input.target ? input.target.value : input;

  const removeElem = document.getElementById("phone_err_msg");
  if (removeElem) {
    removeElem.remove();
  }

  const span = document.createElement("span");
  span.id = "phone_err_msg";
  span.className = "err";

  if (value === "") {
    span.innerHTML = "전화번호를 확인해주세요.";
    return span;
  } else if (value.length > 11) {
    span.innerHTML = "전화번호를 확인해주세요. 전화번호 양식에 맞지 않습니다.";
    return span;
  } else if (!phoneRegex.test(value)) {
    span.innerHTML = "전화번호를 확인해주세요. 전화번호 양식에 맞지 않습니다.";
    return span;
  } else {
    return "";
  }
}
