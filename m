From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Sep 2021 15:08:17 +0200
Subject: [LTP] [PATCH v2 4/7] sched/process.c: Log into cwd, add *.log suffix
In-Reply-To: <20210910130820.21141-1-pvorel@suse.cz>
References: <20210910130820.21141-1-pvorel@suse.cz>
Message-ID: <20210910130820.21141-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

process.c hanged if run with debugging (-D) and log directory (slot/)
wasn't created before.

As nothing depends on this path, log into cwd, for clarity add .log
suffix.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/sched/process_stress/process.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/sched/process_stress/process.c b/testcases/kernel/sched/process_stress/process.c
index 777cdecd4..1fd520eee 100644
--- a/testcases/kernel/sched/process_stress/process.c
+++ b/testcases/kernel/sched/process_stress/process.c
@@ -52,7 +52,6 @@
 #define TNDX 3
 #define MAXBVAL 70
 #define MAXDVAL 11
-#define SLOTDIR "./slot/"
 
 #ifdef _LINUX
 			/* LINUX #defnes */
@@ -539,7 +538,7 @@ int spawn(int val)
 			pid = fork();
 			if (!pid) {	/* CHILD */
 				if (AUSDEBUG) {
-					sprintf(foo, "%sslot%d", SLOTDIR, tval);
+					sprintf(foo, "slot%d.log", tval);
 
 					if ((freopen(foo, "w", stderr)) == NULL) {
 						fprintf(stderr, "freopen(%s, w, stderr) failed: %s (%d)\n",
-- 
2.33.0

