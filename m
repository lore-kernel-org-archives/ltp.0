Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1RsWtn-0005cV-GK
	for ltp-list@lists.sourceforge.net; Wed, 01 Feb 2012 09:54:43 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RsWtm-000065-5O
	for ltp-list@lists.sourceforge.net; Wed, 01 Feb 2012 09:54:43 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q119sajE026597
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Wed, 1 Feb 2012 01:54:36 -0800 (PST)
From: Kang Kai <kai.kang@windriver.com>
Date: Wed, 1 Feb 2012 17:54:30 +0800
Message-ID: <1328090070-15140-1-git-send-email-kai.kang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] sigaction/16-1.c: make build pass on mips arch
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

There is no signal SIGTLKFLT on mips architecture. Remove SIGTLKFLT from
signal set when test on mips arch.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 .../conformance/interfaces/sigaction/16-1.c        |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/16-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/16-1.c
index 1eda711..213bda0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/16-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/16-1.c
@@ -67,7 +67,9 @@ static struct sig_info sigs[] = {
 	{SIGPIPE, "SIGPIPE", 0},
 	{SIGALRM, "SIGALRM", 0},
 	{SIGTERM, "SIGTERM", 0},
+#ifndef __mips__
 	{SIGSTKFLT, "SIGSTKFLT", 0},
+#endif
 	{SIGCHLD, "SIGCHLD", 0},
 	{SIGCONT, "SIGCONT", 0},
 	{SIGTSTP, "SIGTSTP", 0},
-- 
1.7.5.4


------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
