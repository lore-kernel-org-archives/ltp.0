From: Petr Vorel <pvorel@suse.cz>
Date: Sat, 10 Dec 2016 21:29:08 +0100
Subject: [LTP] [PATCH v3 1/2] lib: add FILE_PRINTF
Message-ID: <20161210202909.22260-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Using non-safe version is handy in cleanup.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_safe_file_ops.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/tst_safe_file_ops.h b/include/tst_safe_file_ops.h
index 2e4067ca1..cb8f25dcd 100644
--- a/include/tst_safe_file_ops.h
+++ b/include/tst_safe_file_ops.h
@@ -38,6 +38,10 @@
 	file_lines_scanf(__FILE__, __LINE__, NULL, 1,\
 			(path), (fmt), ## __VA_ARGS__)
 
+#define FILE_PRINTF(path, fmt, ...) \
+	file_printf(__FILE__, __LINE__, \
+	            (path), (fmt), ## __VA_ARGS__)
+
 #define SAFE_FILE_PRINTF(path, fmt, ...) \
 	safe_file_printf(__FILE__, __LINE__, NULL, \
 	                 (path), (fmt), ## __VA_ARGS__)
-- 
2.11.0

