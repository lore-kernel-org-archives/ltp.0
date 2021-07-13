From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Jul 2021 16:06:18 +0200
Subject: [LTP] [PATCH] [COMMITTED] lib/tst_bool_expr: Clear priv pointer on
 token insertion
Message-ID: <20210713140618.18227-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We are using the priv pointer to store an error message but as it wasn't
initialized from the start it may have contianed random data leading to
a crash on a parser error reports.

Reported-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_bool_expr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/tst_bool_expr.c b/lib/tst_bool_expr.c
index 387c38b91..15825e364 100644
--- a/lib/tst_bool_expr.c
+++ b/lib/tst_bool_expr.c
@@ -55,6 +55,7 @@ static int new_tok(struct tst_expr_tok **last, const char *tok, size_t tok_len)
 	(*last)->tok = tok;
 	(*last)->tok_len = tok_len;
 	(*last)->op = char_to_op(tok[0]);
+	(*last)->priv = NULL;
 	(*last)++;
 
 	return 1;
-- 
2.31.1

