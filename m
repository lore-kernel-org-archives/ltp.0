From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Tue, 29 Jan 2019 15:36:56 -0200
Subject: [LTP] [PATCH v4 5/8] tst_timer: Add tst_timespec_sub_us()
In-Reply-To: <20190129173659.27901-1-rafael.tinoco@linaro.org>
References: <20190124161159.GC16804@rei.lan>
 <20190129173659.27901-1-rafael.tinoco@linaro.org>
Message-ID: <20190129173659.27901-5-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This commit adds a tst_timespec_sub_us() function that subtracts
microseconds from a given timespec struct.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 include/tst_timer.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index b57adf7aa..043b71460 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -170,6 +170,23 @@ static inline struct timespec tst_timespec_add(struct timespec t1,
 	return res;
 }
 
+/*
+ * Subtracts us microseconds from t.
+ */
+static inline struct timespec tst_timespec_sub_us(struct timespec t,
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
2.20.1

