Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <salvatore.cro@st.com>) id 1Rpye5-0008Ou-4P
	for ltp-list@lists.sourceforge.net; Wed, 25 Jan 2012 08:55:57 +0000
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137])
	by sog-mx-3.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Rpye0-0006O4-W1
	for ltp-list@lists.sourceforge.net; Wed, 25 Jan 2012 08:55:57 +0000
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F3A91193
	for <ltp-list@lists.sourceforge.net>;
	Wed, 25 Jan 2012 08:55:31 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B79531CA5
	for <ltp-list@lists.sourceforge.net>;
	Wed, 25 Jan 2012 08:55:31 +0000 (GMT)
From: "Salvatore CRO'" <salvatore.cro@st.com>
Date: Wed, 25 Jan 2012 09:55:24 +0100
Message-Id: <1327481724-28367-1-git-send-email-salvatore.cro@st.com>
Subject: [LTP] [PATCH] syscalls: fix creat07 setup and argv to execve
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

Fix test_path variable logic in setup function.
Also use a new argv variable to be passed to execve.

Signed-off-by: Salvatore Cro <salvatore.cro@st.com>
---
 testcases/kernel/syscalls/creat/creat07.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
index 4ed2c22..43a6030 100644
--- a/testcases/kernel/syscalls/creat/creat07.c
+++ b/testcases/kernel/syscalls/creat/creat07.c
@@ -90,9 +90,8 @@ int main(int ac, char **av)
 			tst_brkm(TBROK|TERRNO, cleanup, "fork #1 failed");
 
 		if (pid == 0) {
-			char *av[1];
-			av[0] = basename(test_app);
-			(void)execve(test_app, av, NULL);
+			char *argv[] = { test_app, NULL };
+			(void)execve(test_app, argv, NULL);
 			perror("execve failed");
 			exit(1);
 		}
@@ -138,14 +137,15 @@ void setup(char *app)
 	char *cmd, *pwd = NULL;
 	char test_path[MAXPATHLEN];
 
-	if (test_app[0] == '/')
-		strncpy(test_path, test_app, sizeof(test_app));
+	if (app[0] == '/')
+		snprintf(test_path, sizeof(test_path), "%s/%s",
+				dirname(app), test_app);
 	else {
 		if ((pwd = get_current_dir_name()) == NULL)
 			tst_brkm(TBROK|TERRNO, NULL, "getcwd failed");
 
 		snprintf(test_path, sizeof(test_path), "%s/%s",
-		    pwd, basename(test_app));
+		    pwd, test_app);
 
 		free(pwd);
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
