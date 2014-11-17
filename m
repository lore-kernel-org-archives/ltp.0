Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1XqLdH-0006G8-Ra
	for ltp-list@lists.sourceforge.net; Mon, 17 Nov 2014 12:42:15 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XqLdG-0004SZ-1Z
	for ltp-list@lists.sourceforge.net; Mon, 17 Nov 2014 12:42:15 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sAHCfrhr022911
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Nov 2014 20:41:53 +0800
Message-ID: <1416228009.10929.4.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Mon, 17 Nov 2014 20:40:09 +0800
In-Reply-To: <1416227892.10929.1.camel@G08JYZSD130126.localdomain>
References: <1416227892.10929.1.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Subject: [LTP] [PATCH 3/5] ima_policy.sh: Some cleanup
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

* Install 'policy' into '$LTPROOT/testcases/data'.

* Use 'test_resm' instead of 'tst_res'.

* Delete some unuseful comments.

* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 .../kernel/security/integrity/ima/policy/Makefile  |   2 +-
 .../security/integrity/ima/tests/ima_policy.sh     | 105 ++++++---------------
 2 files changed, 31 insertions(+), 76 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/policy/Makefile b/testcases/kernel/security/integrity/ima/policy/Makefile
index c16302d..1d34ec2 100644
--- a/testcases/kernel/security/integrity/ima/policy/Makefile
+++ b/testcases/kernel/security/integrity/ima/policy/Makefile
@@ -24,7 +24,7 @@ top_srcdir		?= ../../../../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_DIR		:= testcases/bin/policy
+INSTALL_DIR		:= testcases/data/ima_policy
 
 INSTALL_TARGETS		:= measure*
 
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
index d40322a..69f9f3e 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
@@ -25,39 +25,28 @@
 #		policy.
 #
 # Author:       Mimi Zohar, zohar@ibm.vnet.ibm.com
-#
-# Return        - zero on success
-#               - non zero on failure. return value from commands ($RC)
 ################################################################################
+export TST_TOTAL=3
+export TCID="ima_policy"
+export TST_COUNT=0
+
 init()
 {
-	export TST_TOTAL=3
-	export TCID="init"
-	export TST_COUNT=0
-	RC=0
-
 	# verify using default policy
 	IMA_POLICY=$IMA_DIR/policy
 	if [ ! -f $IMA_POLICY ]; then
-		tst_res TINFO $LTPTMP/imalog.$$ \
-		 "$TCID: default policy already replaced"
-		  RC=1
+		tst_resm TINFO "default policy already replaced"
 	fi
 
-	VALID_POLICY=`dirname $0`\/..\/policy/measure.policy
+	VALID_POLICY=$LTPROOT/testcases/data/ima_policy/measure.policy
 	if [ ! -f $VALID_POLICY ]; then
-		tst_res TINFO $LTPTMP/imalog.$$ \
-		 "$TCID: missing $VALID_POLICY"
-		  RC=1
+		tst_resm TINFO "missing $VALID_POLICY"
 	fi
 
-	INVALID_POLICY=`dirname $0`\/..\/policy/measure.policy-invalid
+	INVALID_POLICY=$LTPROOT/testcases/data/ima_policy/measure.policy-invalid
 	if [ ! -f $INVALID_POLICY ]; then
-		tst_res TINFO $LTPTMP/imalog.$$ \
-		 "$TCID: missing $INVALID_POLICY"
-		  RC=1
+		tst_resm TINFO "missing $INVALID_POLICY"
 	fi
-	return $RC
 }
 
 load_policy()
@@ -74,8 +63,7 @@ load_policy()
 			echo $line >&4 2> /dev/null
 			if [ $? -ne 0 ]; then
 				exec 4>&-
-				RC=1
-				return $RC
+				return 1
 			fi
 		fi
 	}
@@ -87,22 +75,13 @@ load_policy()
 # Description   - Verify invalid policy doesn't replace default policy.
 test01()
 {
-	TCID="test01"
-	TST_COUNT=1
-	RC=0
-
 	load_policy $INVALID_POLICY & p1=$!
-	wait "$p1"; RC=$?
-	if [ $RC -ne 0 ]; then
-		RC=0
-		tst_res TPASS $LTPTMP/imalog.$$ \
-		 "$TCID: didn't load invalid policy"
+	wait "$p1"
+	if [ $? -ne 0 ]; then
+		tst_resm TPASS "didn't load invalid policy"
 	else
-		RC=1
-		tst_res TFAIL $LTPTMP/imalog.$$ \
-		 "$TCID: loaded invalid policy"
+		tst_resm TFAIL "loaded invalid policy"
 	fi
-	return $RC
 }
 
 # Function:     test02
@@ -110,63 +89,39 @@ test01()
 #		  and install new policy
 test02()
 {
-	TCID="test02"
-	TST_COUNT=2
-	RC=0
-
 	load_policy $VALID_POLICY & p1=$!  # forked process 1
 	load_policy $VALID_POLICY & p2=$!  # forked process 2
 	wait "$p1"; RC1=$?
 	wait "$p2"; RC2=$?
 	if [ $RC1 -eq 0 ] && [ $RC2 -eq 0 ]; then
-		tst_res TFAIL $LTPTMP/imalog.$$ \
-		 "$TCID: measurement policy opened concurrently"
+		tst_resm TFAIL "measurement policy opened concurrently"
 	elif [ $RC1 -eq 0 ] || [ $RC2 -eq 0 ]; then
-		RC=0
-		tst_res TPASS $LTPTMP/imalog.$$ \
-		 "$TCID: replaced default measurement policy"
+		tst_resm TPASS "replaced default measurement policy"
 	else
-		tst_res TFAIL $LTPTMP/imalog.$$ \
-		 "$TCID: problems opening measurement policy"
+		tst_resm TFAIL "problems opening measurement policy"
 	fi
-	return 0
 }
 
 # Function:     test03
 # Description 	- Verify can't load another measurement policy.
 test03()
 {
-	TCID="test03"
-	TST_COUNT=3
-	RC=0
-
 	load_policy $INVALID_POLICY & p1=$!
-	wait "$p1"; RC=$?
-	if [ $RC -ne 0 ]; then
-		RC=0
-		tst_res TPASS $LTPTMP/imalog.$$ \
-		 "$TCID: didn't replace valid policy"
+	wait "$p1"
+	if [ $? -ne 0 ]; then
+		tst_resm TPASS "didn't replace valid policy"
 	else
-		RC=1
-		tst_res TFAIL $LTPTMP/imalog.$$ "$TCID: replaced valid policy"
+		tst_resm TFAIL "replaced valid policy"
 	fi
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
+. ima_setup.sh
+TST_CLEANUP=cleanup
+
+setup
+init
+test01
+test02
+test03
 
-. $(dirname "$0")/ima_setup.sh
-setup || exit $?
-init || exit $?
-test01 || EXIT_VAL=$RC
-test02 || EXIT_VAL=$RC
-test03 || EXIT_VAL=$RC
-exit $EXIT_VAL
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
