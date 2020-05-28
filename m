From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 May 2020 13:05:53 +0200
Subject: [LTP] [RFC PATCH 1/2] LVM: Don't require root for
 generate_lvm_runfile.sh
In-Reply-To: <20200528110554.10179-1-pvorel@suse.cz>
References: <20200528110554.10179-1-pvorel@suse.cz>
Message-ID: <20200528110554.10179-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LTPROOT can be in user writable directory. Having rights for make
install is user responsibility, it does not have to be guarded by
TST_NEEDS_ROOT=1.

Fixes: 45289e498 ("Add LVM support scripts")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/misc/lvm/generate_lvm_runfile.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/misc/lvm/generate_lvm_runfile.sh b/testcases/misc/lvm/generate_lvm_runfile.sh
index 5ca035f22..b3366cb99 100755
--- a/testcases/misc/lvm/generate_lvm_runfile.sh
+++ b/testcases/misc/lvm/generate_lvm_runfile.sh
@@ -5,7 +5,6 @@
 # Generate LTP runfile for LVM tests (runtest/lvm.local)
 
 TST_TESTFUNC=generate_runfile
-TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="sed"
 . tst_test.sh
 
-- 
2.26.2

