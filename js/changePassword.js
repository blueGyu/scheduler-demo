import { checkConfirmReturnElem } from "./commonCheckForm.js";
import { passwordCapitalRegex, passwordSpeicalRegex } from "./regex.js";

document.getElementById("password").addEventListener("change", (event) => {
  const { value } = event.target;

  const lengthCondition = document.getElementById("length-condition");
  const lengthIcon = lengthCondition.children[0];
  if (value.length < 8 || value.length > 32) {
    lengthCondition.className = "err";
    lengthIcon.innerHTML = "✕";
  } else {
    lengthCondition.className = "succ";
    lengthIcon.innerHTML = "✔";
  }

  const capitalCondition = document.getElementById("capital-condition");
  const capitalIcon = capitalCondition.children[0];
  if (!passwordCapitalRegex.test(value)) {
    capitalCondition.className = "err";
    capitalIcon.innerHTML = "✕";
  } else {
    capitalCondition.className = "succ";
    capitalIcon.innerHTML = "✔";
  }

  const specialCondition = document.getElementById("special-condition");
  const specialIcon = specialCondition.children[0];
  if (!passwordSpeicalRegex.test(value)) {
    specialCondition.className = "err";
    specialIcon.innerHTML = "✕";
  } else {
    specialCondition.className = "succ";
    specialIcon.innerHTML = "✔";
  }
});

document.getElementById("confirm").addEventListener("change", (event) => {
  const msgElem = checkConfirmReturnElem(event);

  if (msgElem) {
    event.target.insertAdjacentElement("afterend", msgElem);
  }
});

document.querySelector("form").addEventListener("submit", (event) => {
  event.preventDefault();

  // 비밀번호 입력칸 확인
  // TODO: 회원가입, 로그인, 비밀번호 변경에서 사용할 수 있도록 리펙터링 확인하기
  const passwordValue = document.getElementById("password").value;
  let passwordErrElem = 0;
  const lengthCondition = document.getElementById("length-condition");
  const lengthIcon = lengthCondition.children[0];
  if (passwordValue.length < 8 || passwordValue.length > 32) {
    lengthCondition.className = "err";
    lengthIcon.innerHTML = "✕";
    passwordErrElem = 1;
  } else {
    lengthCondition.className = "succ";
    lengthIcon.innerHTML = "✔";
  }

  const capitalCondition = document.getElementById("capital-condition");
  const capitalIcon = capitalCondition.children[0];
  if (!passwordCapitalRegex.test(passwordValue)) {
    capitalCondition.className = "err";
    capitalIcon.innerHTML = "✕";
    passwordErrElem = 1;
  } else {
    capitalCondition.className = "succ";
    capitalIcon.innerHTML = "✔";
  }

  const specialCondition = document.getElementById("special-condition");
  const specialIcon = specialCondition.children[0];
  if (!passwordSpeicalRegex.test(passwordValue)) {
    specialCondition.className = "err";
    specialIcon.innerHTML = "✕";
    passwordErrElem = 1;
  } else {
    specialCondition.className = "succ";
    specialIcon.innerHTML = "✔";
  }

  // 비밀번호 확인 입력칸 확인
  const confirmElem = document.getElementById("confirm");
  const confirmErrElem = checkConfirmReturnElem(confirmElem.value);
  if (confirmErrElem) {
    confirmElem.insertAdjacentElement("afterend", confirmErrElem);
  }

  if (passwordErrElem || confirmErrElem) {
    return false;
  }

  return true;
});
