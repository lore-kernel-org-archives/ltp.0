Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from
	<jbeckenbach=ltp-list=lists.sourceforge.net=jmtqtyzj@lancope.com>)
	id 1WTdHh-0001O5-Hd
	for ltp-list@lists.sourceforge.net; Fri, 28 Mar 2014 20:21:49 +0000
Received: from smtp-out3.electric.net ([72.35.12.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WTdHg-000773-GR
	for ltp-list@lists.sourceforge.net; Fri, 28 Mar 2014 20:21:49 +0000
Received: from 1WTdHZ-0000CE-Vw by out3b.electric.net with emc1-ok (Exim
	4.80.1) (envelope-from <jbeckenbach@lancope.com>) id 1WTdHa-0000Db-UE
	for ltp-list@lists.sourceforge.net; Fri, 28 Mar 2014 13:21:42 -0700
Received: from [209.182.184.2] (helo=LCHQEX03.lancope.local)
	by out3b.electric.net with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.80.1) (envelope-from <jbeckenbach@lancope.com>)
	id 1WTdHZ-0000CE-Vw
	for ltp-list@lists.sourceforge.net; Fri, 28 Mar 2014 13:21:41 -0700
From: Joseph Beckenbach <jbeckenbach@lancope.com>
Date: Fri, 28 Mar 2014 20:23:39 +0000
Message-ID: <4506ACC2AE90484D87F9A883BA36C21C54931E@LCHQEX03.lancope.local>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] Suggested patch to recvfrom / recvmsg tests
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi, all!

A tweak to improve recvfrom01.c and recvmsg01.c --
there's a loop in the child server process which walks all available fds and attempts to read those where the relevant fd_set bit is set.
Sadly, when there's more file descriptors available than bits in the fd_set, this loop will happily walk off the end of the fd_set, clearing bits along the way.
This leads to intermittent segfaults and thus false positives in these two tests.

Immediate fix is to force the loop not to look at bits off the end of the fd_set.
I've no idea whether it makes sense to rewrite the server code of these two tests, as only under heavy socket / fd use would the accept() calls in the tests return a file descriptor outside the fd_set.

Thanks!

Joseph
Joseph Beckenbach, senior QA engineer : Automation

=====
diff --git a/testcases/kernel/syscalls/recvfrom/recvfrom01.c b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
index b5ab4a0..5e68d98 100644
--- a/testcases/kernel/syscalls/recvfrom/recvfrom01.c
+++ b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
@@ -319,7 +319,7 @@ void do_child()
 			/* send something back */
 			(void)write(newfd, "hoser\n", 6);
 		}
-		for (fd = 0; fd < nfds; ++fd)
+		for (fd = 0; fd < nfds && fd < FD_SETSIZE; ++fd)
 			if (fd != sfd && FD_ISSET(fd, &rfds)) {
 				cc = read(fd, buf, sizeof(buf));
 				if (cc == 0 || (cc < 0 && errno != EINTR)) {
diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg01.c b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
index dd6b3d5..5492c1d 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg01.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
@@ -481,7 +481,7 @@ void do_child()
 			if (newfd >= 0)
 				FD_SET(newfd, &afds);
 		}
-		for (fd = 0; fd < nfds; ++fd)
+		for (fd = 0; fd < nfds && fd < FD_SETSIZE; ++fd)
 			if (fd != sfd && fd != ufd && FD_ISSET(fd, &rfds)) {
 				char rbuf[1024];


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
