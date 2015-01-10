Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Y9t9u-0003q6-N4
	for ltp-list@lists.sourceforge.net; Sat, 10 Jan 2015 10:20:42 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Y9t9s-0007vC-Te
	for ltp-list@lists.sourceforge.net; Sat, 10 Jan 2015 10:20:42 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t0AAKZ4h030889
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Sat, 10 Jan 2015 05:20:35 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id t0AAKXD1031138
	for <ltp-list@lists.sourceforge.net>; Sat, 10 Jan 2015 05:20:34 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Sat, 10 Jan 2015 11:20:29 +0100
Message-Id: <1420885229-25636-2-git-send-email-jstancek@redhat.com>
Subject: [LTP] [PATCH] recvmsg01: fix select() nfds for UNIX socket
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

commit 7855d094bbeb9b8ce43dd698ec82e400eb91e709 did this
for accept() on INET socket, but missed UNIX one.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/recvmsg/recvmsg01.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg01.c b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
index 1216935..28626e3 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg01.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
@@ -480,8 +480,10 @@ void do_child(void)
 
 			fromlen = sizeof(fsun);
 			newfd = accept(ufd, (struct sockaddr *)&fsun, &fromlen);
-			if (newfd >= 0)
+			if (newfd >= 0) {
 				FD_SET(newfd, &afds);
+				nfds = MAX(nfds, newfd + 1);
+			}
 		}
 		for (fd = 0; fd < nfds; ++fd)
 			if (fd != sfd && fd != ufd && FD_ISSET(fd, &rfds)) {
-- 
1.7.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
