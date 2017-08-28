From: Sandeep Patil <sspatil@google.com>
Date: Mon, 28 Aug 2017 09:40:42 -0700
Subject: [LTP] [PATCH v2 1/2] getcwd01: Remove unnecessary usage of
	temporary directory
In-Reply-To: <20170828164043.93407-1-sspatil@google.com>
References: <20170828164043.93407-1-sspatil@google.com>
Message-ID: <20170828164043.93407-2-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test checks for errors returned from the system call and
doesn't really need a temporary directory in order to do
that.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 testcases/kernel/syscalls/getcwd/getcwd01.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/testcases/kernel/syscalls/getcwd/getcwd01.c b/testcases/kernel/syscalls/getcwd/getcwd01.c
index fdf306103..1199e9f2e 100644
--- a/testcases/kernel/syscalls/getcwd/getcwd01.c
+++ b/testcases/kernel/syscalls/getcwd/getcwd01.c
@@ -74,13 +74,7 @@ static void verify_getcwd(unsigned int n)
 	tst_res(TPASS | TTERRNO, "getcwd() failed as expected");
 }
 
-static void setup(void)
-{
-	SAFE_CHDIR("/tmp");
-}
-
 static struct tst_test test = {
-	.setup = setup,
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_getcwd
 };
-- 
2.14.1.342.g6490525c54-goog

