From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Feb 2017 10:28:53 +0100
Subject: [LTP] [COMMITTED] [PATCH 2/3] tst_test: Fix unused variable warnings
In-Reply-To: <20170214092854.26536-1-chrubis@suse.cz>
References: <20170214092854.26536-1-chrubis@suse.cz>
Message-ID: <20170214092854.26536-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I've forgotten to remove file and line parameters passed to
update_results() in:

commit d97debf386c327285a09fb4794f313d330d823cc
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Mon Feb 13 12:37:39 2017 +0100

tst_test: Allow using tst_res and tst_brk without initialized IPC

Sorry everyone.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index cbc3346..8e24a94 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -144,7 +144,7 @@ void tst_reinit(void)
 	SAFE_CLOSE(fd);
 }
 
-static void update_results(const char *file, unsigned int lineno, int ttype)
+static void update_results(int ttype)
 {
 	if (!results)
 		return;
@@ -235,7 +235,7 @@ void tst_vres_(const char *file, const int lineno, int ttype,
 {
 	print_result(file, lineno, ttype, fmt, va);
 
-	update_results(file, lineno, TTYPE_RESULT(ttype));
+	update_results(TTYPE_RESULT(ttype));
 }
 
 void tst_vbrk_(const char *file, const int lineno, int ttype,
-- 
2.10.2

