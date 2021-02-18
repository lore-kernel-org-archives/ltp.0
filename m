From: Palmer Dabbelt <palmerdabbelt@google.com>
Date: Wed, 17 Feb 2021 20:45:52 -0800
Subject: [LTP] [PATCH 1/2] fsstress: Indicate sg_handler's argument is unused
Message-ID: <20210218044553.2514218-1-palmerdabbelt@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This argument can't be removed because it's part of sigaction, but it's
triggering an unused argument warning.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 testcases/kernel/fs/fsstress/fsstress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/fs/fsstress/fsstress.c
index 811e6ff14..b53a99180 100644
--- a/testcases/kernel/fs/fsstress/fsstress.c
+++ b/testcases/kernel/fs/fsstress/fsstress.c
@@ -280,7 +280,7 @@ void usage(void);
 void write_freq(void);
 void zero_freq(void);
 
-void sg_handler(int signum)
+void sg_handler(int signum __attribute__((unused)))
 {
 	should_stop = 1;
 }
-- 
2.30.0.478.g8a0d178c01-goog

