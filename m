From: Michael Moese <mmoese@suse.de>
Date: Thu, 25 Jan 2018 16:22:57 +0100
Subject: [LTP] [PATCH 03/10] fix old-style-definition and unused parameter
	in pthcli.c
In-Reply-To: <20180125152304.32747-1-mmoese@suse.de>
References: <20180125152304.32747-1-mmoese@suse.de>
Message-ID: <20180125152304.32747-4-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/kernel/sched/clisrv/pthcli.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/sched/clisrv/pthcli.c b/testcases/kernel/sched/clisrv/pthcli.c
index 3bcd688f6..7833b86d1 100644
--- a/testcases/kernel/sched/clisrv/pthcli.c
+++ b/testcases/kernel/sched/clisrv/pthcli.c
@@ -53,15 +53,14 @@
 
 void noprintf(char *string, ...)
 {
+	(void) string;
 }
 
 /* Read contents of FILE *fp. Write each line to socket, then
    read line back from socket and write to standard output.
    Return to caller when done */
 
-void str_cli(fp, sockfd)
-register FILE *fp;
-register int sockfd;
+void str_cli(FILE *fp, int sockfd)
 {
 	int n;
 	char sendline[MAXLINE], recvline[MAXLINE + 1];
-- 
2.13.6

