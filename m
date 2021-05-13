From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 13 May 2021 16:21:22 +0100
Subject: [LTP] [PATCH 3/6] API/cgroups: Check for unknown controller name
In-Reply-To: <20210513152125.25766-1-rpalethorpe@suse.com>
References: <20210513152125.25766-1-rpalethorpe@suse.com>
Message-ID: <20210513152125.25766-4-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 lib/tst_cgroup.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 316dddde5..54636fd7e 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -306,7 +306,7 @@ void tst_cgroup_print_config(void)
 }
 
 __attribute__ ((nonnull, warn_unused_result))
-static struct cgroup_ctrl *cgroup_find_ctrl(const char *const ctrl_name)
+static struct cgroup_ctrl *cgroup_try_find_ctrl(const char *const ctrl_name)
 {
 	struct cgroup_ctrl *ctrl = controllers;
 
@@ -319,6 +319,22 @@ static struct cgroup_ctrl *cgroup_find_ctrl(const char *const ctrl_name)
 	return ctrl;
 }
 
+__attribute__ ((nonnull, returns_nonnull, warn_unused_result))
+static struct cgroup_ctrl *cgroup_find_ctrl(const char *const file,
+					    const int lineno,
+					    const char *const ctrl_name)
+{
+	struct cgroup_ctrl *const ctrl = cgroup_try_find_ctrl(ctrl_name);
+
+	if (!ctrl) {
+		tst_brk_(file, lineno, TBROK,
+			 "Did not find controller '%s'\n", ctrl_name);
+	}
+
+	return ctrl;
+}
+
+
 /* Determine if a mounted cgroup hierarchy is unique and record it if so.
  *
  * For CGroups V2 this is very simple as there is only one
@@ -355,7 +371,7 @@ static void cgroup_root_scan(const char *const mnt_type,
 	SAFE_FILE_READAT(mnt_dfd, "cgroup.controllers", buf, sizeof(buf));
 
 	for (tok = strtok(buf, " "); tok; tok = strtok(NULL, " ")) {
-		if ((const_ctrl = cgroup_find_ctrl(tok)))
+		if ((const_ctrl = cgroup_try_find_ctrl(tok)))
 			add_ctrl(&ctrl_field, const_ctrl);
 	}
 
@@ -371,7 +387,7 @@ static void cgroup_root_scan(const char *const mnt_type,
 
 v1:
 	for (tok = strtok(mnt_opts, ","); tok; tok = strtok(NULL, ",")) {
-		if ((const_ctrl = cgroup_find_ctrl(tok)))
+		if ((const_ctrl = cgroup_try_find_ctrl(tok)))
 			add_ctrl(&ctrl_field, const_ctrl);
 
 		no_prefix |= !strcmp("noprefix", tok);
@@ -580,7 +596,8 @@ void tst_cgroup_require(const char *const ctrl_name,
 			const struct tst_cgroup_opts *options)
 {
 	const char *const cgsc = "cgroup.subtree_control";
-	struct cgroup_ctrl *const ctrl = cgroup_find_ctrl(ctrl_name);
+	struct cgroup_ctrl *const ctrl =
+		cgroup_find_ctrl(__FILE__, __LINE__, ctrl_name);
 	struct cgroup_root *root;
 
 	if (!options)
@@ -892,13 +909,7 @@ static const struct cgroup_file *cgroup_file_find(const char *const file,
 	memcpy(ctrl_name, file_name, len);
 	ctrl_name[len] = '\0';
 
-        ctrl = cgroup_find_ctrl(ctrl_name);
-
-	if (!ctrl) {
-		tst_brk_(file, lineno, TBROK,
-			 "Did not find controller '%s'\n", ctrl_name);
-		return NULL;
-	}
+	ctrl = cgroup_find_ctrl(file, lineno, ctrl_name);
 
 	for (cfile = ctrl->files; cfile->file_name; cfile++) {
 		if (!strcmp(file_name, cfile->file_name))
@@ -919,7 +930,8 @@ enum tst_cgroup_ver tst_cgroup_ver(const char *const file, const int lineno,
 				    const struct tst_cgroup_group *const cg,
 				    const char *const ctrl_name)
 {
-	const struct cgroup_ctrl *const ctrl = cgroup_find_ctrl(ctrl_name);
+	const struct cgroup_ctrl *const ctrl = cgroup_find_ctrl(file, lineno,
+								ctrl_name);
 	const struct cgroup_dir *dir;
 
 	if (!strcmp(ctrl_name, "cgroup")) {
@@ -929,12 +941,6 @@ enum tst_cgroup_ver tst_cgroup_ver(const char *const file, const int lineno,
 		return 0;
 	}
 
-	if (!ctrl) {
-		tst_brk_(file, lineno,
-			 TBROK, "Unknown controller '%s'", ctrl_name);
-		return 0;
-	}
-
 	dir = cg->dirs_by_ctrl[ctrl->ctrl_indx];
 
 	if (!dir) {
-- 
2.31.1

