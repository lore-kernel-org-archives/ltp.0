From: Sandeep Patil <sspatil@google.com>
Date: Fri,  3 Aug 2018 08:22:25 -0700
Subject: [LTP] [PATCH] mknod03: Skip S_ISGID check on files created by
	non-group members.
Message-ID: <20180803152225.21107-1-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

0fa3ecd87848 ("Fix up non-directory creation in SGID directories") fixes
problem described in CVE-2018-13405. This commit is backported to older
streams as well.

This patch removes S_ISGID check for files created by non-group members
in LTP tests mknod03. Basically, does the same thing as commit
'3c87ef2961' for mknod03 test.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 testcases/kernel/syscalls/mknod/mknod03.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/mknod/mknod03.c b/testcases/kernel/syscalls/mknod/mknod03.c
index 2af66f78c..7ecadb5b3 100644
--- a/testcases/kernel/syscalls/mknod/mknod03.c
+++ b/testcases/kernel/syscalls/mknod/mknod03.c
@@ -142,14 +142,11 @@ int main(int ac, char **av)
 			fflag = 0;
 		}
 
-		/* Verify mode permissions of node */
-		if (!(buf.st_mode & S_ISGID)) {
-			tst_resm(TFAIL,
-				 "%s: Incorrect modes, setgid bit not "
-				 "set", node_name);
-			/* unset flag as functionality fails */
-			fflag = 0;
-		}
+		/*
+		 * Skip S_ISGID check
+		 * 0fa3ecd87848 ("Fix up non-directory creation in SGID directories")
+		 * clears S_ISGID for files created by non-group members
+		 */
 
 		/* Verify group ID */
 		if (buf.st_gid != group2_gid) {
-- 
2.18.0.597.ga71716f1ad-goog

