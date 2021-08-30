From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 30 Aug 2021 15:17:29 +0200
Subject: [LTP] [PATCH 1/2] Add verbose setup to creat08, creat09 and open10
Message-ID: <20210830131730.31935-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These tests are sensitive to proper UID/GID configuration so print
the detected values for debugging purposes in case of test failure.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 lib/tst_uid.c                             | 5 ++++-
 testcases/kernel/syscalls/creat/creat08.c | 2 ++
 testcases/kernel/syscalls/creat/creat09.c | 2 ++
 testcases/kernel/syscalls/open/open10.c   | 2 ++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/tst_uid.c b/lib/tst_uid.c
index a73cafa46..2163b1494 100644
--- a/lib/tst_uid.c
+++ b/lib/tst_uid.c
@@ -23,8 +23,11 @@ gid_t tst_get_free_gid_(const char *file, const int lineno, gid_t skip)
 		if (ret == skip || getgrgid(ret))
 			continue;
 
-		if (errno == 0 || errno == ENOENT || errno == ESRCH)
+		if (errno == 0 || errno == ENOENT || errno == ESRCH) {
+			tst_res_(file, lineno, TINFO | TERRNO,
+				"Found unused GID %d", (int)ret);
 			return ret;
+		}
 
 		tst_brk_(file, lineno, TBROK|TERRNO, "Group ID lookup failed");
 		return (gid_t)-1;
diff --git a/testcases/kernel/syscalls/creat/creat08.c b/testcases/kernel/syscalls/creat/creat08.c
index 4392f198a..91581dbf8 100644
--- a/testcases/kernel/syscalls/creat/creat08.c
+++ b/testcases/kernel/syscalls/creat/creat08.c
@@ -41,6 +41,8 @@ static void setup(void)
 	orig_uid = getuid();
 	nobody_uid = ltpuser->pw_uid;
 	nobody_gid = ltpuser->pw_gid;
+	tst_res(TINFO, "User nobody: uid = %d, gid = %d", (int)nobody_uid,
+		(int)nobody_gid);
 	free_gid = tst_get_free_gid(nobody_gid);
 	tmpdir = tst_get_tmpdir();
 }
diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
index 1de16d636..53ab202c1 100644
--- a/testcases/kernel/syscalls/creat/creat09.c
+++ b/testcases/kernel/syscalls/creat/creat09.c
@@ -41,6 +41,8 @@ static void setup(void)
 	struct stat buf;
 	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
 
+	tst_res(TINFO, "User nobody: uid = %d, gid = %d", (int)ltpuser->pw_uid,
+		(int)ltpuser->pw_gid);
 	free_gid = tst_get_free_gid(ltpuser->pw_gid);
 
 	/* Create directories and set permissions */
diff --git a/testcases/kernel/syscalls/open/open10.c b/testcases/kernel/syscalls/open/open10.c
index e3804c74f..d2d3729d2 100644
--- a/testcases/kernel/syscalls/open/open10.c
+++ b/testcases/kernel/syscalls/open/open10.c
@@ -39,6 +39,8 @@ static void setup(void)
 	orig_uid = getuid();
 	nobody_uid = ltpuser->pw_uid;
 	nobody_gid = ltpuser->pw_gid;
+	tst_res(TINFO, "User nobody: uid = %d, gid = %d", (int)nobody_uid,
+		(int)nobody_gid);
 	free_gid = tst_get_free_gid(nobody_gid);
 	tmpdir = tst_get_tmpdir();
 }
-- 
2.32.0

