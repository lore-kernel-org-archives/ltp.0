Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB5DC624A4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 17:12:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B2C43EB0AC
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 19:12:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B67EF3EB095
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 19:11:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 398C014001E3
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 19:11:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AA1E01FB2F;
 Thu,  3 Sep 2026 17:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788455512;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=egaHuq2YFML3YfZQF/i+QmK/waqXrhzuFycOVysqjFE=;
 b=q11Izc68N6rwG8mYlCXwpjl4qH+MxLZXEc6EvK+tDouBwbbt6rHqEvlgj3MPLSwmPAo9lp
 GncUOcDVP4/qL3vY5ASWXr2luTpZQOVDpoQZ0/qDEbzb2cwbQFPa//G44On/BgQCyqT9oV
 ug96EgeMJVVDPYsgu5tKXya8k0BG3Wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788455512;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=egaHuq2YFML3YfZQF/i+QmK/waqXrhzuFycOVysqjFE=;
 b=z+N5Bx/I1efHr2zJPhDjbD8RtZxdJREHxUFOZl7+pzZY7xfKcT+28aoq83B8w8HEXw5DD7
 LzssWmwnCsSFsIAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788455508;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=egaHuq2YFML3YfZQF/i+QmK/waqXrhzuFycOVysqjFE=;
 b=HRL6CRM24AgTeiRooBH19yS2LVaC995yDYrghFAczZYZLqTBGnWHV/XLz55g7hILR+W33d
 kIGXmigtGlg5qhy0e110WCuiXhagOffYlVnBeDBmJFfiFdOkzwt59NLhWS3gvWdQX9u8Dc
 MK/a0AiNoMWeMNI3p6lwuIqxAed6tLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788455508;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=egaHuq2YFML3YfZQF/i+QmK/waqXrhzuFycOVysqjFE=;
 b=vHFIqe96IvPvpcEsceuZVnd42P42kFkxuT7g3wpFMgayy9sbjiT5tZgIrk8BMwiNu/P+sD
 8VniWXNmyiIstnCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F393F136E6;
 Thu,  3 Sep 2026 17:11:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sK9qN1OqmWpZNwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 03 Sep 2026 17:11:47 +0000
Date: Thu, 3 Sep 2026 19:11:42 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260903171142.GJ1107507@pevik>
References: <20260827112157.1748734-1-chrubis@suse.cz>
 <20260827112157.1748734-25-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260827112157.1748734-25-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

...
> +	if (tst_attach_device(dev_path, BACKING_FILE)) {
> +		tst_res(TFAIL, "Failed to attach %s to %s for autoclear check",
> +			BACKING_FILE, dev_path);
> +		return;
> +	}
> +	attached = 1;
> +
> +	fd = SAFE_OPEN(dev_path, O_RDWR);
> +	info.lo_flags = LO_FLAGS_AUTOCLEAR;
> +	SAFE_IOCTL(fd, LOOP_SET_STATUS64, &info);
> +	SAFE_CLOSE(fd);
> +
> +	/* autoclear runs asynchronously off a kernel workqueue, poll for it */
> +	size = TST_RETRY_FN_EXP_BACKOFF(read_loop_size(), TST_RETVAL_EQ0, 5);
> +
> +	if (size == 0) {
> +		tst_res(TPASS, "Device auto-detached");
> +		attached = 0;
> +	} else {
> +		tst_res(TFAIL, "Device did not auto-detach in time");
> +		tst_detach_device(dev_path);
> +		attached = 0;
> +	}
nit: attached = 0 can be only once here below if/else.
Also, I'm not sure why it's set to 0 because tst_detach_device() was not called,
but obviously I just miss something obvious.

> +}
> +
> +static void run(void)
> +{
> +	if (tst_attach_device(dev_path, BACKING_FILE))
> +		tst_brk(TBROK, "Failed to attach %s to %s", BACKING_FILE,
> +			dev_path);
> +	attached = 1;
> +
> +	check_attached();
> +	check_reconfigured();
> +
> +	if (tst_detach_device(dev_path))
IMHO it'd be safer to guard this with check attached in case of later code changes:

	if (attached && tst_detach_device(dev_path))
		tst_brk(TBROK, "Failed to detach %s", dev_path);

Kind regards,
Petr

> +		tst_brk(TBROK, "Failed to detach %s", dev_path);
> +	attached = 0;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
