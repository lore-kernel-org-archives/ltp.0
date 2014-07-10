Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <deller@gmx.de>) id 1X5Gyz-0001Sr-B9
	for ltp-list@lists.sourceforge.net; Thu, 10 Jul 2014 16:14:05 +0000
Received: from mout.gmx.net ([212.227.15.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X5Gyx-0002DQ-Ck
	for ltp-list@lists.sourceforge.net; Thu, 10 Jul 2014 16:14:05 +0000
Date: Thu, 10 Jul 2014 18:13:55 +0200
From: Helge Deller <deller@gmx.de>
Message-ID: <20140710161355.GA14288@ls3530.dhcp.wdf.sap.corp>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH] fix fanotify syscall (again)
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
To: ltp-list@lists.sourceforge.net

This patch to some degree reverts my last patch which was committed as:
  commit 5d08e164964e19be693e6e8fddf3afb82e505b4f
  Author: Helge Deller <deller@gmx.de>
  Date:   Wed Apr 16 21:00:28 2014 +0200
  fix fanotify syscall check on compat kernel

The problem is, that fanotify_mark() uses a 64bit parameter (mask).
When calling this syscall with it's 64bit parameter on a 32bit arch it is very
architecture and compiler dependend, in which order the lower and higher 32bits
are put on the stack and thus ends up in the arguments for the Linux kernel.

So, to avoid any problems we really need to call this syscall the same way as
it's defined by glibc.

This patch will utilize the glibc header <sys/fanotify.h> if available and
only use a manual syscall as fallback.

Tested on the hppa/parisc 32- and 64bit architecture.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index a52093c..6625811 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -28,27 +28,43 @@
 #ifndef	__FANOTIFY_H__
 #define	__FANOTIFY_H__
 
+#include "config.h"
+
 #include <stdint.h>
-#include <endian.h>
-#include "lapi/abisize.h"
 #include "linux_syscall_numbers.h"
 
 /* fanotify(7) wrappers */
 
-#define	myfanotify_init(flags, event_f_flags) \
-	syscall(__NR_fanotify_init, flags, event_f_flags)
 
-long myfanotify_mark(int fd, unsigned int flags, uint64_t mask,
+#if defined(HAVE_SYS_FANOTIFY_H)
+
+#include <sys/fanotify.h>
+
+static int myfanotify_init(unsigned int flags, unsigned int event_f_flags)
+{
+	return fanotify_init(flags, event_f_flags);
+}
+
+static long myfanotify_mark(int fd, unsigned int flags, uint64_t mask,
                      int dfd, const char *pathname)
 {
-#if LTP_USE_64_ABI
-	return ltp_syscall(__NR_fanotify_mark, fd, flags, mask, dfd, pathname);
-#else
-	return ltp_syscall(__NR_fanotify_mark, fd, flags,
-			 __LONG_LONG_PAIR((unsigned long) (mask >> 32),
-					  (unsigned long) mask),
-			 dfd, (unsigned long) pathname);
-#endif
+	return fanotify_mark(fd, flags, mask, dfd, pathname);
+}
+
+#else /* HAVE_SYS_FANOTIFY_H */
+
+static int myfanotify_init(unsigned int flags, unsigned int event_f_flags)
+{
+	return syscall(__NR_fanotify_init, flags, event_f_flags);
 }
 
+static long myfanotify_mark(int fd, unsigned int flags, uint64_t mask,
+                     int dfd, const char *pathname)
+{
+	return syscall(__NR_fanotify_mark, fd, flags, mask, dfd, pathname);
+}
+
+#endif
+
+
 #endif /* __FANOTIFY_H__ */

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
