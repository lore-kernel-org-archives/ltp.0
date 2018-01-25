From: Michael Moese <mmoese@suse.de>
Date: Thu, 25 Jan 2018 16:22:55 +0100
Subject: [LTP] [PATCH 01/10] fix old-style-definition in written.c
In-Reply-To: <20180125152304.32747-1-mmoese@suse.de>
References: <20180125152304.32747-1-mmoese@suse.de>
Message-ID: <20180125152304.32747-2-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/kernel/sched/clisrv/writen.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/testcases/kernel/sched/clisrv/writen.c b/testcases/kernel/sched/clisrv/writen.c
index 43db4b2bd..7ab12cdbe 100644
--- a/testcases/kernel/sched/clisrv/writen.c
+++ b/testcases/kernel/sched/clisrv/writen.c
@@ -25,10 +25,7 @@
 /* Write "n" bytes to a descriptor
    Use instead of write() when fd is a stream socket. */
 
-int writen(fd, ptr, nbytes)
-register int fd;
-register char *ptr;
-register int nbytes;
+int writen(int fd, char *ptr, int nbytes)
 {
 	int nleft, nwritten;
 
-- 
2.13.6

