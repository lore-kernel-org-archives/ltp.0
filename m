From: Pengfei Xu <pengfei.xu@intel.com>
Date: Fri, 20 Dec 2019 17:25:27 +0800
Subject: [LTP] [PATCH v5 2/4] lib: add any kconfig with or without expected
 value into kconfig test
In-Reply-To: <20191220092529.3239-1-pengfei.xu@intel.com>
References: <20191220092529.3239-1-pengfei.xu@intel.com>
Message-ID: <20191220092529.3239-2-pengfei.xu@intel.com>
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
 lib/newlib_tests/config05       | 4 ++++
 lib/newlib_tests/test_kconfig.c | 5 +++++
 6 files changed, 13 insertions(+)

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
index a9d7bab4d..85c8ad22f 100644
--- a/lib/newlib_tests/config05
+++ b/lib/newlib_tests/config05
@@ -1,3 +1,7 @@
 # Everything is wrong
 CONFIG_EXT4_FS=y
 CONFIG_PGTABLE_LEVELS=44
+CONFIG_X86_UMI=y
+CONFIG_X86_UMIPP=y
+CONFIG_X86_INTEL_UMI=y
+CONFIG_X86_INTEL_UMIPP=y
diff --git a/lib/newlib_tests/test_kconfig.c b/lib/newlib_tests/test_kconfig.c
index d9c662fc5..d3a1c2b0b 100644
--- a/lib/newlib_tests/test_kconfig.c
+++ b/lib/newlib_tests/test_kconfig.c
@@ -12,8 +12,13 @@ static void do_test(void)
 
 static const char *kconfigs[] = {
 	"CONFIG_MMU",
+	/* one CONFIG_A without expected value, |NA as the end is optional */
+	"CONFIG_MMU|NA",
 	"CONFIG_EXT4_FS=m",
 	"CONFIG_PGTABLE_LEVELS=4",
+	"CONFIG_X86_INTEL_UMIP|CONFIG_X86_UMIP=y",
+	/* CONFIG_A|CONFIG_B without expected value, need to add |NA as the end */
+	"CONFIG_X86_INTEL_UMIP|CONFIG_X86_UMIP|NA",
 	NULL
 };
 
-- 
2.14.1

