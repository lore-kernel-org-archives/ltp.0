Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WdH9j-0001yY-Hh
	for ltp-list@lists.sourceforge.net; Thu, 24 Apr 2014 10:45:27 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WdH9h-0007jW-3E
	for ltp-list@lists.sourceforge.net; Thu, 24 Apr 2014 10:45:27 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s3OAjE8o032484
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Apr 2014 18:45:14 +0800
Message-ID: <1398336295.2318.4.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 24 Apr 2014 18:44:55 +0800
In-Reply-To: <1398336249.2318.3.camel@G08JYZSD130126>
References: <1398336249.2318.3.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/3] setegid/setegid01.c: cleanup
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
To: ltp-list <ltp-list@lists.sourceforge.net>

* Delete some useless commtents.

* Move the test body from main() to setegid_verify().

* Remove verbose, options global variables and help funtion.

* Use safe macros.

* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/setegid/setegid01.c | 137 +++++++++++++-------------
 1 file changed, 70 insertions(+), 67 deletions(-)

diff --git a/testcases/kernel/syscalls/setegid/setegid01.c b/testcases/kernel/syscalls/setegid/setegid01.c
index 52483e4..ed3aaff 100644
--- a/testcases/kernel/syscalls/setegid/setegid01.c
+++ b/testcases/kernel/syscalls/setegid/setegid01.c
@@ -1,19 +1,19 @@
 /*
- *   Copyright (c) Dan Kegel 2003
+ * Copyright (c) Dan Kegel 2003
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
 /*
@@ -31,75 +31,72 @@
 #include <errno.h>
 #include "test.h"
 #include "usctest.h"
+#include "safe_macros.h"
 
 char *TCID = "setegid01";
-int TST_TOTAL = 1;		/* is this number right? */
-int verbose = 0;
+int TST_TOTAL = 1;
+static void setup(void);
+static void setegid_verify(void);
+static void cleanup(void);
 
-option_t options[] = {
-	{"v", &verbose, NULL},	/* No argument */
-	{NULL, NULL, NULL}	/* NULL required to end array */
-};
-
-void help(void)
-{
-	printf("  -v       verbose\n");
-}
+static gid_t nobody_gid;
 
 int main(int argc, char **argv)
 {
-	struct passwd nobody;
-	gid_t nobody_gid;
-	gid_t cur_rgid, cur_egid, cur_sgid;
-	gid_t orig_rgid, orig_egid, orig_sgid;
+	int lc;
 	char *msg;
 
-	if ((msg = parse_opts(argc, argv, options, help)) != NULL) {
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "Option parsing error - %s", msg);
-		tst_exit();
-	}
 
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be super/root for this test!");
-		tst_exit();
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+		setegid_verify();
 	}
 
-	nobody = *getpwnam("nobody");
-	nobody_gid = nobody.pw_gid;
+	cleanup();
+	tst_exit();
+}
 
-	TEST(getresgid(&orig_rgid, &orig_egid, &orig_sgid));
-	if (TEST_RETURN == -1) {
-		tst_resm(TBROK, "getresgid() Failed, errno=%d : %s", TEST_ERRNO,
-			 strerror(TEST_ERRNO));
-		tst_exit();
-	}
-	if (verbose) {
-		printf("getresgid reports rgid %d, egid %d, sgid %d\n",
-		       orig_rgid, orig_egid, orig_sgid);
-		printf("calling setegid(nobody_gid %d)\n", nobody_gid);
-	}
-	TEST(setegid(nobody_gid));
-	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL, "setegid() Failed, errno=%d : %s", TEST_ERRNO,
-			 strerror(TEST_ERRNO));
-		tst_exit();
-	}
+static void setup(void)
+{
+	struct passwd *nobody;
 
-	TEST(getresgid(&cur_rgid, &cur_egid, &cur_sgid));
-	if (TEST_RETURN == -1) {
-		tst_resm(TBROK, "setegid() Failed, errno=%d : %s", TEST_ERRNO,
-			 strerror(TEST_ERRNO));
-		tst_exit();
-	}
-	if (verbose) {
-		printf("getresgid reports rgid %d, egid %d, sgid %d\n",
-		       cur_rgid, cur_egid, cur_sgid);
-	}
+	tst_require_root(NULL);
+
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+
+	nobody = SAFE_GETPWNAM(cleanup, "nobody");
+
+	nobody_gid = nobody->pw_gid;
+}
+
+static void setegid_verify(void)
+{
+	gid_t cur_rgid, cur_egid, cur_sgid;
+	gid_t orig_rgid, orig_egid, orig_sgid;
+
+	SAFE_GETRESGID(cleanup, &orig_rgid, &orig_egid, &orig_sgid);
+	tst_resm(TINFO, "getresgid reports rgid %d, egid %d, sgid %d",
+		 orig_rgid, orig_egid, orig_sgid);
+
+	tst_resm(TINFO, "calling setegid(nobody_gid %d)", nobody_gid);
+	SAFE_SETEGID(cleanup, nobody_gid);
+
+	SAFE_GETRESGID(cleanup, &cur_rgid, &cur_egid, &cur_sgid);
+	tst_resm(TINFO, "getresgid reports rgid %d, egid %d, sgid %d", cur_rgid,
+		 cur_egid, cur_sgid);
 
 	/* make sure it at least does what its name says */
 	if (nobody_gid != cur_egid) {
 		tst_resm(TFAIL,
-			 "setegid() Failed functional test: it failed to change the effective gid");
+			 "setegid() Failed functional test: it failed to change"
+			 "the effective gid");
 		tst_exit();
 	}
 
@@ -109,15 +106,21 @@ int main(int argc, char **argv)
 	 */
 	if (orig_sgid != cur_sgid) {
 		tst_resm(TFAIL,
-			 "setegid() Failed functional test: it changed the saved set-gid");
+			 "setegid() Failed functional test: it changed the"
+			 "saved set-gid");
 		tst_exit();
 	}
 	if (orig_rgid != cur_rgid) {
 		tst_resm(TFAIL,
-			 "setegid() Failed functional test: it changed the real gid");
+			 "setegid() Failed functional test: it changed the real"
+			 "gid");
 		tst_exit();
 	}
 	tst_resm(TPASS, "setegid() passed functional test");
-	tst_exit();
-	tst_exit();
+
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
 }
-- 
1.8.4.2




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
