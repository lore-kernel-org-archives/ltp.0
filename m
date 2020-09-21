From: Bird, Tim <Tim.Bird@sony.com>
Date: Mon, 21 Sep 2020 20:02:08 +0000
Subject: [LTP] [PATCH] tst_test: Change result strings to use T prefix
Message-ID: <CY4PR13MB117552ABCAA299CEB5F0A52AFD3A0@CY4PR13MB1175.namprd13.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Change PASS to TPASS in the new C library.
Change other results strings to also include the "T" prefix.
This makes the new library consistent with previous LTP
output, and with the shell output.

Signed-off-by: Tim Bird <tim.bird@sony.com>
---
 lib/tst_test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 175dea7..8cc76d5 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -193,22 +193,22 @@ static void print_result(const char *file, const int lineno, int ttype,
 
 	switch (TTYPE_RESULT(ttype)) {
 	case TPASS:
-		res = "PASS";
+		res = "TPASS";
 	break;
 	case TFAIL:
-		res = "FAIL";
+		res = "TFAIL";
 	break;
 	case TBROK:
-		res = "BROK";
+		res = "TBROK";
 	break;
 	case TCONF:
-		res = "CONF";
+		res = "TCONF";
 	break;
 	case TWARN:
-		res = "WARN";
+		res = "TWARN";
 	break;
 	case TINFO:
-		res = "INFO";
+		res = "TINFO";
 	break;
 	default:
 		tst_brk(TBROK, "Invalid ttype value %i", ttype);
-- 
2.1.4

