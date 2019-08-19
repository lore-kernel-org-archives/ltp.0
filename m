From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 19 Aug 2019 15:36:18 +0200
Subject: [LTP] [PATCH] tst_res: Print errno number in addition to error name
Message-ID: <20190819133618.7538-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Occasionally new error numbers are added to the kernel (maybe by
accident). Currently if we do not know the name of them then we just print
???.

This commit simply always prints the error number to aid with debugging.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

It appears we are atleast missing ENOTSUPP (524) which is probably returned by
create_timer for some alarm clocks on none x86 arches. This isn't entirely
clear, but what is clear is that it would help to know what the error number
is without using strace.

 lib/tst_test.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 245e287fa..46481ca3f 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -177,7 +177,7 @@ static void print_result(const char *file, const int lineno, int ttype,
 {
 	char buf[1024];
 	char *str = buf;
-	int ret, size = sizeof(buf), ssize;
+	int ret, size = sizeof(buf), ssize, int_errno;
 	const char *str_errno = NULL;
 	const char *res;
 
@@ -205,15 +205,19 @@ static void print_result(const char *file, const int lineno, int ttype,
 		abort();
 	}
 
-	if (ttype & TERRNO)
+	if (ttype & TERRNO) {
 		str_errno = tst_strerrno(errno);
+		int_errno = errno;
+	}
 
-	if (ttype & TTERRNO)
+	if (ttype & TTERRNO) {
 		str_errno = tst_strerrno(TST_ERR);
+		int_errno = TST_ERR;
+	}
 
 	if (ttype & TRERRNO) {
-		ret = TST_RET < 0 ? -(int)TST_RET : (int)TST_RET;
-		str_errno = tst_strerrno(ret);
+		int_errno = TST_RET < 0 ? -(int)TST_RET : (int)TST_RET;
+		str_errno = tst_strerrno(int_errno);
 	}
 
 	ret = snprintf(str, size, "%s:%i: ", file, lineno);
@@ -237,7 +241,7 @@ static void print_result(const char *file, const int lineno, int ttype,
 				"Next message is too long and truncated:");
 	} else if (str_errno) {
 		ssize = size - 2;
-		ret = snprintf(str, size, ": %s", str_errno);
+		ret = snprintf(str, size, ": %s (%d)", str_errno, int_errno);
 		str += MIN(ret, ssize);
 		size -= MIN(ret, ssize);
 		if (ret >= ssize)
-- 
2.22.0

