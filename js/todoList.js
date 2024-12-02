//페이지 로딩 시 생성
document.addEventListener("DOMContentLoaded", () => {
  // 일정 추가 form에 시간단위 선택 드롭다운 생성
  const hourArray = createHourDropdownComponentArray();
  document.querySelector("#add-select-hour > ul").append(...hourArray);

  // 일정 추가 form에 분단위 선택 드롭다운 생성
  const minuteArray = createMinutteDropdownComponentArray();
  document.querySelector("#add-select-minute > ul").append(...minuteArray);
});

// 드롭다운 이외 영역 클릭 시 드롭다운 닫기
document.addEventListener("click", (event) => {
  if (!document.getElementById("add-select-hour").contains(event.target)) {
    document.querySelector("#add-select-hour > ul").classList.add("hidden");
  }

  if (!document.getElementById("add-select-minute").contains(event.target)) {
    document.querySelector("#add-select-minute > ul").classList.add("hidden");
  }
});

// 시간단위 선택 드롭다운
document.getElementById("add-select-hour").addEventListener("click", (event) => {
  document.querySelector("#add-select-hour > ul").classList.toggle("hidden");

  if (event.target.dataset.hour) {
    document.querySelector("#add-select-hour > p").innerHTML = event.target.dataset.hour;
    document.getElementById("hour").value = event.target.dataset.hour;
  }
});

// 분단위 선택 드롭다운
document.getElementById("add-select-minute").addEventListener("click", (event) => {
  document.querySelector("#add-select-minute > ul").classList.toggle("hidden");

  if (event.target.dataset.minute) {
    document.querySelector("#add-select-minute > p").innerHTML =
      event.target.dataset.minute;
    document.getElementById("minute").value = event.target.dataset.minute;
  }
});

// 수정 버튼 클릭 시 수정 컴포넌트로 기존 컴포넌트 대체
document.querySelectorAll("button.edit").forEach((button) => {
  button.onclick = (event) => {
    // const { id, start, content, showAll } = event.target.dataset;
    const li = document.querySelector(`li[data-id='${event.target.dataset.id}']`);
    // 리스트 초기화
    li.innerHTML = "";
    li.appendChild(createEditCoponent({ ...event.target.dataset }));
  };
});

// 일정추가 form submit 이벤트처리
document
  .getElementById("add-form")
  .addEventListener("submit", (event) => formSubmitEvent(event));

