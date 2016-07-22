From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 21 Jul 2016 21:26:43 -0700
Subject: [LTP] [PATCH V3 10/23] sysconf01: Use _SC_2_C_VERSION conditionally
In-Reply-To: <20160722042656.22346-1-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
Message-ID: <20160722042656.22346-10-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

_SC_2_C_VERSION is not available on musl

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/syscalls/sysconf/sysconf01.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/sysconf/sysconf01.c b/testcases/kernel/syscalls/sysconf/sysconf01.c
index 8542e77..7ebae23 100644
--- a/testcases/kernel/syscalls/sysconf/sysconf01.c
+++ b/testcases/kernel/syscalls/sysconf/sysconf01.c
@@ -102,7 +102,9 @@ int main(void)
 	test_sysconf(_SC_ATEXIT_MAX);
 	test_sysconf(_SC_2_C_BIND);
 	test_sysconf(_SC_2_C_DEV);
+#ifdef _SC_2_C_VERSION
 	test_sysconf(_SC_2_C_VERSION);
+#endif
 	/* 21 - 25 */
 	test_sysconf(_SC_2_CHAR_TERM);
 	test_sysconf(_SC_2_FORT_DEV);
-- 
2.9.0

