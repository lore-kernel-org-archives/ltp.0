From: Petr Vorel <pvorel@suse.cz>
Date: Sat, 27 Apr 2019 07:39:28 +0200
Subject: [LTP] [PATCH 1/1] net/broken_ip: Rewrite into new API
Message-ID: <20190427053929.7372-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Remove IP version from filename as files are for both IPv4 and IPv6
(although not all are used for both versions).

+ Add packet related variables to tst_net.sh ($ICMPV{4,6,}_DATA_MAXSIZE)
and use it.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/net_stress.broken_ip                  | 22 ++++++-------
 testcases/lib/tst_net.sh                      | 11 +++++++
 .../stress/broken_ip/00_Descriptions.txt      | 22 ++++++-------
 testcases/network/stress/broken_ip/Makefile   | 22 ++-----------
 .../stress/broken_ip/broken_ip-checksum       | 18 ++++++++++
 .../stress/broken_ip/broken_ip-dstaddr        | 18 ++++++++++
 .../stress/broken_ip/broken_ip-fragment       | 18 ++++++++++
 .../network/stress/broken_ip/broken_ip-ihl    | 18 ++++++++++
 .../stress/broken_ip/broken_ip-nexthdr        | 18 ++++++++++
 .../network/stress/broken_ip/broken_ip-plen   | 18 ++++++++++
 .../stress/broken_ip/broken_ip-protcol        | 18 ++++++++++
 .../network/stress/broken_ip/broken_ip-totlen | 18 ++++++++++
 .../stress/broken_ip/broken_ip-version        | 18 ++++++++++
 .../stress/broken_ip/broken_ip4-checksum      | 33 -------------------
 .../stress/broken_ip/broken_ip4-dstaddr       | 33 -------------------
 .../stress/broken_ip/broken_ip4-fragment      | 33 -------------------
 .../network/stress/broken_ip/broken_ip4-ihl   | 33 -------------------
 .../stress/broken_ip/broken_ip4-protcol       | 33 -------------------
 .../stress/broken_ip/broken_ip4-totlen        | 33 -------------------
 .../stress/broken_ip/broken_ip4-version       | 33 -------------------
 .../stress/broken_ip/broken_ip6-dstaddr       | 33 -------------------
 .../stress/broken_ip/broken_ip6-nexthdr       | 33 -------------------
 .../network/stress/broken_ip/broken_ip6-plen  | 33 -------------------
 .../stress/broken_ip/broken_ip6-version       | 33 -------------------
 24 files changed, 197 insertions(+), 405 deletions(-)
 create mode 100644 testcases/network/stress/broken_ip/broken_ip-checksum
 create mode 100644 testcases/network/stress/broken_ip/broken_ip-dstaddr
 create mode 100644 testcases/network/stress/broken_ip/broken_ip-fragment
 create mode 100644 testcases/network/stress/broken_ip/broken_ip-ihl
 create mode 100644 testcases/network/stress/broken_ip/broken_ip-nexthdr
 create mode 100644 testcases/network/stress/broken_ip/broken_ip-plen
 create mode 100644 testcases/network/stress/broken_ip/broken_ip-protcol
 create mode 100644 testcases/network/stress/broken_ip/broken_ip-totlen
 create mode 100644 testcases/network/stress/broken_ip/broken_ip-version
 delete mode 100644 testcases/network/stress/broken_ip/broken_ip4-checksum
 delete mode 100644 testcases/network/stress/broken_ip/broken_ip4-dstaddr
 delete mode 100644 testcases/network/stress/broken_ip/broken_ip4-fragment
 delete mode 100644 testcases/network/stress/broken_ip/broken_ip4-ihl
 delete mode 100644 testcases/network/stress/broken_ip/broken_ip4-protcol
 delete mode 100644 testcases/network/stress/broken_ip/broken_ip4-totlen
 delete mode 100644 testcases/network/stress/broken_ip/broken_ip4-version
 delete mode 100644 testcases/network/stress/broken_ip/broken_ip6-dstaddr
 delete mode 100644 testcases/network/stress/broken_ip/broken_ip6-nexthdr
 delete mode 100644 testcases/network/stress/broken_ip/broken_ip6-plen
 delete mode 100644 testcases/network/stress/broken_ip/broken_ip6-version

