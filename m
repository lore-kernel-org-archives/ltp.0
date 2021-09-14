From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Sep 2021 12:01:58 +0200
Subject: [LTP] [PATCH] scripts/checkpatch.pl: Ignore TST_* in constant checks
Message-ID: <20210914100158.744-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The checkpatch.pl thinks that TST_RET etc are constants because it
treats everything that is uppercase as a constant and hence complains at
following code:

	if (TST_RET != tc->exp_errno)
		tst_res(TFAIL, "...");

In this case both sides of the comparsion are variables and the code
is as it should be.

So this commit disables the check for 'yoda comparsion' for constants if
the identifier on the left starts with TST_.

Reported-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 scripts/checkpatch.pl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 88cb294dc..87572b2f4 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5462,7 +5462,9 @@ sub process {
 			my $comp = $3;
 			my $to = $4;
 			my $newcomp = $comp;
-			if ($lead !~ /(?:$Operators|\.)\s*$/ &&
+
+			if ($const !~ /^\QTST_/ &&
+			    $lead !~ /(?:$Operators|\.)\s*$/ &&
 			    $to !~ /^(?:Constant|[A-Z_][A-Z0-9_]*)$/ &&
 			    WARN("CONSTANT_COMPARISON",
 				 "Comparisons should place the constant on the right side of the test\n" . $herecurr) &&
-- 
2.32.0

