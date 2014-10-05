var canvas, ctx;

var hand_circle = function(cx, cy, polar_r, fuzziness, r, color, angle) {
    var a = angle + fuzziness;
    var x = cx + Math.cos(a) * polar_r;
    var y = cy + Math.sin(a) * polar_r;
    var draw = function() {
        draw_circle(x, y, r, color); 
    };
    return {
        draw: draw,
    };
};

var clock_hand = function(cx, cy, r, fuzziness, n_circles, color, angle) {

    var movement = 0.4;
    var smallC = 3; // smallest circle radius
    var largeC = 7; // biggest circle radius
    var circles = [];

    for (var i = 0; i < n_circles; i++) {
        circles.push(hand_circle(cx, cy,
            map(Math.random(), 0, 1, 0.1, 0.9) * r,
            map(Math.random(), 0, 1, -1, 1) * fuzziness,
            map(Math.random(), 0, 1, smallC, largeC),
            color,
            angle));
    }

    var draw = function() {
        for (var i = 0; i < circles.length; i++) {
            circles[i].draw();
        }
    };

    return {
        draw: draw,
    };
};

var fuzzy_clock = function() {

    canvas = document.getElementById('clock');
    ctx = canvas.getContext('2d');
    var w = h = cx = cy = r = clock_r = hrs_r = min_r = 0;
    var hrs_hand = null, min_hand = null;

    var draw = function() {
        hrs_hand.draw();
        min_hand.draw();
    };

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

        hrs_hand = clock_hand(cx, cy, hrs_r, Math.PI * .1, 30, '#FF00FF', hour_angle());
        min_hand = clock_hand(cx, cy, min_r, Math.PI * .3, 70, '#FFFF00', min_angle());

        draw(); // TODO update times and redraw
    };

    return {
        init: init,
    };
};

var draw_circle = function(_x, _y, _r, _color) {
    ctx.beginPath();
    ctx.arc(_x, _y, _r, 0, 2 * Math.PI);
    ctx.fillStyle = _color;
    ctx.fill();
    //ctx.stroke();
};

var map = function(val, domain_min, domain_max, range_min, range_max) {
    return (val - domain_min) / (domain_max - domain_min) * (range_max - range_min) + range_min;
};

var hour_angle = function() { 
    var d = new Date();
    var hour = d.getHours();
    var min = d.getMinutes();
    var res = map(hour + min/60, 0, 24, 0, 2 * 2 * Math.PI)  - Math.PI / 2; 
    console.log('hour_angle', res);
    return res;
};

var min_angle = function(){
    var d = new Date();
    var min = d.getMinutes();
    var sec = d.getSeconds();
    var res = map(min + sec/60, 0, 60, 0, 2 * Math.PI) - Math.PI / 2;
    console.log('min_angle', res);
    return res;
};

window.onload = function() {
    var my_fuzzy_clock = fuzzy_clock();
    my_fuzzy_clock.init();
};

