From: Erico Nunes <ernunes@redhat.com>
Date: Mon, 20 Jul 2020 21:49:19 +0200
Subject: [LTP] [PATCH 2/3] ioperm01: skip test if kernel is locked down
In-Reply-To: <20200720194920.22784-1-ernunes@redhat.com>
References: <20200720194920.22784-1-ernunes@redhat.com>
Message-ID: <20200720194920.22784-2-ernunes@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ioperm is restricted under kernel lockdown.

Signed-off-by: Erico Nunes <ernunes@redhat.com>
---
 testcases/kernel/syscalls/ioperm/ioperm01.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/ioperm/ioperm01.c b/testcases/kernel/syscalls/ioperm/ioperm01.c
index 4c5c0e6ea..d1d633b20 100644
--- a/testcases/kernel/syscalls/ioperm/ioperm01.c
+++ b/testcases/kernel/syscalls/ioperm/ioperm01.c
@@ -42,6 +42,9 @@ static void verify_ioperm(void)
 
 static void setup(void)
 {
+	/* ioperm is restricted under kernel lockdown. */
+	tst_lockdown_skip();
+
 	/*
 	 * The value of IO_BITMAP_BITS (include/asm-i386/processor.h) changed
 	 * from kernel 2.6.8 to permit 16-bits ioperm
-- 
2.26.2

