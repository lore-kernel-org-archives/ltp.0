From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 13 Aug 2020 14:57:37 +0200
Subject: [LTP] [PATCH] [COMMITTED] msgget05: Fix build on centos 6
Message-ID: <20200813125737.20114-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Which has old gcc that does not allow variables decleared inside of the
for loop.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/ipc/msgget/msgget05.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget05.c b/testcases/kernel/syscalls/ipc/msgget/msgget05.c
index a0758d46d..d6177bbed 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget05.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget05.c
@@ -51,7 +51,9 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	for (int i = 0; i < 2; i++) {
+	int i;
+
+	for (i = 0; i < 2; i++) {
 		if (queue_id[i] != -1)
 			SAFE_MSGCTL(queue_id[i], IPC_RMID, NULL);
 	}
-- 
2.26.2

