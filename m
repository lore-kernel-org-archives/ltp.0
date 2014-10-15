Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XeP1P-0006Vj-Gd
	for ltp-list@lists.sourceforge.net; Wed, 15 Oct 2014 13:53:47 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XeP1M-0006NP-SV
	for ltp-list@lists.sourceforge.net; Wed, 15 Oct 2014 13:53:47 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s9FDramI013350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 15 Oct 2014 09:53:36 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s9FDrZjB024530
	for <ltp-list@lists.sourceforge.net>; Wed, 15 Oct 2014 09:53:35 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 15 Oct 2014 15:53:33 +0200
Message-Id: <992ad8725f3114b5a853d27cb1b392cbb80d2300.1413381032.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] cpuset_syscall_testset.sh: check TCONF for test 15, 16
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

If HAVE_DECL_MPOL_F_MEMS_ALLOWED is not defined, test 15 and 16,
returns -1, which is evaluted as failure.

Treat it as TCONF, but don't break the execution, cpuset_syscall_testset.sh
script is expecting to handle stopping/waiting for children by itself.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../cpuset_syscall_test/cpuset_syscall_test.c      |    6 ++--
 .../cpuset_syscall_test/cpuset_syscall_testset.sh  |   26 ++++++++++++++++++-
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
index e202295..407b8c9 100644
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
@@ -190,7 +190,7 @@ void test_get_mempolicy(void)
 	ret = get_mempolicy(NULL, bitmask_mask(nmask), bitmask_nbits(nmask), 0,
 			    MPOL_F_MEMS_ALLOWED);
 #else
-	ret = -1;
+	tst_resm(TCONF, "don't have MPOL_F_MEMS_ALLOWED");
 #endif
 
 	bitmask_displaylist(str, 256, nmask);
diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
index 561c3b9..a32a9b0 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
@@ -299,7 +299,18 @@ test14()
 
 test15()
 {
-	do_syscall_test 0 0 --get_mempolicy 0 || return 1
+	do_syscall_test 0 0 --get_mempolicy 0
+	ret=$?
+
+	grep "TCONF" "$TEST_OUTPUT"
+	if [ $? -eq 0 ]; then
+		return 0
+	fi
+
+	if [ $ret -ne 0 ]; then
+		return 1
+	fi
+
 	allowed_list="$(awk '/Mems_allowed_list:/{print $2}' $TEST_PROCSTATUS )"
 	test "$(cat "$TEST_OUTPUT")" = "0"
 	if [ $? -ne 0 ]; then
@@ -316,7 +327,18 @@ test15()
 
 test16()
 {
-	do_syscall_test 0 0-1 --get_mempolicy 0 || return 1
+	do_syscall_test 0 0-1 --get_mempolicy 0
+	ret=$?
+
+	grep "TCONF" "$TEST_OUTPUT"
+	if [ $? -eq 0 ]; then
+		return 0
+	fi
+
+	if [ $ret -ne 0 ]; then
+		return 1
+	fi
+
 	allowed_list="$(awk '/Mems_allowed_list:/{print $2}' $TEST_PROCSTATUS )"
 	test "$(cat "$TEST_OUTPUT")" = "0-1"
 	if [ $? -ne 0 ]; then
-- 
1.7.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
