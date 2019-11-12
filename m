From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 12 Nov 2019 18:11:30 +0300
Subject: [LTP] [PATCH 1/2] network/netstress: fix -D option description
Message-ID: <20191112151131.5740-1-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/netstress/netstress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 413f20a9d..a5cc9a532 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -999,7 +999,7 @@ static struct tst_option options[] = {
 	{"T:", &type, "-T x     tcp (default), udp, udp_lite, dccp, sctp"},
 	{"z", &zcopy, "-z       enable SO_ZEROCOPY"},
 	{"P:", &reuse_port, "-P       enable SO_REUSEPORT"},
-	{"D:", &dev, "-d x     bind to device x\n"},
+	{"D:", &dev, "-D x     bind to device x\n"},
 
 	{"H:", &server_addr, "Client:\n-H x     Server name or IP address"},
 	{"l", &client_mode, "-l       Become client, default is server"},
-- 
2.20.1

