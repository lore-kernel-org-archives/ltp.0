From: Michael Moese <mmoese@suse.de>
Date: Fri,  9 Mar 2018 15:16:09 +0100
Subject: [LTP] [PATCH v3 3/3] safe_fork() should use tst_flush() instead of
	fflush()
In-Reply-To: <20180309141609.2596-1-mmoese@suse.de>
References: <20180309141609.2596-1-mmoese@suse.de>
Message-ID: <20180309141609.2596-3-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

safe_fork() should not use fflush(stdout). This commit makes use of
the the newly added tst_flush(), which flushes, in fact, both stdout
and stderr.
In addition, tests output their results to stderr, so flushing stdout
here is simply wrong.

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 lib/tst_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 9b4f43828..7069bbc5e 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -380,7 +380,7 @@ pid_t safe_fork(const char *filename, unsigned int lineno)
 	if (!tst_test->forks_child)
 		tst_brk(TBROK, "test.forks_child must be set!");
 
-	fflush(stdout);
+	tst_flush();
 
 	pid = fork();
 	if (pid < 0)
-- 
2.13.6

