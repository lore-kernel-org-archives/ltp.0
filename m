From: Punit Agrawal <punit.agrawal@arm.com>
Date: Wed, 11 Jul 2018 13:29:25 +0100
Subject: [LTP] [PATCH 4/4] controllers/pids.sh: Check for killall
In-Reply-To: <20180711122925.24278-1-punit.agrawal@arm.com>
References: <20180711122925.24278-1-punit.agrawal@arm.com>
Message-ID: <20180711122925.24278-5-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 testcases/kernel/controllers/pids/pids.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/controllers/pids/pids.sh b/testcases/kernel/controllers/pids/pids.sh
index c5430eed7..fab33c415 100755
--- a/testcases/kernel/controllers/pids/pids.sh
+++ b/testcases/kernel/controllers/pids/pids.sh
@@ -32,6 +32,7 @@ TST_TESTFUNC=do_test
 TST_POS_ARGS=3
 TST_USAGE=usage
 TST_NEEDS_ROOT=1
+TST_NEEDS_CMDS="killall"
 
 . tst_test.sh
 
-- 
2.17.1

