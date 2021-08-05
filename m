From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Thu,  5 Aug 2021 14:28:12 +0800
Subject: [LTP] [PATCH] include/tst_test: Expose tst_tmpdir and tst_rmdir to
 newlib tests.
Message-ID: <20210805062812.7363-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/include/tst_test.h b/include/tst_test.h
index ce4e007cf..0e0806c93 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -303,6 +303,14 @@ void tst_set_timeout(int timeout);
  * Returns path to the test temporary directory in a newly allocated buffer.
  */
 char *tst_get_tmpdir(void);
+/*
+ * Make the temporary directory and change to the temporary directory.
+ */
+void tst_tmpdir(void);
+/*
+ * Remove the temporary directory.
+ */
+void tst_rmdir(void);

 #ifndef TST_NO_DEFAULT_MAIN

--
2.20.1



