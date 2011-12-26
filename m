Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Jin.Li@windriver.com>) id 1Rf0xr-0000Ga-Sk
	for ltp-list@lists.sourceforge.net; Mon, 26 Dec 2011 03:11:03 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Rf0xq-0004If-IH
	for ltp-list@lists.sourceforge.net; Mon, 26 Dec 2011 03:11:03 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id pBQ3Auih017414
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Sun, 25 Dec 2011 19:10:56 -0800 (PST)
From: Jin Li <jin.li@windriver.com>
Date: Mon, 26 Dec 2011 11:10:52 +0800
Message-ID: <1324869052-22433-1-git-send-email-jin.li@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] This fix make sure the function "setpgid" get invoked
	in the right time in setpgid03 test02.
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
To: haotian.zhang@windriver.com, jin.li@windriver.com, ltp-list@lists.sourceforge.net

In setpgid03 test02, the function "setpgid" is likely to be invoked

in father process before the function "execlp" get invoked in child

process. Sometimes The performance or NFS file system may cause that

the switch of context could not be done even after the 1 second sleeping

of father process. In this case, the setpgid will get unexpected error

number. Add sync mechanism to insure the 'setpgid' get invoked in the right

order.

Signed-off-by: Jin Li <jin.li@windriver.com>
---
 testcases/kernel/syscalls/setpgid/setpgid03.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/setpgid/setpgid03.c b/testcases/kernel/syscalls/setpgid/setpgid03.c
index a894389..a011419 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid03.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid03.c
@@ -46,6 +46,7 @@
 
 char *TCID = "setpgid03";
 int TST_TOTAL = 1;
+char temp_file[64];
 
 void do_child(void);
 void setup(void);
@@ -60,6 +61,7 @@ int main(int ac, char **av)
 
 	int lc;			/* loop counter */
 	char *msg;		/* message returned from parse_opts */
+	char cmd_line[1024];    /* command line for exec */
 
 	/* parse standard options */
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
@@ -74,6 +76,10 @@ int main(int ac, char **av)
 	 */
 	setup();
 
+	sprintf(temp_file,"/tmp/%s_file",TCID);
+
+	sprintf(cmd_line,"touch %s;sleep 5s;rm -f %s", temp_file, temp_file);
+
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
 		/* reset Tst_count in case we are looping */
@@ -132,12 +138,15 @@ int main(int ac, char **av)
 
 		}
 		if (pid == 0) {
-			if (execlp("sleep", "sleep", "3", NULL) < 0) {
+			if (execlp("sh", "sh", "-c", cmd_line, NULL) < 0) {
 				perror("exec failed");
 			}
 			exit(127);
 		} else {
-			sleep(1);
+			while ( access(temp_file, F_OK) != 0 ) {
+                            sleep(1);
+			}
+
 			rval = setpgid(pid, getppid());
 			if (errno == EACCES) {
 				tst_resm(TPASS, "setpgid SUCCEEDED to set "
@@ -203,4 +212,4 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
-}
\ No newline at end of file
+}
-- 
1.6.3.1


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
