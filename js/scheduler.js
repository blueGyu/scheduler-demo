document.addEventListener("DOMContentLoaded", () => {
  const { searchParams } = new URL(window.location.href);

  const date_str = searchParams.get("date");
  const date = new Date(date_str);
  date.setUTCHours(0);
  date.setUTCMinutes(0);
  date.setUTCSeconds(0);

  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");

  // 월단위 선택 버튼 생성
  const monthArray = [];
  for (let i = 0; i < 12; i++) {
    const a = document.createElement("a");
    a.innerHTML = `${i + 1} 월`;
    a.className = "month-btn";
    a.href = `/src/scheduler/schedulerPage.jsp?date=${year}-${String(i + 1).padStart(
      2,
      "0"
    )}-${day}&showAll=${searchParams.get("showAll")}`;

    if (date.getMonth() === i) {
      a.classList.add("this-month");
    }

    monthArray.push(a);
  }

  document.getElementById("select-month-wrap").append(...monthArray);

  // 금일 하이라이트 표시
  const today = new Date();
  const todayYear = today.getFullYear();
  const todayMonth = String(today.getMonth() + 1).padStart(2, "0");
  const todayDay = String(today.getDate()).padStart(2, "0");

  const todaySchedule = document.querySelector(
    `a[data-date='${todayYear}-${todayMonth}-${todayDay}']`
  );
  if (todaySchedule) {
    todaySchedule.classList.add("today");
  }
});
