Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF46C79FA0
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 15:14:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE7423E950C
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 17:14:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FB193E85D7
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 17:14:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3419C100048A
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 17:14:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5408F1F750;
 Mon,  7 Sep 2026 15:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788794046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vR//vMdzcp5yTlwB1H348h/HB6jDW5VQCxK03rGVnks=;
 b=UcUxX31DsgQmFpspTRMNxfSuTjjxUZ84Aiq01aupGJti3w7I/tGbD8AD8+SqGSGPGIzxyj
 4iaao6cfAHX+7Emv6aMzb3J91mA3L8Dy3QhLPNqx/SjQTghn6uuOpU7WqjdflKiD0JvdaC
 E6qv+ILQT2fOo+ECx78N8NIB0+8u5tU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788794046;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vR//vMdzcp5yTlwB1H348h/HB6jDW5VQCxK03rGVnks=;
 b=frKFjEcIRMXVg9bmSybAuNKAo9gFyTMkZmCb+dLuKjHDM/A/hixW2O94M33WRZ4iZD/nMj
 9TMFdNhdCuc8a5DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788794042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vR//vMdzcp5yTlwB1H348h/HB6jDW5VQCxK03rGVnks=;
 b=jVG1XLQGtYi5XF0y9XKEAgQuIEcuG4nSZ+wJi4lqtnXgS8o9Cj3Mn2cIdVwCrOWtya486W
 u8gR9RQXoiDyGVq7b/9zd9MLnSrr5aRxyLXtyUWl7Q+8MRSEVNIZjBYwh623GKyDOFhmpB
 criz4rqWZwdNGVgvQmncwU7U6N1n4Xk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788794042;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vR//vMdzcp5yTlwB1H348h/HB6jDW5VQCxK03rGVnks=;
 b=z5WEiGbYg0A9oCvXdDvG/7gqU9AhDrUdIQgWDIatTH4moLmdK7lBFRIQFrxVcijusgbb/h
 eWRcfMzn1lDW20DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A2BB1368D;
 Mon,  7 Sep 2026 15:14:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id niNICrrUnmr8UwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 07 Sep 2026 15:14:02 +0000
Date: Mon, 7 Sep 2026 17:14:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ap7Uv_3UV-TBntFa@yuki.lan>
References: <20260827112157.1748734-1-chrubis@suse.cz>
 <20260827112157.1748734-25-chrubis@suse.cz>
 <20260903171142.GJ1107507@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260903171142.GJ1107507@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, yuki.lan:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 24/31] testcases: sysfs: Add sys_block_loop01
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +	fd = SAFE_OPEN(dev_path, O_RDWR);
> > +	info.lo_flags = LO_FLAGS_AUTOCLEAR;
> > +	SAFE_IOCTL(fd, LOOP_SET_STATUS64, &info);
> > +	SAFE_CLOSE(fd);
> > +
> > +	/* autoclear runs asynchronously off a kernel workqueue, poll for it */
> > +	size = TST_RETRY_FN_EXP_BACKOFF(read_loop_size(), TST_RETVAL_EQ0, 5);
> > +
> > +	if (size == 0) {
> > +		tst_res(TPASS, "Device auto-detached");
> > +		attached = 0;
> > +	} else {
> > +		tst_res(TFAIL, "Device did not auto-detach in time");
> > +		tst_detach_device(dev_path);
> > +		attached = 0;
> > +	}
> nit: attached = 0 can be only once here below if/else.
> Also, I'm not sure why it's set to 0 because tst_detach_device() was not called,
> but obviously I just miss something obvious.

That's what the LO_FLAGS_AUTOCLEAR is for, the file is supposed to be
detached when last fd pointing to the device is closed.

> > +}
> > +
> > +static void run(void)
> > +{
> > +	if (tst_attach_device(dev_path, BACKING_FILE))
> > +		tst_brk(TBROK, "Failed to attach %s to %s", BACKING_FILE,
> > +			dev_path);
> > +	attached = 1;
> > +
> > +	check_attached();
> > +	check_reconfigured();
> > +
> > +	if (tst_detach_device(dev_path))
> IMHO it'd be safer to guard this with check attached in case of later code changes:
> 
> 	if (attached && tst_detach_device(dev_path))
> 		tst_brk(TBROK, "Failed to detach %s", dev_path);

I do not like adding code "just in case" it's usually more confusing
that keeping it that way.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
