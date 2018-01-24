From: Michael Moese <mmoese@suse.de>
Date: Wed, 24 Jan 2018 14:02:55 +0100
Subject: [LTP] [PATCH 02/19] fix default int in function definition
In-Reply-To: <20180124130312.7665-1-mmoese@suse.de>
References: <20180124130312.7665-1-mmoese@suse.de>
Message-ID: <20180124130312.7665-3-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/network/stress/ns-tools/ns-udpserver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/stress/ns-tools/ns-udpserver.c b/testcases/network/stress/ns-tools/ns-udpserver.c
index b373edde3..b4bacf612 100644
--- a/testcases/network/stress/ns-tools/ns-udpserver.c
+++ b/testcases/network/stress/ns-tools/ns-udpserver.c
@@ -138,7 +138,7 @@ void set_signal_flag(int type)
  * Return value:
  *  None
  */
-void respond_to_client(sock_fd)
+void respond_to_client(int sock_fd)
 {
 	char *msgbuf;		/* Pointer to the message */
 	size_t msgbuf_size;	/* size of msgbuf */
-- 
2.13.6

