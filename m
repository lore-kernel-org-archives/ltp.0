From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:58 +0200
Subject: [LTP] [COMMITTED] [PATCH 25/40] Make use of SAFE_UMOUNT()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-25-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
index a0e28aa30..e165f6c9a 100644
--- a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
+++ b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
@@ -241,10 +241,7 @@ static void cleanup(void)
 			SAFE_CHDIR(NULL, "..");
 		}
 		if (cgrp_opt[i].mounted) {
-			if (umount(cgrp_opt[i].dir) == -1) {
-				tst_brkm(TBROK | TERRNO, NULL,
-					"Can't unmount: %s", cgrp_opt[i].dir);
-			}
+			SAFE_UMOUNT(NULL, cgrp_opt[i].dir);
 		}
 	}
 
-- 
2.13.5

