From: Petr Vorel <petr.vorel@gmail.com>
Date: Mon, 18 Mar 2019 04:23:30 +0100
Subject: [LTP] [PATCH 5/5] mallopt: Test only on glibc
In-Reply-To: <20190318032330.3346-1-petr.vorel@gmail.com>
References: <20190318032330.3346-1-petr.vorel@gmail.com>
Message-ID: <20190318032330.3346-6-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test works with is glibc specific definitions M_MXFAST , M_NLBLKS, which
aren't supported on other libc (uClibc, MUSL, Bionic), probably no other
libc will ever define.
uClibc also defines them in headers, that's we explicitly check glibc.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
Hi,

maybe #ifdef M_MXFAST && !defined(UCLINUX) would be better.

Kind regards,
Petr
---
 testcases/kernel/syscalls/mallopt/mallopt01.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/mallopt/mallopt01.c b/testcases/kernel/syscalls/mallopt/mallopt01.c
index 416fc48be..14e26dd81 100644
--- a/testcases/kernel/syscalls/mallopt/mallopt01.c
+++ b/testcases/kernel/syscalls/mallopt/mallopt01.c
@@ -63,7 +63,7 @@ extern int tst_COUNT;		/* Test Case counter for tst_routines */
 
 void printinfo();
 
-#if !defined(UCLINUX)
+#if defined(__GLIBC__)
 struct mallinfo info;
 
 int main(int argc, char *argv[])
@@ -150,6 +150,6 @@ void printinfo(void)
 #else
 int main(void)
 {
-	tst_brkm(TCONF, NULL, "test is not available on uClinux");
+	tst_brkm(TCONF, NULL, "mallopt defined only for glibc");
 }
-#endif /* if !defined(UCLINUX) */
+#endif
-- 
2.20.1

