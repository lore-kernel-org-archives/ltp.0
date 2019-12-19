From: Pengfei Xu <pengfei.xu@intel.com>
Date: Thu, 19 Dec 2019 21:18:53 +0800
Subject: [LTP] [PATCH v4 2/4] umip_basic_test.c: improve kconfig check to
 avoid umip wrong abort case
In-Reply-To: <20191219131855.28799-1-pengfei.xu@intel.com>
References: <20191219131855.28799-1-pengfei.xu@intel.com>
Message-ID: <20191219131855.28799-2-pengfei.xu@intel.com>
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

