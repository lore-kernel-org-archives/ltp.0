From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Nov 2020 13:31:50 +0100
Subject: [LTP] [PATCH] [COMMITTED] lib/tst_kconfig: Fix off-by-one in string
 check
Message-ID: <20201119123150.13275-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixed the condition for "Garbage after string" that was previously
triggered on a correct strings.

Fixes: eeed458492cc ("lib/tst_kconfig: Validate variables")
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_kconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 35f20e7a4..734039e37 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -291,7 +291,7 @@ static int validate_var(const struct tst_expr_tok *var)
 			i++;
 		} while (i < var->tok_len && var->tok[i] != '"');
 
-		if (i < var->tok_len) {
+		if (i < var->tok_len - 1) {
 			print_err(stderr, var, i, "Garbage after a string");
 			return 1;
 		}
-- 
2.26.2

