From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri,  7 May 2021 09:17:37 +0100
Subject: [LTP] [PATCH] bpf_prog05: Use 64bit wide integer constant on m32
Message-ID: <20210507081737.26674-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 32bit 1UL is only 32bits wide. We need it to be 64bits.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/syscalls/bpf/bpf_prog05.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/bpf/bpf_prog05.c b/testcases/kernel/syscalls/bpf/bpf_prog05.c
index f2e0e4698..2dce72ee8 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog05.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog05.c
@@ -142,11 +142,11 @@ static void run(void)
 	*key = 0;
 
 	tst_res(TINFO, "Check w7(-1) /= w6(0) [r7 = -1, r6 = 1 << 32]");
-	expect_reg_val("src(r6)", 1UL << 32);
+	expect_reg_val("src(r6)", 1ULL << 32);
 	expect_reg_val("dst(r7)", 0);
 
 	tst_res(TINFO, "Check w7(-1) %%= w6(0) [r7 = -1, r6 = 1 << 32]");
-	expect_reg_val("src(r6)", 1UL << 32);
+	expect_reg_val("src(r6)", 1ULL << 32);
 	expect_reg_val("dst(r7)", (uint32_t)-1);
 
 	SAFE_CLOSE(map_fd);
-- 
2.31.1

