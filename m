From: Erico Nunes <ernunes@redhat.com>
Date: Mon, 20 Jul 2020 21:49:20 +0200
Subject: [LTP] [PATCH 3/3] iopl01: skip test if kernel is locked down
In-Reply-To: <20200720194920.22784-1-ernunes@redhat.com>
References: <20200720194920.22784-1-ernunes@redhat.com>
Message-ID: <20200720194920.22784-3-ernunes@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

iopl is restricted under kernel lockdown.

Signed-off-by: Erico Nunes <ernunes@redhat.com>
---
 testcases/kernel/syscalls/iopl/iopl01.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/testcases/kernel/syscalls/iopl/iopl01.c b/testcases/kernel/syscalls/iopl/iopl01.c
index edf586cd1..4237d3f10 100644
--- a/testcases/kernel/syscalls/iopl/iopl01.c
+++ b/testcases/kernel/syscalls/iopl/iopl01.c
@@ -42,6 +42,12 @@ static void verify_iopl(void)
 	}
 }
 
+static void setup(void)
+{
+	/* iopl is restricted under kernel lockdown. */
+	tst_lockdown_skip();
+}
+
 static void cleanup(void)
 {
 	/*
@@ -54,6 +60,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.test_all = verify_iopl,
 	.needs_root = 1,
+	.setup = setup,
 	.cleanup = cleanup,
 };
 
-- 
2.26.2

