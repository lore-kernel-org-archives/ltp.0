From: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
Date: Wed,  2 Nov 2016 11:59:50 +0100
Subject: [LTP]  [PATCH v3 4/5] llistxattr: new testcase for long path name
In-Reply-To: <1478084391-30192-1-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1478084391-30192-1-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <1478084391-30192-5-git-send-email-dejan.jovicevic@rt-rk.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Added a test case that checks if the path name, given by the
first argument of the function, is too long. If that is the
case, the function should return -1 and errno should be set
to ENAMETOOLONG.

Signed-off-by: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
---
 testcases/kernel/syscalls/llistxattr/llistxattr02.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr02.c b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
index 191ec36..04d8c97 100644
--- a/testcases/kernel/syscalls/llistxattr/llistxattr02.c
+++ b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
@@ -22,11 +22,13 @@
 * to hold the result.
 * 2) llistxattr(2) fails if path is an empty string.
 * 3) llistxattr(2) fails when attempted to read from a invalid address.
+* 4) llistxattr(2) fails if path is longer than allowed.
 *
 * Expected Result:
 * 1) llistxattr(2) should return -1 and set errno to ERANGE.
 * 2) llistxattr(2) should return -1 and set errno to ENOENT.
 * 3) llistxattr(2) should return -1 and set errno to EFAULT.
+* 4) llistxattr(2) should return -1 and set errno to ENAMETOOLONG.
 */
 
 #include "config.h"
@@ -47,6 +49,8 @@
 #define TESTFILE   "testfile"
 #define SYMLINK    "symlink"
 
+char longpathname[PATH_MAX + 2];
+
 static struct test_case {
 	const char *path;
 	size_t size;
@@ -54,7 +58,8 @@ static struct test_case {
 } tc[] = {
 	{SYMLINK, 1, ERANGE},
 	{"", 20, ENOENT},
-	{(char *)-1, 20, EFAULT}
+	{(char *)-1, 20, EFAULT},
+	{longpathname, 20, ENAMETOOLONG}
 };
 
 static void verify_llistxattr(unsigned int n)
@@ -85,6 +90,8 @@ static void setup(void)
 	SAFE_SYMLINK(TESTFILE, SYMLINK);
 
 	SAFE_LSETXATTR(SYMLINK, SECURITY_KEY, VALUE, VALUE_SIZE, XATTR_CREATE);
+
+	memset(&longpathname, 'a', sizeof(longpathname) - 1);
 }
 
 static struct tst_test test = {
-- 
1.9.1

