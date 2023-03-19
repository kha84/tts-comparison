#!/bin/sh
echo "<html>" > result.html
echo "<script src=\"https://www.kryogenix.org/code/browser/sorttable/sorttable.js\"></script>" >> result.html
echo "<table class=\"sortable\"><thead><th>Model name</th><th>Vocoder name</th><th>Proc time</th><th>File name</th><th>Play</th><th>Log</th></tr><thead><tbody>" >> result.html
for FILE in *.log
do 
  echo "Processing $FILE"
  model_full_name=$(cat $FILE | head -n1 | cut -f3 -d" ")
  vocoder_name=$(cat $FILE | head -n2 | tail -n1 | cut -f3 -d" ")
  processing_time_float=$(cat $FILE | grep "Processing time:" | cut -f5 -d" ")
  processing_time=$(printf '%.*f\n' 1 $processing_time_float)
  file_name=$(cat $FILE | grep "Saving output to" | cut -f6 -d" ")
  echo "<tr>" >> result.html
  echo "  <td>$model_full_name</td>" >> result.html
  echo "  <td>$vocoder_name</td>" >> result.html
  echo "  <td>$processing_time</td>" >> result.html
  echo "  <td>$file_name</td>" >> result.html
  echo "  <td><audio controls><source src=\"$file_name\" type=\"audio/wav\">Your browser does not support the audio element.</audio></td>" >> result.html
  echo "  <td><a href=\"$FILE\">$FILE</a></td>" >> result.html
  echo "</tr>" >> result.html
done
echo "</tbody></table></html>" >> result.html
echo "Report was generated to result.html"
echo "Open it with your web browser"
