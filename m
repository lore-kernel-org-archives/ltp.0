From: Sandeep Patil <sspatil@google.com>
Date: Mon,  5 Nov 2018 15:50:15 -0800
Subject: [LTP] [PATCH 1/5] chroot01: Use the 'tmpdir' we create.
In-Reply-To: <20181105235019.254846-1-sspatil@google.com>
References: <20181105235019.254846-1-sspatil@google.com>
Message-ID: <20181105235019.254846-2-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Remove hard coded use of /tmp that breaks this test for Android and use
the tmpdir() we create in the setup() instead.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 testcases/kernel/syscalls/chroot/chroot01.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/chroot/chroot01.c b/testcases/kernel/syscalls/chroot/chroot01.c
index 9b0c30cf1..a1db5e157 100644
--- a/testcases/kernel/syscalls/chroot/chroot01.c
+++ b/testcases/kernel/syscalls/chroot/chroot01.c
@@ -54,7 +54,7 @@ char *TCID = "chroot01";
 int TST_TOTAL = 1;
 int fail;
 
-char path[] = "/tmp";
+char *path;
 
 char nobody_uid[] = "nobody";
 struct passwd *ltpuser;
@@ -94,6 +94,7 @@ void setup(void)
 	tst_require_root();
 
 	tst_tmpdir();
+	path = tst_get_tmpdir();
 
 	if ((ltpuser = getpwnam(nobody_uid)) == NULL)
 		tst_brkm(TBROK | TERRNO, cleanup,
@@ -110,5 +111,6 @@ void cleanup(void)
 {
 	SAFE_SETEUID(NULL, 0);
 
+	free(path);
 	tst_rmdir();
 }
-- 
2.19.1.930.g4563a0d9d0-goog

