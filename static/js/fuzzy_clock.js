var fz = function() {

    var canvas = document.getElementById('clock');
    var ctx = canvas.getContext('2d');

    var init = function() {
        var w = $(window).width() * .9;
        var h = $(window).height() * .9;
        canvas.setAttribute('width', w);
        canvas.setAttribute('height', h);
        ctx.fillStyle = '#000000';
        ctx.fillRect(0, 0, w, h);
    };

    return {
        init: init,
    };
};

window.onload = function() {
    var my_fuzzy_clock = fz();
    my_fuzzy_clock.init();
};

