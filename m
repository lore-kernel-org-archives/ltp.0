From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Wed, 25 Oct 2017 11:36:50 +0800
Subject: [LTP] [PATCH 1/2] syscalls/brk: change to unsigned long to avoid
	incr overflow
Message-ID: <1508902611-28530-1-git-send-email-lizhijian@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Previously, incr is possible be overflowed at
81	incr = (Max_brk_byte_size - Beg_brk_val) / (MAX_SIZE_LC / 2);
103	nbrkpt = cur_brk_val + (2 * incr);

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: leishaoting <leist.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/brk/brk01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/brk/brk01.c b/testcases/kernel/syscalls/brk/brk01.c
index 9a36431..b470ee7 100644
--- a/testcases/kernel/syscalls/brk/brk01.c
+++ b/testcases/kernel/syscalls/brk/brk01.c
@@ -65,7 +65,7 @@ uintptr_t Beg_brk_val;
 int main(int ac, char **av)
 {
 	int lc;
-	int incr;
+	unsigned long incr;
 	uintptr_t nbrkpt;		/* new brk point value */
 	uintptr_t cur_brk_val;	/* current size returned by sbrk */
 	uintptr_t aft_brk_val;	/* current size returned by sbrk */
-- 
2.7.4



