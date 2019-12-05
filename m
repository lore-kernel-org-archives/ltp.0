From: Yi Zhao <yi.zhao@windriver.com>
Date: Thu, 5 Dec 2019 14:30:21 +0800
Subject: [LTP] [PATCH] pidfd_send_signal03: fix compile error with
 -Werror=format-security flag
Message-ID: <20191205063021.9564-1-yi.zhao@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixed when compile with "-Wformat -Wformat-security -Werror=format-security":

In file included from ../../../../include/tst_test.h:85,
                 from pidfd_send_signal.h:10,
                 from pidfd_send_signal03.c:21:
pidfd_send_signal03.c: In function 'verify_pidfd_send_signal':
../../../../include/tst_safe_file_ops.h:53:27: error: format not a string literal and no format arguments [-Werror=format-security]
   53 |                   (path), (fmt), ## __VA_ARGS__)
      |                           ^~~~~
pidfd_send_signal03.c:62:3: note: in expansion of macro 'SAFE_FILE_PRINTF'
   62 |   SAFE_FILE_PRINTF(last_pid_file, pid_str);
      |   ^~~~~~~~~~~~~~~~

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
index 27dbc6626..19d943d06 100644
--- a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
+++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
@@ -59,7 +59,7 @@ static void verify_pidfd_send_signal(void)
 
 		/* Manipulate PID for next process */
 		sprintf(pid_str, "%d", pid - 1);
-		SAFE_FILE_PRINTF(last_pid_file, pid_str);
+		SAFE_FILE_PRINTF(last_pid_file, "%s", pid_str);
 
 		new_pid = SAFE_FORK();
 		if (new_pid == 0) {
-- 
2.17.1

