#!/bin/bash


if [[ "$OSTYPE" == "darwin"* ]]; then
    SLACK_TARGET_PATH="/Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/ssb-interop.js"
elif [[ "$OSTYPE" == "linux-gnu" ]] ; then
    SLACK_TARGET_PATH="/usr/lib/slack/resources/app.asar.unpacked/src/static/ssb-interop.js"
else
    echo "Unsupported OS. Install manually with the instructions in README.md"
    exit 1
fi


if [[ ! -f "$SLACK_TARGET_PATH" ]] ; then
    echo "Path not found: $SLACK_TARGET_PATH"
    echo "Install manually with the instructions in README.md"
    exit 1
fi


cat << 'EOF' >> $SLACK_TARGET_PATH
document.addEventListener('DOMContentLoaded', function() {
  $.ajax({
    url: 'https://raw.githubusercontent.com/lvarado/slackIRC/master/style.css',
    success: function(css) {
      $("<style></style>").appendTo('head').html(css);
    }
  });
});
EOF

echo If Slack.app is already running, refresh with CMD-R
