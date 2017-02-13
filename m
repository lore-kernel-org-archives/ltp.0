From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Feb 2017 17:35:45 +0100
Subject: [LTP] [COMMITTED] [PATCH 1/6] tst_test: Allow using tst_res and
	tst_brk without initialized IPC
Message-ID: <20170213163550.10967-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If we try to print TINFO messages while the shared memory to store
results is not initialized we stop the test execution with TBROK.

But currently there is no way the results not to be allocated when test
code is executed since it's initialized before we call any of the test
functions.

The motivation for this change is that test library code that prints
messages (tst_device.c for instance) cannot be used without doing full
test initialization, which is unfortunate since I wanted to reuse the
code to create a helper binary for shell testcases.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 1518c7c..cbc3346 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -146,10 +146,8 @@ void tst_reinit(void)
 
 static void update_results(const char *file, unsigned int lineno, int ttype)
 {
-	if (!results) {
-		tst_brk(TBROK,
-		        "%s: %d: Results IPC not initialized!", file, lineno);
-	}
+	if (!results)
+		return;
 
 	switch (ttype) {
 	case TCONF:
-- 
2.10.2

