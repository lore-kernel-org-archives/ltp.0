From: Wei Li <liwei391@huawei.com>
Date: Thu, 21 Feb 2019 22:02:21 +0800
Subject: [LTP] [PATCH] syscalls/fstat05.c: fix test logic error
Message-ID: <20190221140221.42163-1-liwei391@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On my machine running linux-4.19.23, the fstat05 test case went failed:
[root@localhost ltp_20180926_src]# ./testcases/kernel/syscalls/fstat/fstat05
fstat05     1  TFAIL  :  fstat05.c:168: fstat() returned 0 but we wanted -1

Finally i found that, the end of head was expanded after invoking setup(), more
than 4 * getpagesize(), then ptr_str is not a point outside user's accessible
address space any more.

Before invoking setup():
[root@localhost home]# cat /proc/10299/maps 
00400000-00417000 r-xp 00000000 fc:01 63312180                           /home/CI_DATA/20190213141353/testcase/kernel_test/ltp_20180926/ltp_20180926_src/testcases/kernel/syscalls/fstat/fstat05
0042f000-00430000 r--p 0001f000 fc:01 63312180                           /home/CI_DATA/20190213141353/testcase/kernel_test/ltp_20180926/ltp_20180926_src/testcases/kernel/syscalls/fstat/fstat05
00430000-00431000 rw-p 00020000 fc:01 63312180                           /home/CI_DATA/20190213141353/testcase/kernel_test/ltp_20180926/ltp_20180926_src/testcases/kernel/syscalls/fstat/fstat05
00431000-00434000 rw-p 00000000 00:00 0 
132dc000-132fd000 rw-p 00000000 00:00 0                                  [heap]
ffff92737000-ffff92747000 rw-p 00000000 00:00 0 
ffff92747000-ffff928bd000 r-xp 00000000 fc:02 266045                     /usr/lib64/libc-2.20-2014.11.so
ffff928bd000-ffff928d3000 ---p 00176000 fc:02 266045                     /usr/lib64/libc-2.20-2014.11.so
ffff928d3000-ffff928d7000 r--p 0017c000 fc:02 266045                     /usr/lib64/libc-2.20-2014.11.so
ffff928d7000-ffff928d9000 rw-p 00180000 fc:02 266045                     /usr/lib64/libc-2.20-2014.11.so
ffff928d9000-ffff928dd000 rw-p 00000000 00:00 0 
ffff928dd000-ffff928fd000 r-xp 00000000 fc:02 266038                     /usr/lib64/ld-2.20-2014.11.so
ffff92905000-ffff92908000 rw-p 00000000 00:00 0 
ffff92909000-ffff9291a000 rw-p 00000000 00:00 0 
ffff9291a000-ffff9291b000 r--p 00000000 00:00 0                          [vvar]
ffff9291b000-ffff9291c000 r-xp 00000000 00:00 0                          [vdso]
ffff9291c000-ffff9291d000 r--p 0002f000 fc:02 266038                     /usr/lib64/ld-2.20-2014.11.so
ffff9291d000-ffff9291e000 rw-p 00030000 fc:02 266038                     /usr/lib64/ld-2.20-2014.11.so
ffff9291e000-ffff9291f000 rw-p 00000000 00:00 0 
fffff5998000-fffff59b9000 rw-p 00000000 00:00 0                          [stack]

After invoking setup():
[root@localhost home]# cat /proc/10299/maps 
00400000-00417000 r-xp 00000000 fc:01 63312180                           /home/CI_DATA/20190213141353/testcase/kernel_test/ltp_20180926/ltp_20180926_src/testcases/kernel/syscalls/fstat/fstat05
0042f000-00430000 r--p 0001f000 fc:01 63312180                           /home/CI_DATA/20190213141353/testcase/kernel_test/ltp_20180926/ltp_20180926_src/testcases/kernel/syscalls/fstat/fstat05
00430000-00431000 rw-p 00020000 fc:01 63312180                           /home/CI_DATA/20190213141353/testcase/kernel_test/ltp_20180926/ltp_20180926_src/testcases/kernel/syscalls/fstat/fstat05
00431000-00434000 rw-p 00000000 00:00 0 
132dc000-1350d000 rw-p 00000000 00:00 0                                  [heap]
ffff92705000-ffff92712000 r-xp 00000000 fc:02 266064                     /usr/lib64/libnss_files-2.20-2014.11.so
ffff92712000-ffff92724000 ---p 0000d000 fc:02 266064                     /usr/lib64/libnss_files-2.20-2014.11.so
ffff92724000-ffff92725000 r--p 0000f000 fc:02 266064                     /usr/lib64/libnss_files-2.20-2014.11.so
ffff92725000-ffff92726000 rw-p 00010000 fc:02 266064                     /usr/lib64/libnss_files-2.20-2014.11.so
ffff92737000-ffff92747000 rw-p 00000000 00:00 0 
ffff92747000-ffff928bd000 r-xp 00000000 fc:02 266045                     /usr/lib64/libc-2.20-2014.11.so
ffff928bd000-ffff928d3000 ---p 00176000 fc:02 266045                     /usr/lib64/libc-2.20-2014.11.so
ffff928d3000-ffff928d7000 r--p 0017c000 fc:02 266045                     /usr/lib64/libc-2.20-2014.11.so
ffff928d7000-ffff928d9000 rw-p 00180000 fc:02 266045                     /usr/lib64/libc-2.20-2014.11.so
ffff928d9000-ffff928dd000 rw-p 00000000 00:00 0 
ffff928dd000-ffff928fd000 r-xp 00000000 fc:02 266038                     /usr/lib64/ld-2.20-2014.11.so
ffff92905000-ffff92908000 rw-p 00000000 00:00 0 
ffff92909000-ffff9291a000 rw-p 00000000 00:00 0 
ffff9291a000-ffff9291b000 r--p 00000000 00:00 0                          [vvar]
ffff9291b000-ffff9291c000 r-xp 00000000 00:00 0                          [vdso]
ffff9291c000-ffff9291d000 r--p 0002f000 fc:02 266038                     /usr/lib64/ld-2.20-2014.11.so
ffff9291d000-ffff9291e000 rw-p 00030000 fc:02 266038                     /usr/lib64/ld-2.20-2014.11.so
ffff9291e000-ffff9291f000 rw-p 00000000 00:00 0 
fffff5998000-fffff59b9000 rw-p 00000000 00:00 0                          [stack]
[root@localhost home]# 

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 testcases/kernel/syscalls/fstat/fstat05.c             | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fstat/fstat05.c b/testcases/kernel/syscalls/fstat/fstat05.c
index 8de5d070a..b10285cbe 100644
--- a/testcases/kernel/syscalls/fstat/fstat05.c
+++ b/testcases/kernel/syscalls/fstat/fstat05.c
@@ -135,15 +135,15 @@ int main(int ac, char **av)
 
 	tst_parse_opts(ac, av, NULL, NULL);
 
-	/* Buffer points outside user's accessible address space. */
-	ptr_str = &stat_buf;	/* if it was for conformance testing */
-	ptr_str = (void *)sbrk(0) + (4 * getpagesize());
-
 	/*
 	 * Invoke setup function
 	 */
 	setup();
 
+	/* Buffer points outside user's accessible address space. */
+	ptr_str = &stat_buf;	/* if it was for conformance testing */
+	ptr_str = (void *)sbrk(0) + (4 * getpagesize());
+
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
 		tst_count = 0;
-- 
2.17.1

