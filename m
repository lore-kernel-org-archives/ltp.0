From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 26 May 2020 22:09:04 +0200
Subject: [LTP] [PATCH 1/1] tst_test.sh: Fix TST_NEEDS_DEVICE=1 implies
 TST_NEEDS_TMPDIR=1
Message-ID: <20200526200904.27264-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

e5dd9c0e7 set TST_TMPDIR=1 instead, which is wrong, because variable
holds path to the test temporary directory. That broke IMA/EVM tests
running on tmpfs (which creates loop device via TST_NEEDS_DEVICE=1):

/opt/ltp/testcases/bin/ima_measurements.sh: 107: cd: can't cd to 1

which also broke umount in cleanup()
umount: /root/mntpoint: target is busy.
ima_measurements 1 TINFO: umount(/dev/loop14) failed, try 1 ...
ima_measurements 1 TINFO: Likely gvfsd-trash is probing newly mounted
fs, kill it to speed up tests.
umount: /root/mntpoint: target is busy.

Fixes: e5dd9c0e7 ("shell: TST_NEEDS_DEVICE implies TST_TMPDIR")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 8d24b4abf..1cf724cbe 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -550,7 +550,7 @@ tst_run()
 
 	_tst_setup_timer
 
-	[ "$TST_NEEDS_DEVICE" = 1 ] && TST_TMPDIR=1
+	[ "$TST_NEEDS_DEVICE" = 1 ] && TST_NEEDS_TMPDIR=1
 
 	if [ "$TST_NEEDS_TMPDIR" = 1 ]; then
 		if [ -z "$TMPDIR" ]; then
-- 
2.26.2

