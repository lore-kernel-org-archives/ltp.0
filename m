From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Sat, 19 May 2018 17:22:20 +0800
Subject: [LTP] [PATCH] fs/read_all: Clear suplementary groups before droping
	privileges
In-Reply-To: <20180518170933.GA5094@rei>
References: <20180518170933.GA5094@rei>
Message-ID: <1526721740-8382-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Current user(e.g. root) has its own suplementary group set when logged in.  Which
means that even when a program sets it's user and group ids to nobody the current
group still stays in the list of supplementary groups, which then is matched for
files with the current group ownership and hence we can still access the file.

For example, if /dev/watchdog has root group ownership and rw group permissions,
running read_all_dev can still open /dev/watchdog and reboot system even after
switching user and group ids from root to nobody.

We need to clear suplementary groups before droping privileges and keep the same
rule as commit 1f011e5 if current user doesn't have the capabilities to clear
suplementary groups.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/fs/read_all/read_all.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index a8e1611..acd8e73 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -258,6 +258,12 @@ static void maybe_drop_privs(void)
 	if (!drop_privs)
 		return;
 
+	TEST(setgroups(0, NULL));
+	if (TEST_RETURN < 0 && TEST_ERRNO != EPERM) {
+		tst_brk(TBROK | TTERRNO,
+			"Failed to clear suplementary group set");
+	}
+
 	nobody = SAFE_GETPWNAM("nobody");
 
 	TEST(setgid(nobody->pw_gid));
-- 
1.8.3.1



