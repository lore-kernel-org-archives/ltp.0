From: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
Date: Mon, 10 Oct 2016 17:40:00 +0200
Subject: [LTP] [PATCH v2 1/2] llistxattr: added a new test case to
	llistxattr02
In-Reply-To: <1476114001-24856-1-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1476114001-24856-1-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <1476114001-24856-2-git-send-email-dejan.jovicevic@rt-rk.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

v1 -> v2:
    - Using memset() for initializing the longpathname buffer.
    - Modified commit message.

Added a test case that checks if the path name, given by the
first argument of the function, is too long. If that is the
case, the function should return -1 and errno should be set
to ENAMETOOLONG.

Signed-off-by: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
---
 testcases/kernel/syscalls/llistxattr/llistxattr02.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr02.c b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
index ec4ba6e..98f0d7b 100644
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
@@ -45,6 +47,8 @@
 #define VALUE	"test"
 #define VALUE_SIZE	4
 
+char longpathname[PATH_MAX + 2];
+
 static struct test_case {
 	const char *path;
 	size_t size;
@@ -55,7 +59,9 @@ static struct test_case {
 	/* test2 */
 	{"", 20, ENOENT},
 	/* test3 */
-	{(char *)-1, 20, EFAULT}
+	{(char *)-1, 20, EFAULT},
+	/* test4 */
+	{longpathname, 20, ENAMETOOLONG}
 };
 
 static void verify_llistxattr(unsigned int n)
@@ -95,6 +101,9 @@ static void setup(void)
 			tst_brk(TBROK | TERRNO, "lsetxattr() failed");
 		}
 	}
+
+	memset(&longpathname, 'a', sizeof(longpathname) - 1);
+	longpathname[sizeof(longpathname)] = '\0';
 }
 
 static struct tst_test test = {
-- 
1.9.1

