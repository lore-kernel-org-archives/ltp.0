From: Steve Ellcey <sellcey@cavium.com>
Date: Wed,  1 Mar 2017 09:20:48 -0800
Subject: [LTP] [PATCH] syscalls/fcntl14: Remove unneeded time() declaration.
Message-ID: <1488388848-26891-1-git-send-email-sellcey@caviumnetworks.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The 'extern long time()' declaration conflicts with time.h which
declares time() to be of type time_t which may or may not be long.
This declaration causes a build failure on x86_64 if the file is
compiled with the -mx32 flag.

Signed-off-by: Steve Ellcey <sellcey@caviumnetworks.com>
---
 testcases/kernel/syscalls/fcntl/fcntl14.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl14.c b/testcases/kernel/syscalls/fcntl/fcntl14.c
index c61eb24..1799084 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl14.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl14.c
@@ -775,8 +775,6 @@ void dochild(void)
 
 void run_test(int file_flag, int file_mode, int seek, int start, int end)
 {
-	extern long time();
-
 	fail = 0;
 
 	for (test = start; test < end; test++) {
-- 
2.7.4

