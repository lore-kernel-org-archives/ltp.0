From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 16 Aug 2018 19:20:47 +0200
Subject: [LTP] [PATCH 2/2] netstress: Unifi help
In-Reply-To: <20180816172047.6281-1-pvorel@suse.cz>
References: <20180816172047.6281-1-pvorel@suse.cz>
Message-ID: <20180816172047.6281-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/netstress/netstress.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 0de3fde1a..21d7245d4 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -994,7 +994,7 @@ static struct tst_option options[] = {
 	{"g:", &tcp_port, "-g x     x - server port"},
 	{"b:", &barg, "-b x     x - low latency busy poll timeout"},
 	{"T:", &type, "-T x     tcp (default), udp, udp_lite, dccp, sctp"},
-	{"z", &zcopy, "-z       enable SO_ZEROCOPY\n"},
+	{"z", &zcopy, "-z       Enable SO_ZEROCOPY\n"},
 
 	{"H:", &server_addr, "Client:\n-H x     Server name or IP address"},
 	{"l", &client_mode, "-l       Become client, default is server"},
@@ -1003,13 +1003,13 @@ static struct tst_option options[] = {
 	{"n:", &narg, "-n x     Client message size"},
 	{"N:", &Narg, "-N x     Server message size"},
 	{"m:", &Targ, "-m x     Reply timeout in microsec (for udp, udp_lite, dccp is timeout always 100 microsec)"},
-	{"d:", &rpath, "-d x     x is a path to file where result is saved"},
+	{"d:", &rpath, "-d x     x - path to file where result is saved"},
 	{"A:", &Aarg, "-A x     x max payload length (generated randomly)\n"},
 
 	{"R:", &Rarg, "Server:\n-R x     x requests after which conn.closed"},
 	{"q:", &qarg, "-q x     x - TFO queue"},
 	{"m:", &Targ, "-m x     Connect timeout in microsec (only for udp, udp_lite)"},
-	{"B:", &server_bg, "-B x     run in background, x - process directory"},
+	{"B:", &server_bg, "-B x     Run in background, x - process directory"},
 	{NULL, NULL, NULL}
 };
 
-- 
2.18.0

