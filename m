From: Hangbin Liu <haliu@redhat.com>
Date: Mon,  7 Mar 2016 15:14:42 +0800
Subject: [LTP]  [PATCH 2/3] network/stress: add ipsec lib
In-Reply-To: <1457334883-11086-1-git-send-email-haliu@redhat.com>
References: <1457334883-11086-1-git-send-email-haliu@redhat.com>
Message-ID: <1457334883-11086-3-git-send-email-haliu@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Hangbin Liu <haliu@redhat.com>
---
 testcases/network/stress/ipsec/Makefile     |  31 +++++++
 testcases/network/stress/ipsec/ipsec_lib.sh | 134 ++++++++++++++++++++++++++++
 2 files changed, 165 insertions(+)
 create mode 100644 testcases/network/stress/ipsec/Makefile
 create mode 100644 testcases/network/stress/ipsec/ipsec_lib.sh

diff --git a/testcases/network/stress/ipsec/Makefile b/testcases/network/stress/ipsec/Makefile
new file mode 100644
index 0000000..b3a1657
--- /dev/null
+++ b/testcases/network/stress/ipsec/Makefile
@@ -0,0 +1,31 @@
+#!/bin/sh
+# Copyright (c) 2016 Red Hat Inc.,  All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+# Author: Hangbin Liu <haliu@redhat.com>
+#
+#######################################################################
+
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS		:= *.sh
+
+MAKE_TARGETS		:=
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
new file mode 100644
index 0000000..feeecf9
--- /dev/null
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -0,0 +1,134 @@
+#!/bin/sh
+# Copyright (c) 2016 Red Hat Inc.,  All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+# Author: Hangbin Liu <haliu@redhat.com>
+#
+#######################################################################
+
+#Uncomment line below for debug output.
+#trace_logic=${trace_logic:-"set -x"}
+$trace_logic
+
+# Make sure the value of LTPROOT
+LTPROOT=${LTPROOT:-`(cd ../../../../ ; pwd)`}
+export LTPROOT
+
+. test_net.sh
+
+# c2x: convert charactor to hex
+c2x()
+{
+	for str in $@; do
+		for (( i=0; i<${#str}; i++ )); do
+			c=${str:$i:1}
+			printf '%x' "'$c"
+		done
+	done
+}
+
+# tst_ipsec flush: flush the ipsec state and policy
+# tst_ipsec target protocol mode first_spi src_addr dst_addr: config ipsec
+#
+# target: target of the configuration file ( src / dst )
+# protocol: ah / esp / ipcomp
+# mode: transport / tunnel
+# first_spi: the first spi value
+# src_addr: source IP address
+# dst_addr: destination IP address
+tst_ipsec()
+{
+	if [ x$1 = x"flush" ]; then
+		ip xfrm state flush && ip xfrm policy flush
+		tst_rhost_run -c "ip xfrm state flush && ip xfrm policy flush"
+		return 0
+	fi
+	if [ $# -ne 6 ]; then
+		tst_resm TINFO "tst_ipsec parameter mismatch"
+		return 1
+	fi
+
+	target=$1
+	protocol=$2
+	mode=$3
+	first_spi=$4
+	src_ipaddr=$5
+	dst_ipaddr=$6
+
+	# Encryption algorithm
+	EALGO="des3_ede"
+	EALGO_KEY="0x$(c2x _I_want_to_have_chicken_)"
+
+	# Authentication algorithm
+	AALGO="sha1"
+	AALGO_KEY="0x$(c2x beef_fish_pork_salad)"
+
+	# Compression algorithm
+	CALGO="deflate"
+	# Algorithm options for each protocol
+	case $protocol in
+		ah)
+			algo_line="auth $AALGO $AALGO_KEY"
+			proto="ah"
+			;;
+		esp)
+			algo_line="enc $EALGO $EALGO_KEY auth $AALGO $AALGO_KEY"
+			proto="esp"
+			;;
+		ipcomp)
+			algo_line="comp $CALGO"
+			proto="comp"
+			;;
+		*)
+			tst_resm TINFO "tst_ipsec protocol mismatch"
+			return 1
+			;;
+	esac
+
+	if [ $target = src ]; then
+		src=$src_ipaddr
+		dst=$dst_ipaddr
+		spi_1="0x$first_spi"
+		spi_2="0x$(( $first_spi + 1 ))"
+		ip xfrm state add src $src dst $dst spi $spi_1 proto $proto \
+			$algo_line mode $mode sel src $src dst $dst
+		ip xfrm policy add src $src dst $dst dir out tmpl src $src \
+			dst $dst proto $proto mode $mode
+
+		ip xfrm state add src $dst dst $src spi $spi_2 proto $proto \
+			$algo_line mode $mode sel src $dst dst $src
+		ip xfrm policy add src $dst dst $src dir in tmpl src $dst \
+			dst $src proto $proto mode $mode
+		ip xfrm state
+		ip xfrm policy
+	elif [ $target = dst ]; then
+		src=$dst_ipaddr
+		dst=$src_ipaddr
+		spi_1="0x$(( $first_spi + 1 ))"
+		spi_2="0x$first_spi"
+		tst_rhost_run -c "ip xfrm state add src $src dst $dst spi $spi_1 \
+			proto $proto $algo_line mode $mode sel src $src dst $dst"
+		tst_rhost_run -c "ip xfrm policy add src $src dst $dst dir out \
+			tmpl src $src dst $dst proto $proto mode $mode"
+
+		tst_rhost_run -c "ip xfrm state add src $dst dst $src spi $spi_2 \
+			proto $proto $algo_line mode $mode sel src $dst dst $src"
+		tst_rhost_run -c "ip xfrm policy add src $dst dst $src dir in \
+			tmpl src $dst dst $src proto $proto mode $mode"
+		tst_rhost_run -c "ip xfrm state"
+		tst_rhost_run -c "ip xfrm policy"
+	fi
+}
-- 
2.5.0

