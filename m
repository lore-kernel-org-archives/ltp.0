Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16675E77188
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 12:47:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 838323C1B47
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 13:47:58 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 697253C0325
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 13:47:42 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D9D761BD674C
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 13:47:41 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1010F1F385;
 Wed,  8 Jan 2025 12:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736340460;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tV/aWMh0t+lGdJezFkdU7SMR/JT4hQ5xIgtbDPcKsUo=;
 b=FRc5EVgBcxR25bJpTsk/VBNvMD85H+/B9S6qahr6DX7RKzcCpNLKWgRYMmi+tltZteZ1vQ
 RajQ8Te7GlplG6GhGEWmgmUsuCYkavzpNF4q3y1zA20pKFUpXx9ZqDCZK5nDuYH1vdFxmp
 bxeTNDFLzSoj1Z7K21umQqSL+CQpN7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736340460;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tV/aWMh0t+lGdJezFkdU7SMR/JT4hQ5xIgtbDPcKsUo=;
 b=R1uQb1KggscLflGWT+gBxgCjpyHwaIShpZrBQS02Kh3EhP/lb+/b/8o29FssNqEzpay1zF
 nKQVvjqUo/Sb6NCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FRc5EVgB;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=R1uQb1Kg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736340460;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tV/aWMh0t+lGdJezFkdU7SMR/JT4hQ5xIgtbDPcKsUo=;
 b=FRc5EVgBcxR25bJpTsk/VBNvMD85H+/B9S6qahr6DX7RKzcCpNLKWgRYMmi+tltZteZ1vQ
 RajQ8Te7GlplG6GhGEWmgmUsuCYkavzpNF4q3y1zA20pKFUpXx9ZqDCZK5nDuYH1vdFxmp
 bxeTNDFLzSoj1Z7K21umQqSL+CQpN7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736340460;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tV/aWMh0t+lGdJezFkdU7SMR/JT4hQ5xIgtbDPcKsUo=;
 b=R1uQb1KggscLflGWT+gBxgCjpyHwaIShpZrBQS02Kh3EhP/lb+/b/8o29FssNqEzpay1zF
 nKQVvjqUo/Sb6NCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6F9D1351A;
 Wed,  8 Jan 2025 12:47:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 14HrNutzfmdDKAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 08 Jan 2025 12:47:39 +0000
Date: Wed, 8 Jan 2025 13:47:34 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250108124734.GB27248@pevik>
References: <20250106-fix_setsid_tests-v2-0-c43f57a2bab6@suse.com>
 <20250106-fix_setsid_tests-v2-3-c43f57a2bab6@suse.com>
 <Z31P7KEtbAwaCG7l@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z31P7KEtbAwaCG7l@yuki.lan>
X-Rspamd-Queue-Id: 1010F1F385
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 03/11] Refactor ptem01 test
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

Hi Andrea, Cyril,

> Hi!
> > +	masterfd = SAFE_OPEN(MASTERCLONE, O_RDWR);
> > +	slavename = SAFE_PTSNAME(masterfd);

> > -	for (i = 0; i < NUMOPENS; ++i) {
> > -		masterfd[i] = open(MASTERCLONE, O_RDWR);
> > -		if (masterfd[i] < 0) {
> > -			tst_resm(TBROK, "%s", MASTERCLONE);
> > -			tst_resm(TBROK, "out of ptys");
> > -			for (i = 0; i < NUMOPENS; ++i) {
> > -				if (masterfd[i] != 0) {
> > -					(void)close(masterfd[i]);
> > -				}
> > -				if (slavefd[i] != 0) {
> > -					(void)close(slavefd[i]);
> > -				}
> > -			}
> > -			tst_exit();
> > -		}
> > +	TST_EXP_PASS(grantpt(masterfd));
> > +	TST_EXP_PASS(unlockpt(masterfd));

> > -		slavename = ptsname(masterfd[i]);
> > -		if (slavename == NULL) {
> > -			tst_brkm(TBROK | TERRNO, NULL,
> > -				 "ptsname() call failed");
> > -		}
> > +	slavefd = SAFE_OPEN(slavename, O_RDWR);

> This would be a bit better if done in setup()

Good catch. If this fails, masterfd will be left unclosest
(it would break on high -i). Also it speedup the test with high -i.

I did not catch it because I thought it's better to close fd in case of repeated
testing with -i, but obviously it should be perfectly safe to have open file
descriptors shared during repeated testing.

> > -		if (grantpt(masterfd[i]) != 0) {
> > -			tst_brkm(TBROK | TERRNO, NULL,
> > -				 "grantpt() call failed");
> > -		}
> > +	TST_EXP_POSITIVE(ioctl(slavefd, TCGETS, &termios));
> > +	TST_EXP_POSITIVE(ioctl(slavefd, TCSETS, &termios));
> > +	TST_EXP_POSITIVE(ioctl(slavefd, TCSETSW, &termios));
> > +	TST_EXP_POSITIVE(ioctl(slavefd, TCSETSF, &termios));
> > +	TST_EXP_POSITIVE(ioctl(slavefd, TCSETS, &termios));
> > +	TST_EXP_POSITIVE(ioctl(slavefd, TCGETA, &termio));
> > +	TST_EXP_POSITIVE(ioctl(slavefd, TCSETA, &termio));
> > +	TST_EXP_POSITIVE(ioctl(slavefd, TCSETAW, &termio));
> > +	TST_EXP_POSITIVE(ioctl(slavefd, TCSETAF, &termio));

> Are you sure these shouldn't be TST_EXP_PASS() instead? The original
> code was doing != 0 for all of these.

+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
