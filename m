From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Feb 2017 13:28:26 +0100
Subject: [LTP] [COMMITTED] [PATCH] Fix "missing terminating ' character"
	warnings
Message-ID: <20170213122826.30361-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The commit:

commit 428936358a66163d564cd4de2eb36a0e2be76f2b
Author: Steven Jackson <sj@oscode.net>
Date:   Tue Jan 17 12:14:25 2017 +0000

Introduced warnings:

 warning: missing terminating ' character
  #warning DEV_BSIZE isn't defined, defaulting to 512

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/bytes_by_prefix.c                   | 2 +-
 lib/write_log.c                         | 2 +-
 testcases/kernel/syscalls/read/read01.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bytes_by_prefix.c b/lib/bytes_by_prefix.c
index e93c70f..797442c 100644
--- a/lib/bytes_by_prefix.c
+++ b/lib/bytes_by_prefix.c
@@ -61,7 +61,7 @@
 #ifdef DEV_BSIZE
 #define B_MULT	DEV_BSIZE	/* block size */
 #else
-#warning DEV_BSIZE isn't defined, defaulting to 512
+#warning DEV_BSIZE is not defined, defaulting to 512
 #define B_MULT	512
 #endif
 
diff --git a/lib/write_log.c b/lib/write_log.c
index 6e4239e..e8ef9c7 100644
--- a/lib/write_log.c
+++ b/lib/write_log.c
@@ -77,7 +77,7 @@
 #ifdef DEV_BSIZE
 #define BSIZE DEV_BSIZE
 #else
-#warning DEV_BSIZE isn't defined, defaulting to 512
+#warning DEV_BSIZE is not defined, defaulting to 512
 #define BSIZE 512
 #endif
 #endif
diff --git a/testcases/kernel/syscalls/read/read01.c b/testcases/kernel/syscalls/read/read01.c
index afe2a65..9abfdb8 100644
--- a/testcases/kernel/syscalls/read/read01.c
+++ b/testcases/kernel/syscalls/read/read01.c
@@ -123,7 +123,7 @@
 #ifdef DEV_BSIZE
 #define READ_BLOCK_SIZE DEV_BSIZE
 #else
-#warning DEV_BSIZE isn't defined, defaulting to 512
+#warning DEV_BSIZE is not defined, defaulting to 512
 #define READ_BLOCK_SIZE 512
 #endif
 
-- 
2.10.2

