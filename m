From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:20:05 +0200
Subject: [LTP] [COMMITTED] [PATCH 32/40] Make use of SAFE_LSEEK()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-32-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fcntl/fcntl14.c   | 4 ++--
 testcases/kernel/syscalls/munmap/munmap01.c | 6 ++----
 testcases/kernel/syscalls/munmap/munmap02.c | 5 +----
 testcases/kernel/syscalls/readv/readv02.c   | 4 +---
 4 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl14.c b/testcases/kernel/syscalls/fcntl/fcntl14.c
index 179908433..5f99dc21e 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl14.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl14.c
@@ -48,6 +48,7 @@
 #include <sys/wait.h>
 #include <inttypes.h>
 #include "test.h"
+#include "safe_macros.h"
 
 #define SKIP 0x0c00
 #if SKIP == F_RDLCK || SKIP== F_WRLCK
@@ -786,8 +787,7 @@ void run_test(int file_flag, int file_mode, int seek, int start, int end)
 			tst_brkm(TBROK, cleanup, "write() failed");
 
 		if (seek) {
-			if (lseek(fd, seek, 0) < 0)
-				tst_brkm(TBROK, cleanup, "lseek() failed");
+			SAFE_LSEEK(cleanup, fd, seek, 0);
 		}
 
 		thiscase = &testcases[test];
diff --git a/testcases/kernel/syscalls/munmap/munmap01.c b/testcases/kernel/syscalls/munmap/munmap01.c
index 62dbaffbc..2a5cfc90d 100644
--- a/testcases/kernel/syscalls/munmap/munmap01.c
+++ b/testcases/kernel/syscalls/munmap/munmap01.c
@@ -75,6 +75,7 @@
 #include <sys/mman.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define TEMPFILE	"mmapfile"
 
@@ -181,10 +182,7 @@ void setup(void)
 	 * move the file pointer to maplength position from the beginning
 	 * of the file.
 	 */
-	if (lseek(fildes, map_len, SEEK_SET) == -1) {
-		tst_brkm(TBROK, cleanup, "lseek() fails on %s, errno=%d : %s",
-			 TEMPFILE, errno, strerror(errno));
-	}
+	SAFE_LSEEK(cleanup, fildes, map_len, SEEK_SET);
 
 	/* Write one byte into temporary file */
 	if (write(fildes, "a", 1) != 1) {
diff --git a/testcases/kernel/syscalls/munmap/munmap02.c b/testcases/kernel/syscalls/munmap/munmap02.c
index a85c079c3..b43250512 100644
--- a/testcases/kernel/syscalls/munmap/munmap02.c
+++ b/testcases/kernel/syscalls/munmap/munmap02.c
@@ -186,10 +186,7 @@ void setup(void)
 	 * move the file pointer to maplength position from the beginning
 	 * of the file.
 	 */
-	if (lseek(fildes, map_len, SEEK_SET) == -1) {
-		tst_brkm(TBROK, cleanup, "lseek() fails on %s, errno=%d : %s",
-			 TEMPFILE, errno, strerror(errno));
-	}
+	SAFE_LSEEK(cleanup, fildes, map_len, SEEK_SET);
 
 	/* Write one byte into temporary file */
 	if (write(fildes, "a", 1) != 1) {
diff --git a/testcases/kernel/syscalls/readv/readv02.c b/testcases/kernel/syscalls/readv/readv02.c
index be67c4ece..aa40e2c7d 100644
--- a/testcases/kernel/syscalls/readv/readv02.c
+++ b/testcases/kernel/syscalls/readv/readv02.c
@@ -279,8 +279,6 @@ int fill_mem(char *c_ptr, int c1, int c2)
 
 long l_seek(int fdesc, long offset, int whence)
 {
-	if (lseek(fdesc, offset, whence) < 0) {
-		tst_brkm(TBROK, cleanup, "lseek Failed : errno = %d", errno);
-	}
+	SAFE_LSEEK(cleanup, fdesc, offset, whence);
 	return 0;
 }
-- 
2.13.5

