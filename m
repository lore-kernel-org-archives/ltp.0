From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Nov 2020 11:55:14 +0100
Subject: [LTP] [PATCH] [COMMITTED] lib/tst_kconfig: Allow variables without
 value again
Message-ID: <20201119105514.10818-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes: eeed458492cc ("lib/tst_kconfig: Validate variables")
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_kconfig.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 8dc623952..35f20e7a4 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -277,8 +277,13 @@ static int validate_var(const struct tst_expr_tok *var)
 	}
 
 	if (i >= var->tok_len) {
-		print_err(stderr, var, i, "Missing value");
-		return 1;
+
+		if (var->tok[i-1] == '=') {
+			print_err(stderr, var, i, "Missing value");
+			return -1;
+		}
+
+		return 0;
 	}
 
 	if (var->tok[i] == '"') {
-- 
2.26.2

