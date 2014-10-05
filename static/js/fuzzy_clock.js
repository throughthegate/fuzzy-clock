var hand_circle = function(cx, cy, polar_r, fuzziness, r, color) {
    var draw = function() {

    };
    return {
        draw: draw,
    };
};

var clock_hand = function(cx, cy, r, fuzziness, n_circles, color) {

    var movement = 0.4;
    var smallC = 7; // smallest circle radius
    var largeC = 13; // biggest circle radius
    var circles = [];

    for (var i = 0; i < n_circles; i++) {
        circles.push(hand_circle(cx, cy,
            (Math.random() * 0.9 + 0.1) * r,
            (Math.random() * 2 - 1) * fuzziness,
            (Math.random() * (largeC - smallC)) + smallC,
            color));
    }

    var draw = function() {

    };

    return {
        draw: draw,
    };
};

var fuzzy_clock = function() {

    var canvas = document.getElementById('clock');
    var ctx = canvas.getContext('2d');
    var w = h = cx = cy = r = clock_r = hrs_r = min_r = 0;
    var hrs_hand = null, min_hand = null;

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

        hrs_hand = clock_hand(cx, cy, hrs_r, Math.PI * .1, 30, '#FF00FF');
        min_hand = clock_hand(cx, cy, min_r, Math.PI * .3, 70, '#FFFF00');
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
    var my_fuzzy_clock = fuzzy_clock();
    my_fuzzy_clock.init();
};

