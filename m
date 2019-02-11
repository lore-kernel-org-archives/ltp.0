From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 11 Feb 2019 21:07:44 +0300
Subject: [LTP] [PATCH 1/4] netstress: support SO_REUSEPORT with new 'P' flag
In-Reply-To: <1549908467-15609-1-git-send-email-alexey.kodanev@oracle.com>
References: <1549908467-15609-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1549908467-15609-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

netstress tool can be used manually by setting -P flag for
a server. There is no test-case yet that specifically
auto tests this functionality or uses it, but it should be
easy to create one. For example, starting multiple netstress
instances on the same port.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/netstress/netstress.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 2c5a6bd..2cdc91a 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -147,6 +147,7 @@ struct sock_info {
 
 static char *zcopy;
 static int send_flags = MSG_NOSIGNAL;
+static char *reuse_port;
 
 static void init_socket_opts(int sd)
 {
@@ -308,6 +309,8 @@ static void bind_before_connect(int sd)
 
 	if (bind_no_port)
 		SAFE_SETSOCKOPT_INT(sd, SOL_IP, IP_BIND_ADDRESS_NO_PORT, 1);
+	if (reuse_port)
+		SAFE_SETSOCKOPT_INT(sd, SOL_SOCKET, SO_REUSEPORT, 1);
 
 	SAFE_BIND(sd, local_addrinfo->ai_addr, local_addrinfo->ai_addrlen);
 
@@ -674,6 +677,8 @@ static void server_init(void)
 	/* IPv6 socket is also able to access IPv4 protocol stack */
 	sfd = SAFE_SOCKET(family, sock_type, protocol);
 	SAFE_SETSOCKOPT_INT(sfd, SOL_SOCKET, SO_REUSEADDR, 1);
+	if (reuse_port)
+		SAFE_SETSOCKOPT_INT(sfd, SOL_SOCKET, SO_REUSEPORT, 1);
 
 	tst_res(TINFO, "assigning a name to the server socket...");
 	SAFE_BIND(sfd, local_addrinfo->ai_addr, local_addrinfo->ai_addrlen);
@@ -996,6 +1001,7 @@ static struct tst_option options[] = {
 	{"b:", &barg, "-b x     x - low latency busy poll timeout"},
 	{"T:", &type, "-T x     tcp (default), udp, udp_lite, dccp, sctp"},
 	{"z", &zcopy, "-z       enable SO_ZEROCOPY"},
+	{"P:", &reuse_port, "-P       enable SO_REUSEPORT"},
 	{"D:", &dev, "-d x     bind to device x\n"},
 
 	{"H:", &server_addr, "Client:\n-H x     Server name or IP address"},
-- 
1.7.1

