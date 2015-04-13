Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Yhavn-0004rG-6w
	for ltp-list@lists.sourceforge.net; Mon, 13 Apr 2015 09:45:27 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Yhavm-00066N-7t
	for ltp-list@lists.sourceforge.net; Mon, 13 Apr 2015 09:45:27 +0000
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t3D9jJun005767
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Apr 2015 09:45:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t3D9jJH0024156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Apr 2015 09:45:19 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t3D9jIAA027345
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Apr 2015 09:45:19 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 13 Apr 2015 12:45:10 +0300
Message-Id: <1428918310-5180-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1428918310-5180-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1428918310-5180-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 2/2] sem_comm: pass a semun union to semctl()
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
Cc: vasily.isaenko@oracle.com

It's required by the semctl() API plus without that the test
case may fail on 64-bit Big Endian systems (like sparc64).

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/containers/sysvipc/sem_comm.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/containers/sysvipc/sem_comm.c b/testcases/kernel/containers/sysvipc/sem_comm.c
index 157ba0c..3d7e7bb 100644
--- a/testcases/kernel/containers/sysvipc/sem_comm.c
+++ b/testcases/kernel/containers/sysvipc/sem_comm.c
@@ -36,6 +36,7 @@
 #include "safe_macros.h"
 #include "libclone.h"
 #include "ipcns_helper.h"
+#include "lapi/semun.h"
 
 #define TESTKEY 124426L
 char *TCID	= "sem_comm";
@@ -57,6 +58,7 @@ static void setup(void)
 int chld1_sem(void *arg)
 {
 	int id;
+	union semun su;
 	struct sembuf sm;
 
 	id = semget(TESTKEY, 1, IPC_CREAT);
@@ -65,7 +67,8 @@ int chld1_sem(void *arg)
 		return 2;
 	}
 
-	if (semctl(id, 0, SETVAL, 1) == -1) {
+	su.val = 1;
+	if (semctl(id, 0, SETVAL, su) == -1) {
 		perror("semctl");
 		semctl(id, 0, IPC_RMID);
 		return 2;
@@ -97,6 +100,7 @@ int chld2_sem(void *arg)
 {
 	int id, rval = 0;
 	struct sembuf sm;
+	union semun su;
 
 	/* wait for child1 to create the semaphore */
 	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
@@ -107,7 +111,8 @@ int chld2_sem(void *arg)
 		return 2;
 	}
 
-	if (semctl(id, 0, SETVAL, 1) == -1) {
+	su.val = 1;
+	if (semctl(id, 0, SETVAL, su) == -1) {
 		perror("semctl");
 		semctl(id, 0, IPC_RMID);
 		return 2;
-- 
1.7.1


------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
