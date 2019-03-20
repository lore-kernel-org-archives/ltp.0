From: Petr Vorel <petr.vorel@gmail.com>
Date: Wed, 20 Mar 2019 22:57:07 +0100
Subject: [LTP] [PATCH 1/1] msgrcv/msgrcv08.c: Use struct msgbuf defined in
	<sys/msg.h>
Message-ID: <20190320215707.30268-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

which requires to define _GNU_SOURCE.
This fixes MUSL build.

NOTE: char array from struct has usually length 1, the one from test had 16,
but that's not a limitation.

Fixes: eccd238da ("ipc/msgrcv: add new testcase msgrcv08")

Reported-by: Dengke Du <dengke.du@windriver.com>
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
Hi Li,

what was the reason to use size 16?

Kind regards,
Petr

PS: I found and fix this error independently while working on MUSL build
fixes, but than found it was reported by Dengke Du in PR #177 [1].

[1] https://github.com/linux-test-project/ltp/pull/177/commits/87c4a4ae2817f835a594ab795dc938a27c642b92
---
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
index a757c0d18..21d77c9dd 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
@@ -35,6 +35,7 @@
  *      If this progarm is compiled as 64-bit application it works.
  */
 
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
@@ -48,11 +49,6 @@ const int TST_TOTAL = 1;
 
 #if __WORDSIZE == 32
 
-struct msgbuf {
-	long mtype;     /* message type, must be > 0 */
-	char mtext[16]; /* message data */
-};
-
 static void msr(int msqid)
 {
 	struct msgbuf msbs;
-- 
2.21.0

