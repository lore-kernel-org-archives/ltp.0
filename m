From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 15 Jun 2016 20:08:11 +0300
Subject: [LTP] new ltp lib doesn't print actual error
Message-ID: <57618B7B.9070402@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

When running a test with the new LTP lib, noticed that if some error 
occurs in a library (tst_tmpdir.c), it'll print the same message:

TMPDIR=/usr ./creat01
tst_tmpdir.c:155: BROK: Non-NULL cleanup in newlib!

but should be:
TMPDIR=/usr ./creat01
tst_tmpdir.c:155: BROK: tst_tmpdir: mkdtemp(/usr/creF5DhMS) failed: EACCES


May be we should remove the strict check in tst_res.c? Otherwise we 
don't see the actual error.

diff --git a/lib/tst_res.c b/lib/tst_res.c
index b388d0d..dd27c54 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -547,11 +547,6 @@ void tst_brkm_(const char *file, const int lineno, 
int ttype,
         EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);

         if (tst_test) {
-               if (func) {
-                       tst_brk_(file, lineno, TBROK,
-                                "Non-NULL cleanup in newlib!");
- }
-
                 tst_brk_(file, lineno, ttype, "%s", tmesg);
         } else {
                 tst_brk__(file, lineno, ttype, func, "%s", tmesg);


Thanks,
Alexey

