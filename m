From: Li Zhijian <zhijianx.li@intel.com>
Date: Wed, 25 Oct 2017 11:33:28 +0800
Subject: [LTP] [PATCH 2/2] syscalls/brk: limit the largest requesting memory
	to UINT_MAX
In-Reply-To: <1508902408-27080-1-git-send-email-zhijianx.li@intel.com>
References: <1508902408-27080-1-git-send-email-zhijianx.li@intel.com>
Message-ID: <1508902408-27080-2-git-send-email-zhijianx.li@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Li Zhijian <lizhijian@cn.fujitsu.com>

sometimes(some platforms), sbrk(0) will return a huge address(e.g
Beg_brk_val=94392102215680), it will lead to the request a huge
memory by brk(size>1T) which beyonds most host memory size

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: leishaoting <leist.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/brk/brk01.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/brk/brk01.c b/testcases/kernel/syscalls/brk/brk01.c
index b470ee7..22b9662 100644
--- a/testcases/kernel/syscalls/brk/brk01.c
+++ b/testcases/kernel/syscalls/brk/brk01.c
@@ -53,6 +53,7 @@ void setup();
 void cleanup();
 
 #define MAX_SIZE_LC	1000	/* loop count test will reach max size */
+#define MAX_INCR	(UINT_MAX / 2)
 
 char *TCID = "brk01";
 int TST_TOTAL = 1;
@@ -83,6 +84,9 @@ int main(int ac, char **av)
 	if ((incr * 2) < 4096)	/* make sure that process will grow */
 		incr += 4096 / 2;
 
+	// limit the requesting memory
+	incr = MIN(MAX_INCR, incr);
+
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
 		tst_count = 0;
-- 
2.7.4

