From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 13 Jan 2017 10:45:13 +0100
Subject: [LTP] [PATCH] lib: fix offset in tst_resm_hexd
Message-ID: <fa1847cc72ff0178bd6744a1822077674059af28.1484300599.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Commit f72ca5b9c484 "lib: add tst_res_hexd for newlib"
broke tst_resm_hexd when I moved "offset = strlen(tmesg)"
before macro that expands varargs.

Fix it by moving offset initialisation after EXPAND_VAR_ARGS.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 lib/tst_res.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/tst_res.c b/lib/tst_res.c
index 261dec0fbba8..61daaeb4944e 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -509,7 +509,7 @@ void tst_resm_hexd_(const char *file, const int lineno, int ttype,
 	char tmesg[USERMESG];
 	static const size_t symb_num	= 2; /* xx */
 	static const size_t size_max	= 16;
-	size_t offset = strlen(tmesg);
+	size_t offset;
 	size_t i;
 	char *pmesg = tmesg;
 	tst_res_func_t res_func;
@@ -520,6 +520,7 @@ void tst_resm_hexd_(const char *file, const int lineno, int ttype,
 		res_func = tst_res__;
 
 	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
+	offset = strlen(tmesg);
 
 	if (size > size_max || size == 0 ||
 		(offset + size * (symb_num + 1)) >= USERMESG)
-- 
1.8.3.1

