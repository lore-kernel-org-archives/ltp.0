From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Jan 2018 15:58:46 +0100
Subject: [LTP] [PATCH] tst_test: Fix exit value on tst_brk(TCONF, ...)
Message-ID: <20180117145846.21303-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We decided not to propagate TCONF into the test exit value in a case
that the test had at least one TPASS in:

commit 5390d6ea36578c1fac8adc416b6f91aa4a330a08
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Thu Sep 7 15:47:22 2017 +0200

    lib/tst_test: Report 0 if test has both TPASS and TCONF

However this commit missed a case when TCONF is passed directly to the
do_exit() function. This may happen in two cases actually, one of the is
tst_brk(TCONF, ...) called from a test and second one is more subtle and
happens when the last result in the run_tcases_per_fs() produces TCONF
which is then propagated to the do_exit() function.

This commit simply mask the TCONF from the exit value in this cases if
we happen to have non-zero success counter.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index e7b9cddf1..1df4b72df 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -580,6 +580,9 @@ static void do_exit(int ret)
 		printf("skipped  %d\n", results->skipped);
 		printf("warnings %d\n", results->warnings);
 
+		if (results->passed && ret == TCONF)
+			ret = 0;
+
 		if (results->failed)
 			ret |= TFAIL;
 
-- 
2.13.6

