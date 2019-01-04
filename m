From: Li Wang <liwang@redhat.com>
Date: Fri,  4 Jan 2019 17:52:56 +0800
Subject: [LTP] [PATCH RFC] fzsync: tst_fzsync_pair_wait exit when parent hit
	accidental break
Message-ID: <20190104095256.12266-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For system(rhel7.6, s390x) without __NR_recvmmsg supported, run
cve-2016-7117 result in timeout and killed by LTP framework. The
root reason is tst_syscall break with cleanup() function calling
in this trace path:

  tst_syscall(__NR_recvmmsg, ...)
    tst_brk()
      cleanup()
        tst_fzsync_pair_cleanup()
          SAFE_PTHREAD_JOIN(pair->thread_b, NULL);

cve-2016-7117 hung at here to wait for thread_b send_and_close() finishing.
But thread_b fall into infinite loop because of tst_fzsync_wait_b without
an extra condition to exit. Eventually, test get timeout error like:

  cve-2016-7117.c:145: CONF: syscall(-1) __NR_recvmmsg not supported
  Test timeouted, sending SIGKILL!
  tst_test.c:1125: INFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
  tst_test.c:1126: BROK: Test killed! (timeout?)

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_fuzzy_sync.h | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index de0402c9b..7e4d48f0a 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -517,7 +517,8 @@ static void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
  * @return A non-zero value if the thread should continue otherwise the
  * calling thread should exit.
  */
-static inline void tst_fzsync_pair_wait(int *our_cntr,
+static inline void tst_fzsync_pair_wait(struct tst_fzsync_pair *pair,
+					int *our_cntr,
 					int *other_cntr,
 					int *spins)
 {
@@ -530,7 +531,8 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
 		 * then our counter may already have been set to zero.
 		 */
 		while (tst_atomic_load(our_cntr) > 0
-		       && tst_atomic_load(our_cntr) < INT_MAX) {
+		       && tst_atomic_load(our_cntr) < INT_MAX
+		       && !tst_atomic_load(&pair->exit)) {
 			if (spins)
 				(*spins)++;
 		}
@@ -540,14 +542,16 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
 		 * Once both counters have been set to zero the invariant
 		 * is restored and we can continue.
 		 */
-		while (tst_atomic_load(our_cntr) > 1)
+		while (tst_atomic_load(our_cntr) > 1
+			&& !tst_atomic_load(&pair->exit))
 			;
 	} else {
 		/*
 		 * If our counter is less than the other thread's we are ahead
 		 * of it and need to wait.
 		 */
-		while (tst_atomic_load(our_cntr) < tst_atomic_load(other_cntr)) {
+		while (tst_atomic_load(our_cntr) < tst_atomic_load(other_cntr)
+			&& !tst_atomic_load(&pair->exit)) {
 			if (spins)
 				(*spins)++;
 		}
@@ -562,7 +566,7 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
  */
 static inline void tst_fzsync_wait_a(struct tst_fzsync_pair *pair)
 {
-	tst_fzsync_pair_wait(&pair->a_cntr, &pair->b_cntr, NULL);
+	tst_fzsync_pair_wait(pair, &pair->a_cntr, &pair->b_cntr, NULL);
 }
 
 /**
@@ -573,7 +577,7 @@ static inline void tst_fzsync_wait_a(struct tst_fzsync_pair *pair)
  */
 static inline void tst_fzsync_wait_b(struct tst_fzsync_pair *pair)
 {
-	tst_fzsync_pair_wait(&pair->b_cntr, &pair->a_cntr, NULL);
+	tst_fzsync_pair_wait(pair, &pair->b_cntr, &pair->a_cntr, NULL);
 }
 
 /**
@@ -678,7 +682,7 @@ static inline void tst_fzsync_start_race_a(struct tst_fzsync_pair *pair)
 static inline void tst_fzsync_end_race_a(struct tst_fzsync_pair *pair)
 {
 	tst_fzsync_time(&pair->a_end);
-	tst_fzsync_pair_wait(&pair->a_cntr, &pair->b_cntr, &pair->spins);
+	tst_fzsync_pair_wait(pair, &pair->a_cntr, &pair->b_cntr, &pair->spins);
 }
 
 /**
@@ -709,7 +713,7 @@ static inline void tst_fzsync_start_race_b(struct tst_fzsync_pair *pair)
 static inline void tst_fzsync_end_race_b(struct tst_fzsync_pair *pair)
 {
 	tst_fzsync_time(&pair->b_end);
-	tst_fzsync_pair_wait(&pair->b_cntr, &pair->a_cntr, &pair->spins);
+	tst_fzsync_pair_wait(pair, &pair->b_cntr, &pair->a_cntr, &pair->spins);
 }
 
 /**
-- 
2.14.5

