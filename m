From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed,  8 Feb 2017 18:07:37 +0300
Subject: [LTP] [PATCH 2/3] net: broken_ip: don't send packets from rhost
In-Reply-To: <1486566458-18921-1-git-send-email-alexey.kodanev@oracle.com>
References: <1486566458-18921-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1486566458-18921-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* add new test-cases with different packet sizes;

* use tst_icmp() to run icmpv*_sender;

* remove broken*_lib.sh;

* check connectivity after sending malformed packets with tst_ping;

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net_stress.broken_ip                       |    8 ++--
 .../network/stress/broken_ip/broken_ip4-checksum   |   13 +++-----
 .../network/stress/broken_ip/broken_ip4-dstaddr    |   14 +++------
 .../network/stress/broken_ip/broken_ip4-fragment   |   13 +++-----
 testcases/network/stress/broken_ip/broken_ip4-ihl  |   14 +++------
 .../network/stress/broken_ip/broken_ip4-protcol    |   13 +++-----
 .../network/stress/broken_ip/broken_ip4-totlen     |   13 +++-----
 .../network/stress/broken_ip/broken_ip4-version    |   13 +++-----
 .../network/stress/broken_ip/broken_ip4_lib.sh     |   28 ------------------
 .../network/stress/broken_ip/broken_ip6-dstaddr    |   14 +++------
 .../network/stress/broken_ip/broken_ip6-nexthdr    |   13 +++-----
 testcases/network/stress/broken_ip/broken_ip6-plen |   14 +++------
 .../network/stress/broken_ip/broken_ip6-version    |   13 +++-----
 .../network/stress/broken_ip/broken_ip6_lib.sh     |   30 --------------------
 14 files changed, 59 insertions(+), 154 deletions(-)
 delete mode 100644 testcases/network/stress/broken_ip/broken_ip4_lib.sh
 delete mode 100644 testcases/network/stress/broken_ip/broken_ip6_lib.sh

diff --git a/runtest/net_stress.broken_ip b/runtest/net_stress.broken_ip
index c037f3e..32e3b99 100644
--- a/runtest/net_stress.broken_ip
+++ b/runtest/net_stress.broken_ip
@@ -11,7 +11,7 @@ broken_ip4-protcol broken_ip4-protcol
 broken_ip4-checksum broken_ip4-checksum
 broken_ip4-dstaddr broken_ip4-dstaddr
 
-broken_ip6-dstaddr broken_ip6-dstaddr
-broken_ip6-nexthdr broken_ip6-nexthdr
-broken_ip6-plen broken_ip6-plen
-broken_ip6-version broken_ip6-version
+broken_ip6-dstaddr broken_ip6-dstaddr -6
+broken_ip6-nexthdr broken_ip6-nexthdr -6
+broken_ip6-plen broken_ip6-plen -6
+broken_ip6-version broken_ip6-version -6
diff --git a/testcases/network/stress/broken_ip/broken_ip4-checksum b/testcases/network/stress/broken_ip/broken_ip4-checksum
index bc268af..33667ba 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-checksum
+++ b/testcases/network/stress/broken_ip/broken_ip4-checksum
@@ -1,6 +1,5 @@
 #!/bin/sh
-
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2006
 #
 # This program is free software; you can redistribute it and/or
@@ -22,14 +21,12 @@
 TCID=broken_ip4-checksum01
 TST_TOTAL=1
 
-. broken_ip4_lib.sh
+. test_net.sh
 
-tst_resm TINFO "Verify that the kernel is not crashed with receiving \
-a large number of IPv4 packets that have wrong value in the checksum field"
+tst_resm TINFO "Sending ICMPv4 with wrong chksum field for $NS_DURATION sec"
 
-tst_rhost_run -s -c "ns-icmpv4_sender -I $(tst_iface rhost) -S $rhost_addr \
-	-M $(tst_hwaddr lhost) -D $lhost_addr -s 56 -t $NS_DURATION -c"
+tst_icmp -t $NS_DURATION -s "0 100 500 1000 1472" -c
 
-tst_resm TPASS "Test is finished successfully."
+EXPECT_PASS tst_ping
 
 tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-dstaddr b/testcases/network/stress/broken_ip/broken_ip4-dstaddr
index f3ddba4..b4b676e 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-dstaddr
+++ b/testcases/network/stress/broken_ip/broken_ip4-dstaddr
@@ -1,6 +1,5 @@
 #!/bin/sh
-
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2006
 #
 # This program is free software; you can redistribute it and/or
