Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DF0606A320
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=wy9C571s;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=s1qbOXzA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=dR1vU688;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zb+dn2TS
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 038DE3EA003
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 11:37:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96ADB3E92CE
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 11:36:45 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DDFD81000A3E
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 11:36:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DAB8B1FB82;
 Thu, 19 Nov 2026 10:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795084604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0oO7QpFQu3v9eaB7xIAdErMIeRKzGVDv2JEMQSo+Js8=;
 b=wy9C571sK2tibVv1PbsSxnXTeQlYQfh/HPqd9p71lx3JifVxKMx0PVdEmajvXXVpoprMpc
 vzDV6lUiGY9xuMJMFe5IixuzAqocuxaCG3OD39ZpQm8fuB0VVL6PeexHEueCa3Ih0U0G2Z
 4kMSQsmeOXP/UEy1s6gF4ZWSf9XBl8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795084604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0oO7QpFQu3v9eaB7xIAdErMIeRKzGVDv2JEMQSo+Js8=;
 b=s1qbOXzAFSYkCILDiXm+GGbgMgh17kgjb6gf3YkKeFTG1RDe0ObQEYKGVuYQU06nGOJgJA
 2FI3mgAubMOX4SCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dR1vU688;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zb+dn2TS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795084602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0oO7QpFQu3v9eaB7xIAdErMIeRKzGVDv2JEMQSo+Js8=;
 b=dR1vU688b8gvMqEMCjH0T283s8qQv9YFPSQCFMU/GwpDV4of/EZ2QlX369AkAQWLOrn9Wd
 a+AQarIkDMe6bDDBjEuGivjIhoaZ3GbyW2hzgsqz+dRWG3Ne+RB/xYJ4tbC+xJHiamM4uV
 5wPlGuB94bgkVXUrw7eH+qgE+sLx9SI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795084602;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0oO7QpFQu3v9eaB7xIAdErMIeRKzGVDv2JEMQSo+Js8=;
 b=zb+dn2TSpdz+3GbQeJkGKhQTKIPbaNN6x2e9Ymz9QZeUOgtu0jVPS53BNESxzIdPc6jm49
 Cqs6KKKtEusNX6DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A864F1342D;
 Thu, 19 Nov 2026 10:36:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id quziIDrR/mrAGAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 19 Nov 2026 10:36:42 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 19 Nov 2026 11:37:11 +0100
Message-ID: <20261119103711.3002153-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: DAB8B1FB82
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:dkim, suse.cz:email]
X-Spam-Score: -12.01
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sys_rtc01: Rewrite the RTC check
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Instead of comparing system time against RTC, which proved to be
unreliable we now sample the RTC since_epoch and compare it with
CLOCK_MONOTONIC_RAW timer. The since_epoch is sampled repeatedly and we
watch for transitions which are timed against the monotonic clock. That
gives us timestamped intervals when the transition has happened. With
these intervals we can make sure that the RTC is monotonic and ticks
roughly once per second.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Wake Liu <wakel@google.com>
---
 testcases/kernel/sysfs/class/rtc/sys_rtc01.c | 293 ++++++++++---------
 1 file changed, 157 insertions(+), 136 deletions(-)

diff --git a/testcases/kernel/sysfs/class/rtc/sys_rtc01.c b/testcases/kernel/sysfs/class/rtc/sys_rtc01.c
index 0e1c69f95..b12683d04 100644
--- a/testcases/kernel/sysfs/class/rtc/sys_rtc01.c
+++ b/testcases/kernel/sysfs/class/rtc/sys_rtc01.c
@@ -14,47 +14,28 @@
  * - hctosys is a boolean
  * - max_user_freq is greater than zero
  * - since_epoch matches date and time converted to a Unix timestamp
