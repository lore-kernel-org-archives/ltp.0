From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 12 Dec 2018 18:40:03 +0800
Subject: [LTP] [PATCH] openposix/strncpy1-1: Fix compiler errors/warnings
In-Reply-To: <20181211123931.GC27346@rei>
References: <20181211123931.GC27346@rei>
Message-ID: <1544611203-22197-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

pragma diagnostic can support push/pop and be allowed inside functions
by commit 0955be65 on gcc-4.6, and it can support -Wstringop-truncation
by commit d8aad78 on gcc-8.1.  We try to avoid some compiler errors or
warnings by just using pragma diagnostic for test on newer gcc(i.e. >= gcc-8.1)
because compiling and running test don't get any failure after removing
pragma diagnostic on older gcc.

For example:
1)compiling test gets the following error on gcc-4.4:
  ------------------------------------------------------
  error: #pragma GCC diagnostic not allowed inside functions
  ------------------------------------------------------
2)compiling test gets the following warning on gcc-4.8:
  -----------------------------------------------------
  warning: unknown option after ‘#pragma GCC diagnostic’ kind [-Wpragmas]
  ------------------------------------------------------

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 .../conformance/interfaces/strncpy/1-1.c           |   10 +++++++---
 testcases/open_posix_testsuite/include/posixtest.h |    2 ++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c
index 396bd60..7006b5f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c
@@ -61,10 +61,14 @@ int main(void)
         sample_str_1 = random_string(i);
         num_bytes = rand() % i;
 
-        #pragma GCC diagnostic push
-        #pragma GCC diagnostic ignored "-Wstringop-truncation"
+	#if GCC_VERSION >= 80100
+	# pragma GCC diagnostic push
+	# pragma GCC diagnostic ignored "-Wstringop-truncation"
+	#endif
         ret_str = strncpy(sample_str_2, sample_str_1, num_bytes);
-        #pragma GCC diagnostic pop
+	#if GCC_VERSION >= 80100
+	# pragma GCC diagnostic pop
+	#endif
 
         sample_str_2[num_bytes] = '\0';
         sample_str_1[num_bytes] = '\0';
diff --git a/testcases/open_posix_testsuite/include/posixtest.h b/testcases/open_posix_testsuite/include/posixtest.h
index dd1a9b2..8859804 100644
--- a/testcases/open_posix_testsuite/include/posixtest.h
+++ b/testcases/open_posix_testsuite/include/posixtest.h
@@ -47,3 +47,5 @@
 #define LTP_ATTRIBUTE_NORETURN		__attribute__((noreturn))
 #define LTP_ATTRIBUTE_UNUSED		__attribute__((unused))
 #define LTP_ATTRIBUTE_UNUSED_RESULT	__attribute__((warn_unused_result))
+
+#define GCC_VERSION (__GNUC__ * 10000 + __GNUC_MINOR__ * 100 + __GNUC_PATCHLEVEL__)
-- 
1.7.1



