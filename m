From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Nov 2020 13:57:09 +0100
Subject: [LTP] [PATCH] [COMMITTED] syscalls/quotactl: Define kconfigs inline.
Message-ID: <20201124125709.12192-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/quotactl/quotactl01.c | 10 ++++------
 testcases/kernel/syscalls/quotactl/quotactl02.c |  5 ++++-
 testcases/kernel/syscalls/quotactl/quotactl02.h |  4 ----
 testcases/kernel/syscalls/quotactl/quotactl03.c | 10 ++++------
 testcases/kernel/syscalls/quotactl/quotactl04.c | 10 ++++------
 testcases/kernel/syscalls/quotactl/quotactl05.c |  5 ++++-
 testcases/kernel/syscalls/quotactl/quotactl06.c | 10 ++++------
 7 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index e1ec22529..7b3649fa5 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -210,14 +210,12 @@ static void verify_quota(unsigned int n)
 	tst_res(TPASS, "quotactl succeeded to %s", tc->des);
 }
 
-static const char *kconfigs[] = {
-	"CONFIG_QFMT_V2",
-	NULL
-};
-
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_kconfigs = kconfigs,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_QFMT_V2",
+		NULL
+	},
 	.test = verify_quota,
 	.tcnt = ARRAY_SIZE(tcases),
 	.mount_device = 1,
diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.c b/testcases/kernel/syscalls/quotactl/quotactl02.c
index cd8a0c388..4186bff65 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
@@ -142,7 +142,10 @@ static void verify_quota(unsigned int n)
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_kconfigs = kconfigs,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_XFS_QUOTA",
+		NULL
+	},
 	.test = verify_quota,
 	.tcnt = ARRAY_SIZE(tcases),
 	.mount_device = 1,
diff --git a/testcases/kernel/syscalls/quotactl/quotactl02.h b/testcases/kernel/syscalls/quotactl/quotactl02.h
index 5140a7042..37f3d7eb7 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl02.h
+++ b/testcases/kernel/syscalls/quotactl/quotactl02.h
@@ -26,10 +26,6 @@ static uint32_t test_id;
 static int x_getnextquota_nsup;
 static int x_getstatv_nsup;
 static const char mntpoint[] = "mnt_point";
-static const char *kconfigs[] = {
-	"CONFIG_XFS_QUOTA",
-	NULL
-};
 
 void check_support_cmd(int quotatype)
 {
diff --git a/testcases/kernel/syscalls/quotactl/quotactl03.c b/testcases/kernel/syscalls/quotactl/quotactl03.c
index d95719521..3ec931727 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl03.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl03.c
@@ -64,14 +64,12 @@ static void verify_quota(void)
 		tst_res(TPASS, "quotactl() failed with ENOENT as expected");
 }
 
-static const char *kconfigs[] = {
-	"CONFIG_XFS_QUOTA",
-	NULL
-};
-
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_kconfigs = kconfigs,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_XFS_QUOTA",
+		NULL
+	},
 	.test_all = verify_quota,
 	.mount_device = 1,
 	.dev_fs_type = "xfs",
diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index 3cc2b974f..9bd160e77 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -154,14 +154,12 @@ static void verify_quota(unsigned int n)
 	tst_res(TPASS, "quotactl succeeded to %s", tc->des);
 }
 
-static const char *kconfigs[] = {
-	"CONFIG_QFMT_V2",
-	NULL
-};
-
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_kconfigs = kconfigs,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_QFMT_V2",
+		NULL
+	},
 	.min_kver = "4.10", /* commit 689c958cbe6b (ext4: add project quota support) */
 	.test = verify_quota,
 	.tcnt = ARRAY_SIZE(tcases),
diff --git a/testcases/kernel/syscalls/quotactl/quotactl05.c b/testcases/kernel/syscalls/quotactl/quotactl05.c
index af5a164e4..e811e47a4 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl05.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl05.c
@@ -99,7 +99,10 @@ static void verify_quota(unsigned int n)
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_kconfigs = kconfigs,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_XFS_QUOTA",
+		NULL
+	},
 	.test = verify_quota,
 	.tcnt = ARRAY_SIZE(tcases),
 	.mount_device = 1,
diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
index 0a36c97a4..2818a4dc4 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -168,14 +168,12 @@ static void setup(void)
 	}
 }
 
-static const char *kconfigs[] = {
-	"CONFIG_QFMT_V2",
-	NULL
-};
-
 static struct tst_test test = {
 	.setup = setup,
-	.needs_kconfigs = kconfigs,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_QFMT_V2",
+		NULL
+	},
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_quotactl,
 	.dev_fs_type = "ext4",
-- 
2.26.2

