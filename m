From: Sandeep Patil <sspatil@google.com>
Date: Mon, 19 Mar 2018 14:13:40 -0700
Subject: [LTP] [PATCH] syscalls/mprotect01: map /dev/zero instead of
	/etc/passwd
Message-ID: <20180319211340.83921-1-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test creates a read-only map for /etc/passwd to test
against errors returned by mprotect with PROT_WRITE. This
doesn't work in Android systems (no /etc/passwd)

More portable solution is to replace /etc/passwd with
/dev/zero instead. That fixes the problem for Android
systems

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 testcases/kernel/syscalls/mprotect/mprotect01.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/mprotect/mprotect01.c b/testcases/kernel/syscalls/mprotect/mprotect01.c
index 7c4f10e02..be4d982ea 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect01.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect01.c
@@ -137,8 +137,8 @@ static void setup2(struct test_case *self)
 
 static void setup3(struct test_case *self)
 {
-	fd = SAFE_OPEN(cleanup, "/etc/passwd", O_RDONLY);
-	
+	fd = SAFE_OPEN(cleanup, "/dev/zero", O_RDONLY);
+
 	self->len = getpagesize();
 
 	/*
-- 
2.16.2.804.g6dcf76e118-goog

