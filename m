From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 27 Jul 2018 14:05:38 +0800
Subject: [LTP] [PATCH] syscalls/madvise02.c: Fix ENOMEM errno tests
Message-ID: <1532671538-22356-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

With commit 212a4b9 on some distros(e.g. RHEL6.9/7.5), running
madvise02 got the following error:
------------------------------------------------------
...
madvise02.c:181: CONF: MADV_UNMERGEABLE is not supported
madvise02.c:196: FAIL: madvise succeeded unexpectedly
madvise02.c:196: FAIL: madvise succeeded unexpectedly
madvise02.c:181: CONF: MADV_WILLNEED is not supported
...
-------------------------------------------------------

If MAP_SIZE was equal to a pagesize, shared_anon may get the same
address which was a part of file2 and already unmapped, so that the
whole address of file2 became valid again.  Subsequently, ENOMEM
errno tests succeeded, so changing the order of mmaps to make
shared_anon get different address.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/madvise/madvise02.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
index 53e4f51..f683a99 100644
--- a/testcases/kernel/syscalls/madvise/madvise02.c
+++ b/testcases/kernel/syscalls/madvise/madvise02.c
@@ -156,11 +156,11 @@ static void setup(void)
 	SAFE_FSTAT(fd, &st);
 
 	file1 = SAFE_MMAP(0, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
+	shared_anon = SAFE_MMAP(0, MAP_SIZE, PROT_READ, MAP_SHARED |
+			 MAP_ANONYMOUS, -1, 0);
 	file2 = SAFE_MMAP(0, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
 	SAFE_MUNMAP(file2 + st.st_size - pagesize, pagesize);
 	file3 = SAFE_MMAP(0, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
-	shared_anon = SAFE_MMAP(0, MAP_SIZE, PROT_READ, MAP_SHARED |
-			MAP_ANONYMOUS, -1, 0);
 
 	nonalign = file1 + 100;
 
-- 
1.8.3.1



