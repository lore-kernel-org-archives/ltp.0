From: Li Wang <liwang@redhat.com>
Date: Mon, 25 Jan 2021 06:47:46 +0000
Subject: [LTP] [PATCH RFC 1/2] lib: add SAFE_READ_PROC_STATUS macro
Message-ID: <20210125064747.26759-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To parse /proc/PID/status files, for example:
    SAFE_READ_PROC_STATUS(pid, "VmSwap:");

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Petr Vorel <pvorel@suse.cz>
Cc: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 include/tst_safe_file_ops.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/tst_safe_file_ops.h b/include/tst_safe_file_ops.h
index 894c16123..7a4076c4c 100644
--- a/include/tst_safe_file_ops.h
+++ b/include/tst_safe_file_ops.h
@@ -25,6 +25,14 @@
                         &tst_rval); \
         tst_rval;})
 
+#define SAFE_READ_PROC_STATUS(pid, item) \
+       ({long tst_rval_; \
+        char tst_path_[128]; \
+        sprintf(tst_path_, "/proc/%d/status", pid); \
+        SAFE_FILE_LINES_SCANF(tst_path_, item " %ld", \
+                        &tst_rval_); \
+        tst_rval_;})
+
 #define FILE_PRINTF(path, fmt, ...) \
 	file_printf(__FILE__, __LINE__, \
 		    (path), (fmt), ## __VA_ARGS__)
-- 
2.21.3

