From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 27 Apr 2016 13:51:14 +0300
Subject: [LTP] [PATCH] lib/rmobj.c: fix warning on FUSE fs
Message-ID: <1461754274-9903-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This warning can appear on FUSE fs in cleanup():
TWARN  :  tst_tmpdir.c:219: tst_rmdir: rmobj(...) failed: unlink(
.../.fuse_hidden#####) failed; errno=2: No such file or directory

rmobj recursively goes through directory entries and unlinks files
there. During the time between getting the entry and calling unlink()
the file can be deleted by FS.

We can fix it by skipping ENOENT errno as it is possible that a file
might not exist by that time.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 lib/rmobj.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/rmobj.c b/lib/rmobj.c
index a9de59c..aa5bb6a 100644
--- a/lib/rmobj.c
+++ b/lib/rmobj.c
@@ -192,8 +192,13 @@ int rmobj(char *obj, char **errmsg)
 			}
 		}
 	} else {
-		/* object is not a directory; just use unlink() */
-		if (unlink(obj) < 0) {
+		/* object is not a directory; just use unlink()
+		 * Note: skip ENOENT errno as it might catch hidden temporary
+		 * files (e.g. can be created by FUSE FS) when listing directory
+		 * entries on the previous stage, but the file could have been
+		 * removed by FS already.
+		 */
+		if (unlink(obj) < 0 && errno != ENOENT) {
 			if (errmsg != NULL) {
 				sprintf(err_msg,
 					"unlink(%s) failed; errno=%d: %s", obj,
-- 
1.7.1

