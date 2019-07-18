From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Jul 2019 10:39:43 +0200
Subject: [LTP] [PATCH 2/2] c: Use $LTP_TIMEOUT_MUL also in retry functions
In-Reply-To: <20190718083943.7687-1-pvorel@suse.cz>
References: <20190718083943.7687-1-pvorel@suse.cz>
Message-ID: <20190718083943.7687-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

in TST_RETRY_FN_EXP_BACKOFF() and thus in TST_RETRY_FUNC() in new C API.
This sync C API with shell API (added in previous commit).

+ mention LTP_TIMEOUT_MUL use in wiki.
+ use SPDX, add copyright

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/test-writing-guidelines.txt |  2 ++
 include/tst_common.h            | 26 +++++++++++---------------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 782e14f32..3548d6043 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2064,6 +2064,8 @@ Sometimes LTP test needs retrying a function for many times to get success.
 This achievement makes that possible via keeping it retrying if the return
 value of the function is NOT as we expected. After exceeding a limited time,
 test will break from the retries immediately.
+NOTE: both 'TST_RETRY_FUNC()' and 'TST_RETRY_FN_EXP_BACKOFF()' use 'LTP_TIMEOUT_MUL'
+environment variable.
 
 [source,c]
 -------------------------------------------------------------------------------
diff --git a/include/tst_common.h b/include/tst_common.h
index c21505450..454a166e8 100644
--- a/include/tst_common.h
+++ b/include/tst_common.h
@@ -1,21 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) Linux Test Project, 2017-2019
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
  * Copyright (c) 2013 Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
  * Copyright (c) 2010 Ngie Cooper <yaneurabeya@gmail.com>
  * Copyright (c) 2008 Mike Frysinger <vapier@gmail.com>
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
  */
 
 #ifndef TST_COMMON_H__
@@ -51,15 +40,22 @@
 
 #define TST_RETRY_FN_EXP_BACKOFF(FUNC, ERET, MAX_DELAY)	\
 ({	int tst_delay_ = 1;						\
+	float m = 1;	\
+	char *mul = getenv("LTP_TIMEOUT_MUL");	\
+	if (mul) {	\
+		m = atof(mul); \
+		if (m < 1) \
+			tst_brk(TBROK, "Invalid timeout multiplier '%s'", mul); \
+	}	\
 	for (;;) {							\
 		typeof(FUNC) tst_ret_ = FUNC;				\
 		if (tst_ret_ == ERET)					\
 			break;						\
-		if (tst_delay_ < MAX_DELAY * 1000000) {			\
+		if (tst_delay_ < MAX_DELAY * m * 1000000) {			\
 			usleep(tst_delay_);				\
 			tst_delay_ *= 2;				\
 		} else {						\
-			tst_brk(TBROK, #FUNC" timed out");		\
+			tst_brk(TBROK, #FUNC" timed out! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"); \
 		}							\
 	}								\
 	ERET;								\
-- 
2.22.0

