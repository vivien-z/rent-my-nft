const setActiveOnclick = () => {
  const url = window.location.href;
  $(".navbar-nav .nav-link").each(function () {
    if (url == (this.href)) {
      $('li.active').removeClass('active');
      $(this).closest("li").addClass("active");
    }
  });
};

export { setActiveOnclick };