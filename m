Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41749606A325
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=IBEZB4ce;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=V00tEOyV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=JSAhaA8I;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=V/WjeyRC
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5E7D3E9356
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 11:12:08 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96D7C3E932F
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 11:11:52 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 43A002009D3
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 11:11:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 54D4A22375;
 Wed, 18 Nov 2026 10:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794996711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=reHdpzmAHobaGvlhPIhnxFMv10cwqlcdr1BURBsUdZ0=;
 b=IBEZB4ceX6YoQEJrM3TN/30p96QPSBjfIUDmkPz3l4jafUECvBW4JsYWa4skyawyj0bEGY
 mcTvdRQQmn6/p+1IxZSvBRoNhzpETr1sgViXXibOEknslsQDF/PDQOg8T09MkZ5MjTC7R2
 hnxISrFDYc0y3ECnDVpaop9KUkTBTgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794996711;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=reHdpzmAHobaGvlhPIhnxFMv10cwqlcdr1BURBsUdZ0=;
 b=V00tEOyV0cPci447ybLSjaWSZj0dswZw0JkdY76QYdm4ZISp2wizM3VwPVJeVKnAAY/896
 9MZRL9jJgOGFQFAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JSAhaA8I;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="V/WjeyRC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794996710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=reHdpzmAHobaGvlhPIhnxFMv10cwqlcdr1BURBsUdZ0=;
 b=JSAhaA8I75IhyyCf89s0ta9svi7qSlNoKNkED8KGYTtjyvLrvBP6/sKctiHe4obvRkiicQ
 cv5ZetnAnaUSLuylB+vNCRYtAdbTfSIn7E+xGb3w1Ob8IOyN/y1B3Z09q2sCXAtXJdTiRd
 ubMEwhjEyhsyVHEqL2lJD7fwsve8oPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794996710;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=reHdpzmAHobaGvlhPIhnxFMv10cwqlcdr1BURBsUdZ0=;
 b=V/WjeyRClCHSabQoZ/2hFrBlU9QF56M4kYsixh7mrFMYHsXt+ecMbGtt5GkVxLg+0DD+9B
 ZOksBKg5JkE6eoBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27CA7134E9;
 Wed, 18 Nov 2026 10:11:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jaqTAeZ5/WqkLgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 18 Nov 2026 10:11:50 +0000
Date: Wed, 18 Nov 2026 11:12:18 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <av16AqIo5sj10FEv@yuki.lan>
References: <20261117235848.2975548-1-wakel@google.com>
 <20261118044914.3815-1-linuxtestproject.agent@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261118044914.3815-1-linuxtestproject.agent@gmail.com>
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_TO(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 54D4A22375
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sys_rtc01: Report TCONF on system time mismatch when
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
Cc: Wake Liu <wakel@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +	} else if (is_clock_unsynced()) {
> > +		tst_res(TCONF,
> > +			"%s: since_epoch (%lld), system time (%lld), diff %llds > slack %lds (STA_UNSYNC is set)",
> > +			name, (long long)since_epoch, (long long)sys_epoch,
> > +			diff, slack);
> 
> STA_UNSYNC is already set at boot by ntp_init() and rtc_hctosys() (via
> do_settimeofday64() -> ntp_clear()), and it is only ever cleared when a
> userspace NTP daemon calls adjtimex(2) with ADJ_STATUS. On any system without
> an active NTP daemon, is_clock_unsynced() always returns 1 even if the clock
> was never stepped after boot, making the TFAIL branch unreachable and masking
> real RTC vs system time mismatches. Conversely, when an NTP daemon is active
> and clears STA_UNSYNC after syncing a system booted with a wrong RTC, the RTC
> can still diverge if CONFIG_RTC_SYSTOHC is disabled or unsupported by the
> driver.

Hmm, I guess that the logic should be the other way, if STA_UNSYNC is
not set the clock was modified by NTP and the test should be skipped:

diff --git a/testcases/kernel/sysfs/class/rtc/sys_rtc01.c b/testcases/kernel/sysfs/class/rtc/sys_rtc01.c
index 0e1c69f95..a4ad37088 100644
--- a/testcases/kernel/sysfs/class/rtc/sys_rtc01.c
+++ b/testcases/kernel/sysfs/class/rtc/sys_rtc01.c
@@ -47,8 +47,11 @@
  * system clock was later stepped in userspace via :manpage:`clock_settime(2)`
  * or :manpage:`settimeofday(2)` without updating the RTC, the kernel sets
  * STA_UNSYNC and CONFIG_RTC_SYSTOHC does not write the system clock back to
- * the RTC while hctosys remains 1. Report TCONF instead of TFAIL when
- * since_epoch diverges from system time while STA_UNSYNC is set.
+ * the RTC while hctosys remains 1.
+ *
+ * If system time was corrected by NTP the kernel clears STA_UNSYNC flag.
+ * Report TCONF instead of TFAIL when since_epoch diverges from system time
+ * when STA_UNSYNC is not set.
  *
  * Under virtualization the slack is additionally multiplied, since a VM's
  * clock (and thus its emulated RTC) commonly lags real time by tens of
@@ -112,14 +115,14 @@ static long read_hctosys(const char *name)
        return TST_SYSFS_READ_LI(PATH_CLASS_RTC "/%s/hctosys", name);
 }

-static int is_clock_unsynced(void)
+static int clock_is_synced(void)
 {
        struct timex tx = { .modes = 0 };

        if (adjtimex(&tx) == -1)
                tst_brk(TBROK | TERRNO, "adjtimex() failed");

-       return !!(tx.status & STA_UNSYNC);
+       return !(tx.status & STA_UNSYNC);
 }

 static void read_rtc_snapshot(const char *name, char *date, size_t date_size,
@@ -217,9 +220,9 @@ static void check_rtc(const char *name, int any_hctosys)
                        "%s: since_epoch (%lld), system time (%lld), diff %llds <= slack %lds",
                        name, (long long)since_epoch, (long long)sys_epoch,
                        diff, slack);
-       } else if (is_clock_unsynced()) {
+       } else if (clock_is_synced()) {
                tst_res(TCONF,
-                       "%s: since_epoch (%lld), system time (%lld), diff %llds > slack %lds (STA_UNSYNC is set)",
+                       "%s: since_epoch (%lld), system time (%lld), diff %llds > slack %lds (STA_UNSYNC is not set)",
                        name, (long long)since_epoch, (long long)sys_epoch,
                        diff, slack);
        } else {


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
