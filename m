From: Michael Moese <mmoese@suse.de>
Date: Thu, 25 Jan 2018 16:22:56 +0100
Subject: [LTP] [PATCH 02/10] fix old-style-definition in readline.c
In-Reply-To: <20180125152304.32747-1-mmoese@suse.de>
References: <20180125152304.32747-1-mmoese@suse.de>
Message-ID: <20180125152304.32747-3-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/kernel/sched/clisrv/readline.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/testcases/kernel/sched/clisrv/readline.c b/testcases/kernel/sched/clisrv/readline.c
index e65ef1840..0c3272999 100644
--- a/testcases/kernel/sched/clisrv/readline.c
+++ b/testcases/kernel/sched/clisrv/readline.c
@@ -25,10 +25,7 @@
 /* Read line from a descriptor, byte at a time, return number of
    characters up to the null */
 
-int readline(fd, ptr, maxlen)
-register int fd;
-register char *ptr;
-register int maxlen;
+int readline(int fd, char *ptr, int maxlen)
 {
 	int n, rc;
 	char c;
-- 
2.13.6

