From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 Feb 2019 12:09:58 +0100
Subject: [LTP] [PATCH v6] syscalls/statx: Add test for sync flags
In-Reply-To: <1545807270-3790-1-git-send-email-vaishnavi.d@zilogic.com>
References: <1545807270-3790-1-git-send-email-vaishnavi.d@zilogic.com>
Message-ID: <20190221110957.GA16911@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a few changes, see below, thanks a lot for the work.

Also sorry for the long delay.

--- a/testcases/kernel/syscalls/statx/statx07.c
+++ b/testcases/kernel/syscalls/statx/statx07.c
@@ -26,8 +26,19 @@
  * AT_STATX_FORCE_SYNC is called to create cache data of the file.
  * Then, by using DONT_SYNC_FILE getting old cached data in client folder,
  * but mode has been chaged in server file.
+ *
+ * The support for SYNC flags was implemented in NFS in:
+ *
+ * commit 9ccee940bd5b766b6dab6c1a80908b9490a4850d
+ * Author: Trond Myklebust <trond.myklebust@primarydata.com>
+ * Date:   Thu Jan 4 17:46:09 2018 -0500
+ *
+ *     Support statx() mask and query flags parameters
+ *
+ * Hence we skip the test on anything older than 4.16.
  */

(Added explanation why we skip the test on kernels prior 4.16)

+#define _GNU_SOURCE
(The _GNU_SOURCE has to be defined before we include anything from libc,
moved it here from the lapi header)
 #include <netdb.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -58,19 +69,20 @@ static int exported;
 
 static int get_mode(char *file_name, int flag_type, char *flag_name)
 {
-	struct statx buff;
+	struct statx buf;
 
-	TEST(statx(AT_FDCWD, file_name, flag_type, STATX_ALL, &buff));
+	TEST(statx(AT_FDCWD, file_name, flag_type, STATX_ALL, &buf));
 
-	if (TST_RET == -1)
+	if (TST_RET == -1) {
 		tst_brk(TFAIL | TST_ERR,
-			"statx(AT_FDCWD, %s, %s, STATX_ALL, &buff)",
-			file_name, flag_name);
-	else
-		tst_res(TINFO, "statx(AT_FDCWD, %s, %s, STATX_ALL, &buff)",
+			"statx(AT_FDCWD, %s, %s, STATX_ALL, &buf)",
 			file_name, flag_name);
+	}
 
-	return buff.stx_mode;
+	tst_res(TINFO, "statx(AT_FDCWD, %s, %s, STATX_ALL, &buf) = %o",
+		file_name, flag_name, buf.stx_mode);
+
+	return buf.stx_mode;
 }

(Just minor changes)

 const struct test_cases {
@@ -89,20 +101,22 @@ static void test_statx(unsigned int i)
 	const struct test_cases *tc = &tcases[i];
 	unsigned int cur_mode;
 
-	if (tc->flag == AT_STATX_DONT_SYNC)
-		get_mode(tc->client_file, tc->flag, tc->flag_name);
+	get_mode(tc->client_file, AT_STATX_FORCE_SYNC, "AT_STATX_FORCE_SYNC");

(This has been changed so that we are sure that the old data are in the
cache so we do FORCE_SYNC statx regardless the test)
 
 	SAFE_CHMOD(tc->server_file, CURRENT_MODE);
 	cur_mode = get_mode(tc->client_file, tc->flag, tc->flag_name);
 
-	if (MODE(cur_mode) == tc->mode)
+	if (MODE(cur_mode) == tc->mode) {
 		tst_res(TPASS,
-			"statx() with %s for mode %o %o",
-			tc->flag_name, tc->mode, MODE(cur_mode));
-	else
+			"statx() with %s for mode %o",
+			tc->flag_name, tc->mode);
+	} else {
 		tst_res(TFAIL,
 			"statx() with %s for mode %o %o",
 			tc->flag_name, tc->mode, MODE(cur_mode));
+	}
+
+	SAFE_CHMOD(tc->server_file, DEFAULT_MODE);

(And we reset the file mode back after the test so that we do something
meaningful for the -i test option)

 }


 static void setup(void)
@@ -131,7 +145,7 @@ static void setup(void)
 		tst_brk(TBROK | TST_ERR, "failed to exportfs");
 
 	if (mount(server_path, CLI_PATH, "nfs", 0, "addr=127.0.0.1")) {
-		if (errno == EOPNOTSUPP)
+		if (errno == EOPNOTSUPP || errno == ECONNREFUSED)
 			tst_brk(TCONF | TERRNO, "nfs server not set up?");

(And I've found that on some distros we got ECONNREFUSED if nfs server
is not set up)

 		tst_brk(TBROK | TERRNO, "mount() nfs failed");
 	}

-- 
Cyril Hrubis
chrubis@suse.cz
