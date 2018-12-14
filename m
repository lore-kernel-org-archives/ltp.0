From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 14 Dec 2018 16:17:37 +0800
Subject: [LTP] [PATCH v2] openposix/strncpy1-1: Fix compiler errors/warnings
In-Reply-To: <20181214083313.GA18691@rei>
References: <20181214083313.GA18691@rei>
Message-ID: <1544775457-16266-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

pragma diagnostic can support push/pop and be allowed inside functions
by commit 0955be65 on gcc-4.6, and it can support -Wstringop-truncation
by commit d8aad78 on gcc-8.1.  We try to avoid some compiler errors or
warnings by removing pragma diagnostic for test directly, because we
don't get any failure after removing it on old/new gcc.

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
 testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c
index 396bd60..b67d09d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c
@@ -61,10 +61,7 @@ int main(void)
         sample_str_1 = random_string(i);
         num_bytes = rand() % i;
 
-        #pragma GCC diagnostic push
-        #pragma GCC diagnostic ignored "-Wstringop-truncation"
         ret_str = strncpy(sample_str_2, sample_str_1, num_bytes);
-        #pragma GCC diagnostic pop
 
         sample_str_2[num_bytes] = '\0';
         sample_str_1[num_bytes] = '\0';
-- 
1.8.3.1



