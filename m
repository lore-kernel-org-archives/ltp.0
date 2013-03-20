Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UIFZf-0000zH-Dj
	for ltp-list@lists.sourceforge.net; Wed, 20 Mar 2013 09:44:47 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UIFZe-0006qv-A9
	for ltp-list@lists.sourceforge.net; Wed, 20 Mar 2013 09:44:47 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r2K9ieeB019106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 20 Mar 2013 05:44:40 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id r2K9ic67007625
	for <ltp-list@lists.sourceforge.net>; Wed, 20 Mar 2013 05:44:39 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 20 Mar 2013 10:44:33 +0100
Message-Id: <1363772673-14851-2-git-send-email-jstancek@redhat.com>
Subject: [LTP] [PATCH] inode01: remove "slash" array
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

and replace strcats with snprintf.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/fs/inode/inode01.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/fs/inode/inode01.c b/testcases/kernel/fs/inode/inode01.c
index 9643651..b3a9a0b 100644
--- a/testcases/kernel/fs/inode/inode01.c
+++ b/testcases/kernel/fs/inode/inode01.c
@@ -96,7 +96,6 @@ char rm_string[200];
 FILE *list_stream = NULL;
 int file_id;
 int list_id;
-char slash[2];
 
 int increment_name(), get_next_name(), mode(), escrivez();
 
@@ -110,9 +109,7 @@ int main()
 	int status;
 	int len;
 	int term();
-
-	slash[0] = '/';
-	slash[1] = '\0';
+	int snp_ret;
 
 	strcpy(path_string, "inode");
 	sprintf(root, "A%d", getpid());
@@ -160,9 +157,13 @@ int main()
 	/*                                      */
 	/****************************************/
 
-	strcpy(path_list_string, path_string);
-	strcat(path_list_string, slash);
-	strcat(path_list_string, "path_list");
+	snp_ret = snprintf(path_list_string, sizeof(path_list_string),
+		"%s/path_list",	path_string);
+	if (snp_ret < 0 || snp_ret >= sizeof(path_list_string)) {
+		tst_resm(TBROK, "snprintf(path_list_string,..) returned %d",
+			snp_ret);
+		fail_exit();
+	}
 	list_id = creat(path_list_string, FILE_MODE);
 	if (list_id == -1) {
 		fprintf(temp,
@@ -308,6 +309,7 @@ int level;			/* the tree depth variable */
 	char new_string[PATH_STRING_LENGTH + 1];
 	int new_level;
 	int i, j;		/* iteration counters */
+	int snp_ret;
 
 	switch_flag = level & TRUE;
 	if (strlen(string) >= MAX_PATH_STRING_LENGTH) {
@@ -324,9 +326,13 @@ int level;			/* the tree depth variable */
 	} else if (level < MAX_DEPTH) {
 		for (i = 0; i <= MAX_BREADTH; i++) {
 			get_next_name();
-			strcpy(new_string, string);
-			strcat(new_string, slash);
-			strcat(new_string, name);
+			snp_ret = snprintf(new_string, sizeof(new_string),
+				"%s/%s", string, name);
+			if (snp_ret < 0 || snp_ret >= sizeof(new_string)) {
+				tst_resm(TBROK, "snprintf(new_string,..) "
+					"returned %d", snp_ret);
+				fail_exit();
+			}
 
 			/****************************************/
 			/*                                      */
-- 
1.7.1


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
