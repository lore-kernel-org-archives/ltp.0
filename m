Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XnqKv-0005p1-TI
	for ltp-list@lists.sourceforge.net; Mon, 10 Nov 2014 14:52:57 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XnqKt-0001Vb-9T
	for ltp-list@lists.sourceforge.net; Mon, 10 Nov 2014 14:52:57 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sAAEqmEe022321
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Nov 2014 09:52:48 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id sAAEqfv4008892
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Nov 2014 09:52:48 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 10 Nov 2014 15:52:28 +0100
Message-Id: <70e7f4426aa311eb3314a5939bcca02fac28386c.1415630966.git.jstancek@redhat.com>
In-Reply-To: <83f98a9de7c4e97c958bd7f9c33610898b998e29.1415630966.git.jstancek@redhat.com>
References: <83f98a9de7c4e97c958bd7f9c33610898b998e29.1415630966.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 2/2 v4] cpuset_syscall_testset.sh: check TCONF for
	do_syscall_test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

If HAVE_DECL_MPOL_F_MEMS_ALLOWED is not defined, test returns -1,
which is evaluted as failure.

Treat it as TCONF, but don't break the execution, cpuset_syscall_testset.sh
script is expecting to handle stopping/waiting for children by itself.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../cpuset_syscall_test/cpuset_syscall_test.c      |   10 ++--
 .../cpuset_syscall_test/cpuset_syscall_testset.sh  |   68 ++++++++++++--------
 2 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
