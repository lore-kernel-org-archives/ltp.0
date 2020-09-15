From: Bird, Tim <Tim.Bird@sony.com>
Date: Tue, 15 Sep 2020 20:54:35 +0000
Subject: [LTP] TPASS in new test lib
Message-ID: <CY4PR13MB117565A7BA2A8371A3B94ED9FD200@CY4PR13MB1175.namprd13.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



> -----Original Message-----
> From: Petr Vorel <pvorel@suse.cz>
> 
...
> > P.P.S How come some tests produce TPASS and some produce just PASS?
> Legacy C API and shell API (both legacy and new) add T (i.e. TPASS), new C API
> don't add it (i.e. PASS). It's a minor detail we could fix that.

Well, Fuego's parser only checks for PASS (probably due to the inconsistency),
but personally I'd prefer if it was consistent. The string "TPASS" is much less
likely to appear in unrelated output than "PASS" is.

It looks like it comes from print_result() in ltp/lib/tst_test.c.

Here's a patch, in case there's interest in changing it:

From 151168bf384135d7c79b0c09bb95267ba1293205 Mon Sep 17 00:00:00 2001
From: Tim Bird <tim.bird@sony.com>
Date: Tue, 15 Sep 2020 14:18:37 -0600
Subject: [PATCH] tst_test: Change result strings to use T prefix

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



