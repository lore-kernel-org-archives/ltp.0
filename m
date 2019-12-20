From: Pengfei Xu <pengfei.xu@intel.com>
Date: Fri, 20 Dec 2019 17:25:29 +0800
Subject: [LTP] [PATCH v5 4/4] umip_basic_test.c: improve kconfig
 verification to avoid umip wrong abort case
In-Reply-To: <20191220092529.3239-1-pengfei.xu@intel.com>
References: <20191220092529.3239-1-pengfei.xu@intel.com>
Message-ID: <20191220092529.3239-4-pengfei.xu@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From v5.5 main line, umip kconfig changed from "CONFIG_X86_INTEL_UMIP=y"
to "CONFIG_X86_UMIP=y".
We could use "CONFIG_X86_INTEL_UMIP|CONFIG_X86_UMIP=y" to check kconfig
CONFIG_X86_INTEL_UMIP=y(old kernel) or CONFIG_X86_UMIP=y(new kernel) for umip.

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 testcases/kernel/security/umip/umip_basic_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/security/umip/umip_basic_test.c b/testcases/kernel/security/umip/umip_basic_test.c
index 1baa26c52..24eca8890 100644
--- a/testcases/kernel/security/umip/umip_basic_test.c
+++ b/testcases/kernel/security/umip/umip_basic_test.c
@@ -171,7 +171,7 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.test = verify_umip_instruction,
 	.needs_kconfigs = (const char *[]){
-		"CONFIG_X86_INTEL_UMIP=y",
+		"CONFIG_X86_INTEL_UMIP|CONFIG_X86_UMIP=y",
 		NULL
 	},
 	.needs_root = 1,
-- 
2.14.1

