From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Thu, 13 May 2021 16:54:14 +0800
Subject: [LTP] [PATCH] syscalls/mallinfo01: Disable free fastbin blocks
Message-ID: <1620896054-26151-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When using malloc to allocate small space, it will use fastbin block firstly if
we have free fastbin free blocks, it is more quickly.
In here, we just test oldblks free chunks, it is the number of ordinary
(i.e. non-fastbin) free blocks. So use mallopt(M_MXFAST, 0) to disable
free fastbin block.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/mallinfo/mallinfo01.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/mallinfo/mallinfo01.c b/testcases/kernel/syscalls/mallinfo/mallinfo01.c
index 48fce0132..4e10e352e 100644
--- a/testcases/kernel/syscalls/mallinfo/mallinfo01.c
+++ b/testcases/kernel/syscalls/mallinfo/mallinfo01.c
@@ -64,6 +64,8 @@ static void setup(void)
 {
 	if (sizeof(info1.arena) != sizeof(int))
 		tst_res(TFAIL, "The member of mallinfo struct is not int");
+	if (mallopt(M_MXFAST, 0) == 0)
+		tst_res(TFAIL, "mallopt(M_MXFAST, 0) failed");
 
 	info1 = mallinfo();
 	print_mallinfo("Start", &info1);
-- 
2.23.0

