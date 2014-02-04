Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jbastian@redhat.com>) id 1WAoiw-00083M-5J
	for ltp-list@lists.sourceforge.net; Tue, 04 Feb 2014 22:44:10 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WAoiu-0002fr-TQ
	for ltp-list@lists.sourceforge.net; Tue, 04 Feb 2014 22:44:10 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s14Mi2X3004502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Feb 2014 17:44:02 -0500
Received: from tarantula.localdomain (ovpn-113-35.phx2.redhat.com
	[10.3.113.35])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id s14Mi0lV018665
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Feb 2014 17:44:02 -0500
Date: Tue, 4 Feb 2014 16:44:00 -0600
From: Jeffrey Bastian <jbastian@redhat.com>
Message-ID: <20140204224400.GA8297@tarantula.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH] use inotify_init1(0) for inotify tests on aarch64
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

aarch64 (and possibly other new architectures) does not implement
the __ARCH_WANT_SYSCALL_NO_FLAGS syscalls, so use inotify_init1(0)
instead of inotify_init(void)

Signed-off-by: Jeffrey Bastian <jbastian@redhat.com>
---
 testcases/kernel/syscalls/inotify/inotify.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/syscalls/inotify/inotify.h b/testcases/kernel/syscalls/inotify/inotify.h
index e396947c4f98..68fe3b5f6426 100644
--- a/testcases/kernel/syscalls/inotify/inotify.h
+++ b/testcases/kernel/syscalls/inotify/inotify.h
@@ -30,8 +30,13 @@
 
 /* inotify(7) wrappers */
 
+#if __NR_inotify_init != __LTP__NR_INVALID_SYSCALL
 #define	myinotify_init() \
 	syscall(__NR_inotify_init)
+#else
+#define	myinotify_init() \
+	syscall(__NR_inotify_init1, 0)
+#endif
 
 #define	myinotify_add_watch(fd, pathname, mask)	\
 	syscall(__NR_inotify_add_watch, fd, pathname, mask)
-- 
1.8.3.1


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
