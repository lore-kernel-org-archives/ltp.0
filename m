From: Erico Nunes <ernunes@redhat.com>
Date: Tue, 28 Jul 2020 18:22:06 +0200
Subject: [LTP] [PATCH v2 2/3] ioperm01: skip test if kernel is locked down
In-Reply-To: <20200728162207.332109-1-ernunes@redhat.com>
References: <20200728162207.332109-1-ernunes@redhat.com>
Message-ID: <20200728162207.332109-2-ernunes@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ioperm is restricted under kernel lockdown.

Signed-off-by: Erico Nunes <ernunes@redhat.com>
---
v2:
- update to skip the test here rather than relying on the helper
  function to skip.
---
 testcases/kernel/syscalls/ioperm/ioperm01.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/ioperm/ioperm01.c b/testcases/kernel/syscalls/ioperm/ioperm01.c
index 4c5c0e6ea..c25baa678 100644
--- a/testcases/kernel/syscalls/ioperm/ioperm01.c
+++ b/testcases/kernel/syscalls/ioperm/ioperm01.c
@@ -42,6 +42,10 @@ static void verify_ioperm(void)
 
 static void setup(void)
 {
+	/* ioperm is restricted under kernel lockdown. */
+	if (tst_lockdown_enabled())
+		tst_brk(TCONF, "Kernel is locked down, skip this test");
+
 	/*
 	 * The value of IO_BITMAP_BITS (include/asm-i386/processor.h) changed
 	 * from kernel 2.6.8 to permit 16-bits ioperm
-- 
2.26.2

