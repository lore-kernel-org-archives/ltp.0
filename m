From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 14 Oct 2019 13:25:21 +0200
Subject: [LTP] [PATCH 1/2] lib: Add support for test tags
In-Reply-To: <20191014112522.24548-1-chrubis@suse.cz>
References: <20191014112522.24548-1-chrubis@suse.cz>
Message-ID: <20191014112522.24548-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The newly introduced test tags are generic name-value pairs that can
hold test metadata, the intended use for now is to store kernel commit
hashes for kernel reproducers as well as CVE ids. The mechanism is
however choosen to be very generic so that it's easy to add basically
any information later on.

As it is the main purpose is to print hints for a test failures. If a
test that has been written as a kernel reproducer fails it prints nice
URL pointing to a kernel commit that may be missing.

Example output:

--------------------------------------------------------------------------
tst_test.c:1145: INFO: Timeout per run is 0h 05m 00s
add_key02.c:98: FAIL: unexpected error with key type 'asymmetric': EINVAL
add_key02.c:98: FAIL: unexpected error with key type 'cifs.idmap': EINVAL
add_key02.c:98: FAIL: unexpected error with key type 'cifs.spnego': EINVAL
add_key02.c:98: FAIL: unexpected error with key type 'pkcs7_test': EINVAL
add_key02.c:98: FAIL: unexpected error with key type 'rxrpc': EINVAL
add_key02.c:98: FAIL: unexpected error with key type 'rxrpc_s': EINVAL
add_key02.c:98: FAIL: unexpected error with key type 'user': EINVAL
add_key02.c:98: FAIL: unexpected error with key type 'logon': EINVAL

HINT: This is a regression test for linux kernel, see commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5649645d725c

HINT: This test also tests for CVE-2017-15274, see:

https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-15274

Summary:
passed   0
failed   8
skipped  0
warnings 0
--------------------------------------------------------------------------

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test.h | 10 ++++++
 lib/tst_test.c     | 77 +++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index 84acf2c59..4a51b6d16 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -108,6 +108,11 @@ int tst_parse_int(const char *str, int *val, int min, int max);
 int tst_parse_long(const char *str, long *val, long min, long max);
 int tst_parse_float(const char *str, float *val, float min, float max);
 
+struct tst_tag {
+	const char *name;
+	const char *value;
+};
+
 extern unsigned int tst_variant;
 
 struct tst_test {
@@ -212,6 +217,11 @@ struct tst_test {
 	 * NULL-terminated array of capability settings
 	 */
 	struct tst_cap *caps;
+
+	/*
+	 * {NULL, NULL} terminated array of tags.
+	 */
+	const struct tst_tag *tags;
 };
 
 /*
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 6239acf89..2129f38cb 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -31,6 +31,9 @@
 #include "old_device.h"
 #include "old_tmpdir.h"
 
+#define LINUX_GIT_URL "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id="
+#define CVE_DB_URL "https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-"
+
 struct tst_test *tst_test;
 
 static const char *tid;
@@ -414,6 +417,9 @@ static void print_help(void)
 {
 	unsigned int i;
 
+	fprintf(stderr, "Options\n");
+	fprintf(stderr, "-------\n\n");
+
 	for (i = 0; i < ARRAY_SIZE(options); i++)
 		fprintf(stderr, "%s\n", options[i].help);
 
@@ -424,6 +430,27 @@ static void print_help(void)
 		fprintf(stderr, "%s\n", tst_test->options[i].help);
 }
 
+static void print_test_info(void)
+{
+	unsigned int i;
+	const struct tst_tag *tags = tst_test->tags;
+
+	printf("\nTags\n");
+	printf("----\n\n");
+
+	if (tags) {
+		for (i = 0; tags[i].name; i++) {
+			if (!strcmp(tags[i].name, "CVE"))
+				printf(CVE_DB_URL "%s\n", tags[i].value);
+			else if (!strcmp(tags[i].name, "linux-git"))
+				printf(LINUX_GIT_URL "%s\n", tags[i].value);
+			else
+				printf("%s: %s\n", tags[i].name, tags[i].value);
+			printf("\n");
+		}
+	}
+}
+
 static void check_option_collision(void)
 {
 	unsigned int i, j;
@@ -499,6 +526,7 @@ static void parse_opts(int argc, char *argv[])
 		break;
 		case 'h':
 			print_help();
+			print_test_info();
 			exit(0);
 		case 'i':
 			iterations = atoi(optarg);
@@ -584,26 +612,61 @@ int tst_parse_float(const char *str, float *val, float min, float max)
 	return 0;
 }
 
+static void print_colored(const char *str)
+{
+	if (tst_color_enabled(STDOUT_FILENO))
+		printf("%s%s%s", ANSI_COLOR_YELLOW, str, ANSI_COLOR_RESET);
+	else
+		printf("%s", str);
+}
+
+static void print_failure_hints(void)
+{
+	unsigned int i;
+	const struct tst_tag *tags = tst_test->tags;
+
+	if (!tags)
+		return;
+
+	for (i = 0; tags[i].name; i++) {
+		if (!strcmp(tags[i].name, "linux-git")) {
+			printf("\n");
+			print_colored("HINT: ");
+			printf("This is a regression test for linux kernel, see commit:\n\n"
+			       LINUX_GIT_URL "%s\n", tags[i].value);
+		}
+
+		if (!strcmp(tags[i].name, "CVE")) {
+			printf("\n");
+			print_colored("HINT: ");
+			printf("This test also tests for CVE-%s, see:\n\n"
+			       CVE_DB_URL "%s\n", tags[i].value, tags[i].value);
+		}
+	}
+}
+
 static void do_exit(int ret)
 {
 	if (results) {
-		printf("\nSummary:\n");
-		printf("passed   %d\n", results->passed);
-		printf("failed   %d\n", results->failed);
-		printf("skipped  %d\n", results->skipped);
-		printf("warnings %d\n", results->warnings);
-
 		if (results->passed && ret == TCONF)
 			ret = 0;
 
-		if (results->failed)
+		if (results->failed) {
 			ret |= TFAIL;
+			print_failure_hints();
+		}
 
 		if (results->skipped && !results->passed)
 			ret |= TCONF;
 
 		if (results->warnings)
 			ret |= TWARN;
+
+		printf("\nSummary:\n");
+		printf("passed   %d\n", results->passed);
+		printf("failed   %d\n", results->failed);
+		printf("skipped  %d\n", results->skipped);
+		printf("warnings %d\n", results->warnings);
 	}
 
 	do_cleanup();
-- 
2.21.0

