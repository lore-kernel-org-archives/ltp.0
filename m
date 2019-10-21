From: Pengfei Xu <pengfei.xu@intel.com>
Date: Mon, 21 Oct 2019 09:29:40 +0800
Subject: [LTP] [PATCH] umip_basic_test.c: remove useless new lines print
Message-ID: <20191021012940.31678-1-pengfei.xu@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 testcases/kernel/security/umip/umip_basic_test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/security/umip/umip_basic_test.c b/testcases/kernel/security/umip/umip_basic_test.c
index 5a2b71013..1baa26c52 100644
--- a/testcases/kernel/security/umip/umip_basic_test.c
+++ b/testcases/kernel/security/umip/umip_basic_test.c
@@ -47,7 +47,7 @@ static void asm_sidt(void)
 	unsigned char val[IDT_LEN];
 
 	memset(val, 0, sizeof(val));
-	tst_res(TINFO, "TEST sidt, sidt result save at [%p]\n", val);
+	tst_res(TINFO, "TEST sidt, sidt result save at [%p]", val);
 	asm volatile("sidt %0\n" : "=m" (val));
 	exit(0);
 }
@@ -56,7 +56,7 @@ static void asm_sldt(void)
 {
 	unsigned long val;
 
-	tst_res(TINFO, "TEST sldt, sldt result save at [%p]\n", &val);
+	tst_res(TINFO, "TEST sldt, sldt result save at [%p]", &val);
 	asm volatile("sldt %0\n" : "=m" (val));
 	exit(0);
 }
@@ -65,7 +65,7 @@ static void asm_smsw(void)
 {
 	unsigned long val;
 
-	tst_res(TINFO, "TEST smsw, smsw result save at [%p]\n", &val);
+	tst_res(TINFO, "TEST smsw, smsw result save at [%p]", &val);
 	asm volatile("smsw %0\n" : "=m" (val));
 	exit(0);
 }
@@ -74,7 +74,7 @@ static void asm_str(void)
 {
 	unsigned long val;
 
-	tst_res(TINFO, "TEST str, str result save at [%p]\n", &val);
+	tst_res(TINFO, "TEST str, str result save at [%p]", &val);
 	asm volatile("str %0\n" : "=m" (val));
 	exit(0);
 }
-- 
2.14.1

