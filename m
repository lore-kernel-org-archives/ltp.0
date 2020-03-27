From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 27 Mar 2020 22:39:20 +0100
Subject: [LTP] [PATCH 2/6] Use .needs_cmds
In-Reply-To: <20200327213924.18816-1-pvorel@suse.cz>
References: <20200327213924.18816-1-pvorel@suse.cz>
Message-ID: <20200327213924.18816-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Change for quotactl01: require also userdel

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New commit.

 testcases/kernel/syscalls/add_key/add_key05.c   | 8 +++++---
 testcases/kernel/syscalls/quotactl/quotactl01.c | 7 ++++---
 testcases/kernel/syscalls/quotactl/quotactl06.c | 7 ++++---
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/add_key/add_key05.c b/testcases/kernel/syscalls/add_key/add_key05.c
index a39bfa0b7..7443a4970 100644
--- a/testcases/kernel/syscalls/add_key/add_key05.c
+++ b/testcases/kernel/syscalls/add_key/add_key05.c
@@ -43,9 +43,6 @@ static void add_user(void)
 		user_added = 1;
 		ltpuser = SAFE_GETPWNAM(username);
 		break;
-	case 255:
-		tst_brk(TCONF, "useradd not found");
-		break;
 	default:
 		tst_brk(TBROK, "useradd failed (%d)", rc);
 	}
@@ -215,6 +212,11 @@ static struct tst_test test = {
 		{&user_buf, .size = 64},
 		{}
 	},
+	.needs_cmds = (const char *const []) {
+		"useradd",
+		"userdel",
+		NULL
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "a08bf91ce28"},
 		{"linux-git", "2e356101e72"},
diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index ede61d7e4..6cc1deeb8 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -168,9 +168,6 @@ static void setup(void)
 	switch (ret) {
 	case 0:
 		break;
-	case 255:
-		tst_brk(TCONF, "quotacheck binary not installed");
-		break;
 	default:
 		tst_brk(TBROK, "quotacheck exited with %i", ret);
 	}
@@ -234,5 +231,9 @@ static struct tst_test test = {
 	.dev_fs_type = "ext4",
 	.mntpoint = MNTPOINT,
 	.mnt_data = "usrquota,grpquota",
+	.needs_cmds = (const char *const []) {
+		"quotacheck",
+		NULL
+	},
 	.setup = setup,
 };
diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
index a3b4517e0..758bd84cd 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -153,9 +153,6 @@ static void setup(void)
 	switch (ret) {
 	case 0:
 		break;
-	case 255:
-		tst_brk(TCONF, "quotacheck binary not installed");
-		break;
 	default:
 		tst_brk(TBROK, "quotacheck exited with %i", ret);
 	}
@@ -192,5 +189,9 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.mnt_data = "usrquota",
+	.needs_cmds = (const char *const []) {
+		"quotacheck",
+		NULL
+	},
 	.needs_root = 1,
 };
-- 
2.25.1

