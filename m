From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 22 Feb 2021 17:02:40 +0100
Subject: [LTP] [PATCH 1/4] lib: Add support for linux stable and glibc tags
In-Reply-To: <20210222160243.507-1-pvorel@suse.cz>
References: <20210222160243.507-1-pvorel@suse.cz>
Message-ID: <20210222160243.507-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_test.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 6bbee030b..be6bf3e2a 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) Linux Test Project, 2016-2021
  */
 
 #include <limits.h>
@@ -38,6 +39,8 @@
 const char *TCID __attribute__((weak));
 
 #define LINUX_GIT_URL "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id="
+#define LINUX_STABLE_GIT_URL "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id="
+#define GLIBC_GIT_URL "https://sourceware.org/git/?p=glibc.git;a=commit;h="
 #define CVE_DB_URL "https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-"
 
 struct tst_test *tst_test;
@@ -492,6 +495,8 @@ static void print_test_tags(void)
 			printf(CVE_DB_URL "%s\n", tags[i].value);
 		else if (!strcmp(tags[i].name, "linux-git"))
 			printf(LINUX_GIT_URL "%s\n", tags[i].value);
+		else if (!strcmp(tags[i].name, "linux-stable-git"))
+			printf(LINUX_STABLE_GIT_URL "%s\n", tags[i].value);
 		else
 			printf("%s: %s\n", tags[i].name, tags[i].value);
 	}
@@ -671,44 +676,40 @@ static void print_colored(const char *str)
 		printf("%s", str);
 }
 
-static void print_failure_hints(void)
+static void print_failure_hint(const char *tag, const char *hint,
+			       const char *url)
 {
-	unsigned int i;
 	const struct tst_tag *tags = tst_test->tags;
 
 	if (!tags)
 		return;
 
+	unsigned int i;
 	int hint_printed = 0;
-	for (i = 0; tags[i].name; i++) {
-		if (!strcmp(tags[i].name, "linux-git")) {
-			if (!hint_printed) {
-				hint_printed = 1;
-				printf("\n");
-				print_colored("HINT: ");
-				printf("You _MAY_ be missing kernel fixes, see:\n\n");
-			}
 
-			printf(LINUX_GIT_URL "%s\n", tags[i].value);
-		}
-
-	}
-
-	hint_printed = 0;
 	for (i = 0; tags[i].name; i++) {
-		if (!strcmp(tags[i].name, "CVE")) {
+		if (!strcmp(tags[i].name, tag)) {
 			if (!hint_printed) {
 				hint_printed = 1;
 				printf("\n");
 				print_colored("HINT: ");
-				printf("You _MAY_ be vulnerable to CVE(s), see:\n\n");
+				printf("You _MAY_ be %s, see:\n\n", hint);
 			}
 
-			printf(CVE_DB_URL "%s\n", tags[i].value);
+			printf("%s%s\n", url, tags[i].value);
 		}
 	}
 }
 
+static void print_failure_hints(void)
+{
+	print_failure_hint("linux-git", "missing kernel fixes", LINUX_GIT_URL);
+	print_failure_hint("linux-stable-git", "missing stable kernel fixes",
+					   LINUX_STABLE_GIT_URL);
+	print_failure_hint("glibc-git", "missing glibc fixes", GLIBC_GIT_URL);
+	print_failure_hint("CVE", "vulnerable to CVE(s)", CVE_DB_URL);
+}
+
 static void do_exit(int ret)
 {
 	if (results) {
-- 
2.30.1

