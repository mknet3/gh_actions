#! /bin/sh

# Check if the current day of the week is a valid day
day=$(date +%A | tr '[:upper:]' '[:lower:]')
days_allowed=$(echo '${{ inputs.days_allowed }}' | tr '[:upper:]' '[:lower:]')
echo $days_allowed
if [[ $days_allowed != *\"$day\"* ]]; then
  echo "is_valid=false" >> "$GITHUB_OUTPUT"
  echo '⚠️ Date of the week is not allowed. Allowed days: ${{ inputs.days_allowed }}' >> $GITHUB_STEP_SUMMARY
  exit 0;
fi

# Check if the current time is between the initial and final hours allowed
current_time=$(date +%H:%M)
if [[ $current_time < "${{ inputs.initial_hour_allowed }}" || $current_time > "${{ inputs.final_hour_allowed }}" ]]; then
  echo "is_valid=false" >> "$GITHUB_OUTPUT"
  echo '⚠️ Date is not within time frame ${{ inputs.initial_hour_allowed }} - ${{ inputs.final_hour_allowed }}' >> $GITHUB_STEP_SUMMARY
  exit 0;
fi

echo "is_valid=true" >> "$GITHUB_OUTPUT"
