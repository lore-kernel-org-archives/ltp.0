From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 24 Sep 2020 12:11:24 +0100
Subject: [LTP] [PATCH] tst_cgroup: Don't try to use V2 if V1 controllers are
 mounted
Message-ID: <20200924111124.5666-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It is not possible to use a controller in V2 cgroups if it has been
mounted as a V1 controller. So if V1 is mounted we use it regardless
of if V2 is available.

We have to include a space in tst_is_mounted so that we do not match
cgroup2.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 lib/tst_cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index ba413d874..73ddd4b82 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -44,7 +44,7 @@ enum tst_cgroup_ver tst_cgroup_version(void)
         enum tst_cgroup_ver cg_ver;
 
         if (tst_cgroup_check("cgroup2")) {
-                if (!tst_is_mounted("cgroup2") && tst_is_mounted("cgroup"))
+                if (tst_is_mounted("cgroup "))
                         cg_ver = TST_CGROUP_V1;
                 else
                         cg_ver = TST_CGROUP_V2;
-- 
2.28.0

