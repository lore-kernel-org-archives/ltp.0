From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 28 Aug 2018 13:07:50 +0200
Subject: [LTP] [PATCH v2 1/2] lib: add tst_get_timeout()
Message-ID: <6680bda80c85d424a5219d9f55dc9c5355dc0da1.1535454204.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/tst_test.h | 1 +
 lib/tst_test.c     | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/tst_test.h b/include/tst_test.h
index 98dacf3873ab..f801d276d2e5 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -217,6 +217,7 @@ const char *tst_strsig(int sig);
  */
 const char *tst_strstatus(int status);
 
+unsigned int tst_get_timeout(void);
 void tst_set_timeout(int timeout);
 
 #ifndef TST_NO_DEFAULT_MAIN
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 2f3d357d2fcc..7bd18205ae7f 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -992,6 +992,11 @@ static void sigint_handler(int sig LTP_ATTRIBUTE_UNUSED)
 	}
 }
 
+unsigned int tst_get_timeout(void)
+{
+	return results->timeout;
+}
+
 void tst_set_timeout(int timeout)
 {
 	char *mul = getenv("LTP_TIMEOUT_MUL");
-- 
1.8.3.1

