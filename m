From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Wed, 12 Dec 2018 18:37:18 -0200
Subject: [LTP] [PATCH v3 1/6] tst_timer.h: add tst_timespect_rem_us()
	function
In-Reply-To: <20181211142750.GA27159@rei>
References: <20181211142750.GA27159@rei>
Message-ID: <20181212203723.18810-1-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Expand tst_timer.h functionality by having a function to also remove
given microseconds from a given timespec.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 include/tst_timer.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index 577bc88ef..b1c9ceeba 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -151,6 +151,23 @@ static inline struct timespec tst_timespec_add_us(struct timespec t,
 	return t;
 }
 
+/*
+ * Removes us microseconds to t.
+ */
+static inline struct timespec tst_timespec_rem_us(struct timespec t,
+                                                  long long us)
+{
+	t.tv_sec -= us / 1000000;
+	t.tv_nsec -= (us % 1000000) * 1000;
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
  * Returns difference between two timespec structures.
  */
-- 
2.20.0.rc1