- * - for the RTC device with hctosys == 1, i.e. the one that was actually
- *   used by the kernel's own CONFIG_RTC_HCTOSYS code to set the system clock
- *   at boot, since_epoch is additionally close to the current system time(2)
- *   value. On a system with multiple RTC devices the other ones are not
- *   guaranteed to be in sync with the system clock at all (e.g. a
- *   peripheral's battery-backed RTC used only for its own wakeup alarm), so
- *   this second check is skipped for them.
- *
- * The hctosys only reflects whether the kernel itself performed the sync;
- * many setups runs ``hwclock --hctosys`` from a userspace init script instead
- * to sync the system clock from the RTC without the kernel ever knowing
- * about it, leaving hctosys == 0 on every device despite the clock
- * legitimately being in sync. To still get coverage on such systems, if no
- * RTC has hctosys == 1 at all, rtc0 is treated as the presumed primary RTC
- * and gets the system time check anyway.
+ * - since_epoch advances at the same rate as CLOCK_MONOTONIC_RAW
  *
  * The date/time vs since_epoch cross-check allows a few seconds of slack since
  * they are read from separate files and the wall clock keeps ticking in
  * between reads. The code also checks for midnight rollover and re-reads the
  * values if that happens.
  *
- * The since_epoch vs system time(2) cross-check allows extra slack that
- * grows with system uptime: the RTC is a free-running hardware crystal
- * oscillator that (absent some periodic resync mechanism, which is not
- * guaranteed to be running) drifts independently of the system clock the
- * whole time the system is up, not just across the couple of reads this
- * test performs, so on a long-running system a purely fixed slack would
- * eventually produce false failures even on perfectly healthy hardware.
- *
- * If the system was booted with an RTC that was off the current time and the
- * system clock was later stepped in userspace via :manpage:`clock_settime(2)`
- * or :manpage:`settimeofday(2)` without updating the RTC, the kernel sets
- * STA_UNSYNC and CONFIG_RTC_SYSTOHC does not write the system clock back to
- * the RTC while hctosys remains 1. Report TCONF instead of TFAIL when
- * since_epoch diverges from system time while STA_UNSYNC is set.
- *
- * Under virtualization the slack is additionally multiplied, since a VM's
- * clock (and thus its emulated RTC) commonly lags real time by tens of
- * seconds right after boot due to hypervisor scheduling delays (steal time)
- * during the guest's own boot sequence, which is unrelated to physical RTC
- * crystal drift and not scaled away by the uptime-based slack above.
+ * The RTC absolute value is not compared against the system time at all,
+ * since there is no guarantee that the RTC is kept in sync with the system
+ * clock. Instead the test polls since_epoch of all RTC devices for the test
+ * runtime and records the CLOCK_MONOTONIC_RAW timestamps of the RTC second
+ * transitions. Since each since_epoch read takes a non-zero amount of time,
+ * every transition is known to have happened in an interval between the start
+ * of the previous read and the end of the read that observed the new value.
+ * For each pair of consecutive transitions the number of elapsed RTC seconds
+ * is checked to be within the bounds of the CLOCK_MONOTONIC_RAW time elapsed
+ * between the two intervals, plus a small tolerance for the RTC crystal
+ * drift. The same check is then done for the whole interval between the first
+ * and the last observed transition. The test also fails if since_epoch goes
+ * backward, if it does not advance at least twice during the test runtime, or
+ * if it stays at the same value for more than a second at the end of the
+ * sampling.
  */
 
 #include <stdio.h>
@@ -63,9 +44,9 @@
 #include <dirent.h>
 #include <limits.h>
 #include <time.h>
-#include <sys/sysinfo.h>
-#include <sys/timex.h>
 #include "tst_test.h"
+#include "tst_timer.h"
+#include "tst_safe_clocks.h"
 #include "tst_sysfs_assert.h"
 #include "tst_path_defs.h"
 
@@ -73,54 +54,43 @@
 
 /*
  * Generously high assumed worst-case RTC crystal drift, in parts per
- * million, used to scale the system time slack with uptime. 200 ppm covers
- * even fairly poor/uncompensated RTC crystals across a wide temperature
- * range; a decent RTC typically drifts far less than this.
+ * million. 200 ppm covers even fairly poor/uncompensated RTC crystals across
+ * a wide temperature range; a decent RTC typically drifts far less than this.
  */
 #define MAX_RTC_DRIFT_PPM 200
 
 /*
- * VM guest clocks commonly lag behind real time by tens of seconds right
- * after boot due to hypervisor steal time accumulated during the guest's
- * own boot sequence, see the top comment. This is unrelated to physical RTC
- * crystal drift, hence a flat multiplier here rather than folding it into
- * MAX_RTC_DRIFT_PPM's uptime-based scaling.
+ * Fixed tolerance for the RTC vs CLOCK_MONOTONIC_RAW rate check, covers RTC
+ * drivers that do not read the time atomically.
  */
-#define VIRT_SLACK_MULTIPLIER 10
-
-static long sys_time_slack_sec(void)
-{
-	struct sysinfo info;
-	long slack;
-
-	SAFE_SYSINFO(&info);
+#define RATE_TOLERANCE_US 10000
 
-	slack = SLACK_SEC + (long)info.uptime * MAX_RTC_DRIFT_PPM / 1000000;
+#define POLL_INTERVAL_US 1000
 
-	if (tst_is_virt(VIRT_ANY)) {
-		tst_res(TINFO,
-			"Running in a VM, multiplying the RTC vs system time slack by %d",
-			VIRT_SLACK_MULTIPLIER);
-		slack *= VIRT_SLACK_MULTIPLIER;
-	}
+#define MAX_RTCS 10
 
-	return slack;
-}
+struct rtc_edge {
+	long long val;
+	/* Bounds of the CLOCK_MONOTONIC_RAW time the transition happened in */
+	struct timespec lo;
+	struct timespec hi;
+};
 
-static long read_hctosys(const char *name)
-{
-	return TST_SYSFS_READ_LI(PATH_CLASS_RTC "/%s/hctosys", name);
-}
+struct rtc_dev {
+	char name[NAME_MAX + 1];
 
-static int is_clock_unsynced(void)
-{
-	struct timex tx = { .modes = 0 };
+	long long last_val;
+	int last_val_set;
+	struct timespec last_start;
 
-	if (adjtimex(&tx) == -1)
-		tst_brk(TBROK | TERRNO, "adjtimex() failed");
+	int edges;
+	int stalled;
+	struct rtc_edge first;
+	struct rtc_edge last;
+};
 
-	return !!(tx.status & STA_UNSYNC);
-}
+static struct rtc_dev rtcs[MAX_RTCS];
+static unsigned int rtc_cnt;
 
 static void read_rtc_snapshot(const char *name, char *date, size_t date_size,
 			      char *rtc_time, size_t time_size,
@@ -154,35 +124,22 @@ static void read_rtc_snapshot(const char *name, char *date, size_t date_size,
 	tst_res(TWARN, "%s: date kept rolling over across the retry", name);
 }
 
-static void check_rtc(const char *name, int any_hctosys)
+static void check_rtc_attrs(const char *name)
 {
-	char date[32] = "", rtc_time[32] = "";
+	char rtc_date[32] = "", rtc_time[32] = "";
 	struct tm tm = { 0 };
-	time_t rtc_epoch, sys_epoch;
-	long hctosys, slack;
-	time_t since_epoch;
-	int is_primary;
+	time_t rtc_epoch, since_epoch;
 
 	TST_SYSFS_ASSERT_BOOL(PATH_CLASS_RTC "/%s/hctosys", name);
 	TST_SYSFS_ASSERT_RANGELL(1, LONG_MAX, PATH_CLASS_RTC "/%s/max_user_freq", name);
 
-	hctosys = read_hctosys(name);
-
-	/*
-	 * If no RTC has hctosys == 1 anywhere (see the top comment), fall
-	 * back to treating rtc0 as the presumed primary RTC.
-	 */
-	is_primary = hctosys || (!any_hctosys && !strcmp(name, "rtc0"));
-
-	read_rtc_snapshot(name, date, sizeof(date), rtc_time, sizeof(rtc_time),
+	read_rtc_snapshot(name, rtc_date, sizeof(rtc_date), rtc_time, sizeof(rtc_time),
 			  &since_epoch);
 
-	sys_epoch = time(NULL);
-
-	if (sscanf(date, "%d-%d-%d", &tm.tm_year, &tm.tm_mon, &tm.tm_mday) != 3 ||
+	if (sscanf(rtc_date, "%d-%d-%d", &tm.tm_year, &tm.tm_mon, &tm.tm_mday) != 3 ||
 	    sscanf(rtc_time, "%d:%d:%d", &tm.tm_hour, &tm.tm_min, &tm.tm_sec) != 3) {
 		tst_res(TFAIL, "%s: failed to parse date '%s' / time '%s'",
-			name, date, rtc_time);
+			name, rtc_date, rtc_time);
 		return;
 	}
 
@@ -193,86 +150,150 @@ static void check_rtc(const char *name, int any_hctosys)
 	if (llabs((long long)(rtc_epoch - since_epoch)) <= SLACK_SEC) {
 		tst_res(TPASS,
 			"%s: since_epoch (%lld) matches date '%s' time '%s' (%lld)",
-			name, (long long)since_epoch, date, rtc_time,
+			name, (long long)since_epoch, rtc_date, rtc_time,
 			(long long)rtc_epoch);
 	} else {
 		tst_res(TFAIL,
 			"%s: since_epoch (%lld) does not match date '%s' time '%s' (%lld)",
-			name, (long long)since_epoch, date, rtc_time,
+			name, (long long)since_epoch, rtc_date, rtc_time,
 			(long long)rtc_epoch);
 	}
+}
 
-	if (!is_primary) {
-		tst_res(TINFO,
-			"%s: not the (assumed) primary RTC, not checking since_epoch against system time",
-			name);
-		return;
-	}
+static void check_edge_to_edge(const char *name, struct rtc_edge *from,
+			       struct rtc_edge *to)
+{
+	long long rtc_us, min_us, max_us, tol_us;
 
-	slack = sys_time_slack_sec();
-	long long diff = llabs((long long)(since_epoch - sys_epoch));
+	rtc_us = (to->val - from->val) * 1000000;
+	min_us = tst_timespec_diff_us(to->lo, from->hi);
+	max_us = tst_timespec_diff_us(to->hi, from->lo);
+	tol_us = RATE_TOLERANCE_US + rtc_us / 1000000 * MAX_RTC_DRIFT_PPM;
 
-	if (diff <= slack) {
+	if (rtc_us >= min_us - tol_us && rtc_us <= max_us + tol_us) {
 		tst_res(TPASS,
-			"%s: since_epoch (%lld), system time (%lld), diff %llds <= slack %lds",
-			name, (long long)since_epoch, (long long)sys_epoch,
-			diff, slack);
-	} else if (is_clock_unsynced()) {
-		tst_res(TCONF,
-			"%s: since_epoch (%lld), system time (%lld), diff %llds > slack %lds (STA_UNSYNC is set)",
-			name, (long long)since_epoch, (long long)sys_epoch,
-			diff, slack);
+			"%s: %lli -> %lli took %9lldus - %9lldus = %lldus (tolerance %lldus)",
+			name, from->val, to->val, min_us, max_us, max_us - min_us, tol_us);
 	} else {
 		tst_res(TFAIL,
-			"%s: since_epoch (%lld), system time (%lld), diff %llds > slack %lds",
-			name, (long long)since_epoch, (long long)sys_epoch,
-			diff, slack);
+			"%s: %lli -> %lli took %9lldus - %9lldus = %lldus (tolerance %lldus)",
+			name, from->val, to->val, min_us, max_us, max_us - min_us, tol_us);
+	}
+}
+
+static void poll_rtc(struct rtc_dev *rtc)
+{
+	struct timespec start, end;
+	struct rtc_edge edge;
+	long long val;
+
+	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC_RAW, &start);
+	val = TST_SYSFS_READ_LI(PATH_CLASS_RTC "/%s/since_epoch", rtc->name);
+	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC_RAW, &end);
+
+	if (rtc->last_val_set && val != rtc->last_val) {
+		edge.val = val;
+		edge.lo = rtc->last_start;
+		edge.hi = end;
+
+		if (val < rtc->last_val) {
+			tst_res(TFAIL, "%s: since_epoch went backward %lli -> %lli",
+				rtc->name, rtc->last_val, val);
+		}
+
+		if (rtc->edges > 0)
+			check_edge_to_edge(rtc->name, &rtc->last, &edge);
+
+		if (rtc->edges > 1)
+			check_edge_to_edge(rtc->name, &rtc->first, &edge);
+
+		if (!rtc->edges)
+			rtc->first = edge;
+
+		rtc->last = edge;
+		rtc->edges++;
+	}
+
+	/*
+	 * This read returned the value from the last transition, which happened
+	 * at the latest at last.hi, so the RTC must not stay on it for longer
+	 * than a second.
+	 */
+	if (rtc->edges && !rtc->stalled) {
+		long long stall_us = tst_timespec_diff_us(start, rtc->last.hi);
+
+		if (stall_us > 1000000 + RATE_TOLERANCE_US) {
+			tst_res(TFAIL, "%s: since_epoch stuck at %lli for at least %lldus",
+				rtc->name, rtc->last.val, stall_us);
+			rtc->stalled = 1;
+		}
 	}
+
+	rtc->last_val = val;
+	rtc->last_val_set = 1;
+	rtc->last_start = start;
 }
 
 static void do_test(void)
 {
-	DIR *d;
-	struct dirent *ent;
-	int found = 0;
-	int any_hctosys = 0;
+	unsigned int i;
 
-	if (!tst_sysfs_exists(PATH_CLASS_RTC))
-		tst_brk(TCONF, PATH_CLASS_RTC ": not present");
+	for (i = 0; i < rtc_cnt; i++) {
+		tst_res(TINFO, "Checking %s attributes", rtcs[i].name);
+		check_rtc_attrs(rtcs[i].name);
 
-	d = SAFE_OPENDIR(PATH_CLASS_RTC);
+		rtcs[i].last_val_set = 0;
+		rtcs[i].edges = 0;
+		rtcs[i].stalled = 0;
+	}
 
-	/* First pass: find out whether any RTC has hctosys == 1 already. */
-	while ((ent = SAFE_READDIR(d))) {
-		if (strncmp(ent->d_name, "rtc", 3))
-			continue;
+	tst_res(TINFO, "Sampling since_epoch against CLOCK_MONOTONIC_RAW");
 
-		found = 1;
+	while (tst_remaining_runtime()) {
+		for (i = 0; i < rtc_cnt; i++)
+			poll_rtc(&rtcs[i]);
 
-		if (read_hctosys(ent->d_name))
-			any_hctosys = 1;
+		usleep(POLL_INTERVAL_US);
 	}
 
-	if (!found) {
-		tst_res(TCONF, "No RTC device found");
-		SAFE_CLOSEDIR(d);
-		return;
+	for (i = 0; i < rtc_cnt; i++) {
+		if (rtcs[i].edges < 2) {
+			tst_res(TFAIL, "%s: since_epoch did not advance (%i transitions seen)",
+				rtcs[i].name, rtcs[i].edges);
+		}
 	}
+}
 
-	rewinddir(d);
+static void setup(void)
+{
+	struct dirent *ent;
+	DIR *d;
+
+	if (!tst_sysfs_exists(PATH_CLASS_RTC))
+		tst_brk(TCONF, PATH_CLASS_RTC ": not present");
+
+	d = SAFE_OPENDIR(PATH_CLASS_RTC);
 
-	/* Second pass: run the actual checks. */
 	while ((ent = SAFE_READDIR(d))) {
 		if (strncmp(ent->d_name, "rtc", 3))
 			continue;
 
-		tst_res(TINFO, "Checking %s", ent->d_name);
-		check_rtc(ent->d_name, any_hctosys);
+		if (rtc_cnt >= MAX_RTCS)
+			tst_brk(TBROK, "More than %i RTC devices found", MAX_RTCS);
+
+		snprintf(rtcs[rtc_cnt].name, sizeof(rtcs[rtc_cnt].name), "%s",
+			 ent->d_name);
+		rtc_cnt++;
 	}
 
 	SAFE_CLOSEDIR(d);
+
+	if (!rtc_cnt)
+		tst_brk(TCONF, "No RTC device found");
 }
 
 static struct tst_test test = {
+	.setup = setup,
 	.test_all = do_test,
+	.runtime = 5,
 };
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
