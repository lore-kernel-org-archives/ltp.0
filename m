Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1TT9RK-0000lV-82
	for ltp-list@lists.sourceforge.net; Tue, 30 Oct 2012 10:52:58 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TT9RE-00064m-Ai
	for ltp-list@lists.sourceforge.net; Tue, 30 Oct 2012 10:52:58 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q9UAqkNm006335
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Oct 2012 06:52:46 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id q9UAqiF5017776
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Oct 2012 06:52:45 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 30 Oct 2012 11:52:42 +0100
Message-Id: <7714323b7c85bc53de14c05d1f5b47085a9a7ae2.1351593924.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v4] ipc/shmat: pick suitable base_addr before each
	testcase
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

This test picked fixed address in setup() which was used throughout
the test. There has been reports that it can fail with EINVAL.

I could reproduce it by adding single printf in between
detach/attach:
http://article.gmane.org/gmane.linux.ltp/16480

This patch picks suitable base_addr before each test. So even if glibc
would mmap extra page with addr == base_addr picked by setup(),
new suitable address will be chosen.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/ipc/shmat/shmat01.c      |   18 ++---------
 testcases/kernel/syscalls/ipc/shmat/shmat02.c      |   16 +--------
 testcases/kernel/syscalls/ipc/shmat/shmat_common.h |   33 ++++++++++++++++++++
 3 files changed, 38 insertions(+), 29 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ipc/shmat/shmat_common.h

diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
index 6e4dee1..b64cf61 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
@@ -56,6 +56,7 @@
  */
 
 #include "ipcshm.h"
+#include "shmat_common.h"
 
 char *TCID = "shmat01";
 
@@ -108,6 +109,7 @@ int main(int ac, char **av)
 			/*
 			 * Use TEST macro to make the call
 			 */
+			base_addr = probe_free_addr();
 			errno = 0;
 			addr = shmat(*(TC[i].shmid), base_addr+TC[i].offset,
 				     TC[i].flags);
@@ -128,7 +130,7 @@ int main(int ac, char **av)
 			 * clean up things in case we are looping - in
 			 * this case, detach the shared memory
 			 */
-			if (shmdt((const void *)addr) == -1) {
+			if (shmdt(addr) == -1) {
 				tst_brkm(TBROK, cleanup,
 					 "Couldn't detach shared memory");
 			}
@@ -261,20 +263,6 @@ void setup(void)
 		tst_brkm(TBROK, cleanup, "Failed to create shared memory "
 			 "resource 1 in setup()");
 	}
-
-	/* Probe an available linear address for attachment */
-	if ((base_addr = shmat(shm_id_1, NULL, 0)) == (void *)-1) {
-		tst_brkm(TBROK, cleanup, "Couldn't attach shared memory");
-	}
-	if (shmdt((const void *)base_addr) == -1) {
-		tst_brkm(TBROK, cleanup, "Couldn't detach shared memory");
-	}
-
-	/* some architectures (e.g. parisc) are strange, so better always align to
-	 * next SHMLBA address. */
-	base_addr =
-	    (void *)(((unsigned long)(base_addr) + (SHMLBA - 1)) &
-		     ~(SHMLBA - 1));
 }
 
 /*
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat02.c b/testcases/kernel/syscalls/ipc/shmat/shmat02.c
index d4cca0e..af28d6c 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat02.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat02.c
@@ -55,6 +55,7 @@
 
 #include "ipcshm.h"
 #include <pwd.h>
+#include "shmat_common.h"
 
 char *TCID = "shmat02";
 char nobody_uid[] = "nobody";
@@ -125,6 +126,7 @@ int main(int ac, char **av)
 
 			setup_tc(i, tc);
 
+			base_addr = probe_free_addr();
 			errno = 0;
 			addr = shmat(*(tc->shmid), base_addr + tc->offset, 0);
 
@@ -180,20 +182,6 @@ void setup(void)
 	if ((shm_id_3 = shmget(shmkey2, INT_SIZE, IPC_CREAT|IPC_EXCL)) ==
 	    -1)
 		tst_brkm(TBROK|TERRNO, cleanup, "shmget #2 failed");
-
-	/* Probe an available linear address for attachment */
-	if ((base_addr = shmat(shm_id_2, NULL, 0)) == (void *)-1)
-		tst_brkm(TBROK|TERRNO, cleanup, "shmat #1 failed");
-
-	if (shmdt((const void *)base_addr) == -1)
-		tst_brkm(TBROK|TERRNO, cleanup, "shmat #2 failed");
-
-	/*
-	 * some architectures (e.g. parisc) are strange, so better always align
-	 * to next SHMLBA address
-	 */
-	base_addr =
-	    (void *)(((unsigned long)(base_addr) & ~(SHMLBA - 1)) + SHMLBA);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat_common.h b/testcases/kernel/syscalls/ipc/shmat/shmat_common.h
new file mode 100644
index 0000000..06cf5ab
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat_common.h
@@ -0,0 +1,33 @@
+static key_t probe_key;
+
+void *probe_free_addr(void)
+{
+	void *p;
+	int ret;
+	int shm_id = -1;
+
+	if (probe_key == 0)
+		probe_key = getipckey();
+
+	/* create a shared memory resource with read and write permissions
+	 * We align this to SHMLBA so we should allocate at least
+	 * SHMLBA*2 in case SHMLBA > page_size. */
+	shm_id = shmget(probe_key, SHMLBA*2, SHM_RW | IPC_CREAT | IPC_EXCL);
+	if (shm_id == -1)
+		tst_brkm(TBROK, cleanup, "probe: shmget failed");
+
+	/* Probe an available linear address for attachment */
+	p = shmat(shm_id, NULL, 0);
+	if (p == (void *)-1)
+		tst_brkm(TBROK, cleanup, "probe: shmat failed");
+	ret = shmdt(p);
+	if (ret == -1)
+		tst_brkm(TBROK, cleanup, "probe: shmdt failed");
+
+	rm_shm(shm_id);
+
+	/* some architectures (e.g. parisc) are strange, so better always
+	 * align to next SHMLBA address. */
+	p = (void *)(((unsigned long)(p) + (SHMLBA - 1)) & ~(SHMLBA - 1));
+	return p;
+}
-- 
1.7.1


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
