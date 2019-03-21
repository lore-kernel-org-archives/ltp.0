From: Petr Vorel <petr.vorel@gmail.com>
Date: Thu, 21 Mar 2019 23:38:52 +0100
Subject: [LTP] [COMMITTED][PATCH v2 1/1] msgrcv/msgrcv08: Rename struct
	msgbuf
Message-ID: <20190321223852.10145-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

According to man msgrcv(3) struct for user buffer should be defined by
user. Therefore rename it as MUSL defines struct msgbuf in <sys/msg.h>
under _BSD_SOURCE, so the name conflict.

Reported-by: Dengke Du <dengke.du@windriver.com>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
index a757c0d18..1773a1bf4 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
@@ -48,15 +48,15 @@ const int TST_TOTAL = 1;
 
 #if __WORDSIZE == 32
 
-struct msgbuf {
+struct mbuf {
 	long mtype;     /* message type, must be > 0 */
 	char mtext[16]; /* message data */
 };
 
 static void msr(int msqid)
 {
-	struct msgbuf msbs;
-	struct msgbuf msbr;
+	struct mbuf msbs;
+	struct mbuf msbr;
 	ssize_t sret;
 	long mtype = 121;
 
-- 
2.21.0

