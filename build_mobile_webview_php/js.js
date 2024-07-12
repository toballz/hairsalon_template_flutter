!(function () {
    var apiC = "https://cocohairsignature.com/i/apim.php", overridedListFromPosted = [], overridecalendarDateSelected="";
    function generateDateRanges(e, t, n) { function g(e) { return e.toISOString().split("T")[0] } function l(e, t) { let n = new Date(e); return n.setDate(n.getDate() + t), n } let r = new Date(e), i = new Date(t), u = new Set(n.map(e => new Date(e).getTime())), o = r, a = []; for (; o <= i;)u.has(o.getTime()) || a.push(new Date(o)), o = l(o, 1); let h = [], s = a[0]; for (let _ = 1; _ < a.length; _++)l(a[_ - 1], 1).getTime() !== a[_].getTime() && (h.push([g(s), g(a[_ - 1])]), s = a[_]); return h.push([g(s), g(a[a.length - 1])]), h }
    function getAppointmentListForDate(date, context) {
        var dateSelected = (date[0] === null ? 'null' : date[0].format('YYYYMMDD'));
        if (dateSelected != "null") {
            $.post(apiC, { cros: "getterCross", getDatesAppointmentsSpecDate: 2, dateFrom: dateSelected },
                function (ddat) {
                    var liost = "";
                    $.each(ddat, function (index, item) {
                        liost += `<li data-sh-orderid="` + item.orderId + `" class="list-group-item d-flex justify-content-between align-items-center">
                                                    <div style="width:250px;flex:1;"><img class="w-100" src="`+ item.imageUrl + `"/></div>
                                                    <div style="width: 75%;flex:5;padding-left:12px;padding-right:12px">
                                                        <div style="width:100%;text-overflow:ellipsis;white-space: nowrap;overflow: hidden;">`+ item.hairname + `</div>
                                                        <div>`+ item.datetime + `</div>
                                                    </div>
                                                    <button class="btn btn-outline-primary btn-sm">
                                                        <i class="bi bi-eye"></i>
                                                    </button>
                                                </li>`;
                    });
                    $(".viewappointmentlist").html(`<ul class="list-group">` + liost + `</ul>`);
                }
            );
        }
    }
    //
    //?afterReloadPageNavigaTE
    function changePage(dataPageRef = null) {
        //print to data-pageswitchref=
        //button click data-pageswitch=
        const url = new URL(window.location.href);
        $('[data-pageswitchref]').css("display", "none");
        if (dataPageRef !== null) {
            $('[data-pageswitchref="' + dataPageRef + '"]').css("display", "block");
        } else if (url.searchParams.has('afterReloadPageNavigaTE')) {
            $('[data-pageswitchref="' + url.searchParams.get('afterReloadPageNavigaTE') + '"]').css("display", "block");
        } else {
            $('[data-pageswitchref="viewappointment"]').css("display", "block");
        }
        //scroll
        window.scrollTo({
            top: 0,
            behavior: 'smooth' // Optional: adds smooth scrolling effect
        });
        // 
        if (url.searchParams.has("afterReloadPageNavigaTE")) {
            // Remove the query parameter
            url.searchParams.delete("afterReloadPageNavigaTE");
            // Update the URL without reloading the page
            window.history.replaceState({}, '', url); 
        }
    }
    //
    function addParam2Url(title,value) {// without reload
        const url = new URL(window.location.href);
        // set the query parameter
        url.searchParams.set(title, value);
        // Update the URL without reloading the page
        window.history.replaceState({}, '', url);
    }
    //
    //
    var today = new Date(),
        year = today.getFullYear(),
        month = (today.getMonth() + 1),
        day = today.getDate(),
        ttodayDatew = year + '' + ((month < 10) ? ('0' + month) : month) + '' + ((day < 10) ? ('0' + day) : day);//yyyymmdd
    //
    //modals
    function modalFuncReturnId(titlee, boddy, okbtn='', okbtnFunction) {
        $(".modal").remove();
        var idr = "h6b6w8"+Math.round(Math.random() * 10001);
        $("body").append(`
            <div class="modal fade" id="${idr}" data-bs-backdrop=static data-bs-keyboard=false tabindex="-1" aria-labelledby="${idr}Label" aria-hidden="true">
              <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="${idr}Label">${titlee.trim()}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">${boddy.trim()}</div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    `+ ((okbtn.trim().length>0)?`<button type="button" class="btn btn-primary" id="modalOkBtn_${idr}">${okbtn}</button>`:``)+`
                  </div>
                </div>
              </div>
            </div>`);

        $(`#modalOkBtn_${idr}`).on('click', function () {
             if (typeof okbtnFunction === 'function') {
                okbtnFunction();
            } else {
                 eval(okbtnFunction);
            }
        });
        return idr;
    }
    //
    //toasts bg-success
    function toastFuncReturnId(title, body, bgcolorClass) {
        $(".toast-container").remove();
        var toastId = "toast" + Math.round(Math.random() * 10001);
        $("body").append(`<div class="toast-container position-fixed bottom-0 end-0 p-3" id="${toastId}">
                      <div id="liveToast" class="toast ${bgcolorClass}" role="alert" aria-live="assertive" aria-atomic="true">
                        <div class="toast-header">
                          <img   class="rounded me-2" alt="...">
                          <strong class="me-auto">${title}</strong>
                          <small>1 seconds ago</small>
                          <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                        </div>
                        <div class="toast-body text-white">${body}</div>
                      </div>
                    </div>`);
        return toastId;
    }

    $(document).ready(function () {
        changePage();
        ///
        //header
        $("header").html('<nav class="bg-light navbar navbar-expand-lg navbar-light top-navbar"><div class=container-fluid><a class=navbar-brand href="javascript:void(0);">Brand</a> <button aria-controls=navbarNav aria-expanded=false aria-label="Toggle navigation"class=navbar-toggler data-bs-target=#navbarNav data-bs-toggle=collapse type=button><span class=navbar-toggler-icon></span></button><div class="collapse navbar-collapse"id=navbarNav><ul class="mx-auto navbar-nav"><li class=nav-item><a class="nav-link active" href=? aria-current=page>Home</a><li class=nav-item><a class=nav-link href="javascript:void(0);">Features</a><li class=nav-item><a class=nav-link href="javascript:void(0);">Pricing</a><li class=nav-item><a class="nav-link disabled">Disabled</a></ul></div></div></nav>');
        //footer
        $("footer").html('<nav class="bg-light bottom-navbar navbar navbar-light"><div class=container><a class=nav-link href="javascript:void(0);" data-pageswitch=viewappointment><i class="bi bi-house"></i> <span class="d-block navb-fs">Appointments</span> </a><a class=nav-link href="javascript:void(0);" data-pageswitch=schedules><i class="bi bi-calendar4-week"></i> <span class="d-block navb-fs">Availability</span> </a><a class=nav-link href="javascript:void(0);"><i class="bi bi-bar-chart"></i> <span class="d-block navb-fs">Stats</span> </a><a class=nav-link href="javascript:void(0);" data-pageswitch=settings><i class="bi bi-gear"></i> <span class="d-block navb-fs">Settings</span></a></div></nav>');
        //
        //
        //change pages js
        $('[data-pageswitch]').click(function () {  
            changePage($(this).data("pageswitch"));
         });
        //
        //
        //validate input time(s) js
        $("#updateoverride,.schld-days-ofweek>input").on("input", function () {
            var value = $(this).val().replace(/[^0-9]/g, ''); // Remove all non-digit characters
            var formattedValue = value.match(/.{1,4}/g)?.join(', ') || ''; // Add comma every 4 digits
            $(this).val(formattedValue);

            var pattern = /^(\d{4},\s?)*\d{4}$/;
            if (pattern.test(formattedValue) || formattedValue=="") {
                $(this).removeClass('is-invalid').addClass('is-valid');
            } else {
                $(this).removeClass('is-valid').addClass('is-invalid');
            }
        });
        //
        //
        //index page get calendar appointment post
        getAppointmentListForDate([moment(ttodayDatew),null], null);
        $.post(
            apiC,
            { cros: "getterCross", getDatesAppointmentsMoreThanDate: 2, dateTo: ttodayDatew },
                function (data) {
                    var DatesBooked = []; 
                    $.each(data, function (index, dateObj) { 
                        DatesBooked.push(dateObj.year + '-' + dateObj.month + '-' + dateObj.day);
                    }); 

                //index 1
                $('#viewappointmentpage').pignoseCalendar({
                    scheduleOptions: {
                        colors: { offer: '#fe49ef', ad: '#9897fc' }
                    },
                    schedules: DatesBooked.map((date, index) => ({
                        name: index % 2 === 0 ? 'offer' : 'ad',
                        date: date
                    })),

                    disabledRanges: generateDateRanges('2012-04-01', '2094-07-24', DatesBooked),
                    select: getAppointmentListForDate
                   
                });
                //index 0

            }
        );
        //
        //
        //get weekly schedules post
        $.post( apiC, { cros: "getterCross", getweeklyStatic: 2, had: "a" },
            function (data) {
                for (var day in data) { 
                    if (data[day]) {
                        $("#"+day.toLowerCase()).val(data[day]); 
                    }
                }
            });
        //
        //
        //override calendar js
        $('#overridecalendar').pignoseCalendar(
            {
                disabledRanges: [['2010-01-12', ttodayDatew.substring(0, 4) + "-" + ttodayDatew.substring(4, 6) + "-" + (parseInt(ttodayDatew) - 1).toString().substring(6, 8)]],
                scheduleOptions: { colors: { offer: '#2fabb7', ad: '#5c6270' } },
                schedules: [{ name: 'offer', date: '2024-05-09' }, { name: 'ad', date: '2024-05-10' }],
                select: function (date, context) {
                    overridecalendarDateSelected = (date[0] === null ? 'null' : date[0].format('YYYYMMDD'));
                }
            });overridecalendarDateSelected = ttodayDatew;
        //
        //
        //override list post
        $.post(apiC, { cros: "getterCross", getOverrideDates: 2, va: "a" },
            function (data) {
                var overidelist = "", newoverride_overridedListFromPosted = [];
                if (data.length > 0) {
                    overridedListFromPosted = data;
                    data.forEach(function (item) {
                        var formattedDate = moment(item.date, "YYYYMMDD").format('dddd MMMM Do YYYY');
                        if (parseInt(item.date) >= parseInt(ttodayDatew)) {
                            newoverride_overridedListFromPosted = $.grep(overridedListFromPosted, function (obj) {
                                return obj.date !== item.date;
                            });
                            var tt = "";
                            item.time.split(", ").forEach(function (ttim) {
                                tt += moment(ttim, "HHmm").format('hh:mm A') + ", ";
                            });

                            overidelist += `
                                <li class="list-group-item d-flex justify-content-between align-items-center mt-2">
                                    <div>
                                        <div><b>Date:</b> ${formattedDate}</div>
                                        <div><b>Time(s):</b> ${tt}</div>
                                    </div>
                                    <button class="btn btn-outline-primary btn-sm" data-overrided-delete="${item.date}">
                                        <i class="bi bi-trash3"></i>
                                    </button>
                                </li>`;
                        }
                    }); overridedListFromPosted = newoverride_overridedListFromPosted;
                } else {
                    overidelist = "<p style='text-align:center;margin-top:12px;'>No future date have been overridden.</p>";
                }
                $(".overrideitemslist").html(overidelist);
                //
                //delete override date
                $('[data-overrided-delete]').click(function () {
                    var tthis = $(this);
                    var propModal = "#" +modalFuncReturnId("Alert", "Do you want to delete this override.", "Delete",
                        function () {
                            overridedListFromPosted = $.grep(overridedListFromPosted, function (obj) {
                                return obj.date !== tthis.data("data-overrided-delete");
                            });
                            $.post(apiC, { cros: 1, cat: JSON.stringify(overridedListFromPosted), updateOverrided: 'v1' }, function () {
                                var toastIdr = $("#" + toastFuncReturnId("success", "Your override schedule has been updated.", "bg-success") + ">div").toast("show");
                                $(propModal).modal("hide");
                                tthis.parent().remove();
                            });
                        });
                    $(propModal).modal("show");
                });
            });
        //
        //
        //
        //save weekly schedules dates post
        $(".saveweeklyschedules").click(function () {
            var propModal = modalFuncReturnId("Alert", "Do you want to save your new weekly schedules.", "Save Updates",
                function () { //submit updates
                    var dataArray = {}, err = false;
                    $(".schld-days-ofweek input").each(function () {
                        var id = $(this).attr("id"); // Get the id attribute of the input
                        var value = $(this).val();   // Get the value of the input
                        if ($(this).hasClass("is-invalid")) {
                            err = true;
                        }
                        dataArray[id] = value; // Add id and value to dataArray
                    });
                    if (!err) {
                        $.post(apiC, { cros: 1, updatesWeekly: JSON.stringify(dataArray), ajr: 'a' }, function () {
                            $('#' + propModal).modal('hide');
                            var toastIdr = $("#" + toastFuncReturnId("success", "your weekly schedule has been updated.", "bg-success") + ">div").toast("show");
                        });
                    } else {
                        $('#' + propModal).modal('hide');
                        var modalIdr = $('#' + modalFuncReturnId("Alert", "Input valid 24hrs time seperated by comma ( , )")).modal('show');
                     }
                });
            $('#' + propModal).modal('show');
        });

        //
        //
        //

        //
        //
        // //submit updates save add override dates post
        $(".addoverridebtnclick").click(function () {
            var propModal = modalFuncReturnId("Alert", "Do you want save and override the selected dates.", "Save Override",
                function () {

                    var err = false, overrideValueTime = $("#updateoverride").val(), checkIfDate2updateExists = false;
                    // Get the value of the input
                    if ($("#updateoverride").hasClass("is-invalid")) { err = true; }
                    if (!err) {
                        $.each(overridedListFromPosted, function (index, obj) {
                            if (obj.date === overridecalendarDateSelected) {
                                obj.time = overrideValueTime;
                                checkIfDate2updateExists = true;
                                return false;
                            }
                        });

                        if (!checkIfDate2updateExists) { overridedListFromPosted.push({ "date": overridecalendarDateSelected, "time": overrideValueTime }); }

                        $.post(apiC, { cros: 1, cat: JSON.stringify(overridedListFromPosted), updateOverrided: 'v1' }, function () {
                            $('#' + propModal).modal('hide');
                            var toastIdr = $("#" + toastFuncReturnId("success", "Your override schedule has been updated.", "bg-success") + ">div").toast("show");
                            $("#updateoverride").val("");
                            setTimeout(function () {
                                addParam2Url("afterReloadPageNavigaTE","schedules");
                                location.reload();
                            }, 1000);
                         });
                    } else {
                        $('#' + propModal).modal('hide');
                        var modalIdr = $('#' + modalFuncReturnId("Alert", "Input valid 24hrs time seperated by comma ( , )")).modal('show');
                    }

                });
            $('#' + propModal).modal('show');
        }); 

}); })();
