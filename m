From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue,  1 Jun 2021 11:55:19 +0100
Subject: [LTP] [PATCH v3 4/6] API/cgroups: Auto add controllers to
 subtree_control in new subgroup
In-Reply-To: <20210601105521.27459-1-rpalethorpe@suse.com>
References: <20210601105521.27459-1-rpalethorpe@suse.com>
Message-ID: <20210601105521.27459-5-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is what we have always wanted so far. If we do not want to do it
on a new test then a new config option can be added during require.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 lib/tst_cgroup.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 0b71d4eed..74746f13e 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -826,19 +826,28 @@ static void cgroup_group_init(struct tst_cgroup_group *const cg,
 	strcpy(cg->group_name, group_name);
 }
 
-__attribute__ ((nonnull))
-static void cgroup_group_add_dir(struct tst_cgroup_group *const cg,
+__attribute__((nonnull (2, 3)))
+static void cgroup_group_add_dir(const struct tst_cgroup_group *const parent,
+				 struct tst_cgroup_group *const cg,
 				 struct cgroup_dir *const dir)
 {
 	const struct cgroup_ctrl *ctrl;
 	int i;
 
-	if (dir->dir_root->ver == TST_CGROUP_V2)
+	if (dir->dir_root->ver != TST_CGROUP_V1)
 		cg->dirs_by_ctrl[0] = dir;
 
 	for_each_ctrl(ctrl) {
-		if (has_ctrl(dir->ctrl_field, ctrl))
-			cg->dirs_by_ctrl[ctrl->ctrl_indx] = dir;
+		if (!has_ctrl(dir->ctrl_field, ctrl))
+			continue;
+
+		cg->dirs_by_ctrl[ctrl->ctrl_indx] = dir;
+
+		if (!parent || dir->dir_root->ver == TST_CGROUP_V1)
+			continue;
+
+		SAFE_CGROUP_PRINTF(parent, "cgroup.subtree_control",
+				   "+%s", ctrl->ctrl_name);
 	}
 
 	for (i = 0; cg->dirs[i]; i++);
@@ -859,7 +868,7 @@ tst_cgroup_group_mk(const struct tst_cgroup_group *const parent,
 	for_each_dir(parent, 0, dir) {
 		new_dir = SAFE_MALLOC(sizeof(*new_dir));
 		cgroup_dir_mk(*dir, group_name, new_dir);
-		cgroup_group_add_dir(cg, new_dir);
+		cgroup_group_add_dir(parent, cg, new_dir);
 	}
 
 	return cg;
@@ -1023,7 +1032,7 @@ static struct tst_cgroup_group *cgroup_group_from_roots(const size_t tree_off)
 		dir = (typeof(dir))(((char *)root) + tree_off);
 
 		if (dir->ctrl_field)
-			cgroup_group_add_dir(cg, dir);
+			cgroup_group_add_dir(NULL, cg, dir);
 	}
 
 	if (cg->dirs[0]) {
-- 
2.31.1

