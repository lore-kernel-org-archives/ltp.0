From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Mar 2017 16:34:03 +0100
Subject: [LTP] [COMMITTED] [PATCH] ltp-aiodio: Move code & fix warnings
Message-ID: <20170322153403.6248-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Move check_zero() function to a common header

* Fix printf() format warnings in that funcition

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/io/ltp-aiodio/aiodio_append.c    | 23 +-----------
 testcases/kernel/io/ltp-aiodio/common_checkzero.h | 45 +++++++++++++++++++++++
 testcases/kernel/io/ltp-aiodio/common_sparse.h    | 28 ++------------
 testcases/kernel/io/ltp-aiodio/dio_append.c       | 23 +-----------
 testcases/kernel/io/ltp-aiodio/read_checkzero.c   | 23 +-----------
 5 files changed, 52 insertions(+), 90 deletions(-)
 create mode 100644 testcases/kernel/io/ltp-aiodio/common_checkzero.h

diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_append.c b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
index 877b972..39a529f 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
@@ -38,28 +38,7 @@
 
 #define NUM_CHILDREN 8
 
-char *check_zero(unsigned char *buf, int size)
-{
-	unsigned char *p;
-
-	p = buf;
-
-	while (size > 0) {
-		if (*buf != 0) {
-			fprintf(stderr,
-				"non zero buffer at buf[%d] => 0x%02x,%02x,%02x,%02x\n",
-				buf - p, (unsigned int)buf[0],
-				size > 1 ? (unsigned int)buf[1] : 0,
-				size > 2 ? (unsigned int)buf[2] : 0,
-				size > 3 ? (unsigned int)buf[3] : 0);
-			fprintf(stderr, "buf %p, p %p\n", buf, p);
-			return buf;
-		}
-		buf++;
-		size--;
-	}
-	return 0;		/* all zeros */
-}
+#include "common_checkzero.h"
 
 int read_eof(char *filename)
 {
diff --git a/testcases/kernel/io/ltp-aiodio/common_checkzero.h b/testcases/kernel/io/ltp-aiodio/common_checkzero.h
new file mode 100644
index 0000000..3ae3b56
--- /dev/null
+++ b/testcases/kernel/io/ltp-aiodio/common_checkzero.h
@@ -0,0 +1,45 @@
+/*
+ * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#ifndef LTP_AIODIO_COMMON_CHECKZERO
+#define LTP_AIODIO_COMMON_CHECKZERO
+
+static char *check_zero(char *buf, int size)
+{
+	char *p;
+
+	p = buf;
+
+	while (size > 0) {
+		if (*buf != 0) {
+			fprintf(stderr, "non zero buffer at buf[%u] => 0x%02x,%02x,%02x,%02x\n",
+				(unsigned int)(buf - p),
+				(unsigned int)buf[0],
+				size > 1 ? (unsigned int)buf[1] : 0,
+				size > 2 ? (unsigned int)buf[2] : 0,
+				size > 3 ? (unsigned int)buf[3] : 0);
+			return buf;
+		}
+		buf++;
+		size--;
+	}
+
+	return NULL;
+}
+
+#endif /* LTP_AIODIO_COMMON_CHECKZERO */
diff --git a/testcases/kernel/io/ltp-aiodio/common_sparse.h b/testcases/kernel/io/ltp-aiodio/common_sparse.h
index e8b906e..3819e00 100644
--- a/testcases/kernel/io/ltp-aiodio/common_sparse.h
+++ b/testcases/kernel/io/ltp-aiodio/common_sparse.h
@@ -19,6 +19,8 @@
 #ifndef LTP_AIODIO_COMMON_SPARSE
 #define LTP_AIODIO_COMMON_SPARSE
 
+#include "common_checkzero.h"
+
 /*
  * This code tries to create dirty free blocks on
  * the HDD so there is a chance that blocks to be allocated
@@ -77,28 +79,6 @@ long long scale_by_kmg(long long value, char scale)
 	return value;
 }
 
-char *check_zero(char *buf, int size)
-{
-	char *p;
-
-	p = buf;
-
-	while (size > 0) {
-		if (*buf != 0) {
-			fprintf(stderr, "non zero buffer at buf[%d] => 0x%02x,%02x,%02x,%02x\n",
-				buf - p, (unsigned int)buf[0],
-				size > 1 ? (unsigned int)buf[1] : 0,
-				size > 2 ? (unsigned int)buf[2] : 0,
-				size > 3 ? (unsigned int)buf[3] : 0);
-			return buf;
-		}
-		buf++;
-		size--;
-	}
-
-	return NULL;
-}
-
 /*
  * Make sure we read only zeroes,
  * either there is a hole in the file,
@@ -134,8 +114,8 @@ static void read_sparse(char *filename, int filesize)
 			r = read(fd, buf, sizeof(buf));
 			if (r > 0) {
 				if ((badbuf = check_zero(buf, r))) {
-					fprintf(stderr, "non-zero read at offset %d\n",
-						offset + badbuf - buf);
+					fprintf(stderr, "non-zero read at offset %u\n",
+						(unsigned int)(offset + badbuf - buf));
 					exit(10);
 				}
 			}
diff --git a/testcases/kernel/io/ltp-aiodio/dio_append.c b/testcases/kernel/io/ltp-aiodio/dio_append.c
index 94235a2..74446ac 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
@@ -45,28 +45,7 @@
 #include "test.h"
 #define NUM_CHILDREN 8
 
-char *check_zero(unsigned char *buf, int size)
-{
-	unsigned char *p;
-
-	p = buf;
-
-	while (size > 0) {
-		if (*buf != 0) {
-			fprintf(stderr,
-				"non zero buffer at buf[%d] => 0x%02x,%02x,%02x,%02x\n",
-				buf - p, (unsigned int)buf[0],
-				size > 1 ? (unsigned int)buf[1] : 0,
-				size > 2 ? (unsigned int)buf[2] : 0,
-				size > 3 ? (unsigned int)buf[3] : 0);
-			fprintf(stderr, "buf %p, p %p\n", buf, p);
-			return buf;
-		}
-		buf++;
-		size--;
-	}
-	return 0;		/* all zeros */
-}
+#include "common_checkzero.h"
 
 int read_eof(char *filename)
 {
diff --git a/testcases/kernel/io/ltp-aiodio/read_checkzero.c b/testcases/kernel/io/ltp-aiodio/read_checkzero.c
index 744178d..b48197a 100644
--- a/testcases/kernel/io/ltp-aiodio/read_checkzero.c
+++ b/testcases/kernel/io/ltp-aiodio/read_checkzero.c
@@ -33,28 +33,7 @@
 #include <stdio.h>
 #include <unistd.h>
 
-char *check_zero(unsigned char *buf, int size)
-{
-	unsigned char *p;
-
-	p = buf;
-
-	while (size > 0) {
-		if (*buf != 0) {
-			fprintf(stderr,
-				"non zero buffer at buf[%d] => 0x%02x,%02x,%02x,%02x\n",
-				buf - p, (unsigned int)buf[0],
-				size > 1 ? (unsigned int)buf[1] : 0,
-				size > 2 ? (unsigned int)buf[2] : 0,
-				size > 3 ? (unsigned int)buf[3] : 0);
-			fprintf(stderr, "buf %p, p %p\n", buf, p);
-			return buf;
-		}
-		buf++;
-		size--;
-	}
-	return 0;		/* all zeros */
-}
+#include "common_checkzero.h"
 
 int read_eof(char *filename)
 {
-- 
2.10.2

