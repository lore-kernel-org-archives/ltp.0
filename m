From: Pengfei Xu <pengfei.xu@intel.com>
Date: Thu, 19 Dec 2019 21:18:54 +0800
Subject: [LTP] [PATCH v4 3/4] lib: add any kconfig to match the expected
 value function into kconfig test
In-Reply-To: <20191219131855.28799-1-pengfei.xu@intel.com>
References: <20191219131855.28799-1-pengfei.xu@intel.com>
Message-ID: <20191219131855.28799-3-pengfei.xu@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

config01/02/03/04 should be passed for UMIP kconfig
All cases in config05 should be failed.

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 lib/newlib_tests/config01       | 1 +
 lib/newlib_tests/config02       | 1 +
 lib/newlib_tests/config03       | 1 +
 lib/newlib_tests/config04       | 1 +
 lib/newlib_tests/config05       | 2 ++
 lib/newlib_tests/test_kconfig.c | 1 +
 6 files changed, 7 insertions(+)

diff --git a/lib/newlib_tests/config01 b/lib/newlib_tests/config01
index 96d68d836..085c9368c 100644
--- a/lib/newlib_tests/config01
+++ b/lib/newlib_tests/config01
@@ -2,3 +2,4 @@
 CONFIG_MMU=y
 CONFIG_EXT4_FS=m
 CONFIG_PGTABLE_LEVELS=4
+CONFIG_X86_UMIP=y
diff --git a/lib/newlib_tests/config02 b/lib/newlib_tests/config02
index 2de45cff8..ca71d26c1 100644
--- a/lib/newlib_tests/config02
+++ b/lib/newlib_tests/config02
@@ -2,3 +2,4 @@
 # CONFIG_MMU is not set
 CONFIG_EXT4_FS=m
 CONFIG_PGTABLE_LEVELS=4
+CONFIG_X86_INTEL_UMIP=y
diff --git a/lib/newlib_tests/config03 b/lib/newlib_tests/config03
index 1a3b9e648..8a92def74 100644
--- a/lib/newlib_tests/config03
+++ b/lib/newlib_tests/config03
@@ -2,3 +2,4 @@
 CONFIG_MMU=y
 CONFIG_EXT4_FS=m
 CONFIG_PGTABLE_LEVELS=44
+CONFIG_X86_UMIP=y
diff --git a/lib/newlib_tests/config04 b/lib/newlib_tests/config04
index cce7051ae..424157fec 100644
--- a/lib/newlib_tests/config04
+++ b/lib/newlib_tests/config04
@@ -1,4 +1,5 @@
 # Unexpected CONFIG_EXT4_FS compiled in
 CONFIG_MMU=y
 CONFIG_EXT4_FS=y
+CONFIG_X86_INTEL_UMIP=y
 CONFIG_PGTABLE_LEVELS=4
diff --git a/lib/newlib_tests/config05 b/lib/newlib_tests/config05
index a9d7bab4d..e68fa8913 100644
--- a/lib/newlib_tests/config05
+++ b/lib/newlib_tests/config05
@@ -1,3 +1,5 @@
 # Everything is wrong
 CONFIG_EXT4_FS=y
 CONFIG_PGTABLE_LEVELS=44
+CONFIG_X86_UMI=y
+CONFIG_X86_INT_UMIP=y
diff --git a/lib/newlib_tests/test_kconfig.c b/lib/newlib_tests/test_kconfig.c
index d9c662fc5..9515b60e2 100644
--- a/lib/newlib_tests/test_kconfig.c
+++ b/lib/newlib_tests/test_kconfig.c
@@ -14,6 +14,7 @@ static const char *kconfigs[] = {
 	"CONFIG_MMU",
 	"CONFIG_EXT4_FS=m",
 	"CONFIG_PGTABLE_LEVELS=4",
+	"CONFIG_X86_INTEL_UMIP|CONFIG_X86_UMIP=y",
 	NULL
 };
 
-- 
2.14.1

