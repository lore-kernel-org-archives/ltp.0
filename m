From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 19 Jun 2019 15:47:07 +0300
Subject: [LTP] [PATCH] syscalls/getxattr05: skip userns test cases when not
	supported
Message-ID: <20190619124707.2981-1-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These test cases are failing when CONFIG_USER_NS is not defined.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/getxattr/getxattr05.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/getxattr/getxattr05.c b/testcases/kernel/syscalls/getxattr/getxattr05.c
index 31b985ee0..c0d339f29 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr05.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr05.c
@@ -37,11 +37,13 @@
 #if defined(HAVE_SYS_XATTR_H) && defined(HAVE_LIBACL)
 
 #define TEST_FILE	"testfile"
+#define SELF_USERNS	"/proc/self/ns/user"
 #define MAX_USERNS	"/proc/sys/user/max_user_namespaces"
 #define UID_MAP	"/proc/self/uid_map"
 
 static acl_t acl;
 static int orig_max_userns = -1;
+static int user_ns_supported = 1;
 
 static struct tcase {
 	/* 0: without userns, 1: with userns */
@@ -110,6 +112,11 @@ static void do_getxattr(unsigned int n)
 	struct tcase *tc = &tcases[n];
 	pid_t pid;
 
+	if (tc->set_userns && !user_ns_supported) {
+		tst_res(TCONF, "user namespace not available");
+		return;
+	}
+
 	pid = SAFE_FORK();
 	if (!pid) {
 		if (tc->set_userns)
@@ -144,10 +151,13 @@ static void setup(void)
 	/* The default value of max_user_namespaces is set to 0 on some distros,
 	 * We need to change the default value to call unshare().
 	 */
-	if (!access(MAX_USERNS, F_OK)) {
+	if (access(SELF_USERNS, F_OK) != 0) {
+		user_ns_supported = 0;
+	} else if (!access(MAX_USERNS, F_OK)) {
 		SAFE_FILE_SCANF(MAX_USERNS, "%d", &orig_max_userns);
 		SAFE_FILE_PRINTF(MAX_USERNS, "%d", 10);
 	}
+
 }
 
 static void cleanup(void)
-- 
2.17.1

