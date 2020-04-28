From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 28 Apr 2020 13:40:14 +0530
Subject: [LTP] [PATCH V2] common_timers: staticize all definitions
Message-ID: <d39e442b4c0e60880f1da3f69125afa01418f8c1.1588061382.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Staticize all variable and function definitions to avoid build failures
in the future if this gets included by multiple files.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Make clock_list static const to avoid warnings.

 include/lapi/common_timers.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/lapi/common_timers.h b/include/lapi/common_timers.h
index df4196eeb579..b783beff4f8b 100644
--- a/include/lapi/common_timers.h
+++ b/include/lapi/common_timers.h
@@ -15,7 +15,7 @@
 #define NSEC_PER_SEC (1000000000L)
 #endif
 
-clock_t clock_list[] = {
+static const clock_t clock_list[] = {
 	CLOCK_REALTIME,
 	CLOCK_MONOTONIC,
 	CLOCK_PROCESS_CPUTIME_ID,
@@ -34,7 +34,7 @@ clock_t clock_list[] = {
 	case def_name:		\
 		return #def_name;
 
-const char *get_clock_str(const int clock_id)
+static inline const char *get_clock_str(const int clock_id)
 {
 	switch (clock_id) {
 	CLOCK_TO_STR(CLOCK_REALTIME);
@@ -50,7 +50,7 @@ const char *get_clock_str(const int clock_id)
 	}
 }
 
-int possibly_unsupported(clock_t clock)
+static inline int possibly_unsupported(clock_t clock)
 {
 	switch (clock) {
 	case CLOCK_BOOTTIME:
@@ -63,7 +63,7 @@ int possibly_unsupported(clock_t clock)
 	}
 }
 
-int have_cputime_timers(void)
+static inline int have_cputime_timers(void)
 {
 	return tst_kvercmp(2, 6, 12) >= 0;
 }
-- 
2.25.0.rc1.19.g042ed3e048af

