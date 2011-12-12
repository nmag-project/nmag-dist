
FILE="$1/conf/rules"

if [ "x`grep shared_darwin7 $FILE`" == "x" ]; then
  echo "Patching $FILE"
  echo >> $FILE
  echo "shared_darwin11: shared_darwin7" >> $FILE
  echo >> $FILE
  echo "done"
fi
