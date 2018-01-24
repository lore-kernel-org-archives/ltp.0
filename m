From: Michael Moese <mmoese@suse.de>
Date: Wed, 24 Jan 2018 14:03:10 +0100
Subject: [LTP] [PATCH 17/19] fix old style definitions in fsx-linux.c
In-Reply-To: <20180124130312.7665-1-mmoese@suse.de>
References: <20180124130312.7665-1-mmoese@suse.de>
Message-ID: <20180124130312.7665-18-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/kernel/fs/fsx-linux/fsx-linux.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/fs/fsx-linux/fsx-linux.c b/testcases/kernel/fs/fsx-linux/fsx-linux.c
index ccf55fe05..02f3eb827 100644
--- a/testcases/kernel/fs/fsx-linux/fsx-linux.c
+++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
@@ -128,10 +128,7 @@ int fsxgoodfd = 0;
 FILE *fsxlogf = NULL;
 int badoff = -1;
 
-void vwarnc(code, fmt, ap)
-int code;
-const char *fmt;
-va_list ap;
+void vwarnc(int code,const char *fmt, va_list ap)
 {
 	fprintf(stderr, "fsx: ");
 	if (fmt != NULL) {
@@ -913,7 +910,7 @@ void dotruncate(unsigned size)
 	}
 }
 
-void writefileimage()
+void writefileimage(void)
 {
 	ssize_t iret;
 	int fd = get_fd();
@@ -1038,8 +1035,7 @@ void test(void)
 		docloseopen();
 }
 
-void cleanup(sig)
-int sig;
+void cleanup(int sig)
 {
 	if (sig)
 		prt("signal %d\n", sig);
-- 
2.13.6

