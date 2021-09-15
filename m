From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Sep 2021 16:37:24 +0200
Subject: [LTP] [PATCH 1/2] lib: tst_kconfig: Fix typo Constrain -> Constraint
In-Reply-To: <20210915143725.13170-1-chrubis@suse.cz>
References: <20210915143725.13170-1-chrubis@suse.cz>
Message-ID: <20210915143725.13170-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_kconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index c2b85821b..c9de3017b 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -497,7 +497,7 @@ void tst_kconfig_check(const char *const kconfigs[])
 
 		if (val != 1) {
 			abort_test = 1;
-			tst_res(TINFO, "Constrain '%s' not satisfied!", kconfigs[i]);
+			tst_res(TINFO, "Constraint '%s' not satisfied!", kconfigs[i]);
 			dump_vars(exprs[i]);
 		}
 
-- 
2.32.0

