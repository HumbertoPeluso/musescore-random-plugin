import QtQuick 2.1
import MuseScore 3.0

MuseScore {
      version:  "3.0"
      description: "Create random score."
      menuPath: "Plugins.random"
      requiresScore: false

      function addNote(key, cursor) {
            var cdur = [ 0 ];
            //           c  g  d  e
            var keyo = [ 0, 7, 2, 4 ];

            var idx    = Math.random() * 2;
            var octave = Math.floor(Math.random() * 2);
            var pitch  = cdur[Math.floor(idx)] + octave * 12 + 60  + keyo[key];
            cursor.addNote(pitch);
            }

      onRun: {
            var measures    = 10; //in 4/4 default time signature
            var numerator   = 4;
            var denominator = 4;
            var octaves     = 1;
            var key         = 0;

            var score = newScore("Random.mscz", "eletric_bass", measures);

            score.addText("title", "==Random==");
            score.addText("subtitle", "subtitle");
            

            var cursor = score.newCursor();
            cursor.track = 0;

            cursor.rewind(0);

            var ts = newElement(Element.TIMESIG);
            ts.timesig = fraction(numerator, denominator);
            cursor.add(ts);
            console.log("------------")

            cursor.rewind(0);

            var realMeasures = Math.ceil(measures * denominator / numerator);
            console.log(realMeasures);
            var notes = realMeasures * 4; //number of 1/4th notes

            for (var i = 0; i < notes; ++i) {

                if (Math.random() < 0.5) {
                    cursor.setDuration(1, 2);
                    addNote(key, cursor);
                    addNote(key, cursor);
                    }
                else {
                    cursor.setDuration(1, 4);
                    addNote(key, cursor);
                    }

                }
            Qt.quit();
            }
      }
