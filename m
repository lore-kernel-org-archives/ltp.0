From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri,  4 Jun 2021 14:41:36 +0100
Subject: [LTP] [PATCH] API/CGroups: Remove TEST macro use from library
Message-ID: <20210604134136.6629-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 lib/tst_cgroup.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 6d94ea41c..2b99c81a4 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -1073,6 +1073,7 @@ ssize_t safe_cgroup_read(const char *const file, const int lineno,
 	const char *alias;
 	size_t prev_len = 0;
 	char prev_buf[BUFSIZ];
+	ssize_t read_ret = 0;
 
 	for_each_dir(cg, cfile->ctrl_indx, dir) {
 		if (!(alias = cgroup_file_alias(cfile, *dir)))
@@ -1081,9 +1082,9 @@ ssize_t safe_cgroup_read(const char *const file, const int lineno,
 		if (prev_len)
 			memcpy(prev_buf, out, prev_len);
 
-		TEST(safe_file_readat(file, lineno,
-				      (*dir)->dir_fd, alias, out, len));
-		if (TST_RET < 0)
+		read_ret = safe_file_readat(file, lineno,
+					    (*dir)->dir_fd, alias, out, len);
+		if (read_ret < 0)
 			continue;
 
 		if (prev_len && memcmp(out, prev_buf, prev_len)) {
@@ -1093,12 +1094,12 @@ ssize_t safe_cgroup_read(const char *const file, const int lineno,
 			break;
 		}
 
-		prev_len = MIN(sizeof(prev_buf), (size_t)TST_RET);
+		prev_len = MIN(sizeof(prev_buf), (size_t)read_ret);
 	}
 
-	out[MAX(TST_RET, 0)] = '\0';
+	out[MAX(read_ret, 0)] = '\0';
 
-	return TST_RET;
+	return read_ret;
 }
 
 void safe_cgroup_printf(const char *const file, const int lineno,
-- 
2.31.1

