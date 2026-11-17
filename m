Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D231F606A31C
	for <ltp@archiver.kernel.org>; Tue, 17 Nov 2026 23:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=Pr0jzpyl;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n2uM2uAK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794959953; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=/ti2VLHjjwoXhAoMhUXnKlA4Lz8TqSDr7I9JoZU0iEs=;
 b=Pr0jzpylgde6gskGhkUxEN5ILaBqt6fGk4RGLoBO5ywiiQEcUmN+izy1u+uWXnBncWs7p
 pQxLTAMEn/1DntUvcDeYMb14QW14kLX6fRo57Wm56ArtQilLu+bI73jtco4zCsK+53Ed0uo
 Zwhr1gRljtyPTH5FlHtUdLLB/QV8hp8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F04E3EA9C3
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 00:59:13 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5365A3E2323
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 00:58:52 +0100 (CET)
Received: from mail-pf1-x447.google.com (mail-pf1-x447.google.com
 [IPv6:2607:f8b0:4864:20::447])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7CCC0100046C
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 00:58:52 +0100 (CET)
Received: by mail-pf1-x447.google.com with SMTP id
 d2e1a72fcca58-8a065e2933fso430622b3a.3
 for <ltp@lists.linux.it>; Tue, 17 Nov 2026 15:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794959931; x=1795564731; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LmTbMP9ihbNI9VjJcGquUQMeVL9d6FdrNoX+35RwR20=;
 b=n2uM2uAKNWjFgEOi88MqUmcUH6BcwTGvD/gFxJXj1GY/2Ca7b3DvSa7sxvAtoFumsp
 tppBxufgv7J+O+eU6ZoI91dgAtHFNzSzKFUfacBnEGJikBJ4FAvQWZFIDZCUNqpW6qZI
 PGsgg6hqWfe/H4WZ4i5Wp4A9Ij7rOyg9Iqt7ILlM78A/E95JUpLsO6PnEHGcWCJqk51M
 wVBjbEEhIe89OdWTOynh4kG1YbgA++Xxjz7RYvXFmHexrz1ntU4lXL60wFTVVCuqNStX
 G6IsvW2eXbjVMYzHkDUXyH3aWKQag9jnoMZtPTHDaKit9cSCH29xW7RW2nDmhIKH5tpg
 DDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794959931; x=1795564731;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LmTbMP9ihbNI9VjJcGquUQMeVL9d6FdrNoX+35RwR20=;
 b=w8RWWtaqaB7MgvPjcnLZEoSA6Z8idWUQZagDWdSbYzK2buvB6FF48H08dWpmyIn+iR
 bzr1+2fSgjTo33yEOtJM60y1si0tSB+m+9yPbNByh0ZwJU4zpOfxrQaPu6Xs5xHR7XUe
 vgLMAfXi4+7auaWteDeOGj4WE27mNpT8A6bx4eef9ZpX+MRA/9lRXx7MNfQIXVgEOfcX
 5Okk/ysx1V6szBqNoQ1N2gF1rSyXZqf6J3skw8KUK7aMahPy7Rfo/NHhngQe97sx92Af
 z3crM89cj6FRjkHsXJk08bh1wXgHutjAErlgmyM/F1pz65GNXdfd3x3v5JfTpgCGBn9D
 xhQg==
X-Gm-Message-State: APuU4Z8CqvO9RBm9irjSVSpmMFcwq75qrloJUzueaO1Jh1f1YK5uSzzR
 W4GnMbrJSE4uAZttsjBEbvR009c1T1VzHkop2Rr7eYLmQtrKHWiMMKebVumYIreOx+ucTwl2Wwe
 c1WDYx8sbFQ5eBlwfddtYouLzl0BxxUzF9+0pNAn8poZUAqBiYZ/yqTzZrvSwKjkAMlreH0ukCE
 Ntj8WjQf+Xo1acKhLyuuuNUR1Dng==
X-Received: from pfbdu11.prod.google.com
 ([2002:a05:6a00:2b4b:b0:8b6:c93c:12fa])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4005:b0:8b5:7fc8:8679
 with SMTP id d2e1a72fcca58-8c5d344038emr718655b3a.21.1794959930334; Tue, 17
 Nov 2026 15:58:50 -0800 (PST)
