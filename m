From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  5 Mar 2020 14:48:29 +0100
Subject: [LTP] [PATCH 3/8] include/tst_timer: Fix normalization
In-Reply-To: <20200305134834.16736-1-chrubis@suse.cz>
References: <20200305134834.16736-1-chrubis@suse.cz>
Message-ID: <20200305134834.16736-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The timespec_add and timespec_sub functions were producing incorrect
results when passed negative input. We have to normalize the result in
both cases for nseconds < 0 && nseconds > 1s.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_timer.h | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index de60bc62a..b091137dc 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -134,6 +134,21 @@ static inline int tst_timespec_lt(struct timespec t1, struct timespec t2)
 	return t1.tv_sec < t2.tv_sec;
 }
 
+static inline struct timespec tst_timespec_normalize(struct timespec t)
+{
+	if (t.tv_nsec >= 1000000000) {
+		t.tv_sec++;
+		t.tv_nsec -= 1000000000;
+	}
+
+	if (t.tv_nsec < 0) {
+		t.tv_sec--;
+		t.tv_nsec += 1000000000;
+	}
+
+	return t;
+}
+
 /*
  * Adds us microseconds to t.
  */
@@ -143,12 +158,8 @@ static inline struct timespec tst_timespec_add_us(struct timespec t,
 	t.tv_sec += us / 1000000;
 	t.tv_nsec += (us % 1000000) * 1000;
 
-	if (t.tv_nsec >= 1000000000) {
-		t.tv_sec++;
-		t.tv_nsec -= 1000000000;
-	}
 
-	return t;
+	return tst_timespec_normalize(t);
 }
 
 /*
@@ -162,12 +173,7 @@ static inline struct timespec tst_timespec_add(struct timespec t1,
 	res.tv_sec = t1.tv_sec + t2.tv_sec;
 	res.tv_nsec = t1.tv_nsec + t2.tv_nsec;
 
-	if (res.tv_nsec >= 1000000000) {
-		res.tv_sec++;
-		res.tv_nsec -= 1000000000;
-	}
-
-	return res;
+	return tst_timespec_normalize(res);
 }
 
 /*
@@ -179,12 +185,7 @@ static inline struct timespec tst_timespec_sub_us(struct timespec t,
 	t.tv_sec -= us / 1000000;
 	t.tv_nsec -= (us % 1000000) * 1000;
 
-	if (t.tv_nsec < 0) {
-		t.tv_sec--;
-		t.tv_nsec += 1000000000;
-	}
-
-	return t;
+	return tst_timespec_normalize(t);
 }
 
 /*
-- 
2.23.0

