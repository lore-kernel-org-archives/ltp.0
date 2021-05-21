From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 21 May 2021 11:25:24 +0100
Subject: [LTP] [PATCH v2 2/6] API/cgroups: Remove obsolete function in API
In-Reply-To: <20210521102528.21102-1-rpalethorpe@suse.com>
References: <20210521102528.21102-1-rpalethorpe@suse.com>
Message-ID: <20210521102528.21102-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 lib/tst_cgroup.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 793a712e1..8fd5ab288 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -225,12 +225,6 @@ static void add_ctrl(uint32_t *const ctrl_field,
 	*ctrl_field |= 1 << ctrl->ctrl_indx;
 }
 
-__attribute__ ((warn_unused_result))
-struct cgroup_root *tst_cgroup_root_get(void)
-{
-	return roots[0].ver ? roots : roots + 1;
-}
-
 static int cgroup_v2_mounted(void)
 {
 	return !!roots[0].ver;
-- 
2.31.1

