From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Oct 2019 15:15:06 +0200
Subject: [LTP] [PATCH] lib: tst_taint: Ignore WARN taint flag if already set
Message-ID: <20191016131506.17193-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This commit changes the library so that it ignores the taint warn flag
if it was set prior to the test run. It turns out that the warn taint
flag is not well defined and could be easily set on a freshly booted
kernel for example when buggy BIOS is detected.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Jan Stancek <jstancek@redhat.com>
CC: Chang Yin <cyin@redhat.com>
---

I haven't tested this, since I don't have a system where the flag is set
at hand, but it's simple enough so that it should work as expected.

 lib/tst_taint.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/tst_taint.c b/lib/tst_taint.c
index a5dbf77d2..3de6d72f4 100644
--- a/lib/tst_taint.c
+++ b/lib/tst_taint.c
@@ -82,8 +82,13 @@ void tst_taint_init(unsigned int mask)
 		tst_res(TCONF, "Kernel is too old for requested mask");
 
 	taint_mask = mask;
-
 	taint = tst_taint_read();
+
+	if (mask & TST_TAINT_W && taint & TST_TAINT_W) {
+		tst_res(TCONF, "Ignoring already set kernel warning taint");
+		mask &= ~TST_TAINT_W;
+	}
+
 	if ((taint & mask) != 0)
 		tst_brk(TBROK, "Kernel is already tainted: %u", taint);
 }
-- 
2.21.0

