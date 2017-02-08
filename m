From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  8 Feb 2017 12:02:50 +0100
Subject: [LTP] [PATCH 1/6] tst_test: Allow priting TINFO without initialized
	IPC
Message-ID: <20170208110255.443-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If we try to print TINFO messages while the shared memory to store
results is not initialized we stop the test execution with TBROK.

But we do not store anything on TINFO hence it does not make much sense
to exit at this point.

The motivation for this change is that test library code that prints
messages with TINFO (tst_device.c for instance) cannot be used without
doing full test initialization, which is unfortunate since I wanted to
reuse the code to create a helper binary for shell testcases.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index e78b412..b8d10ee 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -146,6 +146,9 @@ void tst_reinit(void)
 
 static void update_results(const char *file, unsigned int lineno, int ttype)
 {
+	if (ttype == TINFO)
+		return;
+
 	if (!results) {
 		tst_brk(TBROK,
 		        "%s: %d: Results IPC not initialized!", file, lineno);
-- 
2.10.2

