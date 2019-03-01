From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri,  1 Mar 2019 13:58:21 +0530
Subject: [LTP] [PATCH 2/2] doc: document new library functions
In-Reply-To: <1551428901-30162-1-git-send-email-sumit.garg@linaro.org>
References: <1551428901-30162-1-git-send-email-sumit.garg@linaro.org>
Message-ID: <1551428901-30162-2-git-send-email-sumit.garg@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Document following library functions:
1. tst_fill_file()
2. tst_fill_fd()
3. tst_dev_bytes_written()

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 doc/test-writing-guidelines.txt | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index f2f72c4..a5fe589 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1033,6 +1033,16 @@ results in 'umount(2)' failing with 'EBUSY'.
 IMPORTANT: All testcases should use 'tst_umount()' instead of 'umount(2)' to
            umount filesystems.
 
+[source,c]
+-------------------------------------------------------------------------------
+#include "tst_test.h"
+
+unsigned long tst_dev_bytes_written(const char *dev);
+-------------------------------------------------------------------------------
+
+This function reads test block device stat file (/sys/block/<device>/stat) and
+returns the bytes written since the last invocation of this function.
+
 2.2.15 Formatting a device with a filesystem
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -1142,6 +1152,24 @@ Returns non-zero if directory is empty and zero otherwise.
 
 Directory is considered empty if it contains only '.' and '..'.
 
+[source,c]
+-------------------------------------------------------------------------------
+#include "tst_test.h"
+
+int tst_fill_fd(int fd, char pattern, size_t bs, size_t bcount);
+-------------------------------------------------------------------------------
+
+Fill a file with specified pattern using file descriptor.
+
+[source,c]
+-------------------------------------------------------------------------------
+#include "tst_test.h"
+
+int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount);
+-------------------------------------------------------------------------------
+
+Creates/ovewrites a file with specified pattern using file path.
+
 2.2.18 Getting an unused PID number
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-- 
2.7.4