@@ -22,15 +21,12 @@
 TCID=broken_ip4-dstaddr01
 TST_TOTAL=1
 
-. broken_ip4_lib.sh
+. test_net.sh
 
-tst_resm TINFO "Verify that the kernel is not crashed with receiving \
-a large number of IPv4 packets whose destination address is wrong \
-(destination MAC address is correct)"
+tst_resm TINFO "Sending ICMPv4 with wrong dst address for $NS_DURATION sec"
 
-tst_rhost_run -s -c "ns-icmpv4_sender -I $(tst_iface rhost) -S $rhost_addr \
-	-M $(tst_hwaddr lhost) -D $lhost_addr -s 56 -t $NS_DURATION -i"
+tst_icmp -t $NS_DURATION -s "0 100 500 1000 1472" -i
 
-tst_resm TPASS "Test is finished successfully."
+EXPECT_PASS tst_ping
 
 tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-fragment b/testcases/network/stress/broken_ip/broken_ip4-fragment
index f477996..dbef193 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-fragment
+++ b/testcases/network/stress/broken_ip/broken_ip4-fragment
@@ -1,6 +1,5 @@
 #!/bin/sh
-
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2006
 #
 # This program is free software; you can redistribute it and/or
@@ -22,14 +21,12 @@
 TCID=broken_ip4-fragment01
 TST_TOTAL=1
 
-. broken_ip4_lib.sh
+. test_net.sh
 
-tst_resm TINFO "Verify that the kernel is not crashed with receiving \
-a large number of IPv4 packets that have wrong fragment information"
+tst_resm TINFO "Sending ICMPv4 with wrong frag. info for $NS_DURATION sec"
 
-tst_rhost_run -s -c "ns-icmpv4_sender -I $(tst_iface rhost) -S $rhost_addr \
-	-M $(tst_hwaddr lhost) -D $lhost_addr -s 56 -t $NS_DURATION -f"
+tst_icmp -t $NS_DURATION -s "0 100 500 1000 1472" -f
 
-tst_resm TPASS "Test is finished successfully."
+EXPECT_PASS tst_ping
 
 tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-ihl b/testcases/network/stress/broken_ip/broken_ip4-ihl
index c3a34ec..48deb3b 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-ihl
+++ b/testcases/network/stress/broken_ip/broken_ip4-ihl
@@ -1,6 +1,5 @@
 #!/bin/sh
-
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2006
 #
 # This program is free software; you can redistribute it and/or
@@ -22,15 +21,12 @@
 TCID=broken_ip4-ihl01
 TST_TOTAL=1
 
-. broken_ip4_lib.sh
+. test_net.sh
 
-tst_resm TINFO "Verify that the kernel is not crashed with receiving \
-a large number of IPv4 packets that have wrong value in the header \
-length field."
+tst_resm TINFO "Sending ICMPv4 with wrong header len field for $NS_DURATION sec"
 
-tst_rhost_run -s -c "ns-icmpv4_sender -I $(tst_iface rhost) -S $rhost_addr \
-	-M $(tst_hwaddr lhost) -D $lhost_addr -s 56 -t $NS_DURATION -l"
+tst_icmp -t $NS_DURATION -s "0 100 500 1000 1472" -l
 
-tst_resm TPASS "Test is finished successfully."
+EXPECT_PASS tst_ping
 
 tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-protcol b/testcases/network/stress/broken_ip/broken_ip4-protcol
index 60a6f17..b4b767c 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-protcol
+++ b/testcases/network/stress/broken_ip/broken_ip4-protcol
@@ -1,6 +1,5 @@
 #!/bin/sh
-
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2006
 #
 # This program is free software; you can redistribute it and/or
@@ -22,14 +21,12 @@
 TCID=broken_ip4-protocol01
 TST_TOTAL=1
 
-. broken_ip4_lib.sh
+. test_net.sh
 
-tst_resm TINFO "Verify that the kernel is not crashed with receiving \
-a large number of IPv4 packets that have wrong value in the protocol field"
+tst_resm TINFO "Sending ICMPv4 with wrong proto field for $NS_DURATION sec"
 
-tst_rhost_run -s -c "ns-icmpv4_sender -I $(tst_iface rhost) -S $rhost_addr \
--M $(tst_hwaddr lhost) -D $lhost_addr -s 56 -t $NS_DURATION -p"
+tst_icmp -t $NS_DURATION -s "0 100 500 1000 1472" -p
 
-tst_resm TPASS "Test is finished successfully."
+EXPECT_PASS tst_ping
 
 tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-totlen b/testcases/network/stress/broken_ip/broken_ip4-totlen
