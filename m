Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UbiTh-0001bW-BY
	for ltp-list@lists.sourceforge.net; Mon, 13 May 2013 02:27:05 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UbiTf-0006Qg-R4
	for ltp-list@lists.sourceforge.net; Mon, 13 May 2013 02:27:05 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r4D2QrbS013234
	for <ltp-list@lists.sourceforge.net>; Mon, 13 May 2013 10:26:53 +0800
Message-ID: <51904EE1.9020309@cn.fujitsu.com>
Date: Mon, 13 May 2013 10:24:33 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <51904E37.9090906@cn.fujitsu.com>
In-Reply-To: <51904E37.9090906@cn.fujitsu.com>
Subject: [LTP] [PATCH V2 2/2]semctl/semctl01.c: Test features IPC_INFO,
 SEM_INFO and SEM_STAT
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
To: LTP list <ltp-list@lists.sourceforge.net>


Additional tests for features IPC_INFO, SEM_INFO and SEM_STAT.


Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ipc/semctl/semctl01.c | 39 ++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl01.c b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
index ff734f8..687d909 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl01.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
@@ -41,11 +41,15 @@
  *	call cleanup
  */

+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
 #include "ipcsem.h"
 #include "libtestsuite.h"

 char *TCID = "semctl01";
-int TST_TOTAL = 10;
+int TST_TOTAL = 13;

 static int sem_id_1 = -1;

@@ -66,8 +70,12 @@ static void func_sval(void);
 static void func_rmid(void);
 static void child_cnt(void);
 static void child_pid(void);
+static void func_iinfo(int);
+static void func_sinfo(void);
+static void func_sstat(int);

 static struct semid_ds buf;
+static struct seminfo ipc_buf;
 static unsigned short array[PSEMS];
 static struct sembuf sops;

@@ -107,6 +115,9 @@ static struct test_case_t {
 	{SEM4, GETZCNT, func_cnt, SEMUN_CAST & buf, cnt_setup},
 	{0, SETALL, func_sall, SEMUN_CAST array, sall_setup},
 	{SEM4, SETVAL, func_sval, SEMUN_CAST INCVAL, NULL},
+	{0, IPC_INFO, func_iinfo, SEMUN_CAST & ipc_buf, NULL},
+	{0, SEM_INFO, func_sinfo, SEMUN_CAST & ipc_buf, NULL},
+	{0, SEM_STAT, func_sstat, SEMUN_CAST & buf, NULL},
 	{0, IPC_RMID, func_rmid, SEMUN_CAST & buf, NULL},
 };

@@ -170,6 +181,8 @@ int main(int argc, char *argv[])
 					case GETZCNT:
 					case GETPID:
 					case GETVAL:
+					case IPC_INFO:
+					case SEM_STAT:
 						(*TC[i].func_test)
 						    (TEST_RETURN);
 						break;
@@ -545,6 +558,30 @@ static void func_rmid(void)
 	sem_id_1 = -1;
 }

+static void func_iinfo(int hidx)
+{
+	if (hidx >= 0)
+		tst_resm(TPASS, "the highest index is correct");
+	else
+		tst_resm(TFAIL, "the highest index is incorrect");
+}
+
+static void func_sinfo(void)
+{
+	if (ipc_buf.semusz < 1)
+		tst_resm(TFAIL, "number of semaphore sets is incorrect");
+	else
+		tst_resm(TPASS, "number of semaphore sets is correct");
+}
+
+static void func_sstat(int semidx)
+{
+	if (semidx >= 0)
+		tst_resm(TPASS, "id of the semaphore set is correct");
+	else
+		tst_resm(TFAIL, "id of the semaphore set is incorrect");
+}
+
 void setup(void)
 {

-- 
1.8.3

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
