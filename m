From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Jul 2021 16:07:16 +0200
Subject: [LTP] [PATCH 2/2] broken_ip: TCONF when test run on unsupported
 protocol
In-Reply-To: <20210714140716.1568-1-pvorel@suse.cz>
References: <20210714140716.1568-1-pvorel@suse.cz>
Message-ID: <20210714140716.1568-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

net_stress.broken_ip runtest file is correct, but some users try to run
tests manually.

Fixes: #843

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/broken_ip/broken_ip-checksum | 3 ++-
 testcases/network/stress/broken_ip/broken_ip-fragment | 3 ++-
 testcases/network/stress/broken_ip/broken_ip-ihl      | 3 ++-
 testcases/network/stress/broken_ip/broken_ip-nexthdr  | 3 ++-
 testcases/network/stress/broken_ip/broken_ip-protcol  | 3 ++-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/testcases/network/stress/broken_ip/broken_ip-checksum b/testcases/network/stress/broken_ip/broken_ip-checksum
index 78f00ce98..707ffcb29 100644
--- a/testcases/network/stress/broken_ip/broken_ip-checksum
+++ b/testcases/network/stress/broken_ip/broken_ip-checksum
@@ -1,11 +1,12 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2019-2021 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2006
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 TST_TESTFUNC="do_test"
+TST_NET_IPV4_ONLY=1
 . tst_net.sh
 
 do_test()
diff --git a/testcases/network/stress/broken_ip/broken_ip-fragment b/testcases/network/stress/broken_ip/broken_ip-fragment
index 1f5e5f713..7356bb523 100644
--- a/testcases/network/stress/broken_ip/broken_ip-fragment
+++ b/testcases/network/stress/broken_ip/broken_ip-fragment
@@ -1,11 +1,12 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2019-2021 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2006
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 TST_TESTFUNC="do_test"
+TST_NET_IPV4_ONLY=1
 . tst_net.sh
 
 do_test()
diff --git a/testcases/network/stress/broken_ip/broken_ip-ihl b/testcases/network/stress/broken_ip/broken_ip-ihl
index 9f2a42568..e5e41ee8e 100644
--- a/testcases/network/stress/broken_ip/broken_ip-ihl
+++ b/testcases/network/stress/broken_ip/broken_ip-ihl
@@ -1,11 +1,12 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2019-2021 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2006
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 TST_TESTFUNC="do_test"
+TST_NET_IPV4_ONLY=1
 . tst_net.sh
 
 do_test()
diff --git a/testcases/network/stress/broken_ip/broken_ip-nexthdr b/testcases/network/stress/broken_ip/broken_ip-nexthdr
index 475b92b16..2ab0601ac 100644
--- a/testcases/network/stress/broken_ip/broken_ip-nexthdr
+++ b/testcases/network/stress/broken_ip/broken_ip-nexthdr
@@ -1,11 +1,12 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2019-2021 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2006
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 TST_TESTFUNC="do_test"
+TST_NET_IPV6_ONLY=1
 . tst_net.sh
 
 do_test()
diff --git a/testcases/network/stress/broken_ip/broken_ip-protcol b/testcases/network/stress/broken_ip/broken_ip-protcol
index a91cdaaeb..9f9275f03 100644
--- a/testcases/network/stress/broken_ip/broken_ip-protcol
+++ b/testcases/network/stress/broken_ip/broken_ip-protcol
@@ -1,11 +1,12 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2019-2021 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2006
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 TST_TESTFUNC="do_test"
+TST_NET_IPV4_ONLY=1
 . tst_net.sh
 
 do_test()
-- 
2.32.0