index e854d52..051d969 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-totlen
+++ b/testcases/network/stress/broken_ip/broken_ip4-totlen
@@ -1,6 +1,5 @@
 #!/bin/sh
-
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2006
 #
 # This program is free software; you can redistribute it and/or
@@ -22,14 +21,12 @@
 TCID=broken_ip4-totlen01
 TST_TOTAL=1
 
-. broken_ip4_lib.sh
+. test_net.sh
 
-tst_resm TINFO "Verify that the kernel is not crashed with receiving \
-a large number of IPv4 packets that have wrong value in the total length field."
+tst_resm TINFO "Sending ICMPv4 with wrong total len field for $NS_DURATION sec"
 
-tst_rhost_run -s -c "ns-icmpv4_sender -I $(tst_iface rhost) -S $rhost_addr \
--M $(tst_hwaddr lhost) -D $lhost_addr -s 56 -t $NS_DURATION -L"
+tst_icmp -t $NS_DURATION -s "0 100 500 1000 1472" -L
 
-tst_resm TPASS "Test is finished successfully."
+EXPECT_PASS tst_ping
 
 tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-version b/testcases/network/stress/broken_ip/broken_ip4-version
index 6ba635a..c3ccf7f 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-version
+++ b/testcases/network/stress/broken_ip/broken_ip4-version
@@ -1,6 +1,5 @@
 #!/bin/sh
-
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2006
 #
 # This program is free software; you can redistribute it and/or
@@ -22,14 +21,12 @@
 TCID=broken_ip4-version01
 TST_TOTAL=1
 
-. broken_ip4_lib.sh
+. test_net.sh
 
-tst_resm TINFO "Verify that the kernel is not crashed with receiving \
-a large number of IPv4 packets that have wrong value in version field."
+tst_resm TINFO "Sending ICMPv4 with wrong version field for $NS_DURATION sec"
 
-tst_rhost_run -s -c "ns-icmpv4_sender -I $(tst_iface rhost) -S $rhost_addr \
-	-M $(tst_hwaddr lhost) -D $lhost_addr -s 56 -t $NS_DURATION -v"
+tst_icmp -t $NS_DURATION -s "0 100 500 1000 1472" -v
 
-tst_resm TPASS "Test is finished successfully."
+EXPECT_PASS tst_ping
 
 tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4_lib.sh b/testcases/network/stress/broken_ip/broken_ip4_lib.sh
deleted file mode 100644
index 5b8e17f..0000000
--- a/testcases/network/stress/broken_ip/broken_ip4_lib.sh
+++ /dev/null
@@ -1,28 +0,0 @@
-#!/bin/sh
-
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) International Business Machines  Corp., 2006
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-
-. test_net.sh
-
-tst_resm TINFO "Test duration is $NS_DURATION [sec]"
-
-lhost_addr=$(tst_ipaddr)
-rhost_addr=$(tst_ipaddr rhost)
-
-tst_rhost_run -s -c \
-	"check_icmpv4_connectivity $(tst_iface rhost) $lhost_addr"
diff --git a/testcases/network/stress/broken_ip/broken_ip6-dstaddr b/testcases/network/stress/broken_ip/broken_ip6-dstaddr
index 833015e..5da38ab 100644
--- a/testcases/network/stress/broken_ip/broken_ip6-dstaddr
+++ b/testcases/network/stress/broken_ip/broken_ip6-dstaddr
@@ -1,6 +1,5 @@
 #!/bin/sh
-
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2006
 #
 # This program is free software; you can redistribute it and/or
@@ -22,15 +21,12 @@
 TCID=broken_ip6-dstaddr01
 TST_TOTAL=1
 
-. broken_ip6_lib.sh
+. test_net.sh
 
-tst_resm TINFO "Verify that the kernel is not crashed with receiving \
-a large number of IPv6 packets whose destination address is wrong \
-(destination MAC address is correct)"
+tst_resm TINFO "Sending ICMPv6 with wrong dst address for $NS_DURATION sec"
 
-tst_rhost_run -s -c "ns-icmpv6_sender -I $(tst_iface rhost) -S $rhost_addr \
-	-M $(tst_hwaddr lhost) -D $lhost_addr -s 56 -t $NS_DURATION -i"
+tst_icmp -t $NS_DURATION -s "0 100 500 1000 1452" -i
 
-tst_resm TPASS "Test is finished successfully."
+EXPECT_PASS tst_ping
 
 tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip6-nexthdr b/testcases/network/stress/broken_ip/broken_ip6-nexthdr
