Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1TfrMP-0005uH-NT
	for ltp-list@lists.sourceforge.net; Tue, 04 Dec 2012 12:12:25 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TfrMJ-0002XF-MA
	for ltp-list@lists.sourceforge.net; Tue, 04 Dec 2012 12:12:25 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qB4CCDYl019760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Dec 2012 07:12:13 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id qB4CCCkO012920
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Dec 2012 07:12:12 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Tue,  4 Dec 2012 13:12:07 +0100
Message-Id: <367be95f8c6b66828ee7930758141ec94c07d409.1354623101.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] open_posix_testsuite/.../sigset/{6,
	7}-1.c: fix error handling
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

int may not be large enough to hold return value from sigset():
  typedef void (*sighandler_t)(int);
  sighandler_t sigset(int sig, sighandler_t disp);

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../conformance/interfaces/sigset/6-1.c            |    5 ++---
 .../conformance/interfaces/sigset/7-1.c            |    5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigset/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigset/6-1.c
index 16d340c..286ee37 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigset/6-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigset/6-1.c
@@ -48,9 +48,8 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
-	rc = sigset(SIGCHLD, SIG_HOLD);
-	if (rc < 0) {
-		ERR_MSG("sigset()", rc);
+	if (sigset(SIGCHLD, SIG_HOLD) == SIG_ERR) {
+		perror("Unexpected error while using sigset()");
 		return PTS_UNRESOLVED;
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigset/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigset/7-1.c
index b7230db..18d4bb4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigset/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigset/7-1.c
@@ -56,9 +56,8 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
-	rc = sigset(SIGCHLD, SIG_HOLD);
-	if (rc < 0) {
-		ERR_MSG("sigset()", rc);
+	if (sigset(SIGCHLD, SIG_HOLD) == SIG_ERR) {
+		perror("Unexpected error while using sigset()");
 		return PTS_UNRESOLVED;
 	}
 
-- 
1.7.1


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
