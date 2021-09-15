From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Sep 2021 16:37:25 +0200
Subject: [LTP] [PATCH 2/2] lib: tst_kconfig: Fix segfaults on variable value
 mismatch
In-Reply-To: <20210915143725.13170-1-chrubis@suse.cz>
References: <20210915143725.13170-1-chrubis@suse.cz>
Message-ID: <20210915143725.13170-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If we add CONFIG_FOO=value to the test .needs_kconfig while the kernel
config will not define the particular value we will blindly call
strlen() on the val->val and end up with SegFault. Fix this by checking
that the variable has value set first.

Also initialize the val->val to NULL so that we get segfaults 100% of
the time when we attempt to dereference the value when not defined.

+ Test

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/newlib_tests/config07 | 5 +++++
 lib/tst_kconfig.c         | 4 ++++
 2 files changed, 9 insertions(+)
 create mode 100644 lib/newlib_tests/config07

diff --git a/lib/newlib_tests/config07 b/lib/newlib_tests/config07
new file mode 100644
index 000000000..dd67120f7
--- /dev/null
+++ b/lib/newlib_tests/config07
@@ -0,0 +1,5 @@
+# The default hostaname value mismatch
+CONFIG_MMU=y
+CONFIG_EXT4_FS=m
+CONFIG_PGTABLE_LEVELS=4
+CONFIG_DEFAULT_HOSTNAME=m
diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index c9de3017b..5af67b0a5 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -392,6 +392,7 @@ static inline unsigned int populate_vars(struct tst_expr *exprs[],
 			strncpy(vars[cnt].id, j->tok, vars[cnt].id_len);
 			vars[cnt].id[vars[cnt].id_len] = 0;
 			vars[cnt].choice = 0;
+			vars[cnt].val = NULL;
 
 			var = find_var(vars, cnt, vars[cnt].id);
 
@@ -435,6 +436,9 @@ static int map(struct tst_expr_tok *expr)
 	if (choice != 'v')
 		return var->choice == choice;
 
+	if (var->choice != 'v')
+		return 0;
+
 	if (strlen(var->val) != len)
 		return 0;
 
-- 
2.32.0

