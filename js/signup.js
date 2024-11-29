import {
  checkIdReturnElem,
  checkConfirmReturnElem,
  checkEmailReturnElem,
  checkNameReturnElem,
  checkPhoneReturnElem,
} from "./commonCheckForm.js";
import { passwordCapitalRegex, passwordSpeicalRegex } from "./regex.js";

document.getElementById("id").addEventListener("change", (event) => {
  const msgElem = checkIdReturnElem(event);

  if (msgElem) {
    event.target.insertAdjacentElement("afterend", msgElem);
  }
});

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

document.getElementById("email").addEventListener("change", (event) => {
  const msgElem = checkEmailReturnElem(event);

  if (msgElem) {
    event.target.insertAdjacentElement("afterend", msgElem);
  }
});

// 부서 셀렉트 박스
document.getElementById("select-department").addEventListener("click", (event) => {
  const dropdown = document.getElementById("department-dropdown");
  dropdown.classList.toggle("hidden");

  const arrow = document.getElementById("department-arrow");
  arrow.classList.toggle("arrow");
});

// 부서 드랍다운 메뉴
document.querySelectorAll("#department-dropdown li").forEach((li) => {
  li.addEventListener("click", (event) => {
    // 이벤트 버블링 제거
    event.stopPropagation();

    // 드롭다운 메뉴 숨기기
    const dropdown = document.getElementById("department-dropdown");
    dropdown.classList.add("hidden");

    const arrow = document.getElementById("department-arrow");
    arrow.classList.add("arrow");

    // 부서 선택값 input에 넣기
    document.getElementById("department").value = event.target.dataset.department;

    // 부서 선택값 표시
    document.querySelector("#select-department > p").innerHTML = event.target.innerHTML;

    // 부서 미선택 안내 메시지 삭제
    const errMsg = document.getElementById("department_err_msg");
    if (errMsg) {
      errMsg.remove();
    } else if (errMsg && document.getElementById("department").value !== "0") {
      errMsg.remove();
    }

    // 부서 선택값이 0이라면 안내 메시지 표시
    const departmentValue = document.getElementById("department").value;
    if (departmentValue === "0") {
      const span = document.createElement("span");
      span.id = "department_err_msg";
      span.className = "err";
      span.innerHTML = "부서를 선택해주세요.";
      document
        .getElementById("select-department")
        .insertAdjacentElement("afterend", span);
    }
  });
});

// 직급 셀렉트 박스
document.getElementById("select-rank").addEventListener("click", () => {
  const dropdown = document.getElementById("rank-dropdown");
  dropdown.classList.toggle("hidden");

  const arrow = document.getElementById("rank-arrow");
  arrow.classList.toggle("arrow");
});

// 직급 드롭다운 메뉴
document.querySelectorAll("#rank-dropdown li").forEach((li) => {
  li.addEventListener("click", (event) => {
    // 이벤트 버블링 제거
    event.stopPropagation();

    // 드롭다운 메뉴 숨기기
    const dropdown = document.getElementById("rank-dropdown");
    dropdown.classList.add("hidden");

    const arrow = document.getElementById("rank-arrow");
    arrow.classList.add("arrow");

    // 직급 선택값 input에 값 넣기
    document.getElementById("rank").value = event.target.dataset.rank;

    // 직급 선택값 표시
    document.querySelector("#select-rank > p").innerHTML = event.target.innerHTML;

    // 직급 미선택 안내 메시지 삭제
    const errMsg = document.getElementById("rank_err_msg");
    if (errMsg) {
      errMsg.remove();
    } else if (errMsg && document.getElementById("rank").value !== "0") {
      errMsg.remove();
    }

    // 직급 선택값이 0이라면 안내 메시지 표시
    const rankValue = document.getElementById("rank").value;
    if (rankValue === "0") {
      const span = document.createElement("span");
      span.id = "rank_err_msg";
      span.className = "err";
      span.innerHTML = "직급을 선택해주세요.";
      document.getElementById("select-rank").insertAdjacentElement("afterend", span);
    }
  });
});

// 드롭다운 이외 영역 클릭 시 드롭다운 닫기
document.addEventListener("click", (event) => {
  const selectDepartmentPart = document.getElementById("select-department");
  if (!selectDepartmentPart.contains(event.target)) {
    document.getElementById("department-dropdown").classList.add("hidden");
    document.getElementById("department-arrow").classList.add("arrow");
  }
  const selectRankPart = document.getElementById("select-rank");
  if (!selectRankPart.contains(event.target)) {
    document.getElementById("rank-dropdown").classList.add("hidden");
    document.getElementById("rank-arrow").classList.add("arrow");
  }
});

document.getElementById("name").addEventListener("change", (event) => {
  const msgElem = checkNameReturnElem(event);

  if (msgElem) {
    const target = document.getElementById("name");
    target.insertAdjacentElement("afterend", msgElem);
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

  // 아이디 입력칸 확인
  const idElem = document.getElementById("id");
  const idErrElem = checkIdReturnElem(idElem.value);
  if (idErrElem) {
    idElem.insertAdjacentElement("afterend", idErrElem);
  }

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

  // 이메일 입력칸 확인
  const emailElem = document.getElementById("email");
  const emailErrElem = checkEmailReturnElem(emailElem.value);
  if (emailErrElem) {
    emailElem.insertAdjacentElement("afterend", emailErrElem);
  }
  // 부서 미선택 안내 메시지 삭제
  const departmentErrElem = document.getElementById("department_err_msg");
  if (departmentErrElem) {
    departmentErrElem.remove();
  }

  // 부서 선택칸 확인
  const departmentValue = document.getElementById("department").value;
  if (departmentValue === "0") {
    const span = document.createElement("span");
    span.id = "department_err_msg";
    span.className = "err";
    span.innerHTML = "부서를 선택해주세요.";
    document.getElementById("select-department").insertAdjacentElement("afterend", span);
  }

  // 직급 미선택 안내 메시지 삭제
  const rankErrElem = document.getElementById("rank_err_msg");
  if (rankErrElem) {
    rankErrElem.remove();
  }

  // 직급 선택칸 확인
  const rankValue = document.getElementById("rank").value;
  if (rankValue === "0") {
    const span = document.createElement("span");
    span.id = "rank_err_msg";
    span.className = "err";
    span.innerHTML = "직급을 선택해주세요.";
    document.getElementById("select-rank").insertAdjacentElement("afterend", span);
  }

  // 이름 입력칸 확인
  const nameElem = document.getElementById("name");
  const nameErrElem = checkNameReturnElem(nameElem.value);
  if (nameErrElem) {
    nameElem.insertAdjacentElement("afterend", nameErrElem);
  }

  // 전화번호 입력칸 확인
  const phoneElem = document.getElementById("phone");
  const phoneErrElem = checkPhoneReturnElem(phoneElem.value);
  if (phoneErrElem) {
    phoneElem.insertAdjacentElement("afterend", phoneErrElem);
  }

  if (
    idErrElem ||
    passwordErrElem ||
    confirmErrElem ||
    departmentValue === "0" ||
    rankValue === "0" ||
    nameErrElem ||
    phoneErrElem
  ) {
    return false;
  }

  event.target.submit();
});
