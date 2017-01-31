From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 31 Jan 2017 19:35:44 +0100
Subject: [LTP] [PATCH 2/4] network: Add TI-RPC and TS-RPC tests into
	network.sh
In-Reply-To: <20170131183546.26993-1-pvorel@suse.cz>
References: <20170131183546.26993-1-pvorel@suse.cz>
Message-ID: <20170131183546.26993-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testscripts/network.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testscripts/network.sh b/testscripts/network.sh
index 2d2c6762c..fce59f576 100755
--- a/testscripts/network.sh
+++ b/testscripts/network.sh
@@ -24,6 +24,8 @@ usage()
 	echo "  -r    RPC tests"
 	echo "  -s    SCTP tests"
 	echo "  -t    TCP/IP command tests"
+	echo "  -c    TI-RPC tests"
+	echo "  -s    TS-RPC tests"
 	echo "  -a    Application tests (HTTP, SSH, DNS)"
 	echo "  -e    Interface stress tests"
 	echo "  -b    Stress tests with malformed ICMP packets"
@@ -40,7 +42,7 @@ usage()
 
 TEST_CASES=
 
-while getopts 6mnrstaebiTURMFf:Vvh OPTION
+while getopts 6mnrstaebcsiTURMFf:Vvh OPTION
 do
 	case $OPTION in
 	6) TEST_CASES="$TEST_CASES net.ipv6 net.ipv6_lib";;
@@ -49,6 +51,8 @@ do
 	r) TEST_CASES="$TEST_CASES net.rpc" ;;
 	s) TEST_CASES="$TEST_CASES net.sctp" ;;
 	t) TEST_CASES="$TEST_CASES net.tcp_cmds" ;;
+	c) TEST_CASES="$TEST_CASES net.rpc_tests";;
+	s) TEST_CASES="$TEST_CASES net.tirpc_tests";;
 	a) TEST_CASES="$TEST_CASES net_stress.appl";;
 	e) TEST_CASES="$TEST_CASES net_stress.interface";;
 	b) TEST_CASES="$TEST_CASES net_stress.broken_ip";;
-- 
2.11.0

