From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Apr 2020 16:54:36 +0200
Subject: [LTP] [PATCH] [COMMITTED] tst_timer: Fix compilation on pre C11
 compilers
Message-ID: <20200422145436.4492-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The anonymous unions are supported since C11 and we have to still
support at least gcc-4.4 which does not support C11 since the compiler
is older than the standard.

So this commit gives the union name however 99% of code is unchanged
since we are using function to access the structure members anyways.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reported-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_timer.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index 4f97acd16..999953f44 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -121,11 +121,11 @@ enum tst_ts_type {
 
 struct tst_ts {
 	enum tst_ts_type type;
-	union {
+	union ts {
 		struct timespec libc_ts;
 		struct __kernel_old_timespec kern_old_ts;
 		struct __kernel_timespec kern_ts;
-	};
+	} ts;
 };
 
 /*
@@ -135,11 +135,11 @@ static inline long long tst_ts_get_sec(struct tst_ts ts)
 {
 	switch (ts.type) {
 	case TST_LIBC_TIMESPEC:
-		return ts.libc_ts.tv_sec;
+		return ts.ts.libc_ts.tv_sec;
 	case TST_KERN_OLD_TIMESPEC:
-		return ts.kern_old_ts.tv_sec;
+		return ts.ts.kern_old_ts.tv_sec;
 	case TST_KERN_TIMESPEC:
-		return ts.kern_ts.tv_sec;
+		return ts.ts.kern_ts.tv_sec;
 	default:
 		tst_brk(TBROK, "Invalid type: %d", ts.type);
 		return -1;
@@ -153,11 +153,11 @@ static inline long long tst_ts_get_nsec(struct tst_ts ts)
 {
 	switch (ts.type) {
 	case TST_LIBC_TIMESPEC:
-		return ts.libc_ts.tv_nsec;
+		return ts.ts.libc_ts.tv_nsec;
 	case TST_KERN_OLD_TIMESPEC:
-		return ts.kern_old_ts.tv_nsec;
+		return ts.ts.kern_old_ts.tv_nsec;
 	case TST_KERN_TIMESPEC:
-		return ts.kern_ts.tv_nsec;
+		return ts.ts.kern_ts.tv_nsec;
 	default:
 		tst_brk(TBROK, "Invalid type: %d", ts.type);
 		return -1;
@@ -171,13 +171,13 @@ static inline void tst_ts_set_sec(struct tst_ts *ts, long long sec)
 {
 	switch (ts->type) {
 	case TST_LIBC_TIMESPEC:
-		ts->libc_ts.tv_sec = sec;
+		ts->ts.libc_ts.tv_sec = sec;
 	break;
 	case TST_KERN_OLD_TIMESPEC:
-		ts->kern_old_ts.tv_sec = sec;
+		ts->ts.kern_old_ts.tv_sec = sec;
 	break;
 	case TST_KERN_TIMESPEC:
-		ts->kern_ts.tv_sec = sec;
+		ts->ts.kern_ts.tv_sec = sec;
 	break;
 	default:
 		tst_brk(TBROK, "Invalid type: %d", ts->type);
@@ -191,13 +191,13 @@ static inline void tst_ts_set_nsec(struct tst_ts *ts, long long nsec)
 {
 	switch (ts->type) {
 	case TST_LIBC_TIMESPEC:
-		ts->libc_ts.tv_nsec = nsec;
+		ts->ts.libc_ts.tv_nsec = nsec;
 	break;
 	case TST_KERN_OLD_TIMESPEC:
-		ts->kern_old_ts.tv_nsec = nsec;
+		ts->ts.kern_old_ts.tv_nsec = nsec;
 	break;
 	case TST_KERN_TIMESPEC:
-		ts->kern_ts.tv_nsec = nsec;
+		ts->ts.kern_ts.tv_nsec = nsec;
 	break;
 	default:
 		tst_brk(TBROK, "Invalid type: %d", ts->type);
@@ -211,8 +211,8 @@ static inline struct tst_ts tst_ts_from_timespec(struct timespec ts)
 {
 	struct tst_ts t = {
 		.type = TST_LIBC_TIMESPEC,
-		.libc_ts.tv_sec = ts.tv_sec,
-		.libc_ts.tv_nsec = ts.tv_nsec,
+		.ts.libc_ts.tv_sec = ts.tv_sec,
+		.ts.libc_ts.tv_nsec = ts.tv_nsec,
 	};
 
 	return t;
@@ -223,7 +223,7 @@ static inline struct tst_ts tst_ts_from_timespec(struct timespec ts)
  */
 static inline struct timespec tst_ts_to_timespec(struct tst_ts t)
 {
-	return t.libc_ts;
+	return t.ts.libc_ts;
 }
 
 /*
-- 
2.24.1

