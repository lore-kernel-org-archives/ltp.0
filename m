From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 13 Jul 2021 19:24:50 +0300
Subject: [LTP] [PATCH] syscalls/fanotify19: Add test cases for elevated
 reader privileges
Message-ID: <20210713162450.34947-1-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Even when event reader has elevated privileges, the information provided
in events is determined by the privileges of the user that created the
fanotify group.

Add test cases for unprivileged listener and privileged event reader.

This is a regression test for kernel commit
a8b98c808eab ("fanotify: fix permission model of unprivileged group")

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Petr,

Added test for a fix in v5.13-rc5.

Thanks,
Amir.

 .../kernel/syscalls/fanotify/fanotify19.c     | 57 ++++++++++++++++---
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify19.c b/testcases/kernel/syscalls/fanotify/fanotify19.c
index e4ac8a032..3792c717c 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify19.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify19.c
@@ -38,6 +38,7 @@
 #define MOUNT_PATH	"fs_mnt"
 #define TEST_FILE	MOUNT_PATH "/testfile"
 
+static uid_t euid;
 static int fd_notify;
 static char buf[BUF_SIZE];
 static struct fanotify_event_metadata event_buf[EVENT_BUF_LEN];
@@ -45,12 +46,14 @@ static struct fanotify_event_metadata event_buf[EVENT_BUF_LEN];
 static struct test_case_t {
 	const char *name;
 	unsigned int fork;
+	unsigned int elevate;
 	unsigned int event_count;
 	unsigned long long event_set[EVENT_SET_MAX];
 } test_cases[] = {
 	{
 		"unprivileged listener - events by self",
 		0,
+		0,
 		4,
 		{
 			FAN_OPEN,
@@ -62,6 +65,7 @@ static struct test_case_t {
 	{
 		"unprivileged lisneter - events by child",
 		1,
+		0,
 		4,
 		{
 			FAN_OPEN,
@@ -69,7 +73,31 @@ static struct test_case_t {
 			FAN_MODIFY,
 			FAN_CLOSE,
 		}
-	}
+	},
+	{
+		"unprivileged listener, privileged reader - events by self",
+		0,
+		1,
+		4,
+		{
+			FAN_OPEN,
+			FAN_ACCESS,
+			FAN_MODIFY,
+			FAN_CLOSE,
+		}
+	},
+	{
+		"unprivileged lisneter, privileged reader - events by child",
+		1,
+		1,
+		4,
+		{
+			FAN_OPEN,
+			FAN_ACCESS,
+			FAN_MODIFY,
+			FAN_CLOSE,
+		}
+	},
 };
 
 static void generate_events(void)
@@ -118,6 +146,14 @@ static void test_fanotify(unsigned int n)
 
 	tst_res(TINFO, "Test #%d %s", n, tc->name);
 
+	/* Relinquish privileged user */
+	if (euid == 0) {
+		tst_res(TINFO,
+			"Running as privileged user, revoking.");
+		struct passwd *nobody = SAFE_GETPWNAM("nobody");
+		SAFE_SETEUID(nobody->pw_uid);
+	}
+
 	/* Initialize fanotify */
 	fd_notify = fanotify_init(FANOTIFY_REQUIRED_USER_INIT_FLAGS, O_RDONLY);
 
@@ -149,6 +185,13 @@ static void test_fanotify(unsigned int n)
 	else
 		generate_events();
 
+	/* Restore privileges */
+	if (euid == 0 && tc->elevate) {
+		tst_res(TINFO,
+			"Restoring privileged user.");
+		SAFE_SETEUID(0);
+	}
+
 	/* Read events from queue */
 	len = SAFE_READ(0, fd_notify, event_buf + len, EVENT_BUF_LEN - len);
 
@@ -224,13 +267,7 @@ static void setup(void)
 	/* Check for kernel fanotify support */
 	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_FID, TEST_FILE);
 
-	/* Relinquish privileged user */
-	if (geteuid() == 0) {
-		tst_res(TINFO,
-			"Running as privileged user, revoking.");
-		struct passwd *nobody = SAFE_GETPWNAM("nobody");
-		SAFE_SETUID(nobody->pw_uid);
-	}
+	euid = geteuid();
 }
 
 static void cleanup(void)
@@ -248,6 +285,10 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "a8b98c808eab"},
+		{}
+	}
 };
 
 #else
-- 
2.25.1

