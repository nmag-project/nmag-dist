
FILE="$1/bmake/common/rules.shared.basic"

if [ "x`grep shared_darwin9 $FILE`" == "x" ]; then
  echo "Patching $FILE"
  echo >> $FILE
  echo "shared_darwin9: shared_darwin7" >> $FILE
  echo >> $FILE
  echo "done"
fi

