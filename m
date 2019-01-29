From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Tue, 29 Jan 2019 15:36:54 -0200
Subject: [LTP] [PATCH v4 3/8] tst_timer: Add tst_timespec_add()
In-Reply-To: <20190129173659.27901-1-rafael.tinoco@linaro.org>
References: <20190124161159.GC16804@rei.lan>
 <20190129173659.27901-1-rafael.tinoco@linaro.org>
Message-ID: <20190129173659.27901-3-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This commit adds a tst_timespec_add() function that adds two given
timespec structs. It is needed in order to avoid unneeded ns <-> us
conversions because, so far, there is only tst_timespec_add_us()
available.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 include/tst_timer.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index 577bc88ef..b57adf7aa 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -151,6 +151,25 @@ static inline struct timespec tst_timespec_add_us(struct timespec t,
 	return t;
 }
 
+/*
+ * Adds two timespec structures.
+ */
+static inline struct timespec tst_timespec_add(struct timespec t1,
+                                               struct timespec t2)
+{
+	struct timespec res;
+
+	res.tv_sec = t1.tv_sec + t2.tv_sec;
+	res.tv_nsec = t1.tv_nsec + t2.tv_nsec;
+
+	if (res.tv_nsec >= 1000000000) {
+		res.tv_sec++;
+		res.tv_nsec -= 1000000000;
+	}
+
+	return res;
+}
+
 /*
  * Returns difference between two timespec structures.
  */
-- 
2.20.1

