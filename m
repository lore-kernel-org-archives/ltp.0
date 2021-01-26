From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 26 Jan 2021 09:41:38 +0800
Subject: [LTP] [PATCH] syscalls/msync: Assgin value for page_sz
Message-ID: <1611625298-2425-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since the previous patch, it removes useless getpagesize()
check because this function never fail. But it also remove
the page_size assignment and it lead case fail as below:

msync02     1  TBROK  :  msync02.c:133: mmap failed: errno=EINVAL(22): Invalid argument
msync02     2  TBROK  :  msync02.c:133: Remaining cases broken
msync02     3  TBROK  :  msync02.c:147: munmap failed: errno=EINVAL(22): Invalid argument

Fix this and also fix compiler warning by using size_t data type instead of int.

Fixes: 60f4b01194ca ("syscalls/msync01: Remove useless getpagesize() check")
Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/msync/msync01.c | 4 +++-
 testcases/kernel/syscalls/msync/msync02.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/msync/msync01.c b/testcases/kernel/syscalls/msync/msync01.c
index 121fd86e8..cb740565d 100644
--- a/testcases/kernel/syscalls/msync/msync01.c
+++ b/testcases/kernel/syscalls/msync/msync01.c
@@ -153,12 +153,14 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
-	int c_total = 0, nwrite = 0;	/* no. of bytes to be written */
+	size_t c_total = 0, nwrite = 0;	/* no. of bytes to be written */
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
+	page_sz = (size_t)getpagesize();
+
 	tst_tmpdir();
 
 	if ((fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0)
diff --git a/testcases/kernel/syscalls/msync/msync02.c b/testcases/kernel/syscalls/msync/msync02.c
index c7b7e9e9c..11ed29e3b 100644
--- a/testcases/kernel/syscalls/msync/msync02.c
+++ b/testcases/kernel/syscalls/msync/msync02.c
@@ -106,13 +106,15 @@ int main(int ac, char **av)
 
 void setup(void)
 {
-	int c_total = 0, nwrite = 0;	/* no. of bytes to be written */
+	size_t c_total = 0, nwrite = 0;	/* no. of bytes to be written */
 	char tst_buf[BUF_SIZE];
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
+	page_sz = (size_t)getpagesize();
+
 	tst_tmpdir();
 
 	if ((fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0)
-- 
2.23.0



