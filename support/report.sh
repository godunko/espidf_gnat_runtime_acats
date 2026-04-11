#!/bin/bash

log=$1

total=`cat log | grep ' ,.,.' | wc -l`
passed=`cat log | grep ' ==== [0-9a-zA-Z_]* PASSED' | wc -l`
failed=`cat log | grep ' \*\*\*\* [0-9a-zA-Z_]* FAILED' | wc -l`

echo "TOTAL:  $total"
echo "PASSED: $passed"
echo "FAILED: $failed"

if [ "$total" = "0" ]; then
  exit 1
fi

state=INITIAL
first=TRUE
summary_tests=0
summary_passed=0
summary_failed=0

rm -f sections.tests
rm -f ctrf.json

while IFS= read -r line; do
  case "$state" in
    INITIAL)
      case "$line" in
        \ ,.,.\ *)
	  [[ "$line" =~ \ ,.,.\ ([0-9A-Z]+) ]] || exit 1
	  test_name=${BASH_REMATCH[1]}
	  state=TEST
      esac
      ;;
    TEST)
      case "$line" in
        \ ,.,.*)
          exit 2
	  ;;
        \ ====\ *\ PASSED*)
          test_status="passed"
	  ((summary_tests++))
	  ((summary_passed++))

	  if [ "$first" = "TRUE" ]; then
            first=FALSE
          else
            echo "," >> sections.tests
	  fi
	  echo "      {" >> sections.tests
	  echo "        \"name\": \"${test_name}\"," >> sections.tests
	  echo "        \"status\": \"${test_status}\"," >> sections.tests
	  echo "        \"duration\": 0" >> sections.tests
	  echo -n "      }" >> sections.tests

	  state=INITIAL
	  ;;
        \ \*\*\*\*\ *\ FAILED*)
          test_status="failed"
	  ((summary_tests++))
	  ((summary_failed++))

	  if [ "$first" = "TRUE" ]; then
            first=FALSE
          else
            echo "," >> sections.tests
	  fi
	  echo "      {" >> sections.tests
	  echo "        \"name\": \"${test_name}\"," >> sections.tests
	  echo "        \"status\": \"${test_status}\"," >> sections.tests
	  echo "        \"duration\": 0" >> sections.tests
	  echo -n "      }" >> sections.tests

	  state=INITIAL
	  ;;
      esac
      ;;
    *)
      ;;
  esac
done < $log

echo "{" >> ctrf.json
echo "  \"reportFormat\": \"CTRF\"," >> ctrf.json
echo "  \"specVersion\": \"0.0.0\"," >> ctrf.json
echo "  \"results\": {" >> ctrf.json
echo "    \"tool\": {" >> ctrf.json
echo "      \"name\": \"ACATS\"" >> ctrf.json
echo "    }," >> ctrf.json
echo "    \"summary\": {" >> ctrf.json
echo "      \"tests\": ${summary_tests}," >> ctrf.json
echo "      \"passed\": ${summary_passed}," >> ctrf.json
echo "      \"failed\": ${summary_failed}," >> ctrf.json
echo "      \"pending\": 0," >> ctrf.json
echo "      \"skipped\": 0," >> ctrf.json
echo "      \"other\": 0," >> ctrf.json
echo "      \"start\": 0," >> ctrf.json
echo "      \"stop\": 0" >> ctrf.json
echo "    }," >> ctrf.json
echo "    \"tests\": [" >> ctrf.json
cat sections.tests >> ctrf.json
echo "" >> ctrf.json
echo "    ]" >> ctrf.json
echo "  }" >> ctrf.json
echo "}" >> ctrf.json

rm -f sections.tests
