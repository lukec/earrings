(function() {

  $(function() {
    var ATTR_CUT_FIRST, ATTR_CUT_LAST, ATTR_CUT_SECOND, ATTR_ETCH, EllipseWalls, InnerCircles, ONE_CM_IN_PX, ONE_MM_IN_PX, PAPER_HEIGHT, PAPER_WIDTH, WORKING_AREA_HEIGHT, WORKING_AREA_WIDTH, bb, blob, paper, svgString;
    EllipseWalls = function(paper, x, y, x2, y2, size, type) {
      paper.ellipse(x, y, x2, y2).attr(type);
      if (size !== 0) return paper.ellipse(x, y, x2 - size, y2 - size).attr(type);
    };
    ONE_MM_IN_PX = 4;
    ONE_CM_IN_PX = 38;
    ATTR_CUT_FIRST = {
      fill: "none",
      stroke: "#000",
      "stroke-width": "5"
    };
    ATTR_CUT_SECOND = {
      fill: "none",
      stroke: "#00F",
      "stroke-width": "5"
    };
    ATTR_CUT_LAST = {
      fill: "none",
      stroke: "#F00",
      "stroke-width": "5"
    };
    ATTR_ETCH = {
      fill: "none",
      stroke: "#0F0",
      "stroke-width": "5"
    };
    InnerCircles = function(paper, size_x, size_y) {
      var i, lineThickness, object_size, rings, _results;
      rings = 8;
      lineThickness = ONE_MM_IN_PX * 2;
      object_size = size_y / 2 / rings;
      _results = [];
      for (i = 0; 0 <= rings ? i <= rings : i >= rings; 0 <= rings ? i++ : i--) {
        _results.push(EllipseWalls(paper, size_x / 2 - (object_size * i), size_y / 2, size_x / 2 - (object_size * i), size_y / 2 - (object_size * i), lineThickness, ATTR_CUT_FIRST));
      }
      return _results;
    };
    WORKING_AREA_HEIGHT = ONE_CM_IN_PX * 15;
    WORKING_AREA_WIDTH = ONE_CM_IN_PX * 15;
    PAPER_HEIGHT = WORKING_AREA_HEIGHT;
    PAPER_WIDTH = WORKING_AREA_HEIGHT;
    paper = Raphael(40, 40, PAPER_WIDTH, PAPER_HEIGHT);
    InnerCircles(paper, ONE_CM_IN_PX * 6, ONE_CM_IN_PX * 6);
    svgString = paper.toSVG();
    $('#downloadLink').download('mySvg.svg').type('image/svg+xml');
    bb = new (window.BlobBuilder || WebKitBlobBuilder);
    bb.append(svgString);
    blob = bb.getBlob('image/svg+xml');
    return a.href = (window.URL || webkitURL).createObjectURL(blob);
  })();

}).call(this);
