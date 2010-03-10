Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@users.sourceforge.net>) id 1NpEah-0002kL-P2
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 05:36:19 +0000
Received: from sfp-scmshell-4.v30.ch3.sourceforge.com ([172.29.30.126])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NpEah-0006gX-No
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 05:36:19 +0000
Received: from localhost ([127.0.0.1]
	helo=sfp-scmshell-4.v30.ch3.sourceforge.com)
	by sfp-scmshell-4.v30.ch3.sourceforge.com with smtp (Exim 4.69)
	(envelope-from <risrajak@users.sourceforge.net>) id 1NpEab-0008Au-Kw
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 05:36:19 +0000
From: "Rishi kesh K Rajak" <risrajak@linux.vnet.ibm.com>
Date: Wed, 10 Mar 2010 05:36:12 +0000
Message-Id: <E1NpEab-0008Au-Kw@sfp-scmshell-4.v30.ch3.sourceforge.com>
Subject: [LTP] [Git] ltp updated.
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

The branch, pu, has been updated
       via  615e1e37de053855b6bd56bae8b00d8a17133f8a (commit)
       via  1a5506c97dcfda0bd16f83ca855bb633c47eea4c (commit)
       via  48c52fcd4e7668bc36bbe080f53462d410712b69 (commit)
       via  c962f51674b971496e14ac4be0cc75da98b75fca (commit)
       via  17905ceabf2dc20e978dfa4ea3682197ad01bf9a (commit)
       via  bdfe0b2a9dd720c3013225cc4aa1628e77888b24 (commit)
       via  716d29883b11107c32313b1836bea447fecbaf1e (commit)
       via  58854395050b8a3bb2fa4e5e4401546925f6aad8 (commit)
       via  886918830ae73a7f4b5cc2d9bf8554ee9f393ed8 (commit)
       via  039e4bbd522168a5145d236faa4e13f402037390 (commit)
      from  63f0a8f554d28b28b207f41e42182e1b789333b6 (commit)


- Log -----------------------------------------------------------------
commit 615e1e37de053855b6bd56bae8b00d8a17133f8a
Author: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Date:   Wed Mar 10 11:05:40 2010 +0530

    Merge branches 'master' and 'pu' into pu

-----------------------------------------------------------------------

Summary of changes:
 TODO                                               |    2 +-
 testcases/kernel/containers/Makefile               |    2 +
 .../check_netns_enabled.c => check_for_unshare.c}  |   60 +++++++++++---------
 .../kernel/controllers/freezer/run_freezer.sh      |    3 +-
 testcases/kernel/syscalls/libevent/Makefile.in     |    3 +-
 5 files changed, 40 insertions(+), 30 deletions(-)
 copy testcases/kernel/containers/{netns/check_netns_enabled.c => check_for_unshare.c} (52%)
 
diff --git a/TODO b/TODO
index 9eec828..1756168 100644
--- a/TODO
+++ b/TODO
@@ -1,4 +1,4 @@
-The following things need to be rewritten // fixed:
+The following things need to be rewritten // fixed
 
 get_mempolicy01 // mbind01: They're using numa v1 calls which means that all
 versions of Linux / numa as of a few years ago aren't compatible with the API
diff --git a/testcases/kernel/containers/Makefile b/testcases/kernel/containers/Makefile
index 6a7810e..75eda63 100644
--- a/testcases/kernel/containers/Makefile
+++ b/testcases/kernel/containers/Makefile
@@ -26,6 +26,8 @@ FILTER_OUT_DIRS		:= $(LIBDIR)
 
 LIB			:= $(LIBDIR)/libclone.a
 
+LDLIBS			:= -ldl
+
 INSTALL_TARGETS		:= *.sh 
 
 $(LIBDIR):
