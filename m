From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  4 Aug 2021 11:24:05 +0200
Subject: [LTP] [PATCH v8 0/7] Run tests in CI
Message-ID: <20210804092407.16015-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

* print more items in lib into stderr (Cyril, 1st commit)
* check for readonly fs instead TCONF on any error during writing to
/proc/sys/vm/nr_hugepages (Cyril, 2nd commit)

NOTE: sending just these 2 patches which are different

Tested:
https://github.com/pevik/ltp/actions/runs/1097004804

Diff to v7

diff --git lib/newlib_tests/test_zero_hugepage.sh lib/newlib_tests/test_zero_hugepage.sh
index 8a462478e..d270e686c 100755
--- lib/newlib_tests/test_zero_hugepage.sh
+++ lib/newlib_tests/test_zero_hugepage.sh
@@ -7,11 +7,13 @@ echo "Testing .request_hugepages = TST_NO_HUGEPAGES"
 
 orig_value=`cat /proc/sys/vm/nr_hugepages`
 
-if ! echo "128" > /proc/sys/vm/nr_hugepages; then
-	echo "TCONF: failed to open /proc/sys/vm/nr_hugepages"
+if grep -q -E '^proc /proc(/sys)? proc ro' /proc/mounts; then
+	echo "TCONF: /proc or /proc/sys mounted as read-only"
 	exit 32
 fi
 
+echo "128" > /proc/sys/vm/nr_hugepages
+
 ./test_zero_hugepage
 
 echo $orig_value > /proc/sys/vm/nr_hugepages
diff --git lib/tst_test.c lib/tst_test.c
index d15c8c054..8a6a112ef 100644
--- lib/tst_test.c
+++ lib/tst_test.c
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

Petr Vorel (7):
  lib: Print everything to stderr
  test/test_zero_hugepage.sh: Skip test on read-only /proc
  lib: Add script for running tests
  make: Add make test{, -c, -shell} targets
  build.sh: Add support for make test{,-c,-shell}
  CI: Run also make test-c, test-shell
  ci: Install iproute2

 .github/workflows/ci.yml               |  10 ++
 Makefile                               |  23 +++
 build.sh                               |  24 +++-
 ci/debian.sh                           |   1 +
 ci/fedora.sh                           |   1 +
 ci/tumbleweed.sh                       |   1 +
 lib/newlib_tests/runtest.sh            | 190 +++++++++++++++++++++++++
 lib/newlib_tests/test_zero_hugepage.sh |   6 +
 lib/tst_test.c                         |  38 ++---
 9 files changed, 274 insertions(+), 20 deletions(-)
 create mode 100755 lib/newlib_tests/runtest.sh

-- 
2.32.0

