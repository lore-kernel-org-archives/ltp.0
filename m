From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 May 2018 15:14:30 +0200
Subject: [LTP] [PATCH 1/1] net/tst_netload: TBROK when TST_NEEDS_TMPDIR not
	set
Message-ID: <20180516131430.19090-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_netload function uses $TST_TMPDIR therefore requires
TST_NEEDS_TMPDIR=1. It's better to tell user the reason, as current
error message was a bit misleading:

dccp_ipsec 1 TINFO: run server 'netstress -T dccp -R 500000 -B '
netstress: option requires an argument -- 'B'
-h       Prints this help
-i n     Execute test n times
-I x     Execute test for n seconds
-C ARG   Run child process with ARG arguments (used internally)
-f       Use TFO API, default is old API
-F       TCP_FASTOPEN_CONNECT socket option and standard API
-t x     Set tcp_fastopen value
-S x     Source address to bind
-g x     x - server port
-b x     x - low latency busy poll timeout
-T x     tcp (default), udp, dccp, sctp
-z       enable SO_ZEROCOPY

Client:
-H x     Server name or IP address
-l       Become client, default is server
-a x     Number of clients running in parallel
-r x     Number of client requests
-n x     Client message size
-N x     Server message size
-m x     Reply timeout in microsec.
-d x     x is a path to file where result is saved
-A x     x max payload length (generated randomly)

Server:
-R x     x requests after which conn.closed
-q x     x - TFO queue
-B x     run in background, x - process directory
tst_test.c:492: BROK: Invalid option
dccp_ipsec 1 TFAIL: server failed

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index b0a78e14b..644f4242c 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -480,6 +480,10 @@ tst_netload()
 	local s_replies="${TST_NETLOAD_MAX_SRV_REPLIES:-500000}"
 	local s_opts=
 
+	if [ ! "$TST_NEEDS_TMPDIR" = 1 ]; then
+		tst_brk_ TBROK "Using tst_netload requires setting TST_NEEDS_TMPDIR=1"
+	fi
+
 	OPTIND=0
 	while getopts :a:H:d:n:N:r:R:S:b:t:T:fFe:m:A: opt; do
 		case "$opt" in
-- 
2.16.3

