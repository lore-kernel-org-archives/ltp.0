From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 29 Aug 2019 20:31:10 +0200
Subject: [LTP] [PATCH] net/if-mtu-change.sh: set longer timeout
Message-ID: <20190829183110.23231-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Default CHANGE_INTERVAL 5s caused test to be killed after introducing
LTP_TIMEOUT_MUL to shell API.

TODO: set LTP_TIMEOUT_MUL based on CHANGE_INTERVAL.

Fixes: fbea02ab5 ("lib/tst_test.sh: setup timeout per test run for the
shell tests")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/interface/if-mtu-change.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/network/stress/interface/if-mtu-change.sh b/testcases/network/stress/interface/if-mtu-change.sh
index 30c013214..5a05e99c9 100755
--- a/testcases/network/stress/interface/if-mtu-change.sh
+++ b/testcases/network/stress/interface/if-mtu-change.sh
@@ -5,6 +5,8 @@
 # Copyright (c) International Business Machines  Corp., 2005
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
+LTP_TIMEOUT_MUL=${LTP_TIMEOUT_MUL:-2}
+
 IF_CMD='ifconfig'
 TST_SETUP="do_setup"
 TST_CLEANUP="do_cleanup"
-- 
2.22.1

