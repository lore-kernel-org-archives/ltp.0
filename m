From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 21 May 2021 11:25:23 +0100
Subject: [LTP] [PATCH v2 1/6] API/cgroups: Allow fetching of CGroup name
In-Reply-To: <20210521102528.21102-1-rpalethorpe@suse.com>
References: <20210521102528.21102-1-rpalethorpe@suse.com>
Message-ID: <20210521102528.21102-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Lets the test author get the name of a CGroup.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_cgroup.h | 4 ++++
 lib/tst_cgroup.c     | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index d4c93db79..de72645bc 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -133,6 +133,10 @@ struct tst_cgroup_group *
 tst_cgroup_group_mk(const struct tst_cgroup_group *const parent,
 		    const char *const group_name)
 		    __attribute__ ((nonnull, warn_unused_result));
+const char *
+tst_cgroup_group_name(const struct tst_cgroup_group *const cg)
+		      __attribute__ ((nonnull, warn_unused_result));
+
 /* Remove a descendant CGroup */
 struct tst_cgroup_group *
 tst_cgroup_group_rm(struct tst_cgroup_group *const cg)
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 1e036d3c3..793a712e1 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -855,6 +855,11 @@ tst_cgroup_group_mk(const struct tst_cgroup_group *const parent,
 	return cg;
 }
 
+const char *tst_cgroup_group_name(const struct tst_cgroup_group *const cg)
+{
+	return cg->group_name;
+}
+
 struct tst_cgroup_group *tst_cgroup_group_rm(struct tst_cgroup_group *const cg)
 {
 	struct cgroup_dir **dir;
-- 
2.31.1

