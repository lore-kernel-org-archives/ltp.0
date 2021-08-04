From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  4 Aug 2021 11:24:06 +0200
Subject: [LTP] [PATCH v8 1/7] lib: Print everything to stderr
In-Reply-To: <20210804092407.16015-1-pvorel@suse.cz>
References: <20210804092407.16015-1-pvorel@suse.cz>
Message-ID: <20210804092407.16015-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ie.e hint, tags, summary to unify the behavior with tst_{brk,res}()
which printed into stderr from the beginning.

Initial motivation was issue in GitHub Actions, where stdout and stderr
are probably block buffered and flushed at different times. The result
was mangled summary into other test output.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v7->v8:
* print more items in lib into stderr (Cyril)

 lib/tst_test.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index c7c77596c..8a6a112ef 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -488,23 +488,23 @@ static void print_test_tags(void)
 	if (!tags)
 		return;
 
-	printf("\nTags\n");
-	printf("----\n");
+	fprintf(stderr, "\nTags\n");
+	fprintf(stderr, "----\n");
 
 	for (i = 0; tags[i].name; i++) {
 		if (!strcmp(tags[i].name, "CVE"))
-			printf(CVE_DB_URL "%s\n", tags[i].value);
+			fprintf(stderr, CVE_DB_URL "%s\n", tags[i].value);
 		else if (!strcmp(tags[i].name, "linux-git"))
-			printf(LINUX_GIT_URL "%s\n", tags[i].value);
+			fprintf(stderr, LINUX_GIT_URL "%s\n", tags[i].value);
 		else if (!strcmp(tags[i].name, "linux-stable-git"))
-			printf(LINUX_STABLE_GIT_URL "%s\n", tags[i].value);
+			fprintf(stderr, LINUX_STABLE_GIT_URL "%s\n", tags[i].value);
 		else if (!strcmp(tags[i].name, "glibc-git"))
-			printf(GLIBC_GIT_URL "%s\n", tags[i].value);
+			fprintf(stderr, GLIBC_GIT_URL "%s\n", tags[i].value);
 		else
-			printf("%s: %s\n", tags[i].name, tags[i].value);
+			fprintf(stderr, "%s: %s\n", tags[i].name, tags[i].value);
 	}
 
-	printf("\n");
+	fprintf(stderr, "\n");
 }
 
 static void check_option_collision(void)
@@ -674,9 +674,9 @@ int tst_parse_float(const char *str, float *val, float min, float max)
 static void print_colored(const char *str)
 {
 	if (tst_color_enabled(STDOUT_FILENO))
-		printf("%s%s%s", ANSI_COLOR_YELLOW, str, ANSI_COLOR_RESET);
+		fprintf(stderr, "%s%s%s", ANSI_COLOR_YELLOW, str, ANSI_COLOR_RESET);
 	else
-		printf("%s", str);
+		fprintf(stderr, "%s", str);
 }
 
 static void print_failure_hint(const char *tag, const char *hint,
@@ -694,12 +694,12 @@ static void print_failure_hint(const char *tag, const char *hint,
 		if (!strcmp(tags[i].name, tag)) {
 			if (!hint_printed) {
 				hint_printed = 1;
-				printf("\n");
+				fprintf(stderr, "\n");
 				print_colored("HINT: ");
-				printf("You _MAY_ be %s, see:\n\n", hint);
+				fprintf(stderr, "You _MAY_ be %s, see:\n\n", hint);
 			}
 
-			printf("%s%s\n", url, tags[i].value);
+			fprintf(stderr, "%s%s\n", url, tags[i].value);
 		}
 	}
 }
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

