From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 22 Oct 2015 14:14:26 +0300
Subject: [LTP] [Committed] network/tcp_fastopen: apply SAFE_* macros from
	safe_net.h
Message-ID: <1445512466-609-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/tcp_fastopen/tcp_fastopen.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/testcases/network/tcp_fastopen/tcp_fastopen.c b/testcases/network/tcp_fastopen/tcp_fastopen.c
index 08a6019..6d67b5e 100644
--- a/testcases/network/tcp_fastopen/tcp_fastopen.c
+++ b/testcases/network/tcp_fastopen/tcp_fastopen.c
@@ -596,19 +596,14 @@ static void server_init(void)
 		tst_brkm(TBROK | TERRNO, cleanup, "getaddrinfo failed");
 
 	/* IPv6 socket is also able to access IPv4 protocol stack */
-	sfd = socket(AF_INET6, SOCK_STREAM, 0);
-	if (sfd == -1)
-		tst_brkm(TBROK, cleanup, "Failed to create a socket");
+	sfd = SAFE_SOCKET(cleanup, AF_INET6, SOCK_STREAM, 0);
 
 	tst_resm(TINFO, "assigning a name to the server socket...");
 	if (!local_addrinfo)
 		tst_brkm(TBROK, cleanup, "failed to get the address");
 
-	while (bind(sfd, local_addrinfo->ai_addr,
-		local_addrinfo->ai_addrlen) == -1) {
-		usleep(100000);
-	}
-	tst_resm(TINFO, "the name assigned");
+	SAFE_BIND(cleanup, sfd, local_addrinfo->ai_addr,
+		local_addrinfo->ai_addrlen);
 
 	freeaddrinfo(local_addrinfo);
 
@@ -621,7 +616,7 @@ static void server_init(void)
 			tst_brkm(TBROK, cleanup, "Can't set TFO sock. options");
 	}
 
-	listen(sfd, max_queue_len);
+	SAFE_LISTEN(cleanup, sfd, max_queue_len);
 	tst_resm(TINFO, "Listen on the socket '%d', port '%s'", sfd, tcp_port);
 }
 
-- 
1.7.1

