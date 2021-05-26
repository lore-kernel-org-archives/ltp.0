From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 26 May 2021 12:46:33 +0200
Subject: [LTP] [PATCH 1/1] sendfile0{2,9}: Remove OFF_T workaround
Message-ID: <20210526104633.29561-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Using OFF_T definition to off64_t for 64bit variants seems to be am old
workaround for buggy libc. Nowadays we can rely on off_t to have correct size
(i.e.: 32bit: 4 bytes; 64bit or 32bit with -D_FILE_OFFSET_BITS=64: 8 bytes)

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: -DOFF_T=off64_t is also defined in testcases/kernel/io/disktest
and mentioned in {tst_,}safe_macros.h.

Kind regards,
Petr

 testcases/kernel/syscalls/sendfile/Makefile     |  2 +-
 testcases/kernel/syscalls/sendfile/sendfile02.c |  6 +-----
 testcases/kernel/syscalls/sendfile/sendfile09.c | 10 +++-------
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/sendfile/Makefile b/testcases/kernel/syscalls/sendfile/Makefile
index f63a42fe9..7ee7bbed4 100644
--- a/testcases/kernel/syscalls/sendfile/Makefile
+++ b/testcases/kernel/syscalls/sendfile/Makefile
@@ -6,6 +6,6 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../utils/newer_64.mk
 
-%_64: CPPFLAGS += -D_FILE_OFFSET_BITS=64 -DOFF_T=off64_t -D_GNU_SOURCE
+%_64: CPPFLAGS += -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/sendfile/sendfile02.c b/testcases/kernel/syscalls/sendfile/sendfile02.c
index e5f115146..729a9e123 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile02.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile02.c
@@ -59,10 +59,6 @@
 #include "test.h"
 #include "safe_macros.h"
 
-#ifndef OFF_T
-#define OFF_T off_t
-#endif /* Not def: OFF_T */
-
 TCID_DEFINE(sendfile02);
 int TST_TOTAL = 4;
 
@@ -95,7 +91,7 @@ struct test_case_t {
 static char *argv0;
 #endif
 
-void do_sendfile(OFF_T offset, int i)
+void do_sendfile(off_t offset, int i)
 {
 	int in_fd;
 	struct stat sb;
diff --git a/testcases/kernel/syscalls/sendfile/sendfile09.c b/testcases/kernel/syscalls/sendfile/sendfile09.c
index 297b3e212..320649dcd 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile09.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile09.c
@@ -26,17 +26,13 @@
 
 #ifndef TST_ABI32
 
-#ifndef OFF_T
-#define OFF_T off_t
-#endif
-
 #define ONE_GB		(INT64_C(1) << 30)
 #define IN_FILE		"in_file"
 #define OUT_FILE	"out_file"
 
 static struct test_case_t {
 	char *desc;
-	OFF_T offset;
+	off_t offset;
 	int64_t count;
 	int64_t exp_retval;
 	int64_t exp_updated_offset;
@@ -67,9 +63,9 @@ static void run(unsigned int i)
 {
 	int in_fd = SAFE_OPEN(IN_FILE, O_RDONLY);
 	int out_fd = SAFE_OPEN(OUT_FILE, O_WRONLY);
-	OFF_T offset = tc[i].offset;
+	off_t offset = tc[i].offset;
 
-	OFF_T before_pos, after_pos;
+	off_t before_pos, after_pos;
 	before_pos = SAFE_LSEEK(in_fd, 0, SEEK_CUR);
 
 	TEST(sendfile(out_fd, in_fd, &offset, tc[i].count));
-- 
2.31.1

