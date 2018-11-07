From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  7 Nov 2018 15:22:09 +0100
Subject: [LTP] [RFC] [PATCH] lib: Add support for test tags
Message-ID: <20181107142209.8965-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is just proof of concept of moving some of the test metadata into
more structured form. If implemented it will move some information from
comments in the test source code to an array to the tst_test structure.

It's not finished and certainly not set into a stone, this patch is
mainly intended to start a discussion.

The newly introduced test tags are generic name-value pairs that can
hold test metadata, the intended use for now is to store kernel commit
hashes for kernel reproducers as well as CVE ids. The mechanism is
however choosen to be very generic so that it's easy to add basically
any information later on.

As it is the main purpose is to print hints for a test failures. If a
test that has been written as a kernel reproducer fails it prints nice
URL pointing to a kernel commit that may be missing.

Example output:

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

This commit also adds adds the -q test flag, that can be used to query
test information, which includes these tags, but is not limited to them.

The main inteded use for the query operation is to export test metadata
and constraints to the test execution system. The long term goal for
this would be parallel test execution as for this case the test runner
would need to know which global system resources is the test using to
avoid unexpected failures.

So far it exposes only if test needs root and if block device is needed
for the test, but I would expect that we will need a few more tags for
various resources, one that comes to my mind would be "test is using
SystemV SHM" for that we can do something as add a "constraint" tag with
value "SysV SHM" or anything else that would be fitting. Another would
be "Test is changing system wide clocks", etc.

So far the output from the query operation looks as:

sh$ ./add_key02 -q
{
 "root": false
 "blk_device": false
 "linux-git": "5649645d725c"
 "CVE": "2017-15274"
}

The format is meant to be machine-parseable, but it is certainly not
final as there are no consumers for the data yet.

Another nice feature of having this information in the test runner is
that we can include the URL pointing to a kernel git commit fixing the
issue even for kernel reproducers that crashed the kernel under test and
failed to write out any logs. Which is not that important I guess, but
still nice to have.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: automated-testing@yoctoproject.org
---
 include/tst_test.h                            | 10 +++
 lib/tst_test.c                                | 98 ++++++++++++++++++++++-----
 testcases/kernel/syscalls/add_key/add_key02.c |  7 ++
 3 files changed, 97 insertions(+), 18 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index 2ebf746eb..7af540854 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -110,6 +110,11 @@ int tst_parse_int(const char *str, int *val, int min, int max);
 int tst_parse_long(const char *str, long *val, long min, long max);
 int tst_parse_float(const char *str, float *val, float min, float max);
 
+struct tst_tag {
+	const char *name;
+	const char *value;
+};
+
 struct tst_test {
 	/* number of tests available in test() function */
 	unsigned int tcnt;
@@ -182,6 +187,11 @@ struct tst_test {
 	 * before setup and restore after cleanup
 	 */
 	const char * const *save_restore;
+
+	/*
+	 * {NULL, NULL} terminated array of tags.
+	 */
+	const struct tst_tag *tags;
 };
 
 /*
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 661fbbfce..976f67135 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -406,6 +406,7 @@ static struct option {
 	{"h",  "-h       Prints this help"},
 	{"i:", "-i n     Execute test n times"},
 	{"I:", "-I x     Execute test for n seconds"},
+	{"q", "-q        Queries test information"},
 	{"C:", "-C ARG   Run child process with ARG arguments (used internally)"},
 };
 
@@ -423,6 +424,25 @@ static void print_help(void)
 		fprintf(stderr, "%s\n", tst_test->options[i].help);
 }
 
+static void print_test_info(void)
+{
+	unsigned int i;
+	const struct tst_tag *tags = tst_test->tags;
+	int needs_device = tst_test->needs_device || tst_test->needs_rofs;
+
+	printf("{\n");
+
+	printf(" \"root\": %s\n", tst_test->needs_root ? "true" : "false");
+	printf(" \"blk_device\": %s\n", needs_device ? "true" : "false");
+
+	if (tags) {
+		for (i = 0; tags[i].name; i++)
+			printf(" \"%s\": \"%s\"\n", tags[i].name, tags[i].value);
+	}
+
+	printf("}\n");
+}
+
 static void check_option_collision(void)
 {
 	unsigned int i, j;
@@ -505,6 +525,10 @@ static void parse_opts(int argc, char *argv[])
 		case 'I':
 			duration = atof(optarg);
 		break;
+		case 'q':
+			print_test_info();
+			exit(0);
+		break;
 		case 'C':
 #ifdef UCLINUX
 			child_args = optarg;
@@ -583,26 +607,64 @@ int tst_parse_float(const char *str, float *val, float min, float max)
 	return 0;
 }
 
+#define LINUX_GIT_URL "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id="
+#define CVE_DB_URL "https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-"
+
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
@@ -777,6 +839,17 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->sample)
 		tst_test = tst_timer_test_setup(tst_test);
 
+	if (tst_test->format_device)
+		tst_test->needs_device = 1;
+
+	if (tst_test->mount_device) {
+		tst_test->needs_device = 1;
+		tst_test->format_device = 1;
+	}
+
+	if (tst_test->all_filesystems)
+		tst_test->needs_device = 1;
+
 	parse_opts(argc, argv);
 
 	if (tst_test->needs_root && geteuid() != 0)
@@ -794,17 +867,6 @@ static void do_setup(int argc, char *argv[])
 				tst_brk(TCONF, "%s driver not available", name);
 	}
 
-	if (tst_test->format_device)
-		tst_test->needs_device = 1;
-
-	if (tst_test->mount_device) {
-		tst_test->needs_device = 1;
-		tst_test->format_device = 1;
-	}
-
-	if (tst_test->all_filesystems)
-		tst_test->needs_device = 1;
-
 	setup_ipc();
 
 	if (needs_tmpdir() && !tst_tmpdir_created())
diff --git a/testcases/kernel/syscalls/add_key/add_key02.c b/testcases/kernel/syscalls/add_key/add_key02.c
index 6d19ff2d8..9e23d9eb5 100644
--- a/testcases/kernel/syscalls/add_key/add_key02.c
+++ b/testcases/kernel/syscalls/add_key/add_key02.c
@@ -70,6 +70,8 @@ static void verify_add_key(unsigned int i)
 		return;
 	}
 
+	TST_ERR = EINVAL;
+
 	if (TST_ERR == EFAULT) {
 		tst_res(TPASS, "received expected EFAULT with key type '%s'",
 			tcases[i].type);
@@ -99,4 +101,9 @@ static void verify_add_key(unsigned int i)
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_add_key,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "5649645d725c"},
+		{"CVE", "2017-15274"},
+		{NULL, NULL}
+	}
 };
-- 
2.16.4

