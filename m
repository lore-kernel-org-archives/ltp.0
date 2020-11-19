From: Pengfei Xu <pengfei.xu@intel.com>
Date: Thu, 19 Nov 2020 14:29:34 -0500
Subject: [LTP] [PATCH] lib/tst_kconfig: Fix unexpected error when checking
 Kconfig containing numbers
Message-ID: <20201119192934.5653-1-pengfei.xu@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fix unexpected error when checking Kconfig containing numbers after commit:
eeed458492cc7dc01ad3a5fff500b09d1fda4922:"lib/tst_kconfig: Validate variables",
unexpected error sample is as below:
"
CONFIG_X86_INTEL_UMIP=y
        ^
Unexpected character in variable name

CONFIG_X86_UMIP=y
        ^
Unexpected character in variable name

tst_kconfig.c:475: TBROK: Invalid kconfig variables!
"

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 lib/tst_kconfig.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 72830703c..8dc623952 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -262,6 +262,11 @@ static int validate_var(const struct tst_expr_tok *var)
 			continue;
 		}
 
+		if (c >= '0' && c <= '9') {
+			i++;
+			continue;
+		}
+
 		if (c == '=') {
 			i++;
 			break;
-- 
2.20.1

