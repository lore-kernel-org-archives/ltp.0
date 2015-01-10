Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Y9t9u-0001Rm-J9
	for ltp-list@lists.sourceforge.net; Sat, 10 Jan 2015 10:20:42 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Y9t9s-0007v9-QO
	for ltp-list@lists.sourceforge.net; Sat, 10 Jan 2015 10:20:42 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t0AAKYDb030686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Sat, 10 Jan 2015 05:20:34 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id t0AAKXD0031138
	for <ltp-list@lists.sourceforge.net>; Sat, 10 Jan 2015 05:20:33 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Sat, 10 Jan 2015 11:20:28 +0100
Message-Id: <1420885229-25636-1-git-send-email-jstancek@redhat.com>
Subject: [LTP] [PATCH] skip MSG_ERRQUEUE+tcp test on kernels < 3.17
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

MSG_ERRQUEUE support for tcp has been added in 3.17. [1][2][3]
Skip testing this combination on prior kernels.

[1] https://lkml.org/lkml/2006/9/18/182
[2] f4713a3dfad045d46afcb9c2a7d0bba288920ed4
[3] 4ed2d765dfaccff5ebdac68e2064b59125033a3b

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/recv/recv01.c         |    9 ++++++++-
 testcases/kernel/syscalls/recvfrom/recvfrom01.c |    9 ++++++++-
 testcases/kernel/syscalls/recvmsg/recvmsg01.c   |    9 ++++++++-
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/recv/recv01.c b/testcases/kernel/syscalls/recv/recv01.c
index 3dc7a91..ad5f9f8 100644
--- a/testcases/kernel/syscalls/recv/recv01.c
+++ b/testcases/kernel/syscalls/recv/recv01.c
@@ -130,8 +130,15 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			tdat[testno].setup();
+			if ((tst_kvercmp(3, 17, 0) < 0)
+			    && (tdat[testno].flags & MSG_ERRQUEUE)
+			    && (tdat[testno].type & SOCK_STREAM)) {
+				tst_resm(TINFO, "skip MSG_ERRQUEUE test, "
+						"it's supported from 3.17");
+				continue;
+			}
 
+			tdat[testno].setup();
 			TEST(recv(s, tdat[testno].buf, tdat[testno].buflen,
 				  tdat[testno].flags));
 			if (TEST_RETURN > 0)
diff --git a/testcases/kernel/syscalls/recvfrom/recvfrom01.c b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
index 8d0a2ee..843dfb1 100644
--- a/testcases/kernel/syscalls/recvfrom/recvfrom01.c
+++ b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
@@ -152,8 +152,15 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			tdat[testno].setup();
+			if ((tst_kvercmp(3, 17, 0) < 0)
+			    && (tdat[testno].flags & MSG_ERRQUEUE)
+			    && (tdat[testno].type & SOCK_STREAM)) {
+				tst_resm(TINFO, "skip MSG_ERRQUEUE test, "
+						"it's supported from 3.17");
+				continue;
+			}
 
+			tdat[testno].setup();
 			TEST(recvfrom(s, tdat[testno].buf, tdat[testno].buflen,
 				      tdat[testno].flags, tdat[testno].from,
 				      tdat[testno].salen));
diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg01.c b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
index 42d4968..1216935 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg01.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
@@ -208,10 +208,17 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		tst_count = 0;
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
+			if ((tst_kvercmp(3, 17, 0) < 0)
+			    && (tdat[testno].flags & MSG_ERRQUEUE)
+			    && (tdat[testno].type & SOCK_STREAM)) {
+				tst_resm(TINFO, "skip MSG_ERRQUEUE test, "
+						"it's supported from 3.17");
+				continue;
+			}
+
 			tdat[testno].setup();
 
 			/* setup common to all tests */
-
 			iov[0].iov_base = tdat[testno].buf;
 			iov[0].iov_len = tdat[testno].buflen;
 			msgdat.msg_name = tdat[testno].from;
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
