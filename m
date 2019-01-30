From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Jan 2019 14:53:24 +0100
Subject: [LTP] [PATCH v4 4/8] lib: new restore_wallclock field to
 restore realtime clock
In-Reply-To: <20190129173659.27901-4-rafael.tinoco@linaro.org>
References: <20190124161159.GC16804@rei.lan>
 <20190129173659.27901-1-rafael.tinoco@linaro.org>
 <20190129173659.27901-4-rafael.tinoco@linaro.org>
Message-ID: <20190130135323.GB4709@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've changed the tst_wallclock.c so that it restores the time only if it
was saved previously, otherwise we will either set completely wrong time
if something has failed prior call to tst_wallclock_save() or generage
bogus error messages when the test exits because of unsufficient
priviledges.

full diff:

diff --git a/lib/tst_wallclock.c b/lib/tst_wallclock.c
index 1513882f4..f1c96c0cf 100644
--- a/lib/tst_wallclock.c
+++ b/lib/tst_wallclock.c
@@ -16,6 +16,8 @@
 
 static struct timespec real_begin, mono_begin;
 
+static int clock_saved;
+
 void tst_wallclock_save(void)
 {
 	/* save initial monotonic time to restore it when needed */
@@ -25,12 +27,19 @@ void tst_wallclock_save(void)
 
 	if (tst_clock_gettime(CLOCK_MONOTONIC_RAW, &mono_begin))
 		tst_brk(TBROK | TERRNO, "tst_clock_gettime() monotonic failed");
+
+	clock_saved = 1;
 }
 
 void tst_wallclock_restore(void)
 {
 	static struct timespec mono_end, elapsed, adjust;
 
+	if (!clock_saved)
+		return;
+
+	clock_saved = 0;
+
 	if (tst_clock_gettime(CLOCK_MONOTONIC_RAW, &mono_end))
 		tst_brk(TBROK | TERRNO, "tst_clock_gettime() monotonic failed");
 

-- 
Cyril Hrubis
chrubis@suse.cz
