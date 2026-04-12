#!/bin/bash

log=$1

total=`cat log | grep ' ,.,.' | wc -l`
passed=`cat log | grep ' ==== [0-9a-zA-Z_]* PASSED' | wc -l`
failed=`cat log | grep ' \*\*\*\* [0-9a-zA-Z_]* FAILED' | wc -l`
skipped=`cat log | grep ' ++++ [0-9a-zA-Z_]* NOT-APPLICABLE' | wc -l`

echo "TOTAL:  $total"
echo "PASSED: $passed"
echo "SKIPPED: $skipped"
echo "FAILED: $failed"

if [ "$total" = "0" ]; then
  exit 1
fi

dump_test()
{
  if [ "$first" == "TRUE" ]; then
    first=FALSE
  else
    echo "," >> sections.tests
  fi
  echo "      {" >> sections.tests
  echo "        \"name\": \"${test_name}\"," >> sections.tests
  echo "        \"status\": \"${test_status}\"," >> sections.tests
  echo "        \"duration\": 0," >> sections.tests
  echo "        \"stdout\": [" >> sections.tests
  local first_item=TRUE
  for item in "${test_stdout[@]}"; do
    if [ "$first_item" == "TRUE" ]; then
      first_item=FALSE
    else
      echo "," >> sections.tests
    fi
    echo -n "          \"${item//\"/\\\"}\"" >> sections.tests;
  done
  echo "" >> sections.tests
  echo "        ]" >> sections.tests
  echo -n "      }" >> sections.tests
}

state=INITIAL
first=TRUE
summary_tests=0
summary_passed=0
summary_failed=0
summary_skipped=0

rm -f sections.tests
rm -f ctrf.json

while IFS= read -r line; do
  case "$state" in
    INITIAL)
      case "$line" in
        \ ,.,.\ *)
	  [[ "$line" =~ \ ,.,.\ ([0-9A-Z]+) ]] || exit 1
	  test_name=${BASH_REMATCH[1]}
	  test_stdout=()
	  state=TEST
      esac
      ;;
    TEST)
      case "$line" in
        \ ,.,.*)
          echo "${line}"
          exit 2
	  ;;
        \ ====\ *\ PASSED*)
          test_status="passed"
	  ((summary_tests++))
	  ((summary_passed++))

	  dump_test

	  state=INITIAL
	  ;;
        \ \*\*\*\*\ *\ FAILED*)
          test_status="failed"
	  ((summary_tests++))
	  ((summary_failed++))

	  dump_test

	  state=INITIAL
	  ;;
        \ ++++\ *\ NOT-APPLICABLE*)
          test_status="skipped"
	  ((summary_tests++))
	  ((summary_skipped++))

	  dump_test

	  state=INITIAL
	  ;;
        *)
          IFS=$'\n\r' test_stdout+=(${line})
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
echo "      \"skipped\": ${summary_skipped}," >> ctrf.json
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
