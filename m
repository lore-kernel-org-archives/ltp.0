From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Oct 2019 11:54:42 +0200
Subject: [LTP] [PATCH v5 5/5] net/if-mtu-change.sh: set TST_TIMEOUT
In-Reply-To: <20191011095442.10541-1-pvorel@suse.cz>
References: <20191011095442.10541-1-pvorel@suse.cz>
Message-ID: <20191011095442.10541-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The default setup (100 * 5 seconds just for sleep) is longer than default timeout.
30 sec for each iteration should be more than enough as a default.

Fixes: fbea02ab5 ("lib/tst_test.sh: setup timeout per test run for the shell tests")

Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/interface/if-mtu-change.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/network/stress/interface/if-mtu-change.sh b/testcases/network/stress/interface/if-mtu-change.sh
index 30c013214..b945fb6ce 100755
--- a/testcases/network/stress/interface/if-mtu-change.sh
+++ b/testcases/network/stress/interface/if-mtu-change.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2017-2019 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2015-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2005
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
@@ -13,6 +13,8 @@ TST_CLEANUP="do_cleanup"
 # The interval of the mtu change [second]
 CHANGE_INTERVAL=${CHANGE_INTERVAL:-5}
 
+TST_TIMEOUT=$(((CHANGE_INTERVAL + 30) * MTU_CHANGE_TIMES))
+
 # The array of the value which MTU is changed into sequentially
 # 552 - net.ipv4.route.min_pmtu
 CHANGE_VALUES="784 1142 552 1500 552 1500 552 748 552 1142 1500"
-- 
2.23.0

