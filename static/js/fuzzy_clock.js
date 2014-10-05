var fz = function() {

    var canvas = document.getElementById('clock');
    var ctx = canvas.getContext('2d');
    var w = h = cx = cy = r = clock_r = hrs_r = min_r = 0;

    var init = function() {
        w = $(window).width() * 0.9;
        h = $(window).height() * 0.9;
        canvas.setAttribute('width', w);
        canvas.setAttribute('height', h);
        ctx.fillStyle = '#000000';
        ctx.fillRect(0, 0, w, h);

        cx = Math.round(w / 2);
        cy = Math.round(h / 2);
        r = Math.min(w, h) / 2;
        clock_r = r * 0.9;
        hrs_r = r * 0.5;
        min_r = r * 0.75;

        for (var a = 0; a < Math.PI * 2; a += Math.PI / 6) {
            var x = cx + Math.cos(a) * clock_r;
            var y = cy + Math.sin(a) * clock_r;
            draw_circle(x, y, 4, '#FFFFFF');
        }
    };

    var draw = function() {

    };

    var draw_circle = function(_x, _y, _r, _color) {
        ctx.beginPath();
        ctx.arc(_x, _y, _r, 0, 2 * Math.PI);
        ctx.fillStyle = _color;
        ctx.fill();
        ctx.stroke();
    };

    return {
        init: init,
    };
};

window.onload = function() {
    var my_fuzzy_clock = fz();
    my_fuzzy_clock.init();
};

