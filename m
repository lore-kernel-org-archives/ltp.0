From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 Jun 2021 16:15:27 +0200
Subject: [LTP] [PATCH 1/3] syscalls/sendfile: Convert sendfile02 to the
 new API
In-Reply-To: <20210603033611.15619-2-xieziyao@huawei.com>
References: <20210603033611.15619-1-xieziyao@huawei.com>
 <20210603033611.15619-2-xieziyao@huawei.com>
Message-ID: <YMoHf/mwjDXkCdJH@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> 1. Convert sendfile02 to the new API with file descriptors instead
> of socket descriptors.
> 2. Remove the support for UCLINUX.
> 3. Remove redundant testcases {4, 22, 26} and {6, 20, 26}.

Thanks, merged with diff below (fix docparse formatting, add OFFSET_DESC()
macro, fix checkpatch.pl warning on comparison order).

Kind regards,
Petr

diff --git testcases/kernel/syscalls/sendfile/sendfile02.c testcases/kernel/syscalls/sendfile/sendfile02.c
index 820063681..ffd654885 100644
--- testcases/kernel/syscalls/sendfile/sendfile02.c
+++ testcases/kernel/syscalls/sendfile/sendfile02.c
@@ -9,7 +9,8 @@
 /*\
  * [Description]
  *
- * Test the basic functionality of the sendfile() system call,
+ * Test the basic functionality of the sendfile() system call:
+ *
  * 1. Call sendfile() with offset = 0.
  * 2. Call sendfile() with offset in the middle of the file.
  */
@@ -23,6 +24,8 @@
 #define IN_FILE "in_file"
 #define OUT_FILE "out_file"
 
+#define OFFSET_DESC(x) .desc = "with offset = "#x, .offset = x
+
 struct test_case_t {
 	char *desc;
 	off_t offset;
@@ -30,8 +33,8 @@ struct test_case_t {
 	int64_t exp_retval;
 	int64_t exp_updated_offset;
 } tc[] = {
-	{ "with offset = 0", 0, 26, 26, 26 },
-	{ "with offset = 2", 2, 24, 24, 26 },
+	{ OFFSET_DESC(0), 26, 26, 26 },
+	{ OFFSET_DESC(2), 24, 24, 26 },
 };
 
 static void setup(void)
@@ -60,7 +63,7 @@ static void run(unsigned int i)
 	TEST(sendfile(out_fd, in_fd, &offset, tc[i].count));
 	after_pos = SAFE_LSEEK(in_fd, 0, SEEK_CUR);
 
-	if (TST_RET != tc[i].exp_retval)
+	if (tc[i].exp_retval != TST_RET)
 		tst_res(TFAIL, "sendfile() failed to return expected value, "
 			       "expected: %" PRId64 ", got: %ld",
 			tc[i].exp_retval, TST_RET);
