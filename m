From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 20 Dec 2016 20:31:06 +0300
Subject: [LTP] [PATCH v2 1/3] tst_test: add tst_parse_long()
Message-ID: <1482255068-25771-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v2: Fixes in tst_parse_int():
    * return back checking 'str' for NULL
    * set value in tst_parse_int() only if 'long' version returns 0.

 include/tst_test.h |    1 +
 lib/tst_test.c     |   20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index 1492ff5..3c77a98 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -96,6 +96,7 @@ struct tst_option {
  * On failure non-zero (errno) is returned.
  */
 int tst_parse_int(const char *str, int *val, int min, int max);
+int tst_parse_long(const char *str, long *val, long min, long max);
 int tst_parse_float(const char *str, float *val, float min, float max);
 
 struct tst_test {
diff --git a/lib/tst_test.c b/lib/tst_test.c
index c48d718..3e7f9a0 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -446,6 +446,22 @@ static void parse_opts(int argc, char *argv[])
 int tst_parse_int(const char *str, int *val, int min, int max)
 {
 	long rval;
+
+	if (!str)
+		return 0;
+
+	int ret = tst_parse_long(str, &rval, min, max);
+
+	if (ret)
+		return ret;
+
+	*val = (int)rval;
+	return 0;
+}
+
+int tst_parse_long(const char *str, long *val, long min, long max)
+{
+	long rval;
 	char *end;
 
 	if (!str)
@@ -460,10 +476,10 @@ int tst_parse_int(const char *str, int *val, int min, int max)
 	if (errno)
 		return errno;
 
-	if (rval > (long)max || rval < (long)min)
+	if (rval > max || rval < min)
 		return ERANGE;
 
-	*val = (int)rval;
+	*val = rval;
 	return 0;
 }
 
-- 
1.7.1

