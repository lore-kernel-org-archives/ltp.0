From: Erico Nunes <ernunes@redhat.com>
Date: Tue, 28 Jul 2020 18:22:07 +0200
Subject: [LTP] [PATCH v2 3/3] iopl01: skip test if kernel is locked down
In-Reply-To: <20200728162207.332109-1-ernunes@redhat.com>
References: <20200728162207.332109-1-ernunes@redhat.com>
Message-ID: <20200728162207.332109-3-ernunes@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

iopl is restricted under kernel lockdown.

Signed-off-by: Erico Nunes <ernunes@redhat.com>
---
v2:
- update to skip the test here rather than relying on the helper
  function to skip.
---
 testcases/kernel/syscalls/iopl/iopl01.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/kernel/syscalls/iopl/iopl01.c b/testcases/kernel/syscalls/iopl/iopl01.c
index edf586cd1..e5ec1147f 100644
--- a/testcases/kernel/syscalls/iopl/iopl01.c
+++ b/testcases/kernel/syscalls/iopl/iopl01.c
@@ -42,6 +42,14 @@ static void verify_iopl(void)
 	}
 }
 
+static void setup(void)
+{
+	/* iopl is restricted under kernel lockdown. */
+	if (tst_lockdown_enabled())
+		tst_brk(TCONF, "Kernel is locked down, skip this test");
+
+}
+
 static void cleanup(void)
 {
 	/*
@@ -54,6 +62,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.test_all = verify_iopl,
 	.needs_root = 1,
+	.setup = setup,
 	.cleanup = cleanup,
 };
 
-- 
2.26.2

