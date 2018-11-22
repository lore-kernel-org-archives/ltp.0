From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 22 Nov 2018 16:35:45 +0100
Subject: [LTP] [PATCH v4 0/4] New Fuzzy Sync library API
In-Reply-To: <20181105154217.18879-1-rpalethorpe@suse.com>
References: <20181105154217.18879-1-rpalethorpe@suse.com>
Message-ID: <20181122153545.GA907@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've finally pushed the first three patches, thanks.

I will have a look at the final patch soon enough, quite likely
tomorrow.

The second one was pushed with mostly typo fixes (see below), I really
do like the comments and explanations now, it's much better explained
than the first version. There are a few things that I want to possibly
adjust but these are quite minor so I applied the patchset as it it for
now.

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index 59b5917f8..03f69b78b 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -1,28 +1,15 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (c) 2017-2018 Richard Palethorpe <rpalethorpe@suse.com>
  */
 /**
  * @file tst_fuzzy_sync.h
- * Fuzzy Synchronisation - abreviated to fzsync
+ * Fuzzy Synchronisation - abbreviated to fzsync
  *
  * This library is intended to help reproduce race conditions by synchronising
  * two threads at a given place by marking the range a race may occur
  * in. Because the exact place where any race occurs is within the kernel,
- * and therefor impossible to mark accurately, the library may add randomised
+ * and therefore impossible to mark accurately, the library may add randomised
  * delays to either thread in order to help find the exact race timing.
  *
  * Currently only two way races are explicitly supported, that is races
@@ -51,7 +38,7 @@
  *
  * The calls to tst_fzsync_start/end_race and tst_fzsync_run_a/b block (at
  * least) until both threads have enter them. These functions can only be
- * called once for each iteration, but further sychronisation points can be
+ * called once for each iteration, but further synchronisation points can be
  * added by calling tst_fzsync_wait_a() and tst_fzsync_wait_b() in each
  * thread.
  *
@@ -80,6 +67,9 @@
 #include "tst_timer.h"
 #include "tst_safe_pthread.h"
 
+#ifndef TST_FUZZY_SYNC_H__
+#define TST_FUZZY_SYNC_H__
+
 /** Some statistics for a variable */
 struct tst_fzsync_stat {
 	float avg;
@@ -183,7 +173,7 @@ struct tst_fzsync_pair {
 	int exec_loops;
 	/** Internal; The current loop index  */
 	int exec_loop;
-	/** Internal; The second thread or NULL */
+	/** Internal; The second thread or 0 */
 	pthread_t thread_b;
 };
 
@@ -527,7 +517,7 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
 		/*
 		 * We are about to break the invariant that the thread with
 		 * the lowest count is in front of the other. So we must wait
-		 * here to ensure the other thread has atleast reached the
+		 * here to ensure the other thread has at least reached the
 		 * line above before doing that. If we are in rear position
 		 * then our counter may already have been set to zero.
 		 */
@@ -641,9 +631,9 @@ static inline int tst_fzsync_run_b(struct tst_fzsync_pair *pair)
  *
  * This should be placed just before performing whatever action can cause a
  * race condition. Usually it is placed just before a syscall and
- * tst_fzsync_end_race_a() is placed just afterward.
+ * tst_fzsync_end_race_a() is placed just afterwards.
  *
- * A corrosponding call to tst_fzsync_start_race_b() should be made in thread
+ * A corresponding call to tst_fzsync_start_race_b() should be made in thread
  * B.
  *
  * @return A non-zero value if the calling thread should continue to loop. If
@@ -707,3 +697,5 @@ static inline void tst_fzsync_end_race_b(struct tst_fzsync_pair *pair)
 	tst_fzsync_time(&pair->b_end);
 	tst_fzsync_pair_wait(&pair->b_cntr, &pair->a_cntr, &pair->spins);
 }
+
+#endif /* TST_FUZZY_SYNC_H__ */



-- 
Cyril Hrubis
chrubis@suse.cz
