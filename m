From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 21 Apr 2020 14:15:48 +0200
Subject: [LTP] [PATCH v2] lib: tst_taint: Ignore WARN taint flag if already
 set
Message-ID: <7dd91d5aa2d64bcd0223120916c202f19c327237.1587471007.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This commit changes the library so that it ignores the taint warn flag
if it was set prior to the test run. It turns out that the warn taint
flag is not well defined and could be easily set on a freshly booted
kernel for example when buggy BIOS is detected.

Other recent example is disabling ip forward on kvm guests:
  https://github.com/containers/libpod/issues/5815
  https://lore.kernel.org/netdev/a47b6a3b-c064-2f53-7cf6-d0d0720e9d99@redhat.com/

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
CC: Chang Yin <cyin@redhat.com>
CC: Li Wang <liwang@redhat.com>
---
 lib/tst_taint.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/tst_taint.c b/lib/tst_taint.c
index a5dbf77d2941..49146aacbbe9 100644
--- a/lib/tst_taint.c
+++ b/lib/tst_taint.c
@@ -82,9 +82,14 @@ void tst_taint_init(unsigned int mask)
 		tst_res(TCONF, "Kernel is too old for requested mask");
 
 	taint_mask = mask;
-
 	taint = tst_taint_read();
-	if ((taint & mask) != 0)
+
+	if (taint & TST_TAINT_W) {
+		tst_res(TCONF, "Ignoring already set kernel warning taint");
+		taint_mask &= ~TST_TAINT_W;
+	}
+
+	if ((taint & taint_mask) != 0)
 		tst_brk(TBROK, "Kernel is already tainted: %u", taint);
 }
 
-- 
2.18.1

