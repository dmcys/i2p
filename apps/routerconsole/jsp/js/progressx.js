/* ProgressX 1.0, 2018-11-16
 * https://github.com/ryadpasha/progressx
 * Copyright (c) 2018 Ryad Pasha
 * Licensed under the MIT License */
;
(function(window, document) {
  "use strict";
  (function() {
    var lastTime = 0;
    var vendors = ["ms", "moz", "webkit", "o"];
    for (var x = 0; x < vendors.length && !window.requestAnimationFrame; ++x) {
      window.requestAnimationFrame = window[vendors[x] + "RequestAnimationFrame"];
      window.cancelAnimationFrame = window[vendors[x] + "CancelAnimationFrame"] || window[vendors[x] + "CancelRequestAnimationFrame"];
    }
    if (!window.requestAnimationFrame) window.requestAnimationFrame = function(callback, element) {
      var currTime = new Date().getTime();
      var timeToCall = Math.max(0, 16 - (currTime - lastTime));
      var id = window.setTimeout(function() {
        callback(currTime + timeToCall);
      }, timeToCall);
      lastTime = currTime + timeToCall;
      return id;
    };
    if (!window.cancelAnimationFrame) window.cancelAnimationFrame = function(id) {
      clearTimeout(id);
    };
  }());
  var canvas, progressTimerId, fadeTimerId, currentProgress, showing, addEvent = function(elem, type, handler) {
      if (elem.addEventListener) elem.addEventListener(type, handler, false)
      else if (elem.attachEvent) elem.attachEvent("on" + type, handler)
      else elem["on" + type] = handler
    },
    options = {
      autoRun: true,
      barThickness: 3,
      barColors: {
        "0": "rgba(220,  48,  16,  .8)",
        "1.0": "rgba(255,  96,   0,  .8)"
      },
    },
    repaint = function() {
      canvas.width = window.innerWidth
      canvas.height = options.barThickness
      var ctx = canvas.getContext("2d")
      var lineGradient = ctx.createLinearGradient(0, 0, canvas.width, 0)
      for (var stop in options.barColors) lineGradient.addColorStop(stop, options.barColors[stop])
      ctx.lineWidth = options.barThickness
      ctx.beginPath()
      ctx.moveTo(0, options.barThickness / 2)
      ctx.lineTo(Math.ceil(currentProgress * canvas.width), options.barThickness / 2)
      ctx.strokeStyle = lineGradient
      ctx.stroke()
    },
    createCanvas = function() {
      canvas = document.createElement("canvas")
      canvas.id = "pageloader"
      var style = canvas.style
      style.position = "fixed"
      style.top = style.left = style.right = style.margin = style.padding = 0
      style.zIndex = 100001
      style.display = "none"
      document.body.appendChild(canvas)
      addEvent(window, "resize", repaint)
    },
    progressx = {
      config: function(opts) {
        for (var key in opts)
          if (options.hasOwnProperty(key)) options[key] = opts[key]
      },
      show: function() {
        if (showing) return
        showing = true
        if (fadeTimerId !== null) window.cancelAnimationFrame(fadeTimerId)
        if (!canvas) createCanvas()
        canvas.style.opacity = 1
        canvas.style.display = "block"
        progressx.progress(0)
        if (options.autoRun) {
          (function loop() {
            progressTimerId = window.requestAnimationFrame(loop)
            progressx.progress("+" + (0.05 * Math.pow(1 - Math.sqrt(currentProgress), 2)))
          })()
        }
      },
      progress: function(to) {
        if (typeof to === "undefined") return currentProgress
        if (typeof to === "string") {
          to = (to.indexOf("+") >= 0 || to.indexOf("-") >= 0 ? currentProgress : 0) + parseFloat(to)
        }
        currentProgress = to > 1 ? 1 : to
        repaint()
        return currentProgress
      },
      hide: function() {
        if (!showing) return
        showing = false
        if (progressTimerId != null) {
          window.cancelAnimationFrame(progressTimerId)
          progressTimerId = null
        }
        (function loop() {
          if (progressx.progress("+.1") >= 1) {
            canvas.style.opacity -= 0.25
            if (canvas.style.opacity <= 0.25) {
              canvas.style.display = "none"
              fadeTimerId = null
              return
            }
          }
          fadeTimerId = window.requestAnimationFrame(loop)
        })()
      }
    }
  if (typeof module === "object" && typeof module.exports === "object") {
    module.exports = progressx
  } else if (typeof define === "function" && define.amd) {
    define(function() {
      return progressx
    })
  } else {
    this.progressx = progressx
  }
})
.call(this, window, document)