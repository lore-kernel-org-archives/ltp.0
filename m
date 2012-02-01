Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <salvatore.cro@st.com>) id 1RsZDO-00074N-NG
	for ltp-list@lists.sourceforge.net; Wed, 01 Feb 2012 12:23:06 +0000
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131])
	by sog-mx-3.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RsZDK-00059D-IR
	for ltp-list@lists.sourceforge.net; Wed, 01 Feb 2012 12:23:06 +0000
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 32F7C12E
	for <ltp-list@lists.sourceforge.net>;
	Wed,  1 Feb 2012 11:51:52 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EA6102406
	for <ltp-list@lists.sourceforge.net>;
	Wed,  1 Feb 2012 11:51:51 +0000 (GMT)
From: "Salvatore CRO'" <salvatore.cro@st.com>
Date: Wed,  1 Feb 2012 12:51:44 +0100
Message-Id: <1328097104-25615-1-git-send-email-salvatore.cro@st.com>
Subject: [LTP] [PATCH] syscalls: fix creat07 setup and arg to execve
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

Fix typo in setup function as app[0] should be
checked instead of test_app[0].
Fix test_path concatenating the absolute
path to test_app when required (app[0] == '/').
Finally fix execve (returning Bad address - EFAULT)
argument av[1] as it requires argument
array to be terminated by a null pointer.

Signed-off-by: Salvatore Cro <salvatore.cro@st.com>
---
 testcases/kernel/syscalls/creat/creat07.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
index 4ed2c22..edaa182 100644
--- a/testcases/kernel/syscalls/creat/creat07.c
+++ b/testcases/kernel/syscalls/creat/creat07.c
@@ -92,6 +92,7 @@ int main(int ac, char **av)
 		if (pid == 0) {
 			char *av[1];
 			av[0] = basename(test_app);
+			av[1] = NULL;
 			(void)execve(test_app, av, NULL);
 			perror("execve failed");
 			exit(1);
@@ -138,8 +139,9 @@ void setup(char *app)
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
