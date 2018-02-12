From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Feb 2018 16:46:43 +0100
Subject: [LTP] [COMMITTED] [PATCH] tst_rod: Fix error propagation on
	'command not found'
Message-ID: <20180212154643.26844-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In a case that we try to execute nonexistent command we end up with
'command not found' in the test logs but the error is actually ignored.
That is because the pclose() returns the value as returned by wait() so
some of the upper bits are cleared on return from the main().

Since we are not actually using the return value for anything, we only
do tst_brk if it's non-zero we may as well normalize it with double
negation, which is what this patch does.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/lib/tst_rod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_rod.c b/testcases/lib/tst_rod.c
index ce936258e..8d436fc22 100644
--- a/testcases/lib/tst_rod.c
+++ b/testcases/lib/tst_rod.c
@@ -162,5 +162,5 @@ int main(int argc, char *argv[])
 	for (i = 0; args[i]; i++)
 		fprintf(sin, "%s ", args[i]);
 
-	return pclose(sin);
+	return !!pclose(sin);
 }
-- 
2.13.6

