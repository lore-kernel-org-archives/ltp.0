From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 24 Jul 2019 11:07:10 +0200
Subject: [LTP] [PATCH] syslog: fix sporadic failures due to rate-limitting
Message-ID: <6db4a928733290dca3b2e4b4a27f1cb69d805401.1563959090.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some distros (Fedora30) do not have rsyslog installed by default.
Also some test environments generate a lot of messages before they
start syslogs tests.

This creates a problem if rsyslog is using imjournal, because by default
rate-limitting is enabled. If there is a big backlog of messages
prior to running syslog tests, some messages from tests may be dropped.

Easy way to reproduce is to stop rsyslog, delete imjournal.state,
run kmsg01 test couple times and then run some syslog test:
  Jul 23 15:05:13 ... begin to drop messages due to rate-limiting
  Jul 23 15:05:21 ... 47006 messages lost due to rate-limiting
Messages make it to systemd journal, but not to log configured in rsyslog.

This patch adds Ratelimit.Interval="0" and IgnorePreviousMessages="on"
to config for imjournal:
  https://www.rsyslog.com/doc/v8-stable/configuration/modules/imjournal.html

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/syslog/syslog-lib.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/syslog/syslog-lib.sh b/testcases/kernel/syscalls/syslog/syslog-lib.sh
index 31266f93e729..eed501d9b3ad 100755
--- a/testcases/kernel/syscalls/syslog/syslog-lib.sh
+++ b/testcases/kernel/syscalls/syslog/syslog-lib.sh
@@ -75,19 +75,19 @@ setup()
 		#   $ModLoad imjournal
 		#   module(load="imjournal"...)
 		# in rsyslog config, and using those settings.
-		if grep -qri '^[^#].*load.*imjournal' /etc/rsyslog.conf /etc/rsyslog.d/ ; then
-			systemd_journal=$(grep -Ehoi "^[^#].*(imjournal|workdirectory).*" -r /etc/rsyslog.conf /etc/rsyslog.d/)
-			RSYSLOG_CONFIG=$(cat <<EOF
-$systemd_journal
-EOF
-)
+		if grep -qri '^[^#]*modload.*imjournal' /etc/rsyslog.conf /etc/rsyslog.d/; then
+			RSYSLOG_CONFIG=$(grep -Ehoi "^[^#].*(imjournal|workdirectory).*" -r /etc/rsyslog.conf /etc/rsyslog.d/;
+				echo '$imjournalRatelimitInterval 0'; \
+				echo '$ImjournalIgnorePreviousMessages on';)
+		elif grep -qri '^[^#]*module.*load="imjournal"' /etc/rsyslog.conf /etc/rsyslog.d/; then
+			RSYSLOG_CONFIG=$(grep -Ehoi "^[^#].*workdirectory.*" -r /etc/rsyslog.conf /etc/rsyslog.d/; \
+				echo 'module(load="imjournal"'; \
+				echo '       StateFile="imjournal.state"'; \
+				echo '       Ratelimit.Interval="0"'; \
+				echo '       IgnorePreviousMessages="on")')
 		else
-			log_socket=$(grep -ho "^\$SystemLogSocketName .*" -r /etc/rsyslog.conf /etc/rsyslog.d/ | head -1)
-			RSYSLOG_CONFIG=$(cat <<EOF
-\$ModLoad imuxsock.so
-$log_socket
-EOF
-)
+			RSYSLOG_CONFIG=$(echo '$ModLoad imuxsock.so'; \
+				grep -ho "^\$SystemLogSocketName .*" -r /etc/rsyslog.conf /etc/rsyslog.d/ | head -1)
 		fi
 	else
 		tst_resm TCONF "Couldn't find syslogd, syslog-ng or rsyslogd"
-- 
1.8.3.1

