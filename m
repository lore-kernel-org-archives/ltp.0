From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Jul 2019 11:09:08 +0200
Subject: [LTP] [PATCH v4] syscalls/prctl06: New test for prctl() with
 PR_{SET, GET}_NO_NEW_PRIVS
In-Reply-To: <1563255457-2336-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20190715154945.GA28618@rei.lan>
 <1563255457-2336-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190716090908.GA12815@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with two changes, thanks.


diff --git a/testcases/kernel/syscalls/prctl/prctl06.c b/testcases/kernel/syscalls/prctl/prctl06.c
index eafbedfef..0e1274a2a 100644
--- a/testcases/kernel/syscalls/prctl/prctl06.c
+++ b/testcases/kernel/syscalls/prctl/prctl06.c
@@ -81,8 +81,8 @@ static void setup(void)
 
 	SAFE_CP(TESTBIN, TEST_REL_BIN_DIR);
 
-	SAFE_CHMOD(BIN_PATH, SUID_MODE);
 	SAFE_CHOWN(BIN_PATH, 0, 0);
+	SAFE_CHMOD(BIN_PATH, SUID_MODE);

 	TEST(prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
 	if (TST_RET == 0) {

This is actually important fix, you have to set the SUID bits last since
they are cleared if you change owner of the file.


diff --git a/testcases/kernel/syscalls/prctl/prctl06.h b/testcases/kernel/syscalls/prctl/prctl06.h
index 72f9c4e5a..f5c66e809 100644
--- a/testcases/kernel/syscalls/prctl/prctl06.h
+++ b/testcases/kernel/syscalls/prctl/prctl06.h
@@ -25,12 +25,14 @@
 #define BIN_PATH           MNTPOINT"/"TESTBIN
 #define SUID_MODE          (S_ISUID|S_ISGID|S_IXUSR|S_IXGRP|S_IXOTH)
 
-static int flag = 1;
-
 void check_proc_field(int val, char *name)
 {
+	static int flag = 1;
 	int field = 0;
 
+	if (!flag)
+		return;
+
 	TEST(FILE_LINES_SCANF(PROC_STATUS, "NoNewPrivs:%d", &field));
 	if (TST_RET == 1) {
 		tst_res(TCONF,
@@ -57,8 +59,8 @@ void check_no_new_privs(int val, char *name)
 		tst_res(TFAIL,
 			"%s prctl(PR_GET_NO_NEW_PRIVS) expected %d got %ld",
 			name, val, TST_RET);
-	if (flag)
-		check_proc_field(val, name);
+
+	check_proc_field(val, name);
 }
 
 #endif

This is merely cosmetic and moves the flag to the function so that it's
not global.

-- 
Cyril Hrubis
chrubis@suse.cz
