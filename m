Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UaMXE-0005X6-EP
	for ltp-list@lists.sourceforge.net; Thu, 09 May 2013 08:49:08 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UaMXC-0003RF-Vr
	for ltp-list@lists.sourceforge.net; Thu, 09 May 2013 08:49:08 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r498n0ZA011923
	for <ltp-list@lists.sourceforge.net>; Thu, 9 May 2013 16:49:00 +0800
Message-ID: <518B6271.2030707@cn.fujitsu.com>
Date: Thu, 09 May 2013 16:46:41 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <518B618F.80400@cn.fujitsu.com>
In-Reply-To: <518B618F.80400@cn.fujitsu.com>
Subject: [LTP]  [PATCH 2/2]semctl/semctl01.c: Test features IPC_INFO,
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
 testcases/kernel/syscalls/ipc/semctl/semctl01.c | 45 +++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl01.c b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
index 93d7cd7..8e5c907 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl01.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
@@ -32,11 +32,19 @@
  *        system. Fix this by using pipes to synchronize processes.
  */

+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
 #include "ipcsem.h"
 #include "libtestsuite.h"

 char *TCID = "semctl01";
+
+#ifdef __linux__
+int TST_TOTAL = 13;
+#else
 int TST_TOTAL = 10;
+#endif

 static int sem_id_1 = -1;

@@ -57,8 +65,14 @@ static void func_sval(void);
 static void func_rmid(void);
 static void child_cnt(void);
 static void child_pid(void);
+#ifdef __linux__
+static void func_iinfo(int);
+static void func_sinfo(void);
+static void func_sstat(int);
+#endif

 static struct semid_ds buf;
+static struct seminfo ipc_buf;
 static unsigned short array[PSEMS];
 static struct sembuf sops;

@@ -98,6 +112,11 @@ static struct test_case_t {
 	{SEM4, GETZCNT, func_cnt, SEMUN_CAST & buf, cnt_setup},
 	{0, SETALL, func_sall, SEMUN_CAST array, sall_setup},
 	{SEM4, SETVAL, func_sval, SEMUN_CAST INCVAL, NULL},
+#ifdef __linux__
+	{0, IPC_INFO, func_iinfo, SEMUN_CAST & ipc_buf, NULL},
+	{0, SEM_INFO, func_sinfo, SEMUN_CAST & ipc_buf, NULL},
+	{0, SEM_STAT, func_sstat, SEMUN_CAST & buf, NULL},
+#endif
 	{0, IPC_RMID, func_rmid, SEMUN_CAST & buf, NULL},
 };

@@ -161,6 +180,8 @@ int main(int argc, char *argv[])
 					case GETZCNT:
 					case GETPID:
 					case GETVAL:
+					case IPC_INFO:
+					case SEM_STAT:
 						(*TC[i].func_test)
 						    (TEST_RETURN);
 						break;
@@ -536,6 +557,30 @@ static void func_rmid(void)
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
1.8.1



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
