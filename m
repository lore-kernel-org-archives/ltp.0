From: Li Wang <liwang@redhat.com>
Date: Sun, 26 Apr 2020 17:00:53 +0800
Subject: [LTP] [COMMITTED] pipe2: add min_kver = "2.6.35" in pipe2_04
Message-ID: <20200426090053.26764-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To change the capacity of a pipe was involved from kernel-2.6.35 version.

  F_SETPIPE_SZ (int; since Linux 2.6.35)
  F_GETPIPE_SZ (void; since Linux 2.6.35)

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/pipe2/pipe2_04.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/pipe2/pipe2_04.c b/testcases/kernel/syscalls/pipe2/pipe2_04.c
index 1edb3f151..432007e4d 100644
--- a/testcases/kernel/syscalls/pipe2/pipe2_04.c
+++ b/testcases/kernel/syscalls/pipe2/pipe2_04.c
@@ -98,6 +98,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.min_kver = "2.6.35",
 	.test_all = test_pipe2,
 	.setup = setup,
 	.cleanup = cleanup,
-- 
2.21.1

