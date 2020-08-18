From: Filip Bozuta <Filip.Bozuta@syrmia.com>
Date: Tue, 18 Aug 2020 20:48:09 +0200
Subject: [LTP] [PATCH] lib/tst_clocks.c: fix 'tst_clock_gettime()' and
 'tst_clock_settime()'
Message-ID: <20200818184809.45961-1-Filip.Bozuta@syrmia.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The type of 'struct tst_ts' has to be kept between function calls
because a function can be called with the wrong timespec type.
For that reason, a 'static' identifier is added for 'tts'
in 'tst_clock_gettime()' and 'tst_clock_settime()' as to make sure
the right timespec type is passed in 'clock_gettime()' and
'clock_settime()'.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 lib/tst_clocks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tst_clocks.c b/lib/tst_clocks.c
index 7b465b1f6..cdcb9fc4f 100644
--- a/lib/tst_clocks.c
+++ b/lib/tst_clocks.c
@@ -57,7 +57,7 @@ int tst_clock_getres(clockid_t clk_id, struct timespec *res)
 
 int tst_clock_gettime(clockid_t clk_id, struct timespec *ts)
 {
-	struct tst_ts tts = { 0, };
+	static struct tst_ts tts = { 0, };
 	static mysyscall func;
 	int ret;
 
@@ -87,7 +87,7 @@ int tst_clock_gettime(clockid_t clk_id, struct timespec *ts)
 
 int tst_clock_settime(clockid_t clk_id, struct timespec *ts)
 {
-	struct tst_ts tts = { 0, };
+	static struct tst_ts tts = { 0, };
 	static mysyscall func;
 
 #if (__NR_clock_settime64 != __LTP__NR_INVALID_SYSCALL)
-- 
2.25.1

