Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <salvatore.cro@st.com>) id 1RsbKo-0001yp-De
	for ltp-list@lists.sourceforge.net; Wed, 01 Feb 2012 14:38:54 +0000
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113])
	by sog-mx-1.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RsbKi-0002GI-RS
	for ltp-list@lists.sourceforge.net; Wed, 01 Feb 2012 14:38:54 +0000
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 883C1153
	for <ltp-list@lists.sourceforge.net>;
	Wed,  1 Feb 2012 14:38:41 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2EE962799
	for <ltp-list@lists.sourceforge.net>;
	Wed,  1 Feb 2012 14:38:41 +0000 (GMT)
From: "Salvatore CRO'" <salvatore.cro@st.com>
Date: Wed,  1 Feb 2012 15:38:34 +0100
Message-Id: <1328107114-14472-1-git-send-email-salvatore.cro@st.com>
In-Reply-To: <1328097104-25615-1-git-send-email-salvatore.cro@st.com>
References: <1328097104-25615-1-git-send-email-salvatore.cro@st.com>
Subject: [LTP] [PATCH V2] syscalls: fix creat07 setup and arg to execve
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
 testcases/kernel/syscalls/creat/creat07.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
index 4ed2c22..3bb1288 100644
--- a/testcases/kernel/syscalls/creat/creat07.c
+++ b/testcases/kernel/syscalls/creat/creat07.c
@@ -90,8 +90,9 @@ int main(int ac, char **av)
 			tst_brkm(TBROK|TERRNO, cleanup, "fork #1 failed");

 		if (pid == 0) {
-			char *av[1];
+			char *av[2];
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
