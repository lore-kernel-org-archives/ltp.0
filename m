From: Michael Moese <mmoese@suse.de>
Date: Thu, 25 Jan 2018 16:22:58 +0100
Subject: [LTP] [PATCH 04/10] fix old-style-definition and unused parameter
	in pthserv.c
In-Reply-To: <20180125152304.32747-1-mmoese@suse.de>
References: <20180125152304.32747-1-mmoese@suse.de>
Message-ID: <20180125152304.32747-5-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/kernel/sched/clisrv/pthserv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/sched/clisrv/pthserv.c b/testcases/kernel/sched/clisrv/pthserv.c
index 7aeb63f6e..e3da52130 100644
--- a/testcases/kernel/sched/clisrv/pthserv.c
+++ b/testcases/kernel/sched/clisrv/pthserv.c
@@ -53,8 +53,7 @@ int sockfd;
 /* Read a stream socket one line at a time and write each line back
    to sender. Return when connection is terminated */
 
-int str_echo(sockfd)
-int sockfd;
+int str_echo(int sockfd)
 {
 	int n, testint;
 	char line[MAXLINE];
@@ -95,6 +94,7 @@ int main(int argc, char *argv[])
 	struct sockaddr_in cli_addr, serv_addr;
 	pname = argv[0];
 
+	(void) argc;
 	prtln();
 	/* Open inet stream socket */
 	if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
-- 
2.13.6

