Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WdciQ-0007Ru-0e
	for ltp-list@lists.sourceforge.net; Fri, 25 Apr 2014 09:46:42 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WdciP-0007mB-77
	for ltp-list@lists.sourceforge.net; Fri, 25 Apr 2014 09:46:41 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3P9kY5Z013968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Apr 2014 09:46:35 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3P9kXk0000954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Apr 2014 09:46:34 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3P9kXpO010010
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Apr 2014 09:46:33 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 25 Apr 2014 13:46:28 +0400
Message-Id: <1398419188-17193-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] sigaction 9-1, 10-1,
	11-1: use SIGKILL instead of SIGHUP
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
Cc: vasily.isaenko@oracle.com

There are test environments, where the SIGHUP signal may be either
added to the signal mask or ignored. One example of such environments
is Autotest, which sets the SIGHUP signal to SIG_IGN for its jobs.

Therefore the above test cases hang in that environment because their
parent processes send SIGHUP to terminate the child (and the child ignores it).

I think it will not be a problem to use SIGKILL here instead of SIGHUP, because
SIGKILL can not be caught, blocked, or ignored.
And it does the job - stopping the child - very well :)

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../conformance/interfaces/sigaction/10-1.c        |    3 +--
 .../conformance/interfaces/sigaction/11-1.c        |    3 +--
 .../conformance/interfaces/sigaction/9-1.c         |    3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/10-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/10-1.c
index 1e729f4..e50357b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/10-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/10-1.c
@@ -101,8 +101,7 @@ int main(void)
 			wait_for_notification(CLD_CONTINUED);
 		}
 
-		/* POSIX specifies default action to be abnormal termination */
-		kill(pid, SIGHUP);
+		kill(pid, SIGKILL);
 		waitpid(pid, &s, 0);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/11-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/11-1.c
index 804bf9e..73405ea 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/11-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/11-1.c
@@ -95,8 +95,7 @@ int main(void)
 
 		}
 
-		/* POSIX specifies default action to be abnormal termination */
-		kill(pid, SIGHUP);
+		kill(pid, SIGKILL);
 		waitpid(pid, &s, 0);
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/9-1.c
index 984a0ee..07dbb7b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/9-1.c
@@ -89,8 +89,7 @@ int main(void)
 			kill(pid, SIGCONT);
 		}
 
-		/* POSIX specifies default action to be abnormal termination */
-		kill(pid, SIGHUP);
+		kill(pid, SIGKILL);
 		waitpid(pid, &s, 0);
 	}
 
-- 
1.7.1


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
