From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon,  5 Nov 2018 16:42:14 +0100
Subject: [LTP] [PATCH v4 1/4] tst_timer: Add nano second conversions
In-Reply-To: <20181105154217.18879-1-rpalethorpe@suse.com>
References: <20181105154217.18879-1-rpalethorpe@suse.com>
Message-ID: <20181105154217.18879-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_timer.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index 0fd7ed6cf..577bc88ef 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -34,6 +34,11 @@
 #include <sys/time.h>
 #include <time.h>
 
+static inline long long tst_timespec_to_ns(struct timespec t)
+{
+	return t.tv_sec * 1000000000 + t.tv_nsec;
+}
+
 /*
  * Converts timespec to microseconds.
  */
@@ -166,6 +171,12 @@ static inline struct timespec tst_timespec_diff(struct timespec t1,
 	return res;
 }
 
+static inline long long tst_timespec_diff_ns(struct timespec t1,
+					     struct timespec t2)
+{
+	return t1.tv_nsec - t2.tv_nsec + 1000000000LL * (t1.tv_sec - t2.tv_sec);
+}
+
 static inline long long tst_timespec_diff_us(struct timespec t1,
                                              struct timespec t2)
 {
-- 
2.18.0

