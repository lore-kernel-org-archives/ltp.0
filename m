From: Pengfei Xu <pengfei.xu@intel.com>
Date: Fri, 20 Dec 2019 17:25:28 +0800
Subject: [LTP] [PATCH v5 3/4] lib: add usage that any kconfig with or
 without expected value in document
In-Reply-To: <20191220092529.3239-1-pengfei.xu@intel.com>
References: <20191220092529.3239-1-pengfei.xu@intel.com>
Message-ID: <20191220092529.3239-3-pengfei.xu@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 doc/test-writing-guidelines.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 79d857fea..2299b6982 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1590,7 +1590,13 @@ aborted with 'TCONF' if any of the required options were not set.
 #include "tst_test.h"
 
 static const char *kconfigs[] = {
-	"CONFIG_X86_INTEL_UMIP",
+	"CONFIG_EXT4_FS=y",
+	"CONFIG_MMU",
+	/* one CONFIG_A without expected value, add |NA as the end is optional */
+	"CONFIG_MMU|NA",
+	"CONFIG_X86_INTEL_UMIP|CONFIG_X86_UMIP=y",
+	/* CONFIG_A|CONFIG_B without expected value, need to add |NA as the end */
+	"CONFIG_X86_INTEL_UMIP|CONFIG_X86_UMIP|NA",
 	NULL
 };
 
-- 
2.14.1

