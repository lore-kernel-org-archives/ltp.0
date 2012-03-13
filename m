Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S7JoP-00020P-75
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:17 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S7JoO-0005Lk-71
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:17 +0000
Received: by dado14 with SMTP id o14so271995dad.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 12 Mar 2012 21:58:10 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Tue, 13 Mar 2012 12:56:36 +0800
Message-Id: <1331614605-30347-3-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
References: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH 02/11] hugetlb/hugeshmat: set nr_hugepages in tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Like hugemmap tests, this patch enables nr_hugepages set/restore in each
test of hugeshmat, so that we don't need to set the values with external
commands.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 testcases/kernel/mem/hugetlb/Makefile.inc          |   16 +++++-----
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat01.c     |   28 +++++++++++++++-----
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat02.c     |   28 +++++++++++++++-----
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat03.c     |   26 ++++++++++++++----
 testcases/kernel/mem/hugetlb/lib/ipcshm.h          |    5 +++
 testcases/kernel/mem/hugetlb/lib/libipc.c          |    7 ++++-
 6 files changed, 81 insertions(+), 29 deletions(-)


--------------1.7.8.4
Content-Type: text/x-patch;
	name="0002-hugetlb-hugeshmat-set-nr_hugepages-in-tests.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0002-hugetlb-hugeshmat-set-nr_hugepages-in-tests.patch"

diff --git a/testcases/kernel/mem/hugetlb/Makefile.inc b/testcases/kernel/mem/hugetlb/Makefile.inc
index bb352e5..274bd7c 100644
--- a/testcases/kernel/mem/hugetlb/Makefile.inc
+++ b/testcases/kernel/mem/hugetlb/Makefile.inc
@@ -23,19 +23,19 @@
 # DO NOT USE THIS FILE FOR hugetlb / lib!!!
 LIBIPCDIR		:= ../lib
 LIBIPC			:= $(LIBIPCDIR)/libipc_hugetlb.a
-
 $(LIBIPCDIR):
 	mkdir -p "$@"
-
 $(LIBIPC): $(LIBIPCDIR)
 	$(MAKE) -C "$^" -f "$(abs_srcdir)/$^/Makefile" all
 
-CPPFLAGS		+= -I$(abs_srcdir)/$(LIBIPCDIR)
-
-LDFLAGS			+= -L$(abs_builddir)/$(LIBIPCDIR)
-
-LDLIBS			+= -lipc_hugetlb
+LIBMEMDIR		:= ../../lib
+LIBMEM			:= $(LIBMEMDIR)/libmem.a
+$(LIBMEM): $(LIBMEMDIR)
+	$(MAKE) -C "$^" -f "$(abs_srcdir)/$^/Makefile" all
 
-MAKE_DEPS		:= $(LIBIPC)
+CPPFLAGS		+= -I$(abs_srcdir)/$(LIBIPCDIR) -I$(abs_srcdir)/../../include
+LDFLAGS			+= -L$(abs_builddir)/$(LIBIPCDIR) -L$(abs_builddir)/$(LIBMEMDIR)
+LDLIBS			+= $(NUMA_LIBS) -lmem -lltp -lipc_hugetlb
+MAKE_DEPS		+= $(LIBMEM) $(LIBIPC)
 
 # vim: syntax=make
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index b92f6eb..e46ae12 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -57,7 +57,8 @@
  */
 
 #include "ipcshm.h"
-#include "system_specific_hugepages_info.h"
+#include "safe_macros.h"
+#include "mem.h"
 
 char *TCID = "hugeshmat01";
 int TST_TOTAL = 3;
@@ -79,6 +80,12 @@ static size_t shm_size;
 static int    shm_id_1 = -1;
 static void   *addr;
 
