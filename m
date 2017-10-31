From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 31 Oct 2017 14:05:14 +0100
Subject: [LTP] [PATCH] fzsync: Prevent early exit
Message-ID: <20171031130514.2823-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Richard Palethorpe <richiejp@f-m.fm>

In some tests it may be possible for the child thread to exit before it has
completed an equal number of iterations to main thread (the thread which sets
the exit state). Due to the way most tests use the library this is unlikely to
matter, but in theory it could cause some tests to exit uncleanly. To fix
this, we only exit if we find that the thread has progressed to a wait() call
which would spin indefinitely if exit were not set.

I already suspected this bug existed, but confirmed while trying to formally
verify the algorithm using Modex, see:
https://github.com/richiejp/modex_models

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_fuzzy_sync.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index d89f034f0..bcc625e24 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -265,7 +265,9 @@ static inline int tst_fzsync_pair_wait(struct tst_fzsync_pair *pair,
 			;
 	}
 
-	return !tst_atomic_load(&pair->exit);
+	/* Only exit if we have done the same amount of work as the other thread */
+	return !tst_atomic_load(&pair->exit) ||
+	  tst_atomic_load(other_cntr) <= tst_atomic_load(our_cntr);
 }
 
 static inline int tst_fzsync_wait_a(struct tst_fzsync_pair *pair)
-- 
2.14.2