diff --git a/runtest/net_stress.broken_ip b/runtest/net_stress.broken_ip
index 32e3b99f6..ca71c3e7b 100644
--- a/runtest/net_stress.broken_ip
+++ b/runtest/net_stress.broken_ip
@@ -3,15 +3,15 @@
 #
 
 # Broken IP packet
-broken_ip4-version broken_ip4-version
-broken_ip4-ihl broken_ip4-ihl
-broken_ip4-totlen broken_ip4-totlen
-broken_ip4-fragment broken_ip4-fragment
-broken_ip4-protcol broken_ip4-protcol
-broken_ip4-checksum broken_ip4-checksum
-broken_ip4-dstaddr broken_ip4-dstaddr
+broken_ip4-version broken_ip-version
+broken_ip4-ihl broken_ip-ihl
+broken_ip4-totlen broken_ip-totlen
+broken_ip4-fragment broken_ip-fragment
+broken_ip4-protcol broken_ip-protcol
+broken_ip4-checksum broken_ip-checksum
+broken_ip4-dstaddr broken_ip-dstaddr
 
-broken_ip6-dstaddr broken_ip6-dstaddr -6
-broken_ip6-nexthdr broken_ip6-nexthdr -6
-broken_ip6-plen broken_ip6-plen -6
-broken_ip6-version broken_ip6-version -6
+broken_ip6-dstaddr broken_ip-dstaddr -6
+broken_ip6-nexthdr broken_ip-nexthdr -6
+broken_ip6-plen broken_ip-plen -6
+broken_ip6-version broken_ip-version -6
diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 692278361..17dbcf9f2 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -59,6 +59,14 @@ tst_net_setup()
 {
 	tst_net_remote_tmpdir
 	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
+
+	if [ -z "$ICMP_DATA_MAXSIZE" ]; then
+		if [ "$TST_IPV6" ]; then
+			ICMP_DATA_MAXSIZE="$ICMPV6_DATA_MAXSIZE"
+		else
+			ICMP_DATA_MAXSIZE="$ICMPV4_DATA_MAXSIZE"
+		fi
+	fi
 }
 
 [ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
@@ -820,6 +828,9 @@ export TST_NET_MAX_PKT="${TST_NET_MAX_PKT:-$(tst_default_max_pkt)}"
 export LHOST_HWADDRS="${LHOST_HWADDRS:-$(tst_get_hwaddrs lhost)}"
 export RHOST_HWADDRS="${RHOST_HWADDRS:-$(tst_get_hwaddrs rhost)}"
 
+export ICMPV4_DATA_MAXSIZE=1472
+export ICMPV6_DATA_MAXSIZE=1452
+
 # More information about network parameters can be found
 # in the following document: testcases/network/stress/README
 
diff --git a/testcases/network/stress/broken_ip/00_Descriptions.txt b/testcases/network/stress/broken_ip/00_Descriptions.txt
index af686b658..064b26417 100644
--- a/testcases/network/stress/broken_ip/00_Descriptions.txt
+++ b/testcases/network/stress/broken_ip/00_Descriptions.txt
@@ -1,45 +1,45 @@
-broken_ip4-version01
+broken_ip4-version
 	Verify that the kernel is not crashed with receiving a large number of
 	IPv4 packets that have wrong value in version field
 
-broken_ip4-ihl01
+broken_ip4-ihl
 	Verify that the kernel is not crashed with receiving a large number of
 	IPv4 packets that have wrong value in the header length field
 
-broken_ip4-totlen01
+broken_ip4-totlen
 	Verify that the kernel is not crashed with receiving a large number of
 	IPv4 packets that have wrong value in the total length field
 
-broken_ip4-fragment01
+broken_ip4-fragment
 	Verify that the kernel is not crashed with receiving a large number of
 	IPv4 packets that have wrong fragment information
 
-broken_ip4-protcol01
+broken_ip4-protcol
 	Verify that the kernel is not crashed with receiving a large number of
 	IPv4 packets that have wrong value in the protocol field
 
-broken_ip4-checksum01
+broken_ip4-checksum
 	Verify that the kernel is not crashed with receiving a large number of
 	IPv4 packets that have wrong value in the checksum field
 
-broken_ip4-dstaddr01
+broken_ip4-dstaddr
 	Verify that the kernel is not crashed with receiving a large number of
 	IPv4 packets whose destination address is wrong
 	(destination MAC address is corrct)
 
-broken_ip6-version01
+broken_ip6-version
 	Verify that the kernel is not crashed with receiving a large number of
 	IPv6 packets that have wrong value in version field
 
-broken_ip6-plen01
+broken_ip6-plen
 	Verify that the kernel is not crashed with receiving a large number of
 	IPv6 packets that have wrong value in the payload length field
 
-broken_ip6-nexthdr01
+broken_ip6-nexthdr
 	Verify that the kernel is not crashed with receiving a large number of
 	IPv6 packets that have wrong value in the next header field
 
-broken_ip6-dstaddr01
+broken_ip6-dstaddr
 	Verify that the kernel is not crashed with receiving a large number of
 	IPv6 packets whose destination address is wrong (destination MAC
 	address is correct)
diff --git a/testcases/network/stress/broken_ip/Makefile b/testcases/network/stress/broken_ip/Makefile
index 29775d823..e530c7c13 100644
--- a/testcases/network/stress/broken_ip/Makefile
+++ b/testcases/network/stress/broken_ip/Makefile
@@ -1,24 +1,6 @@
-#
-#    network/stress/broken_ip test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/network/stress/broken_ip/broken_ip-checksum b/testcases/network/stress/broken_ip/broken_ip-checksum
new file mode 100644
index 000000000..5bca09ccf
--- /dev/null
+++ b/testcases/network/stress/broken_ip/broken_ip-checksum
@@ -0,0 +1,18 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2006
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
+
+TST_TESTFUNC="do_test"
+. tst_net.sh
+
+do_test()
+{
+	tst_res TINFO "Sending ICMPv$TST_IPVER with wrong chksum field for $NS_DURATION sec"
+	tst_icmp -t $NS_DURATION -s "0 100 500 1000 $ICMP_DATA_MAXSIZE" -c
+	tst_ping
+}
+
+tst_run
diff --git a/testcases/network/stress/broken_ip/broken_ip-dstaddr b/testcases/network/stress/broken_ip/broken_ip-dstaddr
new file mode 100644
index 000000000..93c60347a
--- /dev/null
+++ b/testcases/network/stress/broken_ip/broken_ip-dstaddr
@@ -0,0 +1,18 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2006
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
+
+TST_TESTFUNC="do_test"
+. tst_net.sh
+
+do_test()
+{
+	tst_res TINFO "Sending ICMPv$TST_IPVER with wrong dst address for $NS_DURATION sec"
+	tst_icmp -t $NS_DURATION -s "0 100 500 1000 $ICMP_DATA_MAXSIZE" -i
+	tst_ping
+}
+
+tst_run
diff --git a/testcases/network/stress/broken_ip/broken_ip-fragment b/testcases/network/stress/broken_ip/broken_ip-fragment
new file mode 100644
index 000000000..897a68e47
--- /dev/null
+++ b/testcases/network/stress/broken_ip/broken_ip-fragment
@@ -0,0 +1,18 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2006
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
+
+TST_TESTFUNC="do_test"
+. tst_net.sh
+
+do_test()
+{
+	tst_res TINFO "Sending ICMPv$TST_IPVER with wrong frag. info for $NS_DURATION sec"
+	tst_icmp -t $NS_DURATION -s "0 100 500 1000 $ICMP_DATA_MAXSIZE" -f
+	tst_ping
+}
+
+tst_run
diff --git a/testcases/network/stress/broken_ip/broken_ip-ihl b/testcases/network/stress/broken_ip/broken_ip-ihl
new file mode 100644
index 000000000..15321a5cd
--- /dev/null
+++ b/testcases/network/stress/broken_ip/broken_ip-ihl
@@ -0,0 +1,18 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2006
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
+
+TST_TESTFUNC="do_test"
+. tst_net.sh
+
+do_test()
+{
+	tst_res TINFO "Sending ICMPv$TST_IPVER with wrong header len field for $NS_DURATION sec"
+	tst_icmp -t $NS_DURATION -s "0 100 500 1000 $ICMP_DATA_MAXSIZE" -l
+	tst_ping
+}
+
+tst_run
diff --git a/testcases/network/stress/broken_ip/broken_ip-nexthdr b/testcases/network/stress/broken_ip/broken_ip-nexthdr
new file mode 100644
index 000000000..0ac65475f
--- /dev/null
+++ b/testcases/network/stress/broken_ip/broken_ip-nexthdr
@@ -0,0 +1,18 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2006
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
+
+TST_TESTFUNC="do_test"
+. tst_net.sh
+
+do_test()
+{
+	tst_res TINFO "Sending ICMPv$TST_IPVER with wrong next header for $NS_DURATION sec"
+	tst_icmp -t $NS_DURATION -s "0 100 500 1000 $ICMP_DATA_MAXSIZE" -n
+	tst_ping
+}
+
+tst_run
diff --git a/testcases/network/stress/broken_ip/broken_ip-plen b/testcases/network/stress/broken_ip/broken_ip-plen
new file mode 100644
index 000000000..29416ee8e
--- /dev/null
+++ b/testcases/network/stress/broken_ip/broken_ip-plen
@@ -0,0 +1,18 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2006
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
+
+TST_TESTFUNC="do_test"
+. tst_net.sh
+
+do_test()
+{
+	tst_res TINFO "Sending ICMPv$TST_IPVER with wrong payload len for $NS_DURATION sec"
+	tst_icmp -t $NS_DURATION -s "0 100 500 1000 $ICMP_DATA_MAXSIZE" -L
+	tst_ping
+}
+
+tst_run
diff --git a/testcases/network/stress/broken_ip/broken_ip-protcol b/testcases/network/stress/broken_ip/broken_ip-protcol
new file mode 100644
index 000000000..14a3d644d
--- /dev/null
+++ b/testcases/network/stress/broken_ip/broken_ip-protcol
@@ -0,0 +1,18 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2006
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
+
+TST_TESTFUNC="do_test"
+. tst_net.sh
+
+do_test()
+{
+	tst_res TINFO "Sending ICMPv$TST_IPVER with wrong proto field for $NS_DURATION sec"
+	tst_icmp -t $NS_DURATION -s "0 100 500 1000 $ICMP_DATA_MAXSIZE" -p
+	tst_ping
+}
+
+tst_run
diff --git a/testcases/network/stress/broken_ip/broken_ip-totlen b/testcases/network/stress/broken_ip/broken_ip-totlen
new file mode 100644
index 000000000..cd636bb1b
--- /dev/null
+++ b/testcases/network/stress/broken_ip/broken_ip-totlen
@@ -0,0 +1,18 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2006
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
+
+TST_TESTFUNC="do_test"
+. tst_net.sh
+
+do_test()
+{
+	tst_res TINFO "Sending ICMPv$TST_IPVER with wrong total len field for $NS_DURATION sec"
+	tst_icmp -t $NS_DURATION -s "0 100 500 1000 $ICMP_DATA_MAXSIZE" -L
+	tst_ping
+}
+
+tst_run
diff --git a/testcases/network/stress/broken_ip/broken_ip-version b/testcases/network/stress/broken_ip/broken_ip-version
new file mode 100644
index 000000000..82c14d20b
--- /dev/null
+++ b/testcases/network/stress/broken_ip/broken_ip-version
@@ -0,0 +1,18 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2006
+# Author: Mitsuru Chinen <mitch@jp.ibm.com>
+
+TST_TESTFUNC="do_test"
+. tst_net.sh
+
+do_test()
+{
+	tst_res TINFO "Sending ICMPv$TST_IPVER with wrong version field for $NS_DURATION sec"
+	tst_icmp -t $NS_DURATION -s "0 100 500 1000 $ICMP_DATA_MAXSIZE" -v
+	tst_ping
+}
+
+tst_run
diff --git a/testcases/network/stress/broken_ip/broken_ip4-checksum b/testcases/network/stress/broken_ip/broken_ip4-checksum
deleted file mode 100644
index 53c6868ba..000000000
--- a/testcases/network/stress/broken_ip/broken_ip4-checksum
+++ /dev/null
@@ -1,33 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
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
-#
-# Author: Mitsuru Chinen <mitch@jp.ibm.com>
-
-TCID=broken_ip4-checksum01
-TST_TOTAL=1
-
-TST_USE_LEGACY_API=1
-. tst_net.sh
-
-tst_resm TINFO "Sending ICMPv4 with wrong chksum field for $NS_DURATION sec"
-
-tst_icmp -t $NS_DURATION -s "0 100 500 1000 1472" -c
-
-tst_ping
-
-tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-dstaddr b/testcases/network/stress/broken_ip/broken_ip4-dstaddr
deleted file mode 100644
index b940d7661..000000000
--- a/testcases/network/stress/broken_ip/broken_ip4-dstaddr
+++ /dev/null
@@ -1,33 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
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
-#
-# Author: Mitsuru Chinen <mitch@jp.ibm.com>
-
-TCID=broken_ip4-dstaddr01
-TST_TOTAL=1
-
-TST_USE_LEGACY_API=1
-. tst_net.sh
-
-tst_resm TINFO "Sending ICMPv4 with wrong dst address for $NS_DURATION sec"
-
-tst_icmp -t $NS_DURATION -s "0 100 500 1000 1472" -i
-
-tst_ping
-
-tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-fragment b/testcases/network/stress/broken_ip/broken_ip4-fragment
deleted file mode 100644
index e5d90b464..000000000
--- a/testcases/network/stress/broken_ip/broken_ip4-fragment
+++ /dev/null
@@ -1,33 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
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
-#
-# Author: Mitsuru Chinen <mitch@jp.ibm.com>
-
-TCID=broken_ip4-fragment01
-TST_TOTAL=1
-
-TST_USE_LEGACY_API=1
-. tst_net.sh
-
-tst_resm TINFO "Sending ICMPv4 with wrong frag. info for $NS_DURATION sec"
-
-tst_icmp -t $NS_DURATION -s "0 100 500 1000 1472" -f
-
-tst_ping
-
-tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-ihl b/testcases/network/stress/broken_ip/broken_ip4-ihl
deleted file mode 100644
index de8324537..000000000
--- a/testcases/network/stress/broken_ip/broken_ip4-ihl
+++ /dev/null
@@ -1,33 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
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
-#
-# Author: Mitsuru Chinen <mitch@jp.ibm.com>
-
-TCID=broken_ip4-ihl01
-TST_TOTAL=1
-
-TST_USE_LEGACY_API=1
-. tst_net.sh
-
-tst_resm TINFO "Sending ICMPv4 with wrong header len field for $NS_DURATION sec"
-
-tst_icmp -t $NS_DURATION -s "0 100 500 1000 1472" -l
-
-tst_ping
-
-tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-protcol b/testcases/network/stress/broken_ip/broken_ip4-protcol
deleted file mode 100644
index 0fee79364..000000000
--- a/testcases/network/stress/broken_ip/broken_ip4-protcol
+++ /dev/null
@@ -1,33 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
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
-#
-# Author: Mitsuru Chinen <mitch@jp.ibm.com>
-
-TCID=broken_ip4-protocol01
-TST_TOTAL=1
-
-TST_USE_LEGACY_API=1
-. tst_net.sh
-
-tst_resm TINFO "Sending ICMPv4 with wrong proto field for $NS_DURATION sec"
-
-tst_icmp -t $NS_DURATION -s "0 100 500 1000 1472" -p
-
-tst_ping
-
-tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-totlen b/testcases/network/stress/broken_ip/broken_ip4-totlen
deleted file mode 100644
index cd5f31177..000000000
--- a/testcases/network/stress/broken_ip/broken_ip4-totlen
+++ /dev/null
@@ -1,33 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
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
-#
-# Author: Mitsuru Chinen <mitch@jp.ibm.com>
-
-TCID=broken_ip4-totlen01
-TST_TOTAL=1
-
-TST_USE_LEGACY_API=1
-. tst_net.sh
-
-tst_resm TINFO "Sending ICMPv4 with wrong total len field for $NS_DURATION sec"
-
-tst_icmp -t $NS_DURATION -s "0 100 500 1000 1472" -L
-
-tst_ping
-
-tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip4-version b/testcases/network/stress/broken_ip/broken_ip4-version
deleted file mode 100644
index a5e30b4b6..000000000
--- a/testcases/network/stress/broken_ip/broken_ip4-version
+++ /dev/null
@@ -1,33 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
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
-#
-# Author: Mitsuru Chinen <mitch@jp.ibm.com>
-
-TCID=broken_ip4-version01
-TST_TOTAL=1
-
-TST_USE_LEGACY_API=1
-. tst_net.sh
-
-tst_resm TINFO "Sending ICMPv4 with wrong version field for $NS_DURATION sec"
-
-tst_icmp -t $NS_DURATION -s "0 100 500 1000 1472" -v
-
-tst_ping
-
-tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip6-dstaddr b/testcases/network/stress/broken_ip/broken_ip6-dstaddr
deleted file mode 100644
index 69e993c2f..000000000
--- a/testcases/network/stress/broken_ip/broken_ip6-dstaddr
+++ /dev/null
@@ -1,33 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
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
-#
-# Author: Mitsuru Chinen <mitch@jp.ibm.com>
-
-TCID=broken_ip6-dstaddr01
-TST_TOTAL=1
-
-TST_USE_LEGACY_API=1
-. tst_net.sh
-
-tst_resm TINFO "Sending ICMPv6 with wrong dst address for $NS_DURATION sec"
-
-tst_icmp -t $NS_DURATION -s "0 100 500 1000 1452" -i
-
-tst_ping
-
-tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip6-nexthdr b/testcases/network/stress/broken_ip/broken_ip6-nexthdr
deleted file mode 100644
index 2510fd235..000000000
--- a/testcases/network/stress/broken_ip/broken_ip6-nexthdr
+++ /dev/null
@@ -1,33 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
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
-#
-# Author: Mitsuru Chinen <mitch@jp.ibm.com>
-
-TCID=broken_ip6-nexthdr01
-TST_TOTAL=1
-
-TST_USE_LEGACY_API=1
-. tst_net.sh
-
-tst_resm TINFO "Sending ICMPv4 with wrong next header for $NS_DURATION sec"
-
-tst_icmp -t $NS_DURATION -s "0 100 500 1000 1452" -n
-
-tst_ping
-
-tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip6-plen b/testcases/network/stress/broken_ip/broken_ip6-plen
deleted file mode 100644
index 960902b3d..000000000
--- a/testcases/network/stress/broken_ip/broken_ip6-plen
+++ /dev/null
@@ -1,33 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
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
-#
-# Author: Mitsuru Chinen <mitch@jp.ibm.com>
-
-TCID=broken_ip6-plen01
-TST_TOTAL=1
-
-TST_USE_LEGACY_API=1
-. tst_net.sh
-
-tst_resm TINFO "Sending ICMPv4 with wrong payload len for $NS_DURATION sec"
-
-tst_icmp -t $NS_DURATION -s "0 100 500 1000 1452" -L
-
-tst_ping
-
-tst_exit
diff --git a/testcases/network/stress/broken_ip/broken_ip6-version b/testcases/network/stress/broken_ip/broken_ip6-version
deleted file mode 100644
index b189ba1dd..000000000
--- a/testcases/network/stress/broken_ip/broken_ip6-version
+++ /dev/null
@@ -1,33 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
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
-#
-# Author: Mitsuru Chinen <mitch@jp.ibm.com>
-
-TCID=broken_ip6-version01
-TST_TOTAL=1
-
-TST_USE_LEGACY_API=1
-. tst_net.sh
-
-tst_resm TINFO "Sending ICMPv6 with wrong version field for $NS_DURATION sec"
-
-tst_icmp -t $NS_DURATION -s "0 100 500 1000 1452" -v
-
-tst_ping
-
-tst_exit
-- 
2.20.1