diff --git a/testcases/kernel/containers/netns/check_netns_enabled.c b/testcases/kernel/containers/check_for_unshare.c
similarity index 52%
copy from testcases/kernel/containers/netns/check_netns_enabled.c
copy to testcases/kernel/containers/check_for_unshare.c
index f6add06..06bdfd7 100644
--- a/testcases/kernel/containers/netns/check_netns_enabled.c
+++ b/testcases/kernel/containers/check_for_unshare.c
@@ -13,37 +13,43 @@
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *
-* Author: Veerendra C <vechandr@in.ibm.com>
+**************************************************************************/
+/*
+* Description:
+* This program verifies the kernel version to be no later than 2.6.16
+* And checks if the unshare() system call is defined using dlsym(),
+* in the Dynamically Linked Libraries.
 *
-* Net namespaces were introduced around 2.6.25.  Kernels before that,
-* assume they are not enabled.  Kernels after that, check for -EINVAL
-* when trying to use CLONE_NEWNET and CLONE_NEWNS.
-***************************************************************************/
-#include <stdio.h>
-#include <sched.h>
-#include "config.h"
-#include "libclone.h"
-#include "linux_syscall_numbers.h"
-#include "test.h"
+* Date : 26-11-2008
+* Author : Veerendra C <vechandr@in.ibm.com>
+*/
 
-char *TCID = "check_netns_enabled";
-int TST_COUNT = 1;
-int TST_TOTAL = 1; 
+#include <stdio.h>
+#include <stdlib.h>
+#include <dlfcn.h>
+#include <linux/version.h>
 
-#ifndef CLONE_NEWNET
-#define CLONE_NEWNET -1
-#endif
+int main(int argc, char **argv)
+{
+	void *handle;
+	void *ret;
+	char *error;
+	if (LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 16))
+	return 1;
 
-#ifndef CLONE_NEWNS
-#define CLONE_NEWNS -1
-#endif
+	handle = dlopen(NULL, RTLD_LAZY);
+	if (!handle) {
+		fprintf(stderr, "%s\n", dlerror());
+		exit(1);
+	}
 
-int
-main()
-{
-	/* Checking if the kernel supports unshare with netns capabilities. */
-        if (syscall(__NR_unshare, CLONE_NEWNET | CLONE_NEWNS) < 0) {
-		tst_resm (TFAIL | TERRNO, "unshare syscall smoke test failed");
+	dlerror();    /* Clear any existing error */
+	ret = dlsym(handle, "unshare");
+	if ((error = dlerror()) != NULL)  {
+		fprintf(stderr, "Error: %s\n", error);
+		exit(1);
 	}
-	tst_exit();
+
+	dlclose(handle);
+	return 0;
 }
diff --git a/testcases/kernel/controllers/freezer/run_freezer.sh b/testcases/kernel/controllers/freezer/run_freezer.sh
index 3baf968..f66e321 100755
--- a/testcases/kernel/controllers/freezer/run_freezer.sh
+++ b/testcases/kernel/controllers/freezer/run_freezer.sh
@@ -69,7 +69,8 @@ function test_setup()
 	export LTPBIN PATH TCID TST_COUNT TST_TOTAL CGROUPS_TESTROOT
 	tst_resm TINFO "Preparing to run: ${P} $@"
 
-	make all
+	# this is not require here
+	#make all
 }
 
 function test_prereqs()
diff --git a/testcases/kernel/syscalls/libevent/Makefile.in b/testcases/kernel/syscalls/libevent/Makefile.in
index d1d9af7..dd0138d 100644
--- a/testcases/kernel/syscalls/libevent/Makefile.in
+++ b/testcases/kernel/syscalls/libevent/Makefile.in
@@ -99,6 +99,7 @@ LIBS = @LIBS@
 libevent_a_DEPENDENCIES =  @LIBOBJS@
 libevent_a_OBJECTS =  event.o buffer.o evbuffer.o
 AR = ar
+AR_FLAGS = cr
 COMPILE = $(CC) $(DEFS) $(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS)
 CCLD = $(CC)
 LINK = $(CCLD) $(AM_CFLAGS) $(CFLAGS) $(LDFLAGS) -o $@
@@ -219,7 +220,7 @@ maintainer-clean-compile:
 
 libevent.a: $(libevent_a_OBJECTS) $(libevent_a_DEPENDENCIES)
 	-rm -f libevent.a
-	$(AR) cru libevent.a $(libevent_a_OBJECTS) $(libevent_a_LIBADD)
+	$(AR) $(AR_FLAGS) libevent.a $(libevent_a_OBJECTS) $(libevent_a_LIBADD)
 	$(RANLIB) libevent.a
 
 install-man3:


hooks/post-receive
-- 
ltp

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