// 수정 컴포넌트 생성
function createEditCoponent({ id, start, content, showall }) {
  // 날짜 -> 시간, 분 나누기;
  const date = new Date(start);
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");
  const hour = String(date.getHours()).padStart(2, "0");
  const minute = String(date.getMinutes()).padStart(2, "0");

  const form = document.createElement("form");
  form.id = `edit-form-${id}`;
  form.action = "todoListEditAction.jsp";
  form.method = "get";
  form.onsubmit = (event) => formSubmitEvent(event);

  const timeSelector = document.createElement("div");
  timeSelector.className = "time-seletor";

  // 입력값 hidden
  const idInput = document.createElement("input");
  idInput.className = "hidden";
  idInput.name = "schedule_id";
  idInput.type = "text";
  idInput.value = id;

  const dateInput = document.createElement("input");
  dateInput.className = "hidden";
  dateInput.name = "date";
  dateInput.type = "text";
  dateInput.value = `${year}-${month}-${day}`;

  const showAllInput = document.createElement("input");
  showAllInput.className = "hidden";
  showAllInput.name = "showAll";
  showAllInput.type = "text";
  showAllInput.value = showall;

  const hourInput = document.createElement("input");
  hourInput.className = "hidden";
  hourInput.name = "hour";
  hourInput.type = "text";
  hourInput.value = hour;
  hourInput.dataset.id = id;

  const minuteInput = document.createElement("input");
  minuteInput.className = "hidden";
  minuteInput.name = "minute";
  minuteInput.type = "text";
  minuteInput.value = minute;
  minuteInput.dataset.id = id;

  const selectorWrap = document.createElement("div");
  selectorWrap.className = "select-box-wrap";

  // 시간단위 선택 박스
  const hourSelector = document.createElement("div");
  hourSelector.id = `edit-select-hour-${id}`;
  hourSelector.className = "select-box";
  hourSelector.onclick = (event) => {
    document.querySelector(`#${hourSelector.id} > ul`).classList.toggle("hidden");
    // 시간단위 토글
    if (event.target.dataset.hour) {
      document.querySelector(`#${hourSelector.id} > p`).innerHTML =
        event.target.dataset.hour;
      document.querySelector(`input[name='hour'][data-id='${id}']`).value =
        event.target.dataset.hour;
    }
  };

  const hourP = document.createElement("p");
  hourP.innerHTML = String(date.getHours()).padStart(2, "0");

  const hourUl = document.createElement("ul");
  hourUl.className = "dropdown-menu hidden";

  hourUl.append(...createHourDropdownComponentArray());

  const hourArrow = document.createElement("div");
  hourArrow.className = "arrow";
  hourArrow.innerHTML = "⏏︎";

  hourSelector.append(hourP, hourUl, hourArrow);

  // 분댠위 선택 박스
  const minuteSelector = document.createElement("div");
  minuteSelector.id = `edit-select-minute-${id}`;
  minuteSelector.className = "select-box";
  minuteSelector.onclick = (event) => {
    document.querySelector(`#${minuteSelector.id} > ul`).classList.toggle("hidden");
    // 시간단위 토글
    if (event.target.dataset.minute) {
      document.querySelector(`#${minuteSelector.id} > p`).innerHTML =
        event.target.dataset.minute;
      document.querySelector(`input[name='minute'][data-id='${id}']`).value =
        event.target.dataset.minute;
    }
  };

  const minuteP = document.createElement("p");
  minuteP.innerHTML = String(date.getMinutes()).padStart(2, "0");

  const minuteUl = document.createElement("ul");
  minuteUl.className = "dropdown-menu hidden";

  minuteUl.append(...createMinutteDropdownComponentArray());

  const minuteArrow = document.createElement("div");
  minuteArrow.className = "arrow";
  minuteArrow.innerHTML = "⏏︎";

  minuteSelector.append(minuteP, minuteUl, minuteArrow);

  document.addEventListener("click", (event) => {
    if (!hourSelector.contains(event.target)) {
      hourUl.className = "dropdown-menu hidden";
    }

    if (!minuteSelector.contains(event.target)) {
      minuteUl.className = "dropdown-menu hidden";
    }
  });

  selectorWrap.append(hourSelector, ":", minuteSelector);

  const button = document.createElement("button");
  button.className = "primary";
  button.type = "submit";
  button.innerHTML = "수정완료";

  timeSelector.append(selectorWrap, button);

  const textarea = document.createElement("textarea");
  textarea.name = "content";
  textarea.placeholder = "일정을 입력해주세요.";
  textarea.innerHTML = content;

  form.append(
    timeSelector,
    textarea,
    idInput,
    dateInput,
    showAllInput,
    hourInput,
    minuteInput
  );

  return form;
}

// 시간단위 드롭다운 생성
function createHourDropdownComponentArray() {
  const array = [];
  for (let i = 0; i < 24; i++) {
    const li = document.createElement("li");
    li.dataset.hour = i.toString().padStart(2, "0");
    li.innerHTML = i.toString().padStart(2, "0");

    array.push(li);
  }

  return array;
}

// 분단위 드롭다운 생성
function createMinutteDropdownComponentArray() {
  const array = [];
  // 분선택 드롭다운 생성
  for (let i = 0; i < 12; i++) {
    const li = document.createElement("li");
    li.dataset.minute = (i * 5).toString().padStart(2, "0");
    li.innerHTML = (i * 5).toString().padStart(2, "0");

    array.push(li);
  }

  return array;
}

function formSubmitEvent(event) {
  event.preventDefault();

  // form 내부의 textarea 확인
  const contentValue = document.querySelector(`#${event.target.id} > textarea`).value;
  if (!contentValue || contentValue.length > 1000) {
    alert("일정을 확인해주세요.");
    return false;
  } else if (contentValue.length > 1000) {
    alert("일정은 1000자 이내로 입력할 수 있습니다.");
    return false;
  }

  event.target.submit();
}
