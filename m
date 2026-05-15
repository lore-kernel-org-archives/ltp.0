Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF6CCD343F
	for <ltp@archiver.kernel.org>; Fri, 15 May 2026 14:40:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3CB63E2C1B
	for <ltp@archiver.kernel.org>; Fri, 15 May 2026 16:40:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4ADF93E241E
 for <ltp@lists.linux.it>; Fri, 15 May 2026 16:39:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D57AF20026B
 for <ltp@lists.linux.it>; Fri, 15 May 2026 16:39:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 31615673A9;
 Fri, 15 May 2026 14:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778855990;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qHjzTabV4uSK3TWB77bq07YV0fBUWO5gNV9ny9VY1cU=;
 b=OQRBZ/Bz9c3nn4c3HDJgHZrpekBWe14abqO+x7WHOR9fqHjtaTa2cfjCayC2ltJVJM3i+L
 55qpNQlcOPUQ290w3K4M64ZwTrOS8stAlHbbiVG8cxjpcLOv5xr9puqnXUMzs49rwL18Zz
 CJtwgriVbEFsJeaFTiqXssM/QCMRALw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778855990;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qHjzTabV4uSK3TWB77bq07YV0fBUWO5gNV9ny9VY1cU=;
 b=bk/MvCcU5E2hCxuW1H7FFVdMpAbNxsM+EiiTper8IXL5hqhyRxlaYzwLj7iwmKqdKvuIGy
 qjywqNACYL2VTXCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="OQRBZ/Bz";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="bk/MvCcU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778855990;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qHjzTabV4uSK3TWB77bq07YV0fBUWO5gNV9ny9VY1cU=;
 b=OQRBZ/Bz9c3nn4c3HDJgHZrpekBWe14abqO+x7WHOR9fqHjtaTa2cfjCayC2ltJVJM3i+L
 55qpNQlcOPUQ290w3K4M64ZwTrOS8stAlHbbiVG8cxjpcLOv5xr9puqnXUMzs49rwL18Zz
 CJtwgriVbEFsJeaFTiqXssM/QCMRALw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778855990;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qHjzTabV4uSK3TWB77bq07YV0fBUWO5gNV9ny9VY1cU=;
 b=bk/MvCcU5E2hCxuW1H7FFVdMpAbNxsM+EiiTper8IXL5hqhyRxlaYzwLj7iwmKqdKvuIGy
 qjywqNACYL2VTXCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03BFA593A9;
 Fri, 15 May 2026 14:39:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /vYrADYwB2puMgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 15 May 2026 14:39:50 +0000
Date: Fri, 15 May 2026 16:39:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <20260515143948.GA40164@pevik>
References: <20260514093649.125287-2-piotr.kubaj@intel.com>
 <20260514120004.4030-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260514120004.4030-1-linuxtestproject.agent@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.21 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TAGGED_RCPT(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 31615673A9
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

> Hi Piotr,

> On 2026-05-14, Piotr Kubaj wrote:
> > thermal: add new test group

> > +static void run(void)
> > +{
> > +	static bool first_zone = true;
> > +	...
> > +		if (!first_zone) {
> > +			tst_res(TINFO, "Cooling down for %d seconds", COOLDOWN);
> > +			sleep(COOLDOWN);
> > +		}
> > +		first_zone = false;

> The `static` qualifier means `first_zone` is initialized only once, at
> program start. On the second iteration (`-i 2`), it will already be
> `false`, causing the first zone to incur an unnecessary 300-second
> cooldown. Drop `static` so it resets to `true` on every call.

AI is wrong, that was actually the point. IMHO this v20 is better than following
v21. I just wonder if 300 sec isn't too much.

Also, it can still fail if one runs test more times without iterations. But I'm
ok with this known issue.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

If I get Cyril's ack, I'll merge this version with minor formatting diff.

Kind regards,
Petr

diff --git testcases/kernel/thermal/thermal_interrupt_events.c testcases/kernel/thermal/thermal_interrupt_events.c
index b282180314..9d9d9d7e4c 100644
--- testcases/kernel/thermal/thermal_interrupt_events.c
+++ testcases/kernel/thermal/thermal_interrupt_events.c
@@ -201,7 +201,7 @@ static void run(void)
 	for (int i = 0; i < tz_counter; i++) {
 		if (x86_pkg_temp_tz[i]) {
 			if (!first_zone) {
-				tst_res(TINFO, "Cooling down for %d seconds", COOLDOWN);
+				tst_res(TINFO, "Cooling down for %d sec", COOLDOWN);
 				sleep(COOLDOWN);
 			}
 			first_zone = false;
@@ -215,8 +215,8 @@ static void run(void)
 			for (int j = 0; j < nproc; j++) {
 				if (interrupt_later[j] > interrupt_init[j]) {
 					interrupt_increased = true;
-					tst_res(TINFO, "CPU %d interrupt counter: %" PRIu64 " (previous: %" PRIu64 ")",
-						j, interrupt_later[j], interrupt_init[j]);
+					tst_res(TINFO, "CPU %d interrupt counter: %" PRIu64 " => %" PRIu64,
+						j, interrupt_init[j], interrupt_later[j]);
 				}
 			}
 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
