Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1Vgmgu-000833-Hq
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 02:29:56 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vgmgr-00085O-IK
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 02:29:56 +0000
From: Peng Haitao <penght@cn.fujitsu.com>
Date: Thu, 14 Nov 2013 10:25:07 +0800
Message-Id: <1384395907-13886-1-git-send-email-penght@cn.fujitsu.com>
Subject: [LTP] [PATCH] sigaction:16-1: leave it untested on the Linux kernel
	less than 2.6.22
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
To: jstancek@redhat.com, gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net

As the Linux signal(7) said:
POSIX semaphore interfaces: sem_wait(3) and sem_timedwait(3) (since Linux 2.6.22; beforehand, always failed with EINTR).

So, on linux, we just leave this untested when the kernel version
is less than 2.6.22.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/open_posix_testsuite/Makefile              |  4 ++++
 testcases/open_posix_testsuite/Makefile.linux        | 20 ++++++++++++++++++++
 .../open_posix_testsuite/scripts/tst_kvercmp.sh      | 20 ++++++++++++++++++++
 3 files changed, 44 insertions(+)
 create mode 100644 testcases/open_posix_testsuite/Makefile.linux
 create mode 100755 testcases/open_posix_testsuite/scripts/tst_kvercmp.sh

diff --git a/testcases/open_posix_testsuite/Makefile b/testcases/open_posix_testsuite/Makefile
index 9c61fa4..500ddc2 100644
--- a/testcases/open_posix_testsuite/Makefile
+++ b/testcases/open_posix_testsuite/Makefile
@@ -40,6 +40,10 @@ exec_prefix?=		$(prefix)
 
 all: conformance-all functional-all stress-all tools-all
 
+ifeq ($(shell uname -s), Linux)
+include Makefile.linux
+endif
+
 clean: $(CRITICAL_MAKEFILES)
 	@rm -f $(LOGFILE)*
 	@for dir in $(SUBDIRS) tools; do \
diff --git a/testcases/open_posix_testsuite/Makefile.linux b/testcases/open_posix_testsuite/Makefile.linux
new file mode 100644
index 0000000..de3dd0e
--- /dev/null
+++ b/testcases/open_posix_testsuite/Makefile.linux
@@ -0,0 +1,20 @@
+all: conformance-all functional-all stress-all tools-all filter-broken
+
+cmd_disable = @set -e; \
+	echo "Disabling: $(1)"; \
+	echo "\#!/bin/sh" > $(1); \
+	echo "echo $(1) skipped" >> $(1); \
+	echo "echo $(2)" >> $(1); \
+	echo "exit 0" >> $(1); \
+	chmod a+x $(1)
+
+kver_cmp = $(shell $(top_srcdir)/scripts/tst_kvercmp.sh 2 6 22)
+ifeq ($(kver_cmp), 1)
+filter-broken: t_sigaction_16-1
+else
+filter-broken:
+endif
+
+t_sigaction_16-1:
+	$(call cmd_disable,conformance/interfaces/sigaction/sigaction_16-1.run-test, \
+	  This fails on old linux because sem_wait always be interrupted by a signal.)
diff --git a/testcases/open_posix_testsuite/scripts/tst_kvercmp.sh b/testcases/open_posix_testsuite/scripts/tst_kvercmp.sh
new file mode 100755
index 0000000..d0e101c
--- /dev/null
+++ b/testcases/open_posix_testsuite/scripts/tst_kvercmp.sh
@@ -0,0 +1,20 @@
+#!/bin/bash
+
+if [ $# -ne 3 ]; then
+	echo "Usgae: ./tst_kvercmp.sh r1 r2 r3"
+	exit 1
+fi
+
+ker_ver=$(uname -r)
+r1=$(echo ${ker_ver} | awk -F. '{print $1}')
+r2=$(echo ${ker_ver} | awk -F. '{print $2}')
+r3=$(echo ${ker_ver} | awk -F. '{print $3}')
+r3=${r3%-*}
+
+test_ver=$(($1 * 65536 + $2 * 256 + $3))
+curr_ver=$((${r1} * 65536 + ${r2} * 256 + ${r3}))
+if [ ${curr_ver} -ge ${test_ver} ]; then
+	echo 0
+else
+	echo 1
+fi
-- 
1.8.3.1


------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
