From: Palmer Dabbelt <palmerdabbelt@google.com>
Date: Wed, 17 Feb 2021 20:45:53 -0800
Subject: [LTP] [PATCH 2/2] fsstress: Indicate one of sync_f's arguments is
 unused
In-Reply-To: <20210218044553.2514218-1-palmerdabbelt@google.com>
References: <20210218044553.2514218-1-palmerdabbelt@google.com>
Message-ID: <20210218044553.2514218-2-palmerdabbelt@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This argument is necessary to make sync_f's prototype match opfnc_t for
the op table, but is otherwise unused and triggers an unused argument
warning.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 testcases/kernel/fs/fsstress/fsstress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/fs/fsstress/fsstress.c
index b53a99180..42ee696a5 100644
--- a/testcases/kernel/fs/fsstress/fsstress.c
+++ b/testcases/kernel/fs/fsstress/fsstress.c
@@ -2501,7 +2501,7 @@ void symlink_f(int opno, long r)
 }
 
 /* ARGSUSED */
-void sync_f(int opno, long r)
+void sync_f(int opno, long r __attribute__((unused)))
 {
 	sync();
 	if (verbose)
-- 
2.30.0.478.g8a0d178c01-goog

