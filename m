Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F391DD74962
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 14:25:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DAC03D0540
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 15:25:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8038D3CB3C1
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 15:25:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CB39960096A
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 15:25:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2E266336DB;
 Fri, 19 Dec 2025 14:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766154322;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/R/qZx6KiDJAz+PCy70Csq8GFr53+EdLS86ae8EZGiE=;
 b=FDXs6crYvQyifISRcsleVuEDo8t9ihnSrXZ8yA6Cs3zwNopYOLDNxhzETCfcU/vDC4N+7a
 eR4ohTfIH1Aasw7r8oMFoNpeapryD41TRDQ5Cj3jDatIu8///LyOSI5DWKgNtxXovH92bx
 y1v9oxsxOFrnquifIskIVRpkuT6tGew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766154322;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/R/qZx6KiDJAz+PCy70Csq8GFr53+EdLS86ae8EZGiE=;
 b=nkdQd9f9rXnzB8ejenpcNEFrjjh5VefQrGBdkKZOQPcdcFcSAxkqIRcQ+MS6XFlRiITnOg
 bHg5YvP9NPLuIdDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FDXs6crY;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nkdQd9f9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766154322;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/R/qZx6KiDJAz+PCy70Csq8GFr53+EdLS86ae8EZGiE=;
 b=FDXs6crYvQyifISRcsleVuEDo8t9ihnSrXZ8yA6Cs3zwNopYOLDNxhzETCfcU/vDC4N+7a
 eR4ohTfIH1Aasw7r8oMFoNpeapryD41TRDQ5Cj3jDatIu8///LyOSI5DWKgNtxXovH92bx
 y1v9oxsxOFrnquifIskIVRpkuT6tGew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766154322;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/R/qZx6KiDJAz+PCy70Csq8GFr53+EdLS86ae8EZGiE=;
 b=nkdQd9f9rXnzB8ejenpcNEFrjjh5VefQrGBdkKZOQPcdcFcSAxkqIRcQ+MS6XFlRiITnOg
 bHg5YvP9NPLuIdDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 943C13EA63;
 Fri, 19 Dec 2025 14:25:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mItdH1FgRWmjOQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 19 Dec 2025 14:25:21 +0000
Date: Fri, 19 Dec 2025 15:25:12 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251219142512.GC247368@pevik>
References: <20251118143607.45308-1-pvorel@suse.cz>
 <20251118143607.45308-3-pvorel@suse.cz> <aTqnt-lgcX2KLHPK@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aTqnt-lgcX2KLHPK@yuki.lan>
X-Rspamd-Queue-Id: 2E266336DB
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] swapon03: Try to swapon() as many files
 until it fails
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

...
> > +/*
> > + * MAX_SWAPFILES from the internal kernel implementation is currently <23, 29>,
> > + * depending on kernel configuration (see man swapon(2). Chose small enough
> > + * value for future changes.
> > + */
> > +#define NUM_SWAP_FILES 15

> It would be slightly better if we renamed this to MIN_SWAP_FILES since
> this is the minimal number of swapfiles we expect to be able to create.

> >  #define MNTPOINT	"mntpoint"
> >  #define TEST_FILE	MNTPOINT"/testswap"

> > @@ -27,31 +37,33 @@ static int swapfiles;

> >  static int setup_swap(void)
> >  {
> > -	int j, max_swapfiles, used_swapfiles;
> > +	int used_swapfiles, expected_swapfiles;

> Here as well, s/expected_swapfiles/min_swapfiles/

> >  	char filename[FILENAME_MAX];

> > -	/* Determine how many more files are to be created */
> > -	max_swapfiles = tst_max_swapfiles();
> >  	used_swapfiles = tst_count_swaps();
> > -	swapfiles = max_swapfiles - used_swapfiles;
> > -	if (swapfiles > max_swapfiles)
> > -		swapfiles = max_swapfiles;
> > +	expected_swapfiles = NUM_SWAP_FILES - used_swapfiles;

> > -	/*create and turn on remaining swapfiles */
> > -	for (j = 0; j < swapfiles; j++) {
> > +	if (expected_swapfiles < 0)
> > +		tst_brk(TCONF, "too many used swap files (%d)", used_swapfiles);

> Do we really have to quit here? If all swap slots are already used we
> will not create any additioinal swaps and just go directly to the test.
> If there are some slot left, we will fill them.

We already have v4, which does not contain it.  But just for a record (I'm sorry
to discuss in the old version):
the original suggestion was to have at least few swapon() runs. This is not
checked in the code you suggested. Of course, the reason why swapon() fails
should be due already used swaps. But we don't check that. We have options:
* count used swaps (i.e. count lines in /proc/swaps)
* ignore the check
* require at least one swap can be created (code in v4).

Kind regards,
Petr

> The only difference is taht we shouldn't expect a failure until this
> number of swaps has been reached.

> So we should do:

> 	if (swapon(filename, 0) == -1) {
> 		if (errno == EPERM && swapfiles > min_swapfiles)
> 			break;

> 		tst_res(TFAIL | TERRNO, "swapon(%s, 0)", filename);
> 	}

> > -		/* Create the swapfile */
> > -		snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j + 2);
> > -		SAFE_MAKE_SMALL_SWAPFILE(filename);
> > +	SAFE_MAKE_SMALL_SWAPFILE(TEST_FILE);
> > +	swapfiles++;

> Why do we increase the number of swapfiles here? We only created the
> file. Isn't the swapfiles counter for swaps that were enabled by
> swapon()?

> > -		/* turn on the swap file */
> > -		TST_EXP_PASS_SILENT(swapon(filename, 0));
> > -		if (!TST_PASS)
> > -			tst_brk(TFAIL, "Failed to setup swap files");
> > +	while (true) {
> > +		/* Create the swapfile */
> > +		snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, swapfiles);
> > +		MAKE_SMALL_SWAPFILE(filename);
> > +
> > +		/* Quit on a first swap file over max, check for EPERM */
> > +		if (swapon(filename, 0) == -1) {
> > +			if (errno != EPERM)
> > +				tst_res(TFAIL | TERRNO, "swapon(%s, 0)", filename);
> > +			break;
> > +		}
> > +		swapfiles++;
> >  	}

> >  	tst_res(TINFO, "Successfully created %d swap files", swapfiles);
> > -	MAKE_SMALL_SWAPFILE(TEST_FILE);

> >  	return 0;
> >  }
> > @@ -61,7 +73,7 @@ static int setup_swap(void)
> >   */
> >  static int check_and_swapoff(const char *filename)
> >  {
> > -	char cmd_buffer[256];
> > +	char cmd_buffer[FILENAME_MAX+28];
> >  	int rc = -1;

> >  	snprintf(cmd_buffer, sizeof(cmd_buffer), "grep -q '%s.*file' /proc/swaps", filename);
> > @@ -82,8 +94,8 @@ static void clean_swap(void)
> >  	int j;
> >  	char filename[FILENAME_MAX];

> > -	for (j = 0; j < swapfiles; j++) {
> > -		snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j + 2);
> > +	for (j = 1; j < swapfiles; j++) {
> > +		snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j);
> >  		check_and_swapoff(filename);
> >  	}

> > -- 
> > 2.51.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
