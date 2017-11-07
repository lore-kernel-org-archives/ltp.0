From: vkabatov@redhat.com <vkabatov@redhat.com>
Date: Tue,  7 Nov 2017 17:10:42 +0100
Subject: [LTP]  [PATCH v2] Fix buffer overflow in print_result() function
Message-ID: <20171107161042.12825-1-vkabatov@redhat.com>
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
 lib/tst_test.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index c8baf2a43..b43fb35f7 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -227,13 +227,18 @@ static void print_result(const char *file, const int lineno, int ttype,
 	size -= ret;
 
 	ret = vsnprintf(str, size, fmt, va);
-	str += ret;
-	size -= ret;
-
-	if (str_errno) {
+	str += MIN(ret, size - 2);
+	size -= MIN(ret, size - 2);
+	if (ret >= size - 2) {
+		tst_res_(file, lineno, TWARN,
+				"Next message is too long and truncated:");
+	} else if (str_errno) {
 		ret = snprintf(str, size, ": %s", str_errno);
-		str += ret;
-		size -= ret;
+		str += MIN(ret, size - 2);
+		size -= MIN(ret, size - 2);
+		if (ret >= size - 2)
+			tst_res_(file, lineno, TWARN,
+				"Next message is too long and truncated:");
 	}
 
 	snprintf(str, size, "\n");
-- 
2.13.6

