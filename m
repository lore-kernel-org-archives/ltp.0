From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Oct 2019 15:24:29 +0200
Subject: [LTP] [PATCH v5 4/8] net: Add tst_ipaddr_un.sh test
In-Reply-To: <20191011132433.24197-1-pvorel@suse.cz>
References: <20191011132433.24197-1-pvorel@suse.cz>
Message-ID: <20191011132433.24197-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Testing tst_ipaddr_un() function from network shell API (tst_net.sh).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/newlib_tests/shell/net/tst_ipaddr_un.sh | 167 ++++++++++++++++++++
 1 file changed, 167 insertions(+)
 create mode 100755 lib/newlib_tests/shell/net/tst_ipaddr_un.sh

diff --git a/lib/newlib_tests/shell/net/tst_ipaddr_un.sh b/lib/newlib_tests/shell/net/tst_ipaddr_un.sh
new file mode 100755
index 000000000..a9d95f975
--- /dev/null
+++ b/lib/newlib_tests/shell/net/tst_ipaddr_un.sh
@@ -0,0 +1,167 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+
+TST_TESTFUNC=do_test
+TST_CNT=2
+TST_NEEDS_CMDS="cut"
+
+PATH="$(dirname $0)/../../../../testcases/lib/:$PATH"
+
+RHOST="foo"
+. tst_net.sh
+
+IPV4_DATA="
+0 0|10.23.0.0
+0 1|10.23.0.1
+1 0|10.23.1.0
+1 1|10.23.1.1
+1 2|10.23.1.2
+2 2|10.23.2.2
+1 3|10.23.1.3
+3 3|10.23.3.3
+1 128|10.23.1.128
+128 128|10.23.128.128
+1 254|10.23.1.254
+254 254|10.23.254.254
+1 255|10.23.1.255
+255 255|10.23.255.255
+1 256|10.23.1.0
+256 256|10.23.0.0
+1 257|10.23.1.1
+257 257|10.23.1.1
+
+-c 0|10.23.0.2
+-c 0 lhost|10.23.0.2
+-c 0 rhost|10.23.0.1
+
+-c 1|10.23.0.2
+-c 1 rhost|10.23.0.1
+-c 2|10.23.0.4
+-c 2 rhost|10.23.0.3
+-c 127|10.23.0.254
+-c 127 rhost|10.23.0.253
+-c 128|10.23.1.2
+-c 128 rhost|10.23.1.1
+-c 254|10.23.1.254
+-c 254 rhost|10.23.1.253
+-c 255|10.23.2.2
+-c 255 rhost|10.23.2.1
+
+-c 0 -h1,255|10.23.0.2
+-c 0 -h1,255 rhost|10.23.0.1
+-c 1 -h1,255|10.23.0.2
+-c 1 -h1,255 rhost|10.23.0.1
+-c 127 -h1,255|10.23.0.254
+-c 127 -h1,255 rhost|10.23.0.253
+-c 128 -h1,255|10.23.1.1
+-c 128 -h1,255 rhost|10.23.0.255
+-c 255 -h1,255|10.23.1.255
+-c 255 -h1,255 rhost|10.23.1.254
+-c 256 -h1,255|10.23.2.2
+-c 256 -h1,255 rhost|10.23.2.1
+
+-c1 -h 2,8 -n 2,8|10.23.2.3
+-c1 -h 2,8 -n 2,8 rhost|10.23.2.2
+-c2 -h 2,8 -n 2,8|10.23.2.5
+-c2 -h 2,8 -n 2,8 rhost|10.23.2.4
+
+-c1 -n 22,44|10.23.22.2
+-c1 -n 22,44 rhost|10.23.22.1
+-c2 -n 22,44|10.23.22.4
+-c2 -n 22,44 rhost|10.23.22.3
+"
+
+IPV6_DATA="
+0 0|fd00:23::
+0 1|fd00:23::1
+1 0|fd00:23:1::
+1 1|fd00:23:1::1
+1 2|fd00:23:1::2
+2 2|fd00:23:2::2
+1 3|fd00:23:1::3
+3 3|fd00:23:3::3
+1 32767|fd00:23:1::7fff
+32767 32767|fd00:23:7fff::7fff
+1 65534|fd00:23:1::fffe
+65534 65534|fd00:23:fffe::fffe
+1 65535|fd00:23:1::ffff
+65535 65535|fd00:23:ffff::ffff
+1 65536|fd00:23:1::
+65536 65536|fd00:23::
+1 65537|fd00:23:1::1
+65537 65537|fd00:23:1::1
+
+-c 0|fd00:23::2
+-c 0 lhost|fd00:23::2
+-c 0 rhost|fd00:23::1
+
+-c 1|fd00:23::2
+-c 1 rhost|fd00:23::1
+-c 2|fd00:23::4
+-c 2 rhost|fd00:23::3
+-c 32767|fd00:23::fffe
+-c 32767 rhost|fd00:23::fffd
+-c 32768|fd00:23:1::2
+-c 32768 rhost|fd00:23:1::1
+-c 65534|fd00:23:1::fffe
+-c 65534 rhost|fd00:23:1::fffd
+-c 65535|fd00:23:2::2
+-c 65535 rhost|fd00:23:2::1
+
+-c 0 -h1,65535|fd00:23::2
+-c 0 -h1,65535 rhost|fd00:23::1
+-c 1 -h1,65535|fd00:23::2
+-c 1 -h1,65535 rhost|fd00:23::1
+-c 32767 -h1,65535|fd00:23::fffe
+-c 32767 -h1,65535 rhost|fd00:23::fffd
+-c 32768 -h1,65535|fd00:23:1::1
+-c 32768 -h1,65535 rhost|fd00:23::ffff
+-c 65535 -h1,65535|fd00:23:1::ffff
+-c 65535 -h1,65535 rhost|fd00:23:1::fffe
+-c 65536 -h1,65535|fd00:23:2::2
+-c 65536 -h1,65535 rhost|fd00:23:2::1
+
+-c1 -h 2,8 -n 2,8|fd00:23:2::3
+-c1 -h 2,8 -n 2,8 rhost|fd00:23:2::2
+-c2 -h 2,8 -n 2,8|fd00:23:2::5
+-c2 -h 2,8 -n 2,8 rhost|fd00:23:2::4
+
+-c1 -n 22,44|fd00:23:16::2
+-c1 -n 22,44 rhost|fd00:23:16::1
+-c2 -n 22,44|fd00:23:16::4
+-c2 -n 22,44 rhost|fd00:23:16::3
+"
+
+test_tst_ipaddr_un()
+{
+	local data cmd i result
+	local var="$1"
+
+	tst_res TINFO "Testing for IPv${TST_IPVER}, data: \$$var"
+
+	eval data="\$$var"
+	IFS="
+"
+	for i in $data; do
+		cmd="tst_ipaddr_un $(echo $i | cut -d'|' -f 1)"
+		result="$(echo $i | cut -d'|' -f 2)"
+		tst_res TINFO "testing $cmd"
+		EXPECT_PASS "[ '$(eval $cmd)' = '$result' ]"
+	done
+}
+
+do_test2()
+{
+	test_tst_ipaddr_un "IPV${TST_IPVER}_DATA"
+}
+
+do_test()
+{
+	case $1 in
+	 1) TST_IPV6= TST_IPVER=4 do_test2;;
+	 2) TST_IPV6=6 TST_IPVER=6 do_test2;;
+	esac
+}
+
+tst_run
-- 
2.23.0

