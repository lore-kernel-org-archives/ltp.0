From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Mar 2017 11:20:01 +0100
Subject: [LTP] [PATCH 1/1] cron: Speed up optimization for grep logs
Message-ID: <20170310102001.22828-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/commands/cron/cron_tests.sh | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/testcases/commands/cron/cron_tests.sh b/testcases/commands/cron/cron_tests.sh
index 36e7181a1..b76f0b68d 100644
--- a/testcases/commands/cron/cron_tests.sh
+++ b/testcases/commands/cron/cron_tests.sh
@@ -38,18 +38,25 @@ grep_logs()
 	local pattern="$1"
 	local fail_msg="$2"
 	local pass_msg="${3:-}"
+	local n="${4:-10}"
 
 	local lines=10
 	local out=out.$$
 	local err=err.$$
+	local i ret
 
-	if [ "$LOGS" ]; then
-		tail -n $lines $LOGS | grep "$pattern" > $out 2> $err
-	else
-		journalctl -n $lines | grep "$pattern" > $out 2> $err
-	fi
+	for i in $(seq 1 $n); do
+		if [ "$LOGS" ]; then
+			tail -n $lines $LOGS | grep "$pattern" > $out 2> $err
+		else
+			journalctl -n $lines | grep "$pattern" > $out 2> $err
+		fi
+		ret=$?
+		[ $ret -eq 0 ] && break
+		sleep 1
+	done
 
-	if [ $? -ne 0 ]; then
+	if [ $ret -ne 0 ]; then
 		tst_res TFAIL "$fail_msg: `cat $err`"
 	else
 		[ "$pass_msg" ] && tst_res TPASS "$pass_msg"
@@ -127,8 +134,6 @@ EOF
 		tst_res TINFO "cron job installed successfully"
 	fi
 
-	sleep 10
-
 	grep_logs 'crontab.*REPLACE' \
 		"cron activity not recorded" \
 		"cron activity logged"
@@ -179,7 +184,7 @@ EOF
 	if [ ! "$fail" ]; then
 		grep_logs "CMD ($script)" \
 			"failed to install cron job installed and execute it" \
-			"cron job installed and executed"
+			"cron job installed and executed" 1
 	fi
 
 	remove_crontab
@@ -194,14 +199,12 @@ remove_cron_job_test()
 	create_hello_script $script
 	create_crontab $script
 
-	sleep 10
-
 	grep_logs 'crontab.*REPLACE' \
 		"crontab activity not recorded"
 
 	remove_crontab && grep_logs DELETE \
 		"crontab activity not recorded" \
-		"crontab removed the cron job"
+		"crontab removed the cron job" 1
 }
 
 list_cron_jobs_test()
-- 
2.12.0