index e202295..0a36763 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
@@ -128,7 +128,7 @@ void sigint_handler(int __attribute__ ((unused)) signo)
 void test_setaffinity(void)
 {
 	cpu_set_t tmask;
-	int i;
+	unsigned int i;
 	CPU_ZERO(&tmask);
 	for (i = 0; i < 8 * sizeof(mask); i++) {
 		if ((1 << i) & mask)
@@ -140,7 +140,7 @@ void test_setaffinity(void)
 void test_getaffinity(void)
 {
 	cpu_set_t tmask;
-	int i;
+	unsigned int i;
 	CPU_ZERO(&tmask);
 	ret = sched_getaffinity(0, sizeof(tmask), &tmask);
 	for (i = 0; i < 8 * sizeof(mask); i++) {
@@ -190,7 +190,8 @@ void test_get_mempolicy(void)
 	ret = get_mempolicy(NULL, bitmask_mask(nmask), bitmask_nbits(nmask), 0,
 			    MPOL_F_MEMS_ALLOWED);
 #else
-	ret = -1;
+	tst_resm(TCONF, "don't have MPOL_F_MEMS_ALLOWED");
+	ret = TCONF;
 #endif
 
 	bitmask_displaylist(str, 256, nmask);
@@ -243,7 +244,6 @@ int main(int argc, char *argv[])
 #else
 int main(void)
 {
-	printf("System doesn't have required mempolicy support\n");
-	tst_exit();
+	tst_brkm(TCONF, NULL, "System doesn't have required mempolicy support");
 }
 #endif
diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
index 561c3b9..771b642 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
@@ -30,6 +30,8 @@ export TST_COUNT=1
 
 check
 
+tst_flag2mask TCONF
+TCONF=$?
 exit_status=0
 
 nr_mems=$N_NODES
@@ -80,6 +82,11 @@ do_syscall_test()
 	/bin/kill -s SIGINT $testpid
 	wait $testpid
 	ret=$?
+
+	if [ "$ret" -eq "$TCONF" ]; then
+		return $TCONF
+	fi
+
 	if [ $4 -eq 0 ]; then
 		if [ $ret -ne 0 ]; then
 			tst_resm TFAIL "Test task exited abnormally.(expect return value is 0)"
@@ -96,7 +103,7 @@ do_syscall_test()
 
 test1()
 {
-	do_syscall_test 0 0 --setaffinity=1 0 || return 1
+	do_syscall_test 0 0 --setaffinity=1 0 || return $?
 	allowed_list="$(awk '/Cpus_allowed_list:/{print $2}' $TEST_PROCSTATUS )"
 	test "$allowed_list" = "0"
 	if [ $? -ne 0 ]; then
@@ -108,7 +115,7 @@ test1()
 
 test2()
 {
-	do_syscall_test 0-1 0 --setaffinity=1 0 || return 1
+	do_syscall_test 0-1 0 --setaffinity=1 0 || return $?
 	allowed_list="$(awk '/Cpus_allowed_list:/{print $2}' $TEST_PROCSTATUS )"
 	test "$allowed_list" = "0"
 	if [ $? -ne 0 ]; then
@@ -120,7 +127,7 @@ test2()
 
 test3()
 {
-	do_syscall_test 0-1 0 --setaffinity=6 0 || return 1
+	do_syscall_test 0-1 0 --setaffinity=6 0 || return $?
 	allowed_list="$(awk '/Cpus_allowed_list:/{print $2}' $TEST_PROCSTATUS )"
 	test "$allowed_list" = "1"
 	if [ $? -ne 0 ]; then
@@ -132,7 +139,7 @@ test3()
 
 test4()
 {
-	do_syscall_test 0-1 0 --setaffinity=12 1 || return 1
+	do_syscall_test 0-1 0 --setaffinity=12 1 || return $?
 	allowed_list="$(awk '/Cpus_allowed_list:/{print $2}' $TEST_PROCSTATUS )"
 	test "$allowed_list" = "0-1" || return 1
 	if [ $? -ne 0 ]; then
@@ -144,7 +151,7 @@ test4()
 
 test5()
 {
-	do_syscall_test 0 0 --getaffinity 0 || return 1
+	do_syscall_test 0 0 --getaffinity 0 || return $?
 	allowed_list="$(awk '/Cpus_allowed_list:/{print $2}' $TEST_PROCSTATUS )"
 	test "$(cat "$TEST_OUTPUT")" = "0,"
 	if [ $? -ne 0 ]; then
@@ -161,7 +168,7 @@ test5()
 
 test6()
 {
-	do_syscall_test 0-1 0 --getaffinity 0 || return 1
+	do_syscall_test 0-1 0 --getaffinity 0 || return $?
 	allowed_list="$(awk '/Cpus_allowed_list:/{print $2}' $TEST_PROCSTATUS )"
 	test "$(cat "$TEST_OUTPUT")" = "0,1,"
 	if [ $? -ne 0 ]; then
@@ -178,7 +185,7 @@ test6()
 
 test7()
 {
-	do_syscall_test 0 0 --mbind=1 0 || return 1
+	do_syscall_test 0 0 --mbind=1 0 || return $?
 	memory_addr="$(cat $TEST_OUTPUT)"
 	memory_addr=${memory_addr##*0x}
 	allowed_list=$(cat $TEST_PROCNUMA | grep "$memory_addr" | \
@@ -194,7 +201,7 @@ test7()
 
 test8()
 {
-	do_syscall_test 0 0-1 --mbind=1 0 || return 1
+	do_syscall_test 0 0-1 --mbind=1 0 || return $?
 	memory_addr="$(cat $TEST_OUTPUT)"
 	memory_addr=${memory_addr##*0x}
 	allowed_list=$(cat $TEST_PROCNUMA | grep "$memory_addr" | \
@@ -210,7 +217,7 @@ test8()
 
 test9()
 {
-	do_syscall_test 0 0-1 --mbind=6 0 || return 1
+	do_syscall_test 0 0-1 --mbind=6 0 || return $?
 	memory_addr="$(cat $TEST_OUTPUT)"
 	memory_addr=${memory_addr##*0x}
 	allowed_list=$(cat $TEST_PROCNUMA | grep "$memory_addr" | \
@@ -226,7 +233,7 @@ test9()
 
 test10()
 {
-	do_syscall_test 0 0 --mbind=6 1 || return 1
+	do_syscall_test 0 0 --mbind=6 1 || return $?
 	memory_addr="$(cat $TEST_OUTPUT)"
 	memory_addr=${memory_addr##*0x}
 	allowed_list=$(cat $TEST_PROCNUMA | grep "$memory_addr" | \
@@ -264,14 +271,14 @@ check_result()
 
 test11()
 {
-	do_syscall_test 0 0 --set_mempolicy=1 0 || return 1
+	do_syscall_test 0 0 --set_mempolicy=1 0 || return $?
 	check_result "0"
 	return $?
 }
 
 test12()
 {
-	do_syscall_test 0 0-1 --set_mempolicy=1 0 || return 1
+	do_syscall_test 0 0-1 --set_mempolicy=1 0 || return $?
 	check_result "0"
 	return $?
 }
@@ -279,9 +286,9 @@ test12()
 test13()
 {
 	if [ $nr_mems -ge 3 ]; then
-		do_syscall_test 0 0-1 --set_mempolicy=6 0 || return 1
+		do_syscall_test 0 0-1 --set_mempolicy=6 0 || return $?
 	else
-		do_syscall_test 0 0-1 --set_mempolicy=2 0 || return 1
+		do_syscall_test 0 0-1 --set_mempolicy=2 0 || return $?
 	fi
 	check_result "1"
 	return $?
@@ -290,16 +297,16 @@ test13()
 test14()
 {
 	if [ $nr_mems -ge 3 ]; then
-		do_syscall_test 0 0 --set_mempolicy=6 1 || return 1
+		do_syscall_test 0 0 --set_mempolicy=6 1 || return $?
 	else
-		do_syscall_test 0 0 --set_mempolicy=2 1 || return 1
+		do_syscall_test 0 0 --set_mempolicy=2 1 || return $?
 	fi
 	return 0
 }
 
 test15()
 {
-	do_syscall_test 0 0 --get_mempolicy 0 || return 1
+	do_syscall_test 0 0 --get_mempolicy 0 || return $?
 	allowed_list="$(awk '/Mems_allowed_list:/{print $2}' $TEST_PROCSTATUS )"
 	test "$(cat "$TEST_OUTPUT")" = "0"
 	if [ $? -ne 0 ]; then
@@ -316,7 +323,7 @@ test15()
 
 test16()
 {
-	do_syscall_test 0 0-1 --get_mempolicy 0 || return 1
+	do_syscall_test 0 0-1 --get_mempolicy 0 || return $?
 	allowed_list="$(awk '/Mems_allowed_list:/{print $2}' $TEST_PROCSTATUS )"
 	test "$(cat "$TEST_OUTPUT")" = "0-1"
 	if [ $? -ne 0 ]; then
@@ -333,22 +340,27 @@ test16()
 
 for c in $(seq 1 $TST_TOTAL)
 do
+	tst_resm TINFO "Starting test no. $c"
 	setup
 	if [ $? -ne 0 ]; then
 		exit_status=1
 	else
 		test$c
-		if [ $? -ne 0 ]; then
+		ret=$?
+		cleanup
+		ret=$((ret | $?))
+
+		case $ret in
+		0)
+			tst_resm TPASS "Cpuset vs systemcall test succeeded."
+			;;
+		"$TCONF")
+			tst_resm TCONF "Test exited with TCONF"
+			;;
+		*)
 			exit_status=1
-			cleanup
-		else
-			cleanup
-			if [ $? -ne 0 ]; then
-				exit_status=1
-			else
-				tst_resm TPASS "Cpuset vs systemcall test succeeded."
-			fi
-		fi
+			;;
+		esac
 	fi
 	TST_COUNT=$(($TST_COUNT + 1))
 done
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
