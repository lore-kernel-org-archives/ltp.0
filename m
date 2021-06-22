From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 22 Jun 2021 12:35:08 +0100
Subject: [LTP] [PATCH 2/8] ftest: Fix uninitialized var error
In-Reply-To: <20210622113514.22284-1-rpalethorpe@suse.com>
References: <20210622113514.22284-1-rpalethorpe@suse.com>
Message-ID: <20210622113514.22284-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Mark misc_intvl as const which allows the compiler to eliminate some
confusing branches. This is a minimal change to fix the error.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/fs/ftest/ftest01.c | 3 +--
 testcases/kernel/fs/ftest/ftest05.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/fs/ftest/ftest01.c b/testcases/kernel/fs/ftest/ftest01.c
index afad18095..31203d689 100644
--- a/testcases/kernel/fs/ftest/ftest01.c
+++ b/testcases/kernel/fs/ftest/ftest01.c
@@ -83,7 +83,7 @@ static void term(int sig);
 static int csize;		/* chunk size */
 static int iterations;		/* # total iterations */
 static int max_size;		/* max file size */
-static int misc_intvl;		/* for doing misc things; 0 ==> no */
+static const int misc_intvl = 10;		/* for doing misc things; 0 ==> no */
 static int nchild;		/* how many children */
 static int fd;			/* file descriptor used by child */
 static int parent_pid;
@@ -139,7 +139,6 @@ static void setup(void)
 	nchild = 5;
 	csize = K_2;		/* should run with 1, 2, and 4 K sizes */
 	max_size = K_1 * K_1;
-	misc_intvl = 10;
 
 	if (sigset(SIGTERM, term) == SIG_ERR) {
 		tst_brkm(TBROK | TERRNO, NULL, "sigset failed");
diff --git a/testcases/kernel/fs/ftest/ftest05.c b/testcases/kernel/fs/ftest/ftest05.c
index 0bd32e4f6..8d8e6d497 100644
--- a/testcases/kernel/fs/ftest/ftest05.c
+++ b/testcases/kernel/fs/ftest/ftest05.c
@@ -87,7 +87,7 @@ static void cleanup(void);
 static int csize;		/* chunk size */
 static int iterations;		/* # total iterations */
 static off64_t max_size;	/* max file size */
-static int misc_intvl;		/* for doing misc things; 0 ==> no */
+static const int misc_intvl = 10;		/* for doing misc things; 0 ==> no */
 static int nchild;		/* how many children */
 static int fd;			/* file descriptor used by child */
 static int parent_pid;
@@ -147,7 +147,6 @@ static void setup(void)
 	nchild = 5;
 	csize = K_2;		/* should run with 1, 2, and 4 K sizes */
 	max_size = K_1 * K_1;
-	misc_intvl = 10;
 
 	if (sigset(SIGTERM, term) == SIG_ERR) {
 		tst_brkm(TBROK | TERRNO, NULL,
-- 
2.31.1

