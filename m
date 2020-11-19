From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 19 Nov 2020 12:52:30 +0100
Subject: [LTP] [PATCH v4 3/3] syscalls/iopl02,
 ioperm02: Skip when kernel is locked down
In-Reply-To: <20201119115230.8829-1-mdoucha@suse.cz>
References: <20201119115230.8829-1-mdoucha@suse.cz>
Message-ID: <20201119115230.8829-3-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The iopl() and ioperm() syscalls are blocked when the kernel is locked down.
The order of sanity checks is not guaranteed so it's better to skip these
tests even if they accidentally work.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/ioperm/ioperm02.c | 4 ++++
 testcases/kernel/syscalls/iopl/iopl02.c     | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/testcases/kernel/syscalls/ioperm/ioperm02.c b/testcases/kernel/syscalls/ioperm/ioperm02.c
index 1808191bf..80dcb992e 100644
--- a/testcases/kernel/syscalls/ioperm/ioperm02.c
+++ b/testcases/kernel/syscalls/ioperm/ioperm02.c
@@ -45,6 +45,10 @@ static struct tcase_t {
 
 static void setup(void)
 {
+	/* ioperm() is restricted under kernel lockdown. */
+	if (tst_lockdown_enabled())
+		tst_brk(TCONF, "Kernel is locked down, skip this test");
+
 	/*
 	 * The value of IO_BITMAP_BITS (include/asm-i386/processor.h) changed
 	 * from kernel 2.6.8 to permit 16-bits (65536) ioperm
diff --git a/testcases/kernel/syscalls/iopl/iopl02.c b/testcases/kernel/syscalls/iopl/iopl02.c
index 6a817cf2d..a6135ddf3 100644
--- a/testcases/kernel/syscalls/iopl/iopl02.c
+++ b/testcases/kernel/syscalls/iopl/iopl02.c
@@ -52,6 +52,11 @@ static void verify_iopl(unsigned int i)
 static void setup(void)
 {
 	struct passwd *pw;
+
+	/* iopl() is restricted under kernel lockdown. */
+	if (tst_lockdown_enabled())
+		tst_brk(TCONF, "Kernel is locked down, skip this test");
+
 	pw = SAFE_GETPWNAM("nobody");
 	SAFE_SETEUID(pw->pw_uid);
 }
-- 
2.29.2