Date: Tue, 17 Nov 2026 23:58:48 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117235848.2975548-1-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sys_rtc01: Report TCONF on system time mismatch when
 STA_UNSYNC is set
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

For the primary RTC (where hctosys == 1, or rtc0 as fallback), sys_rtc01
asserts that since_epoch is within slack of the current system time(2).

When a system boots with an RTC that is off the current time and
userspace later steps CLOCK_REALTIME via clock_settime(2) or
settimeofday(2) (for example via date(1)) without updating /dev/rtcN,
do_settimeofday64() sets STA_UNSYNC in the kernel NTP status. While
STA_UNSYNC is set, the kernel's CONFIG_RTC_SYSTOHC (sync_hw_clock())
does not write CLOCK_REALTIME back to the RTC, yet /sys/class/rtc/rtc0
still reports hctosys == 1 from boot. As noted in the test comment,
since_epoch and system time legitimately diverge in this state.

Query adjtimex(2) when since_epoch differs from system time by more than
slack and report TCONF instead of TFAIL if STA_UNSYNC is set.

Fixes: 79d62f4cf62f ("testcases: sysfs: Add sys_rtc01")
Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/sysfs/class/rtc/sys_rtc01.c | 25 +++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/sysfs/class/rtc/sys_rtc01.c b/testcases/kernel/sysfs/class/rtc/sys_rtc01.c
index 89141f2fa..0e1c69f95 100644
--- a/testcases/kernel/sysfs/class/rtc/sys_rtc01.c
+++ b/testcases/kernel/sysfs/class/rtc/sys_rtc01.c
@@ -43,9 +43,12 @@
  * test performs, so on a long-running system a purely fixed slack would
  * eventually produce false failures even on perfectly healthy hardware.
  *
- * The check may still fail if the system was booted with RTC that is fairly
- * off the current time and the system was later synced with NTP. This is out
- * of scope of this test.
+ * If the system was booted with an RTC that was off the current time and the
+ * system clock was later stepped in userspace via :manpage:`clock_settime(2)`
+ * or :manpage:`settimeofday(2)` without updating the RTC, the kernel sets
+ * STA_UNSYNC and CONFIG_RTC_SYSTOHC does not write the system clock back to
+ * the RTC while hctosys remains 1. Report TCONF instead of TFAIL when
+ * since_epoch diverges from system time while STA_UNSYNC is set.
  *
  * Under virtualization the slack is additionally multiplied, since a VM's
  * clock (and thus its emulated RTC) commonly lags real time by tens of
@@ -61,6 +64,7 @@
 #include <limits.h>
 #include <time.h>
 #include <sys/sysinfo.h>
+#include <sys/timex.h>
 #include "tst_test.h"
 #include "tst_sysfs_assert.h"
 #include "tst_path_defs.h"
@@ -108,6 +112,16 @@ static long read_hctosys(const char *name)
 	return TST_SYSFS_READ_LI(PATH_CLASS_RTC "/%s/hctosys", name);
 }
 
+static int is_clock_unsynced(void)
+{
+	struct timex tx = { .modes = 0 };
+
+	if (adjtimex(&tx) == -1)
+		tst_brk(TBROK | TERRNO, "adjtimex() failed");
+
+	return !!(tx.status & STA_UNSYNC);
+}
+
 static void read_rtc_snapshot(const char *name, char *date, size_t date_size,
 			      char *rtc_time, size_t time_size,
 			      time_t *since_epoch)
@@ -203,6 +217,11 @@ static void check_rtc(const char *name, int any_hctosys)
 			"%s: since_epoch (%lld), system time (%lld), diff %llds <= slack %lds",
 			name, (long long)since_epoch, (long long)sys_epoch,
 			diff, slack);
+	} else if (is_clock_unsynced()) {
+		tst_res(TCONF,
+			"%s: since_epoch (%lld), system time (%lld), diff %llds > slack %lds (STA_UNSYNC is set)",
+			name, (long long)since_epoch, (long long)sys_epoch,
+			diff, slack);
 	} else {
 		tst_res(TFAIL,
 			"%s: since_epoch (%lld), system time (%lld), diff %llds > slack %lds",
-- 
2.56.0.679.gc527c65306-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
