Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sweekar.pinto@oracle.com>) id 1W6H6K-0007MF-IN
	for ltp-list@lists.sourceforge.net; Thu, 23 Jan 2014 10:01:32 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1W6H6J-0004R2-Hx
	for ltp-list@lists.sourceforge.net; Thu, 23 Jan 2014 10:01:32 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s0NA1PtO000885
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 23 Jan 2014 10:01:25 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s0NA1OXo003929
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 23 Jan 2014 10:01:25 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s0NA1OC1003908
	for <ltp-list@lists.sourceforge.net>; Thu, 23 Jan 2014 10:01:24 GMT
From: Sweekar Pinto <sweekar.pinto@oracle.com>
Date: Wed, 22 Jan 2014 17:13:37 -0500
Message-Id: <1390428817-31923-1-git-send-email-sweekar.pinto@oracle.com>
Subject: [LTP] [PATCH 1/3] Fixed compile errors in crasher.c
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
Cc: lisa.vaz@oracle.com

-Conditional inclusion of asm.h for kernel > 3.4
-The owner field of proc_dir_entry has been removed

Signed-off-by: Sweekar Pinto <sweekar.pinto@oracle.com>
---
 testcases/kdump/lib/crasher/crasher.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kdump/lib/crasher/crasher.c b/testcases/kdump/lib/crasher/crasher.c
index bc192dc..2b01412 100644
--- a/testcases/kdump/lib/crasher/crasher.c
+++ b/testcases/kdump/lib/crasher/crasher.c
@@ -25,7 +25,10 @@
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
 #include <asm/uaccess.h>
+#include <linux/version.h>
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 4, 0)
 #include <asm/system.h>
+#endif
 
 MODULE_LICENSE("GPL");
 
@@ -46,7 +49,7 @@ static int crasher_write(struct file *file, const char *buffer,
 			 unsigned long count, void *data)
 {
 	char value, *a;
-	spinlock_t mylock = SPIN_LOCK_UNLOCKED;
+	DEFINE_SPINLOCK(mylock);
 
 	/* grab the first byte the user gave us, ignore the rest */
 	if (copy_from_user(&value, buffer, 1))
@@ -94,7 +97,6 @@ int crasher_init(void)
 
 	crasher_proc->read_proc = crasher_read;
 	crasher_proc->write_proc = crasher_write;
-	crasher_proc->owner = THIS_MODULE;
 	return 0;
 }
 
-- 
1.7.1


From f58a6316dc168781daa76edf4d78a217e2af2628 Mon Sep 17 00:00:00 2001
From: Sweekar Pinto <sweekar.pinto@oracle.com>
Date: Wed, 22 Jan 2014 17:05:01 -0500
Subject: [PATCH 2/3] Fix passwordless ssh for network(ssh) dump test

-Force ssh to use kdumps rsa key to run commands remotely

Signed-off-by: Sweekar Pinto <sweekar.pinto@oracle.com>
---
 testcases/kdump/runkdump.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kdump/runkdump.sh b/testcases/kdump/runkdump.sh
index e2e681c..cd6ee1c 100755
--- a/testcases/kdump/runkdump.sh
+++ b/testcases/kdump/runkdump.sh
@@ -95,7 +95,7 @@ PrepareVerify ()
             exit 1
         fi
 
-        file=$(ssh "${SCP_PATH}" "ls -t ${COREDIR}/*/vmcore \
+        file=$(ssh -i ~/.ssh/kdump_id_rsa "${SCP_PATH}" "ls -t ${COREDIR}/*/vmcore* \
          2>/dev/null | head -1")
 
         mkdir -p "${COREDIR}/${last}"
@@ -103,7 +103,7 @@ PrepareVerify ()
         if [ "${file}" ]; then
             # Not fatal error.
             set +e
-            scp "${SCP_PATH}:${file}" "${COREDIR}/${last}"
+            scp  -i ~/.ssh/kdump_id_rsa "${SCP_PATH}:${file}" "${COREDIR}/${last}"
             set -e
         fi
 
@@ -116,7 +116,7 @@ PrepareVerify ()
         COREDIR=/mnt"${COREDIR}"
     fi
 
-    vmcore=$(ls -t "${COREDIR}"/*/vmcore 2>/dev/null | head -1)
+    vmcore=$(ls -t "${COREDIR}"/*/vmcore* 2>/dev/null | head -1)
 }
 
 VerifyTest ()
-- 
1.7.1


From 76ab06883327fdcdf038af5dd96a036e0b077818 Mon Sep 17 00:00:00 2001
From: Sweekar Pinto <sweekar.pinto@oracle.com>
Date: Wed, 22 Jan 2014 17:08:23 -0500
Subject: [PATCH 3/3] Change crashkernel param to 256M@128M

-Change the crashkernel parm of x86 and default arch to 256M@128M as this is found to be the best fit
Signed-off-by: Sweekar Pinto <sweekar.pinto@oracle.com>
---
 testcases/kdump/lib/setup.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kdump/lib/setup.sh b/testcases/kdump/lib/setup.sh
index 5bc54bb..3e53f1a 100755
--- a/testcases/kdump/lib/setup.sh
+++ b/testcases/kdump/lib/setup.sh
@@ -86,11 +86,11 @@ echo "Modify Boot Loader."
 if [ "${arch}" = "ppc64" ]; then
     args="crashkernel=256M@32M xmon=off"
 elif [ "${arch}" = "i686" ]; then
-    args="crashkernel=128M@16M nmi_watchdog=1"
+    args="crashkernel=256M@128M nmi_watchdog=1"
 elif [ "${arch}" = "ia64" ]; then
     args="crashkernel=512M@256M"
 else
-    args="crashkernel=128M@16M"
+    args="crashkernel=256M@128M"
 fi
 
 if [ -x "/sbin/grubby" ]; then
-- 
1.7.1


------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