+static long hugepages = 128;
+static option_t options[] = {
+	{ "s:",	&sflag,	&nr_opt	},
+	{ NULL,	NULL,	NULL	}
+};
+
 struct test_case_t {
 	int  *shmid;
 	void *addr;
@@ -101,14 +108,11 @@ int main(int ac, char **av)
 	int lc, i;
 	char *msg;
 
-	msg = parse_opts(ac, av, NULL, NULL);
+	msg = parse_opts(ac, av, options, &help);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-
-	if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
-		tst_brkm(TCONF, NULL, "Not enough available Hugepages");
-	else
-		shm_size = (get_no_of_hugepages()*hugepages_size()*1024) / 2;
+	if (sflag)
+		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
 
 	setup();
 
@@ -205,9 +209,17 @@ static void check_functionality(int i)
 
 void setup(void)
 {
+	long hpage_size;
+
+	tst_require_root(NULL);
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
+	orig_hugepages = get_sys_tune("nr_hugepages");
+	set_sys_tune("nr_hugepages", hugepages, 1);
+	hpage_size = read_meminfo("Hugepagesize:") * 1024;
+
+	shm_size = hpage_size * hugepages / 2;
 	shmkey = getipckey();
 	shm_id_1 = shmget(shmkey++, shm_size,
 		    SHM_HUGETLB|SHM_RW|IPC_CREAT|IPC_EXCL);
@@ -223,5 +235,7 @@ void cleanup(void)
 
 	rm_shm(shm_id_1);
 
+	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+
 	tst_rmdir();
 }
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index 6697436..0d00a34 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
@@ -52,7 +52,8 @@
 
 #include <pwd.h>
 #include "ipcshm.h"
-#include "system_specific_hugepages_info.h"
+#include "safe_macros.h"
+#include "mem.h"
 
 char *TCID = "hugeshmat02";
 int TST_TOTAL = 2;
@@ -68,6 +69,12 @@ static int    shm_id_1 = -1;
 static int    shm_id_2 = -1;
 static void   *addr;
 
+static long hugepages = 128;
+static option_t options[] = {
+	{ "s:",	&sflag,	&nr_opt	},
+	{ NULL,	NULL,	NULL	}
+};
+
 struct test_case_t {
 	int  *shmid;
 	void *addr;
@@ -85,14 +92,11 @@ int main(int ac, char **av)
 	int lc, i;
 	char *msg;
 
-	msg = parse_opts(ac, av, NULL, NULL);
+	msg = parse_opts(ac, av, options, &help);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-
-	if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
-		tst_brkm(TCONF, NULL, "Not enough available Hugepages");
-	else
-		shm_size = (get_no_of_hugepages()*hugepages_size()*1024) / 2;
+	if (sflag)
+		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
 
 	setup();
 
@@ -121,9 +125,17 @@ int main(int ac, char **av)
 
 void setup(void)
 {
+	long hpage_size;
+
+	tst_require_root(NULL);
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
+	orig_hugepages = get_sys_tune("nr_hugepages");
+	set_sys_tune("nr_hugepages", hugepages, 1);
+	hpage_size = read_meminfo("Hugepagesize:") * 1024;
+
+	shm_size = hpage_size * hugepages / 2;
 	shmkey = getipckey();
 
 	/* create a shared memory resource with read and write permissions */
@@ -142,5 +154,7 @@ void cleanup(void)
 
 	rm_shm(shm_id_2);
 
+	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+
 	tst_rmdir();
 }
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index 938ddfa..22832dd 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
@@ -58,7 +58,8 @@
  */
 
 #include "ipcshm.h"
-#include "system_specific_hugepages_info.h"
+#include "safe_macros.h"
+#include "mem.h"
 
 char *TCID = "hugeshmat03";
 int TST_TOTAL = 1;
@@ -69,6 +70,12 @@ static void   *addr;
 static uid_t  ltp_uid;
 static char   *ltp_user = "nobody";
 
+static long hugepages = 128;
+static option_t options[] = {
+	{ "s:",	&sflag,	&nr_opt	},
+	{ NULL,	NULL,	NULL	}
+};
+
 static void do_child(void);
 
 int main(int ac, char **av)
@@ -77,14 +84,12 @@ int main(int ac, char **av)
 	int status;
 	pid_t pid;
 
-	msg = parse_opts(ac, av, NULL, NULL);
+	msg = parse_opts(ac, av, options, &help);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
-		tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
-	else
-		shm_size = (get_no_of_hugepages()*hugepages_size()*1024) / 2;
+	if (sflag)
+		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
 
 	setup();
 
@@ -128,10 +133,17 @@ static void do_child(void)
 
 void setup(void)
 {
+	long hpage_size;
+
 	tst_require_root(NULL);
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
+	orig_hugepages = get_sys_tune("nr_hugepages");
+	set_sys_tune("nr_hugepages", hugepages, 1);
+	hpage_size = read_meminfo("Hugepagesize:") * 1024;
+
+	shm_size = hpage_size * hugepages / 2;
 	shmkey = getipckey();
 	shm_id_1 = shmget(shmkey, shm_size,
 		    SHM_HUGETLB|SHM_RW|IPC_CREAT|IPC_EXCL);
@@ -149,5 +161,7 @@ void cleanup(void)
 
 	rm_shm(shm_id_1);
 
+	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+
 	tst_rmdir();
 }
diff --git a/testcases/kernel/mem/hugetlb/lib/ipcshm.h b/testcases/kernel/mem/hugetlb/lib/ipcshm.h
index caac9af..1e9edbe 100644
--- a/testcases/kernel/mem/hugetlb/lib/ipcshm.h
+++ b/testcases/kernel/mem/hugetlb/lib/ipcshm.h
@@ -54,4 +54,9 @@ void check_root();
 int getipckey();
 int getuserid(char*);
 
+char *nr_opt;
+int sflag;
+long orig_hugepages;
+void help(void);
+
 #endif /* ipcshm.h */
diff --git a/testcases/kernel/mem/hugetlb/lib/libipc.c b/testcases/kernel/mem/hugetlb/lib/libipc.c
index a5d609c..cc3ca02 100644
--- a/testcases/kernel/mem/hugetlb/lib/libipc.c
+++ b/testcases/kernel/mem/hugetlb/lib/libipc.c
@@ -198,4 +198,9 @@ rm_shm(int shm_id)
 		tst_resm(TINFO, "This could lead to IPC resource problems.");
 		tst_resm(TINFO, "id = %d", shm_id);
 	}
-}
\ No newline at end of file
+}
+
+void help(void)
+{
+	printf("    -s NUM  Set the number of hugepages to be allocated\n");
+}

--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.4--



