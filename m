Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <deller@gmx.de>) id 1WaV4a-0004Ie-Pu
	for ltp-list@lists.sourceforge.net; Wed, 16 Apr 2014 19:00:40 +0000
Received: from mout.gmx.net ([212.227.17.22])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WaV4Y-0002t3-W2
	for ltp-list@lists.sourceforge.net; Wed, 16 Apr 2014 19:00:40 +0000
Date: Wed, 16 Apr 2014 21:00:28 +0200
From: Helge Deller <deller@gmx.de>
Message-ID: <20140416190028.GA2093@ls3530.fritz.box>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH] fix fanotify syscall check on compat kernel
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

The fanotify[0-5] testcases use the myfanotify_mark() wrapper for the
fanotify_mark() syscall. But the #define does not take into account, that
the mask field is actually of type _u64 where we need to split the hi
and low word in the syscall on a 32bit arch.

The attached patch converts the #define to a inline function where
the compiler will help to convert the given values to the correct types
(e.g. unsigned long).

Bug found and tested on the parisc/hppa (32bit userspace with 64bit
kernel) arch.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index a4c2a8f..b13cb7b 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -28,12 +28,26 @@
 #ifndef	__FANOTIFY_H__
 #define	__FANOTIFY_H__
 
+#include <sys/types.h>
+#include <endian.h>
+#include "config.h"
+#include "linux_syscall_numbers.h"
+
 /* fanotify(7) wrappers */
 
 #define	myfanotify_init(flags, event_f_flags) \
 	syscall(__NR_fanotify_init, flags, event_f_flags)
 
-#define	myfanotify_mark(fd, flags, mask, dfd, pathname)	\
-	syscall(__NR_fanotify_mark, fd, flags, mask, dfd, pathname)
+long myfanotify_mark(int fd, unsigned int flags, unsigned long long mask, int dfd, const char *pathname)
+{
+#if __WORDSIZE == 64
+	return ltp_syscall(__NR_fanotify_mark, fd, flags, mask, dfd, pathname);
+#else
+	return ltp_syscall(__NR_fanotify_mark, fd, flags,
+			 __LONG_LONG_PAIR((unsigned long) (mask >> 32),
+					  (unsigned long) mask),
+			 dfd, (unsigned long) pathname);
+#endif
+}
 
 #endif /* __FANOTIFY_H__ */

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
