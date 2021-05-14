From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 14 May 2021 10:12:27 +0100
Subject: [LTP] [PATCH] API/cgroups: Fix whitespace
Message-ID: <20210514091227.8936-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It appears LSP mode with clangd was sneekily inserting spaces.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_cgroup.h | 4 ++--
 lib/tst_cgroup.c     | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index 0df989bfd..de72645bc 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -25,8 +25,8 @@
  * case we end up with a set of hierarchies like the follwoing. Where
  * existing system-manager-created CGroups have been omitted.
  *
- * 	(V2 Root)	(V1 Root 1)	...	(V1 Root N)
- * 	    |		     |			     |
+ *	(V2 Root)	(V1 Root 1)	...	(V1 Root N)
+ *	    |		     |			     |
  *	  (ltp)		   (ltp)	...	   (ltp)
  *	 /     \	  /	\		  /	\
  *  (drain) (test-n) (drain)  (test-n)  ...  (drain)  (test-n)
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 279617297..ce6e256d3 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -123,7 +123,7 @@ struct cgroup_ctrl {
 	const enum cgroup_ctrl_indx ctrl_indx;
 
 	/* Runtime; hierarchy the controller is attached to */
-        struct cgroup_root *ctrl_root;
+	struct cgroup_root *ctrl_root;
 	/* Runtime; whether we required the controller */
 	int we_require_it:1;
 };
@@ -468,7 +468,7 @@ void tst_cgroup_scan(void)
 	}
 
 	do {
-                if (strncmp(mnt->mnt_type, "cgroup", 6))
+		if (strncmp(mnt->mnt_type, "cgroup", 6))
 			continue;
 
 		cgroup_root_scan(mnt->mnt_type, mnt->mnt_dir, mnt->mnt_opts);
@@ -556,7 +556,7 @@ mount:
 	if (!ctrl->ctrl_root)
 		return;
 
-        ctrl->ctrl_root->we_mounted_it = 1;
+	ctrl->ctrl_root->we_mounted_it = 1;
 	ctrl->ctrl_root->mnt_dir.we_created_it = made_dir;
 
 	if (ctrl->ctrl_indx == CTRL_MEMORY) {
-- 
2.31.1

