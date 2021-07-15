From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 15 Jul 2021 10:30:48 +0200
Subject: [LTP] [PATCH v6 1/5] lib: Print Summary: into stderr
In-Reply-To: <20210715083052.7138-1-pvorel@suse.cz>
References: <20210715083052.7138-1-pvorel@suse.cz>
Message-ID: <20210715083052.7138-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to follow tst_{brk,res}() being printed to stderr.

Found with GitHub actions where stdout and stderr are probably
block buffered and flushed at different times.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
* new in v6

 lib/tst_test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index f4d9f8e3b..084a83c9e 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -734,12 +734,12 @@ static void do_exit(int ret)
 		if (results->broken)
 			ret |= TBROK;
 
-		printf("\nSummary:\n");
-		printf("passed   %d\n", results->passed);
-		printf("failed   %d\n", results->failed);
-		printf("broken   %d\n", results->broken);
-		printf("skipped  %d\n", results->skipped);
-		printf("warnings %d\n", results->warnings);
+		fprintf(stderr, "\nSummary:\n");
+		fprintf(stderr, "passed   %d\n", results->passed);
+		fprintf(stderr, "failed   %d\n", results->failed);
+		fprintf(stderr, "broken   %d\n", results->broken);
+		fprintf(stderr, "skipped  %d\n", results->skipped);
+		fprintf(stderr, "warnings %d\n", results->warnings);
 	}
 
 	do_cleanup();
-- 
2.32.0

