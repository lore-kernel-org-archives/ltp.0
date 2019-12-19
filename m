From: Pengfei Xu <pengfei.xu@intel.com>
Date: Thu, 19 Dec 2019 21:18:55 +0800
Subject: [LTP] [PATCH v4 4/4] lib: add any kconfig to match the expected
 value function document
In-Reply-To: <20191219131855.28799-1-pengfei.xu@intel.com>
References: <20191219131855.28799-1-pengfei.xu@intel.com>
Message-ID: <20191219131855.28799-4-pengfei.xu@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 doc/test-writing-guidelines.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 79d857fea..e64ff8716 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1590,7 +1590,9 @@ aborted with 'TCONF' if any of the required options were not set.
 #include "tst_test.h"
 
 static const char *kconfigs[] = {
-	"CONFIG_X86_INTEL_UMIP",
+	"CONFIG_EXT4_FS=y",
+	"CONFIG_MMU",
+	"CONFIG_X86_INTEL_UMIP|CONFIG_X86_UMIP=y",
 	NULL
 };
 
-- 
2.14.1

