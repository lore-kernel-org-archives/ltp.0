From: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
Date: Thu,  6 Oct 2016 14:08:38 +0200
Subject: [LTP] [PATCH 1/2] llistxattr: added a new testcase to llistxattr02
In-Reply-To: <1475755719-17762-1-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1475755719-17762-1-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <1475755719-17762-2-git-send-email-dejan.jovicevic@rt-rk.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Testcase that checks if the correct errno is set if the path_name
exceeds allowed length was added.

Signed-off-by: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
---
 testcases/kernel/syscalls/llistxattr/llistxattr02.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr02.c b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
index ec4ba6e..c1e8bd0 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr02.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
@@ -45,6 +45,9 @@
 #define VALUE	"test"
 #define VALUE_SIZE	4
 
+static int longpath_setup(void);
+char longpathname[PATH_MAX + 2];
+
 static struct test_case {
 	const char *path;
 	size_t size;
@@ -55,7 +58,9 @@ static struct test_case {
 	/* test2 */
 	{"", 20, ENOENT},
 	/* test3 */
-	{(char *)-1, 20, EFAULT}
+	{(char *)-1, 20, EFAULT},
+	/* test4 */
+	{longpathname, 20, ENAMETOOLONG}
 };
 
 static void verify_llistxattr(unsigned int n)
@@ -78,6 +83,16 @@ static void verify_llistxattr(unsigned int n)
 	}
 }
 
+int longpath_setup(void)
+{
+	int i;
+
+	for (i = 0; i < PATH_MAX + 2; i++)
+		longpathname[i] = 'a';
+
+	return 0;
+}
+
 static void setup(void)
 {
 	int n;
@@ -95,6 +110,7 @@ static void setup(void)
 			tst_brk(TBROK | TERRNO, "lsetxattr() failed");
 		}
 	}
+	longpath_setup();
 }
 
 static struct tst_test test = {
-- 
1.9.1

