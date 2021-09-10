From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Sep 2021 15:08:20 +0200
Subject: [LTP] [PATCH v2 7/7] sched/process.c: Remove useless TRUE FALSE
 definitions
In-Reply-To: <20210910130820.21141-1-pvorel@suse.cz>
References: <20210910130820.21141-1-pvorel@suse.cz>
Message-ID: <20210910130820.21141-8-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

FALSE is not used at all and replace TRUE with 1 (there is no point
trying to use true from <stdbool.h> just for while).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/sched/process_stress/process.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/sched/process_stress/process.c b/testcases/kernel/sched/process_stress/process.c
index b66908e7a..9075305e1 100644
--- a/testcases/kernel/sched/process_stress/process.c
+++ b/testcases/kernel/sched/process_stress/process.c
@@ -46,13 +46,6 @@
 #define MAXBVAL 70
 #define MAXDVAL 11
 
-#ifndef TRUE
-#define TRUE 1
-#endif
-#ifndef FALSE
-#define FALSE 0
-#endif
-
 #ifdef DEBUG
 #define prtln()	printf("At line number: %d\n", __LINE__); \
 		fflush(NULL)
@@ -200,7 +193,7 @@ int send_message(int id, mtyp_t type, char *text)
 
 	strcpy(sndbuf.mtext, text);
 	sndbuf.mtyp = type;
-	while (TRUE) {
+	while (1) {
 		rc = msgsnd(id, &sndbuf, sizeof(struct messagebuf), IPC_NOWAIT);
 		if (rc == -1 && errno == EAGAIN) {
 			debugout("msgqueue %d of mtyp %d not ready to send\n",
@@ -992,7 +985,7 @@ void messenger(void)
 	 *  Infinite loop used to receive error messages from children and
 	 *  to terminate process tree.
 	 */
-	while (TRUE) {
+	while (1) {
 		rc = msgrcv(msgerr, &rcvbuf, sizeof(struct messagebuf), 0, 0);
 		if (rc == -1) {
 			switch (errno) {
-- 
2.33.0

