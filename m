Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1TRhy7-0003Su-JA
	for ltp-list@lists.sourceforge.net; Fri, 26 Oct 2012 11:20:51 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TRhy1-0003Ba-PH
	for ltp-list@lists.sourceforge.net; Fri, 26 Oct 2012 11:20:51 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q9QBKeW2006678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Oct 2012 07:20:40 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id q9QBKcu8005497
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Oct 2012 07:20:39 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 26 Oct 2012 13:20:36 +0200
Message-Id: <14456d9017d4cb1ad9cec19bba5c56e1dce41895.1351250305.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v2] ipc/shmat: pick suitable base_addr before each
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
 testcases/kernel/syscalls/ipc/shmat/Makefile       |    3 ++
 testcases/kernel/syscalls/ipc/shmat/shmat01.c      |   16 ++-------
 testcases/kernel/syscalls/ipc/shmat/shmat02.c      |   16 ++-------
 testcases/kernel/syscalls/ipc/shmat/shmat_common.c |   34 ++++++++++++++++++++
 4 files changed, 43 insertions(+), 26 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ipc/shmat/shmat_common.c

diff --git a/testcases/kernel/syscalls/ipc/shmat/Makefile b/testcases/kernel/syscalls/ipc/shmat/Makefile
index f467389..5cbf37c 100644
--- a/testcases/kernel/syscalls/ipc/shmat/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmat/Makefile
@@ -20,4 +20,7 @@ top_srcdir              ?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
+
+MAKE_TARGETS            := $(patsubst $(abs_srcdir)/%.c,%,$(wildcard $(abs_srcdir)/*[0-9].c))
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
index 6e4dee1..160abca 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
@@ -56,6 +56,7 @@
  */
 
 #include "ipcshm.h"
+#include "shmat_common.c"
 
 char *TCID = "shmat01";
 
@@ -108,6 +109,7 @@ int main(int ac, char **av)
 			/*
 			 * Use TEST macro to make the call
 			 */
+			base_addr = probe_free_addr();
 			errno = 0;
 			addr = shmat(*(TC[i].shmid), base_addr+TC[i].offset,
 				     TC[i].flags);
@@ -262,19 +264,7 @@ void setup(void)
 			 "resource 1 in setup()");
 	}
 
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
+	base_addr = probe_free_addr();
 }
 
 /*
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat02.c b/testcases/kernel/syscalls/ipc/shmat/shmat02.c
index d4cca0e..b260e18 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat02.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat02.c
@@ -55,6 +55,7 @@
 
 #include "ipcshm.h"
 #include <pwd.h>
+#include "shmat_common.c"
 
 char *TCID = "shmat02";
 char nobody_uid[] = "nobody";
@@ -125,6 +126,7 @@ int main(int ac, char **av)
 
 			setup_tc(i, tc);
 
+			base_addr = probe_free_addr();
 			errno = 0;
 			addr = shmat(*(tc->shmid), base_addr + tc->offset, 0);
 
@@ -181,19 +183,7 @@ void setup(void)
 	    -1)
 		tst_brkm(TBROK|TERRNO, cleanup, "shmget #2 failed");
 
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
+	base_addr = probe_free_addr();
 }
 
 /*
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat_common.c b/testcases/kernel/syscalls/ipc/shmat/shmat_common.c
new file mode 100644
index 0000000..508bf4b
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat_common.c
@@ -0,0 +1,34 @@
+static key_t probe_key;
+
+void *probe_free_addr()
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
+	ret = shmdt((const void *)p);
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
+
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
