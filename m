Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shiwh@cn.fujitsu.com>) id 1NbuPD-0001M7-N4
	for ltp-list@lists.sourceforge.net; Mon, 01 Feb 2010 11:25:23 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NbuPA-000886-HU
	for ltp-list@lists.sourceforge.net; Mon, 01 Feb 2010 11:25:23 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 3CCEC170028
	for <ltp-list@lists.sourceforge.net>;
	Mon,  1 Feb 2010 19:25:09 +0800 (CST)
Received: from fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id o11BOVjT020462
	for <ltp-list@lists.sourceforge.net>; Mon, 1 Feb 2010 19:24:31 +0800
Received: from [10.167.141.106] (unknown [10.167.141.106])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 1E277D47AE
	for <ltp-list@lists.sourceforge.net>;
	Mon,  1 Feb 2010 19:26:30 +0800 (CST)
Message-ID: <4B66BA12.1050707@cn.fujitsu.com>
Date: Mon, 01 Feb 2010 19:25:06 +0800
From: Shi Weihua <shiwh@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] sysctl03: sysctl returns EACCES after 2.6.33-rc1
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

The syscall of sysctl has been changed function call process on 2.6.33-rc1.
So we should change some code about sysctl.

Before 2.6.33-rc1:
do_sysctl
	->parse_table
		->sysctl_perm		(will return EPERM sometime)
		->do_sysctl_strategy
			->sysctl_perm	(will return EPERM sometime)
...

After 2.6.33-rc1:
do_sysctl
	->binary_sysctl
		check enable to access or not	(will return EACCES some time)
...

I fixed sysctl03, other cases of sysctl are OK.
This patch works on 2.6.31.5-127.fc12.x86_64, 2.6.32, 2.6.33-rc1, 
and 2.6.33-rc6.

Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
---
--- testcases/kernel/syscalls/sysctl/sysctl03.c.orig	2010-02-02 18:15:56.000000000 +0800
+++ testcases/kernel/syscalls/sysctl/sysctl03.c	2010-02-02 18:49:40.000000000 +0800
@@ -22,15 +22,18 @@
  *	sysctl03.c
  *
  * DESCRIPTION
- *	Testcase to check that sysctl(2) sets errno to EPERM correctly.
+ *	Testcase to check that sysctl(2) sets errno to EPERM or EACCES 
+ *	correctly. But it will return EACCES on kernels that are 2.6.33-rc1 
+ *	and higher.  
  *
  * ALGORITHM
  *	a.	Call sysctl(2) as a root user, and attempt to write data
  *		to the kernel_table[]. Since the table does not have write
- *		permissions even for the root, it should fail EPERM.
+ *		permissions even for the root, it should fail EPERM or EACCES.
  *	b.	Call sysctl(2) as a non-root user, and attempt to write data
  *		to the kernel_table[]. Since the table does not have write
- *		permission for the regular user, it should fail with EPERM.
+ *		permission for the regular user, it should fail with EPERM 
+ *		or EACCES.
  *
  * USAGE:  <for command-line>
  *  sysctl03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
@@ -43,6 +46,7 @@
  *
  * HISTORY
  *	07/2001 Ported by Wayne Boyer
+ *	02/2010 Updated by shiwh@cn.fujitsu.com
  *
  * RESTRICTIONS
  *	Test must be run as root.
@@ -82,6 +86,7 @@ int main(int ac, char **av)
 {
 	int lc;
 	char *msg;
+	int exp_eno;
 
 	char osname[OSNAMESZ];
 	int osnamelth, status;
@@ -96,6 +101,13 @@ int main(int ac, char **av)
 
 	setup();
 
+	if ((tst_kvercmp(2, 6, 32)) <= 0){
+		exp_eno = EPERM;
+	} else {
+		exp_eno = EACCES;
+		exp_enos[0] = EACCES;
+	}
+
 	TEST_EXP_ENOS(exp_enos);
 
 	/* check looping state if -i option is given */
@@ -114,13 +126,13 @@ int main(int ac, char **av)
 		} else {
 			TEST_ERROR_LOG(TEST_ERRNO);
 
-			if (TEST_ERRNO != EPERM) {
+			if (TEST_ERRNO != exp_eno) {
 				tst_resm(TFAIL,
-					 "Expected EPERM (%d), got %d: %s",
-					 EPERM, TEST_ERRNO,
+					 "Expected %s (%d), got %d: %s",
+					 strerror(exp_eno), exp_eno, TEST_ERRNO,
 					 strerror(TEST_ERRNO));
 			} else {
-				tst_resm(TPASS, "Got expected EPERM error");
+				tst_resm(TPASS, "Got expected %s error", strerror(exp_eno));
 			}
 		}
 
@@ -147,12 +159,12 @@ int main(int ac, char **av)
 			} else {
 				TEST_ERROR_LOG(TEST_ERRNO);
 
-				if (TEST_ERRNO != EPERM) {
-					tst_resm(TFAIL, "Expected EPERM, got "
-						 "%d", TEST_ERRNO);
+				if (TEST_ERRNO != exp_eno) {
+					tst_resm(TFAIL, "Expected %s, got "
+						 "%d", strerror(exp_eno), TEST_ERRNO);
 				} else {
-					tst_resm(TPASS, "Got expected EPERM "
-						 "error");
+					tst_resm(TPASS, "Got expected %s "
+						 "error", strerror(exp_eno));
 				}
 			}
 

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
