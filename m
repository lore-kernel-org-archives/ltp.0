Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD3FCD8C92
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 12:24:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1FB23E6EF5
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 14:24:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9045F3C1C1F
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 14:24:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0D186600079
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 14:24:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7ED7D75908;
 Tue,  9 Jun 2026 12:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781007867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ARGR6h6F+2Raj3Xj613COamVUISbTp5oI8R7zk/7Oco=;
 b=B2n+PsOez+0i/HV6hkcIa9ZzmTS03cO3+zUbG/525J3sSRjKamzRx5TkWqCc/3iBi9GuEG
 cgeyyWE2rR9smFM8iw7DCaTojeh6XjoAQhclBZChs+KIyWwNwFO1mzkBfCOCvpi2i3bG/Z
 ufNOkvCiZK6XRsrvWMuoKmSvqatdy/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781007867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ARGR6h6F+2Raj3Xj613COamVUISbTp5oI8R7zk/7Oco=;
 b=h3RVv3Kra3n8kWvxo0iM5d3rCh6wvnNYbTCcvIJui2qKxlA6Y15fBLKSjpZ0ZPdkzX8u3Q
 D1rUtiIfI9PLlKAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781007867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ARGR6h6F+2Raj3Xj613COamVUISbTp5oI8R7zk/7Oco=;
 b=B2n+PsOez+0i/HV6hkcIa9ZzmTS03cO3+zUbG/525J3sSRjKamzRx5TkWqCc/3iBi9GuEG
 cgeyyWE2rR9smFM8iw7DCaTojeh6XjoAQhclBZChs+KIyWwNwFO1mzkBfCOCvpi2i3bG/Z
 ufNOkvCiZK6XRsrvWMuoKmSvqatdy/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781007867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ARGR6h6F+2Raj3Xj613COamVUISbTp5oI8R7zk/7Oco=;
 b=h3RVv3Kra3n8kWvxo0iM5d3rCh6wvnNYbTCcvIJui2qKxlA6Y15fBLKSjpZ0ZPdkzX8u3Q
 D1rUtiIfI9PLlKAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71CC9779A7;
 Tue,  9 Jun 2026 12:24:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S2r0GvsFKGpMUwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 09 Jun 2026 12:24:27 +0000
Date: Tue, 9 Jun 2026 14:24:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: "Kubaj, Piotr" <piotr.kubaj@intel.com>
Message-ID: <aigF9StEMr3oNPFD@yuki.lan>
References: <20260514133446.144550-2-piotr.kubaj@intel.com>
 <20260514141912.4030-1-linuxtestproject.agent@gmail.com>
 <20260515144242.GB40164@pevik>
 <d1e90d8d94fd4cb58f34cbff4a07b49257195129.camel@intel.com>
 <21a5a4cec4cbb9a7084b8b5374fa06865a0d74d8.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <21a5a4cec4cbb9a7084b8b5374fa06865a0d74d8.camel@intel.com>
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_EQ_ADDR_SOME(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[gmail.com,suse.cz,lists.linux.it];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thermal: add new test group
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "linuxtestproject.agent@gmail.com" <linuxtestproject.agent@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
I've been debugging the test random failures and it all boils down to
two things:

- the sysfs temperature values are in mC the increment we have is way
  too small

- we need to set the trigger value in the while(sleep_time > 0) loop
  otherwise we can end up running all the iterations with a value that
  is too high (if we enter the function when the CPU temperature was
  high)

The test runs reliably for me with -i 100 with these changes, I can push
the test with these changes added if you agree:

diff --git a/testcases/kernel/thermal/thermal_interrupt_events.c b/testcases/kernel/thermal/thermal_interrupt_events.c
index 42e1532f6..ed55632dc 100644
--- a/testcases/kernel/thermal/thermal_interrupt_events.c
+++ b/testcases/kernel/thermal/thermal_interrupt_events.c
@@ -20,10 +20,10 @@
 #include "tst_timer_test.h"

 #define        TEST_RUNTIME    ((RUNTIME + SLEEPTIME) * (SLEEPTIME / 2) + COOLDOWN)
-#define        RUNTIME         30
+#define        RUNTIME         10
 #define        SLEEPTIME       10
 #define        COOLDOWN        300
-#define        TEMP_INCREMENT  10
+#define        TEMP_INCREMENT  5000

 static bool *x86_pkg_temp_tz;
 static char temp_path[PATH_MAX], trip_path[PATH_MAX];
@@ -135,13 +135,8 @@ static void cpu_workload(double run_time)
        }
 }

-static void test_zone(int i)
+static void set_trippoint(void)
 {
-       int sleep_time = SLEEPTIME;
-       double run_time = RUNTIME;
-
-       snprintf(temp_path, PATH_MAX, "/sys/class/thermal/thermal_zone%d/temp", i);
-       tst_res(TINFO, "Testing %s", temp_path);
        SAFE_FILE_SCANF(temp_path, "%d", &temp);
        if (temp < 0)
                tst_brk(TBROK, "Unexpected zone temperature value %d", temp);
@@ -150,10 +145,21 @@ static void test_zone(int i)

        temp_high = temp + TEMP_INCREMENT;

-       snprintf(trip_path, PATH_MAX, "/sys/class/thermal/thermal_zone%d/trip_point_1_temp", i);
-
        tst_res(TDEBUG, "Setting new trip_point_1_temp value: %d", temp_high);
        SAFE_FILE_PRINTF(trip_path, "%d", temp_high);
+}
+
+static void test_zone(int i)
+{
+       int sleep_time = SLEEPTIME;
+       double run_time = RUNTIME;
+
+       snprintf(temp_path, PATH_MAX, "/sys/class/thermal/thermal_zone%d/temp", i);
+       snprintf(trip_path, PATH_MAX, "/sys/class/thermal/thermal_zone%d/trip_point_1_temp", i);
+
+       tst_res(TINFO, "Testing %s", temp_path);
+
+       set_trippoint();

        while (sleep_time > 0) {
                tst_res(TDEBUG, "Running for %f seconds, then sleeping for %d seconds", run_time, sleep_time);
@@ -173,7 +179,9 @@ static void test_zone(int i)
                if (temp > temp_high)
                        break;
                sleep(sleep_time--);
-               run_time -= 3;
+               run_time--;
+
+               set_trippoint();
        }
 }


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
