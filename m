Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1XqLeX-0006NB-7N
	for ltp-list@lists.sourceforge.net; Mon, 17 Nov 2014 12:43:33 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XqLeV-0004VT-L5
	for ltp-list@lists.sourceforge.net; Mon, 17 Nov 2014 12:43:33 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sAHChA3m022941
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Nov 2014 20:43:10 +0800
Message-ID: <1416228087.10929.6.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Mon, 17 Nov 2014 20:41:27 +0800
In-Reply-To: <1416227892.10929.1.camel@G08JYZSD130126.localdomain>
References: <1416227892.10929.1.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Subject: [LTP] [PATCH 5/5] ima_violations.sh: Some cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

* Use 'test_resm' instead of 'tst_res'.

* Use '$()' instead of '``'.

* Delete some unuseful comments.

* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 .../security/integrity/ima/tests/ima_violations.sh | 133 +++++++--------------
 1 file changed, 45 insertions(+), 88 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index 4c9fc3c..aa5c7d5 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -30,6 +30,10 @@
 #               - non zero on failure. return value from commands ($RC)
 ################################################################################
 
+export TST_TOTAL=3
+export TCID="ima_violations"
+export TST_COUNT=0
+
 open_file_read()
 {
 	exec 3< $1
@@ -59,147 +63,100 @@ close_file_write()
 
 init()
 {
-	export TST_TOTAL=3
-	export TCID="init"
-	export TST_COUNT=0
-	RC=0
-
-	if [ -f /etc/init.d/auditd ]; then
-		service auditd status > /dev/null 2>&1 || RC=$?
-	else
-		RC=$?
-	fi
-
-	if [ $RC -ne 0 ]; then
+	service auditd status > /dev/null 2>&1
+	if [ $? -ne 0 ]; then
 		log=/var/log/messages
 	else
 		log=/var/log/audit/audit.log
-		tst_res TINFO $LTPTMP/imalog.$$ \
-		 "$TCID: requires integrity auditd patch"
+		tst_resm TINFO "requires integrity auditd patch"
 	fi
+
+	ima_violations=$SECURITYFS/ima/violations
 }
 
 # Function:     test01
-# Description   - Verify ToMToU violation
+# Description	- Verify open writers violation
 test01()
 {
-	TCID="test01"
-	TST_COUNT=1
-	RC=0
-
-	ima_violations=$SECURITYFS/ima/violations
 	read num_violations < $ima_violations
 
-	TMPFN=$LTPIMA/test.txt-$$
+	TMPFN=test.txt
 	open_file_write $TMPFN
 	open_file_read $TMPFN
 	close_file_read
 	close_file_write
 	read num_violations_new < $ima_violations
-	num=$((`expr $num_violations_new - $num_violations`))
+	num=$(($(expr $num_violations_new - $num_violations)))
 	if [ $num -gt 0 ]; then
-		tail $log | grep test.txt-$$ | \
-			grep 1>/dev/null 'open_writers' || RC=$?
-		if [ $RC -eq 0 ]; then
-			tst_res TPASS $LTPTMP/imalog.$$ \
-			 "$TCID: open_writers violation added(test.txt-$$)"
-			return $RC
+		tail $log | grep test.txt | grep -q 'open_writers'
+		if [ $? -eq 0 ]; then
+			tst_resm TPASS "open_writers violation added(test.txt)"
 		else
-			tst_res TINFO $LTPTMP/imalog.$$ \
-			 "$TCID: (message ratelimiting?)"
+			tst_resm TFAIL "(message ratelimiting?)"
 		fi
+	else
+		tst_resm TFAIL "open_writers violation not added(test.txt)"
 	fi
-	tst_res TFAIL $LTPTMP/imalog.$$ \
-	 "$TCID: open_writers violation not added(test.txt-$$)"
-	return $RC
 }
 
 # Function:     test02
-# Description	- Verify open writers violation
+# Description   - Verify ToMToU violation
 test02()
 {
-	TCID="test02"
-	TST_COUNT=2
-	RC=0
-
-	ima_violations=$SECURITYFS/ima/violations
 	read num_violations < $ima_violations
 
-	TMPFN=$LTPIMA/test.txt-$$
+	TMPFN=test.txt
 	open_file_read $TMPFN
 	open_file_write $TMPFN
 	close_file_write
 	close_file_read
 	read num_violations_new < $ima_violations
-	num=$((`expr $num_violations_new - $num_violations`))
+	num=$(($(expr $num_violations_new - $num_violations)))
 	if [ $num -gt 0 ]; then
-		tail $log | grep test.txt-$$ | \
-			grep 'ToMToU' 1>/dev/null || RC=$?
-		if [ $RC -eq 0 ]; then
-			tst_res TPASS $LTPTMP/imalog.$$ \
-			 "$TCID: ToMToU violation added(test.txt-$$)"
-			return $RC
+		tail $log | grep test.txt | grep -q 'ToMToU'
+		if [ $? -eq 0 ]; then
+			tst_resm TPASS "ToMToU violation added(test.txt)"
 		else
-			tst_res TINFO $LTPTMP/imalog.$$ \
-			 "$TCID: (message ratelimiting?)"
+			tst_resm TFAIL "(message ratelimiting?)"
 		fi
+	else
+		tst_resm TFAIL "ToMToU violation not added(test.txt)"
 	fi
-	tst_res TFAIL $LTPTMP/imalog.$$ \
-	 "$TCID: ToMToU violation not added(test.txt-$$)"
-	return $RC
 }
 
 # Function:     test03
 # Description 	- verify open_writers using mmapped files
 test03()
 {
-	TCID="test03"
-	TST_COUNT=3
-	RC=0
-
-	ima_violations=$SECURITYFS/ima/violations
 	read num_violations < $ima_violations
 
-	TMPFN=$LTPIMA/test.txtb-$$
-	mkdir -p $LTPIMA
+	TMPFN=test.txtb
 	echo 'testing testing ' > $TMPFN
 	ima_mmap $TMPFN & p1=$!
 	sleep 1		# got to wait for ima_mmap to mmap the file
 	open_file_read $TMPFN
 	read num_violations_new < $ima_violations
-	num=$((`expr $num_violations_new - $num_violations`))
+	num=$(($(expr $num_violations_new - $num_violations)))
 	if [ $num -gt 0 ]; then
-		tail $log | grep test.txtb-$$ | \
-			grep 1>/dev/null 'open_writers' || RC=$?
-		if [ $RC -eq 0 ]; then
-			tst_res TPASS $LTPTMP/imalog.$$ \
-			 "$TCID: mmapped open_writers violation added(test.txtb-$$)"
-			return $RC
+		tail $log | grep test.txtb | grep -q 'open_writers'
+		if [ $? -eq 0 ]; then
+			tst_resm TPASS "mmapped open_writers violation added(test.txtb)"
 		else
-			tst_res TINFO $LTPTMP/imalog.$$ \
-			 "$TCID: (message ratelimiting?)"
+			tst_resm TFAIL "(message ratelimiting?)"
 		fi
+	else
+		tst_resm TFAIL "mmapped open_writers violation not added(test.txtb)"
 	fi
-	tst_res TFAIL $LTPTMP/imalog.$$ \
-	 "$TCID: mmapped open_writers violation not added(test.txtb-$$)"
 	close_file_read
-	return $RC
 }
 
-# Function:     main
-#
-# Description:  - Execute all tests, exit with test status.
-#
-# Exit:         - zero on success
-#               - non-zero on failure.
-#
-RC=0    # Return value from setup, init, and test functions.
-EXIT_VAL=0
-
-. $(dirname "$0")/ima_setup.sh
-setup || exit $?
-init || exit $?
-test01 || EXIT_VAL=$RC
-test02 || EXIT_VAL=$RC
-test03 || EXIT_VAL=$RC
-exit $EXIT_VAL
+. ima_setup.sh
+TST_CLEANUP=cleanup
+
+setup
+init
+test01
+test02
+test03
+
+tst_exit
-- 
1.8.3.1




------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
