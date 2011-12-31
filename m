Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1Rgpgi-0007u1-Ko
	for ltp-list@lists.sourceforge.net; Sat, 31 Dec 2011 03:32:52 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Rgpgh-0000FS-Dd
	for ltp-list@lists.sourceforge.net; Sat, 31 Dec 2011 03:32:52 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id pBV3WjUf026874
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Fri, 30 Dec 2011 19:32:45 -0800 (PST)
From: Kang Kai <kai.kang@windriver.com>
Date: Sat, 31 Dec 2011 11:32:46 +0800
Message-ID: <1325302366-375-1-git-send-email-kai.kang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] mq_timedsend/5-1: make parent has chance to sleep
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

Child process sends the last signal before parent process enter the
final sleep sometimes, so sleep in parent will not be interrupted then
the case fails.
Sleep 1 second before send the last signal in child to make sure parent
enter the final sleep.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 .../conformance/interfaces/mq_timedsend/5-1.c      |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-1.c
index 96daf72..37993c8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-1.c
@@ -82,6 +82,9 @@ int main()
 		sleep(1);  // give parent time to set up handler
 		for (i=0; i<MAXMSG+1; i++) {
         		mq_timedsend(gqueue, msgptr, strlen(msgptr), 1, &ts);
+            /* make sure parent enter the final sleep */
+			if (i == MAXMSG) 
+                sleep(1);
 			/* send signal to parent each time message is sent */
 			kill(getppid(), SIGABRT);
 		}
@@ -138,4 +141,4 @@ int main()
 	}
 
 	return PTS_UNRESOLVED;
-}
\ No newline at end of file
+}
-- 
1.7.5.4


------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
