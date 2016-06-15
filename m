From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 15 Jun 2016 13:28:20 -0400 (EDT)
Subject: [LTP] new ltp lib doesn't print actual error
In-Reply-To: <57618B7B.9070402@oracle.com>
References: <57618B7B.9070402@oracle.com>
Message-ID: <488657345.6790022.1466011700050.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Alexey Kodanev" <alexey.kodanev@oracle.com>
> To: ltp@lists.linux.it
> Sent: Wednesday, 15 June, 2016 7:08:11 PM
> Subject: [LTP] new ltp lib doesn't print actual error
> 
> Hi,
> 
> When running a test with the new LTP lib, noticed that if some error
> occurs in a library (tst_tmpdir.c), it'll print the same message:
> 
> TMPDIR=/usr ./creat01
> tst_tmpdir.c:155: BROK: Non-NULL cleanup in newlib!
> 
> but should be:
> TMPDIR=/usr ./creat01
> tst_tmpdir.c:155: BROK: tst_tmpdir: mkdtemp(/usr/creF5DhMS) failed: EACCES
> 
> 
> May be we should remove the strict check in tst_res.c? Otherwise we
> don't see the actual error.

Or turn it into warning, so that we get both failures. tst_tmpdir() needs
a fix to not pass cleanup function for newlib testcases.

diff --git a/lib/tst_res.c b/lib/tst_res.c
index b388d0d2e516..ab9759b9263b 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -548,8 +548,8 @@ void tst_brkm_(const char *file, const int lineno, int ttype,

        if (tst_test) {
                if (func) {
-                       tst_brk_(file, lineno, TBROK,
-                                "Non-NULL cleanup in newlib!");
+                       tst_resm(TWARN, "Non-NULL cleanup in newlib! %s:%d",
+                               file, lineno);
                }

                tst_brk_(file, lineno, ttype, "%s", tmesg);

