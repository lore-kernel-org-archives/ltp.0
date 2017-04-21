From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 21 Apr 2017 17:52:44 +0200
Subject: [LTP] [RFC] [PATCH] tst_kvcmp: Add support for extra kernel versions
Message-ID: <20170421155244.29773-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds support for extra kernel versions to the tst_kvcmp shell
helper.

Now we can append the extra version(s) after the generic kernel version
in the expression. For example to check for older kernel than
3.0 or in case of RHEL6 older than 2.6.32 we do:

tst_kvcmp -lt '3.0 RHEL6:2.6.32'

This commit also reduces the number of uname() syscalls needed to
acquire the result as a side efect.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Jan Stancek <jstancek@redhat.com>
---

Jan can you please check that everything works fine when specifying extra
version on RHEL? It seems that the only systems that are supported by extra
kernel versions are RHEL5 and RHEL6 at the moment.

 include/tst_kvercmp.h     | 20 ++++++++++++++---
 lib/tst_kvercmp.c         | 54 ++++++++++++++++++++++++++++----------------
 testcases/lib/tst_kvcmp.c | 57 +++++++++++++++++++++++++++++++++++++----------
 3 files changed, 97 insertions(+), 34 deletions(-)

diff --git a/include/tst_kvercmp.h b/include/tst_kvercmp.h
index 6b0414a..1349976 100644
--- a/include/tst_kvercmp.h
+++ b/include/tst_kvercmp.h
@@ -35,13 +35,27 @@
 #define TST_KVERCMP_H__
 
 /*
- * Parse string kernel version into three integers.
- *
- * If version has only two numbers, i.e. 2.4 the third integer is set to zero.
+ * The same as tst_kvercmp() but running kernel version is passed as parameter
+ * instead of utilizing uname().
+ */
+int tst_kvcmp(const char *cur_kver, int r1, int r2, int r3);
+
+/*
+ * Parsers string into three integer version.
  */
 int tst_parse_kver(const char *str_kver, int *v1, int *v2, int *v3);
 
 /*
+ * Returns distribution name parsed from kernel version string or NULL.
+ */
+const char *tst_kvcmp_distname(const char *cur_kver);
+
+/*
+ * Compares versions up to five version numbers long.
+ */
+int tst_kvexcmp(const char *tst_exv, const char *cur_kver);
+
+/*
  * Compare given kernel version with currently running kernel.
  *
  * Returns negative if older, 0 if the smame and possitive if newer.
diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
index c497f5d..dc3bb66 100644
--- a/lib/tst_kvercmp.c
+++ b/lib/tst_kvercmp.c
@@ -78,17 +78,15 @@ int tst_parse_kver(const char *str_kver, int *v1, int *v2, int *v3)
 	return 0;
 }
 
-int tst_kvercmp(int r1, int r2, int r3)
+int tst_kvcmp(const char *cur_kver, int r1, int r2, int r3)
 {
 	int a1, a2, a3;
 	int testver, currver;
-	struct utsname uval;
 
-	uname(&uval);
-	if (tst_parse_kver(uval.release, &a1, &a2, &a3)) {
+	if (tst_parse_kver(cur_kver, &a1, &a2, &a3)) {
 		tst_resm(TWARN,
 			 "Invalid kernel version %s, expected %%d.%%d.%%d",
-		         uval.release);
+		         cur_kver);
 	}
 
 	testver = (r1 << 16) + (r2 << 8) + r3;
@@ -97,7 +95,16 @@ int tst_kvercmp(int r1, int r2, int r3)
 	return currver - testver;
 }
 
-static int tst_kexvcmp(char *tst_exv, char *cur_ver)
+int tst_kvercmp(int r1, int r2, int r3)
+{
+	struct utsname uval;
+
+	uname(&uval);
+
+	return tst_kvcmp(uval.release, r1, r2, r3);
+}
+
+int tst_kvexcmp(const char *tst_exv, const char *cur_ver)
 {
 	int c1 = 0, c2 = 0, c3 = 0, c4 = 0, c5 = 0;
 	int t1 = 0, t2 = 0, t3 = 0, t4 = 0, t5 = 0;
@@ -118,24 +125,33 @@ static int tst_kexvcmp(char *tst_exv, char *cur_ver)
 	return c5 - t5;
 }
 
+const char *tst_kvcmp_distname(const char *kver)
+{
+	if (strstr(kver, ".el5uek"))
+		return "OL5UEK";
+
+	if (strstr(kver, ".el5"))
+		return "RHEL5";
+
+	if (strstr(kver, ".el6uek"))
+		return "OL6UEK";
+
+	if (strstr(kver, ".el6"))
+		return "RHEL6";
+
+	return NULL;
+}
+
 int tst_kvercmp2(int r1, int r2, int r3, struct tst_kern_exv *vers)
 {
 	int i;
+	const char *kver;
 	struct utsname uval;
-	char *kver;
-	const char *cur_dist_name = NULL;
+	const char *cur_dist_name;
 
 	uname(&uval);
 	kver = uval.release;
-	if (strstr(kver, ".el5uek")) {
-		cur_dist_name = "OL5UEK";
-	} else if (strstr(kver, ".el5")) {
-		cur_dist_name = "RHEL5";
-	} else if (strstr(kver, ".el6uek")) {
-		cur_dist_name = "OL6UEK";
-	} else if (strstr(kver, ".el6")) {
-		cur_dist_name = "RHEL6";
-	}
+	cur_dist_name = tst_kvcmp_distname(kver);
 
 	if (cur_dist_name == NULL)
 		return tst_kvercmp(r1, r2, r3);
@@ -144,9 +160,9 @@ int tst_kvercmp2(int r1, int r2, int r3, struct tst_kern_exv *vers)
 		if (!strcmp(vers[i].dist_name, cur_dist_name)) {
 			tst_resm(TINFO, "Detected %s using kernel version %s",
 				 cur_dist_name, kver);
-			return tst_kexvcmp(vers[i].extra_ver, kver);
+			return tst_kvexcmp(vers[i].extra_ver, kver);
 		}
 	}
 
-	return tst_kvercmp(r1, r2, r3);
+	return tst_kvcmp(kver, r1, r2, r3);
 }
diff --git a/testcases/lib/tst_kvcmp.c b/testcases/lib/tst_kvcmp.c
index fbae901..06632a2 100644
--- a/testcases/lib/tst_kvcmp.c
+++ b/testcases/lib/tst_kvcmp.c
@@ -19,6 +19,7 @@
 #define TST_NO_DEFAULT_MAIN
 #include <stdio.h>
 #include <stdlib.h>
+#include <sys/utsname.h>
 #include <tst_test.h>
 
 enum op {
@@ -73,25 +74,64 @@ static void help(const char *fname)
 	printf("-le kver\tReturns true if kernel version is lesser or equal\n");
 	printf("-a  \t\tDoes logical and between two expressions\n");
 	printf("-o  \t\tDoes logical or between two expressions\n\n");
-	printf("Kernel version format has either one or two dots: ");
-	printf("'2.6' or '4.8.1'\n");
+	printf("Kernel version format has either one or two dots:\n\n");
+	printf("'2.6' or '4.8.1'\n\n");
+	printf("Kernel version can also be followed by a space separated list\n");
+	printf("of extra versions prefixed by distribution which when matched\n");
+	printf("take precedence:\n\n'3.0 RHEL6:2.6.18'\n\n");
+}
+
+static int compare_kver(const char *cur_kver, char *kver)
+{
+	const char *ver, *exver;
+	const char *distname = tst_kvcmp_distname(cur_kver);
+	int v1, v2, v3;
+
+	ver = strtok(kver, " ");
+
+	while ((exver = strtok(NULL, " "))) {
+		char *exkver = strchr(exver, ':');
+
+		if (!exkver) {
+			fprintf(stderr, "Invalid extra version '%s'\n", exver);
+			exit(2);
+		}
+
+		*(exkver++) = '\0';
+
+		if (!distname || strcmp(distname, exver))
+			continue;
+
+		return tst_kvexcmp(exkver, cur_kver);
+	}
+
+	if (tst_parse_kver(ver, &v1, &v2, &v3)) {
+		fprintf(stderr,
+			"Invalid kernel version '%s'\n",
+			ver);
+		return 2;
+	}
+
+	return tst_kvcmp(cur_kver, v1, v2, v3);
 }
 
 int main(int argc, char *argv[])
 {
 	int i = 1;
 	int ret = -1;
-	int v1, v2, v3;
 	enum op prev_op = ERR;
+	struct utsname buf;
 
 	if (argc <= 1 || !strcmp(argv[1], "-h")) {
 		help(argv[0]);
 		return 0;
 	}
 
+	uname(&buf);
+
 	while (i < argc) {
 		const char *strop = argv[i++];
-		const char *strkver;
+		char *strkver;
 		int res;
 
 		enum op op = strtop(strop);
@@ -116,13 +156,6 @@ int main(int argc, char *argv[])
 			}
 
 			strkver = argv[i++];
-
-			if (tst_parse_kver(strkver, &v1, &v2, &v3)) {
-				fprintf(stderr,
-					"Invalid kernel version '%s'\n",
-					strkver);
-				return 2;
-			}
 		break;
 		case AND:
 		case OR:
@@ -140,7 +173,7 @@ int main(int argc, char *argv[])
 			return 2;
 		}
 
-		res = tst_kvercmp(v1, v2, v3);
+		res = compare_kver(buf.release, strkver);
 
 		switch (op) {
 		case EQ:
-- 
2.10.2

