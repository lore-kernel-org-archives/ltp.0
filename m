Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4F8C982D8
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 15:53:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29AB03EAE18
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 17:53:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 460E63E9201
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 17:53:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EC2F51000645
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 17:53:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 25E4021DDA;
 Fri, 18 Sep 2026 15:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789746794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y4nDC0KUzK3RuuP/L9fmpgn6H22PXA7JYYblIigANJ8=;
 b=D8cLuaVH8TiZXgrzCrInTz2+OdFUmLSSLOIyWZjHVQ5nnTyu57xd8WWgct1Cg9E6dsVmoM
 JSO0Squxoz8AJKeymVegvkHHBpY/8rLRgGfJA5n4T0Cx0/i2tqxcpAtdfOuiXLj6bJXWMY
 wwy6GC0pZYsqWqtr9h2Jic/qc3KI52U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789746794;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y4nDC0KUzK3RuuP/L9fmpgn6H22PXA7JYYblIigANJ8=;
 b=qnW/UYW1oUYxLPVh01hEfan7UJLwfoW22NH+wDQJGXzOCmZvPkMmnh1zx5vkxyWSSsP7aP
 zTF2ZzuPwoVauCDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Nx2E7VWW;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="z/zdrXSC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789746790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y4nDC0KUzK3RuuP/L9fmpgn6H22PXA7JYYblIigANJ8=;
 b=Nx2E7VWWQ/4EIcAUe/yVG2mWmOCSq5UVSJE/dyZjaMsh3+gGtn4zptar2nikNvnrvJCnJk
 gW3NU8qQg9R50BTc+WI0nSUqSCBfaGiOJSYbxo8lg6M0vv3YjABNT6Qg4HRoYrrKayX4Ev
 Y6WZAZujNrfCYp0pR221lGd3ruBP/Wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789746790;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y4nDC0KUzK3RuuP/L9fmpgn6H22PXA7JYYblIigANJ8=;
 b=z/zdrXSCq4Iwcy9MsI73UktGR8W3IxgXFwtloBMhanR4zmQX0jj4SjktVVu0/yYqmJWrdp
 m8oLZsQkEkvT7jCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAFC713991;
 Fri, 18 Sep 2026 15:53:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UHhCMWVerWpTVwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 18 Sep 2026 15:53:09 +0000
Date: Fri, 18 Sep 2026 17:53:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aq1ecV5JbC4ZSIXp@yuki.lan>
References: <20260916140402.1797325-1-pvorel@suse.cz>
 <20260916140402.1797325-36-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260916140402.1797325-36-pvorel@suse.cz>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 25E4021DDA
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 35/36] keyctl38: Test KEYCTL_WATCH_KEY add and
 remove
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
> +static void run(void)
> +{
> +	int pipefd[2];
> +
> +	TEST(pipe2(pipefd, O_NOTIFICATION_PIPE));
> +	if (TST_RET < 0) {
> +		if (TST_ERR == ENOPKG)
> +			tst_brk(TCONF | TTERRNO, "CONFIG_WATCH_QUEUE is not set");
> +		if (TST_ERR == EINVAL)
> +			tst_brk(TCONF | TTERRNO, "O_NOTIFICATION_PIPE is not supported");
> +		tst_brk(TBROK | TTERRNO, "pipe2(O_NOTIFICATION_PIPE) failed");
> +	}
> +
> +	SAFE_IOCTL(pipefd[0], IOC_WATCH_QUEUE_SET_SIZE, 256);
> +
> +	TST_EXP_PASS(keyctl(KEYCTL_WATCH_KEY, key, pipefd[0], 1),
> +		     "KEYCTL_WATCH_KEY add watch on key");
> +
> +	TST_EXP_PASS(keyctl(KEYCTL_WATCH_KEY, key, pipefd[0], -1),
> +		     "KEYCTL_WATCH_KEY remove watch on key");
> +
> +	TST_EXP_PASS(keyctl(KEYCTL_WATCH_KEY, KEY_SPEC_SESSION_KEYRING,
> +			    pipefd[0], 2),
> +		     "KEYCTL_WATCH_KEY add watch on session keyring");
> +
> +	TST_EXP_PASS(keyctl(KEYCTL_WATCH_KEY, KEY_SPEC_SESSION_KEYRING,
> +			    pipefd[0], -1),
> +		     "KEYCTL_WATCH_KEY remove watch on session keyring");
> +
> +	SAFE_CLOSE(pipefd[0]);
> +	SAFE_CLOSE(pipefd[1]);

I guess that this test is pretty much incomplete, we should actually do
something with the key, i.e. set key attributes and then check that the
notification pipe got the right event.

So I would skip the notification pipe tests for the release, there is
quite a lot of missing features here.


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
