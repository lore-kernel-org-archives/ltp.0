From: vkabatov@redhat.com <vkabatov@redhat.com>
Date: Fri,  3 Nov 2017 17:13:22 +0100
Subject: [LTP]  [PATCH] Fix buffer overflow in print_result() function
Message-ID: <20171103161322.15792-1-vkabatov@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Veronika Kabatova <vkabatov@redhat.com>

From man page: "The functions snprintf() and vsnprintf() do not write
more than size bytes (including the terminating null byte ('\0')). If
the output was truncated due to this limit, then the return value is the
number of characters (excluding the terminating null byte) which would
have been written to the final string if enough space had been
available. Thus, a return value of `size` or more means that the output
was truncated."

The return value is not checked and blindly subtracted from available
space in the buffer which may cause negative values (which are then
converted to unsigned type size_t) in case the variables to print don't
fit into buffer. The pointer to buffer is also moved forward the same
amount, and writing into memory that is not allocated causes unexpected
failures of tests with segfaults.

This was discovered during rewriting of mtest06/mmap1 testcase to new
library where verbose output tried to print out memory contents longer
than space available in the buffer. The framework should be robust
enough to handle these situations.

Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
---
 lib/tst_test.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index c8baf2a43..09691031e 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -180,7 +180,7 @@ static void print_result(const char *file, const int lineno, int ttype,
 {
 	char buf[1024];
 	char *str = buf;
-	int ret, size = sizeof(buf);
+	int ret, overflowed = 0, size = sizeof(buf);
 	const char *str_errno = NULL;
 	const char *res;
 
@@ -227,17 +227,31 @@ static void print_result(const char *file, const int lineno, int ttype,
 	size -= ret;
 
 	ret = vsnprintf(str, size, fmt, va);
+	if (ret >= size) {
+		overflowed = 1;
+		goto finish;
+	}
 	str += ret;
 	size -= ret;
 
 	if (str_errno) {
 		ret = snprintf(str, size, ": %s", str_errno);
+		if (ret >= size) {
+			overflowed = 1;
+			goto finish;
+		}
 		str += ret;
 		size -= ret;
 	}
 
-	snprintf(str, size, "\n");
+finish:
+	/* Keep space for newline and \0 if the buffer was filled */
+	if (overflowed) {
+		str += size - 2;
+		size = 2;
+	}
 
+	snprintf(str, size, "\n");
 	fputs(buf, stderr);
 }
 
-- 
2.13.6