index 866a92d..bb1bdcb 100644
--- a/testcases/network/stress/broken_ip/broken_ip6-nexthdr
+++ b/testcases/network/stress/broken_ip/broken_ip6-nexthdr
@@ -1,6 +1,5 @@
 #!/bin/sh
-
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2006
 #
 # This program is free software; you can redistribute it and/or
@@ -22,14 +21,12 @@
 TCID=broken_ip6-nexthdr01
 TST_TOTAL=1
 
-. broken_ip6_lib.sh
+. test_net.sh
 
-tst_resm TINFO "Verify that the kernel is not crashed with receiving \
-a large number of IPv6 packets that have wrong value in the next header field."
+tst_resm TINFO "Sending ICMPv4 with wrong next header for $NS_DURATION sec"
 
-tst_rhost_run -s -c "ns-icmpv6_sender -I $(tst_iface rhost) -S $rhost_addr \
-	-M $(tst_hwaddr lhost) -D $lhost_addr -s 56 -t $NS_DURATION -n"
+tst_icmp -t $NS_DURATION -s "0 100 500 1000 1452" -n
 
-tst_resm TPASS "Test is finished successfully."
+EXPECT_PASS tst_ping
 
 tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip6-plen b/testcases/network/stress/broken_ip/broken_ip6-plen
index 75ee080..8eacbf4 100644
--- a/testcases/network/stress/broken_ip/broken_ip6-plen
+++ b/testcases/network/stress/broken_ip/broken_ip6-plen
@@ -1,6 +1,5 @@
 #!/bin/sh
-
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2006
 #
 # This program is free software; you can redistribute it and/or
@@ -22,15 +21,12 @@
 TCID=broken_ip6-plen01
 TST_TOTAL=1
 
-. broken_ip6_lib.sh
+. test_net.sh
 
-tst_resm TINFO "Verify that the kernel is not crashed with receiving \
-a large number of IPv6 packets that have wrong value in the payload \
-length field."
+tst_resm TINFO "Sending ICMPv4 with wrong payload len for $NS_DURATION sec"
 
-tst_rhost_run -s -c "ns-icmpv6_sender -I $(tst_iface rhost) -S $rhost_addr \
-	-M $(tst_hwaddr lhost) -D $lhost_addr -s 56 -t $NS_DURATION -L"
+tst_icmp -t $NS_DURATION -s "0 100 500 1000 1452" -L
 
-tst_resm TPASS "Test is finished successfully."
+EXPECT_PASS tst_ping
 
 tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip6-version b/testcases/network/stress/broken_ip/broken_ip6-version
index 9467347..cdce71f 100644
--- a/testcases/network/stress/broken_ip/broken_ip6-version
+++ b/testcases/network/stress/broken_ip/broken_ip6-version
@@ -1,6 +1,5 @@
 #!/bin/sh
-
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2006
 #
 # This program is free software; you can redistribute it and/or
@@ -22,14 +21,12 @@
 TCID=broken_ip6-version01
 TST_TOTAL=1
 
-. broken_ip6_lib.sh
+. test_net.sh
 
-tst_resm TINFO "Verify that the kernel is not crashed with receiving \
-a large number of IPv6 packets that have wrong value in version field."
+tst_resm TINFO "Sending ICMPv6 with wrong version field for $NS_DURATION sec"
 
-tst_rhost_run -s -c "ns-icmpv6_sender -I $(tst_iface rhost) -S $rhost_addr \
-	-M $(tst_hwaddr lhost) -D $lhost_addr -s 56 -t $NS_DURATION -v"
+tst_icmp -t $NS_DURATION -s "0 100 500 1000 1452" -v
 
-tst_resm TPASS "Test is finished successfully."
+EXPECT_PASS tst_ping
 
 tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip6_lib.sh b/testcases/network/stress/broken_ip/broken_ip6_lib.sh
deleted file mode 100644
index e2429ac..0000000
--- a/testcases/network/stress/broken_ip/broken_ip6_lib.sh
+++ /dev/null
@@ -1,30 +0,0 @@
-#!/bin/sh
-
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) International Business Machines  Corp., 2006
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-
-. test_net.sh
-
-TST_IPV6=6
-
-tst_resm TINFO "Test duration is $NS_DURATION [sec]"
-
-lhost_addr=$(tst_ipaddr)
-rhost_addr=$(tst_ipaddr rhost)
-
-tst_rhost_run -s -c \
-	"check_icmpv6_connectivity $(tst_iface rhost) $lhost_addr"
-- 
1.7.1

