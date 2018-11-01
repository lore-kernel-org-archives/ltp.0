From: Pengfei Xu <pengfei.xu@intel.com>
Date: Thu,  1 Nov 2018 09:49:28 +0800
Subject: [LTP] [PATCH ltp v2 2/2] Add umip(User Mode Instruction Prevention)
	test cases
In-Reply-To: <20181101014928.23628-1-pengfei.xu@intel.com>
References: <20181101014928.23628-1-pengfei.xu@intel.com>
Message-ID: <20181101014928.23628-2-pengfei.xu@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add umip test cases into ltp/runtest/secure_umip

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 runtest/secure_umip | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 runtest/secure_umip

diff --git a/runtest/secure_umip b/runtest/secure_umip
new file mode 100644
index 000000000..c93301b62
--- /dev/null
+++ b/runtest/secure_umip
@@ -0,0 +1,6 @@
+#DESCRIPTION: CPU security feature UMIP test
+umip_protect_sgdt		umip_func.sh umip_gp_test g
+umip_protect_sidt		umip_func.sh umip_gp_test i
+umip_protect_sldt		umip_func.sh umip_gp_test l
+umip_protect_smsw		umip_func.sh umip_gp_test m
+umip_protect_str		umip_func.sh umip_gp_test t
-- 
2.14.1

