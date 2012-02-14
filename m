Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <salvatore.cro@st.com>) id 1RxGKF-00084Z-CK
	for ltp-list@lists.sourceforge.net; Tue, 14 Feb 2012 11:13:35 +0000
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147])
	by sog-mx-1.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RxGK9-0001QW-N8
	for ltp-list@lists.sourceforge.net; Tue, 14 Feb 2012 11:13:35 +0000
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BBDB851
	for <ltp-list@lists.sourceforge.net>;
	Tue, 14 Feb 2012 11:13:22 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 81CE523CA
	for <ltp-list@lists.sourceforge.net>;
	Tue, 14 Feb 2012 11:13:22 +0000 (GMT)
From: "Salvatore CRO'" <salvatore.cro@st.com>
Date: Tue, 14 Feb 2012 12:13:14 +0100
Message-Id: <1329217994-11574-1-git-send-email-salvatore.cro@st.com>
In-Reply-To: <1329215581-26357-1-git-send-email-salvatore.cro@st.com>
References: <1329215581-26357-1-git-send-email-salvatore.cro@st.com>
Subject: [LTP] [PATCH V2] clone06: set child_env to getenv directly
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

sprintf check is bugged as a return value of 0 is acceptable.
Furthermore sprintf to set the child env var is unneeded.
Drop sprintf call as child_env can be set to getenv directly.

Signed-off-by: Salvatore Cro <salvatore.cro@st.com>
---
 testcases/kernel/syscalls/clone/clone06.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/clone/clone06.c b/testcases/kernel/syscalls/clone/clone06.c
index 5db183b..50c8ef3 100644
--- a/testcases/kernel/syscalls/clone/clone06.c
+++ b/testcases/kernel/syscalls/clone/clone06.c
@@ -192,18 +192,16 @@ void cleanup()
 int child_environ(void)
 {
 
-	char var[MAX_LINE_LENGTH];
+	char *child_env;
 
 	/* Close read end from child */
 	if ((close(pfd[0])) == -1) {
 		tst_brkm(TBROK|TERRNO, cleanup, "close(pfd[0]) failed");
 	}
 
-	if ((sprintf(var, "%s", getenv("TERM") ? : "")) <= 0) {
-		tst_resm(TWARN|TERRNO, "sprintf() failed");
-	}
+	child_env = getenv("TERM") ? : "";
 
-	if ((write(pfd[1], var, MAX_LINE_LENGTH)) == -1) {
+	if ((write(pfd[1], child_env, MAX_LINE_LENGTH)) == -1) {
 		tst_resm(TWARN|TERRNO, "write to pipe failed");
 	}
 
-- 
1.7.4.4


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
