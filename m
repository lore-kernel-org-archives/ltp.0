From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Jun 2021 15:23:08 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscalls/sendfile06: Fix format string
Message-ID: <20210630132308.31016-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There cannot be any characters between "%" and PRId64 since these two
when concatenated produce the format string for the 64bit integer that
follows.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/sendfile/sendfile06.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/sendfile/sendfile06.c b/testcases/kernel/syscalls/sendfile/sendfile06.c
index b504f1805..6133be4d0 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile06.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile06.c
@@ -54,7 +54,7 @@ static void run(void)
 			sb.st_size, TST_RET);
 	else if (after_pos != sb.st_size)
 		tst_res(TFAIL, "sendfile() updated the file position of in_fd unexpectedly,"
-			" expected file position: %," PRId64
+			" expected file position: %" PRId64
 			" actual file position %" PRId64,
 			(int64_t)(sb.st_size), (int64_t)(after_pos));
 	else
-- 
2.31.1

