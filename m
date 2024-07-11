Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0ECC3DA47
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 08:45:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 131533CDE69
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 10:45:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31BD23C0625
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 10:45:23 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7209D1A05C6B
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 10:45:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A576C21BD1;
 Thu, 11 Jul 2024 08:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720687521;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o2kXSJ9OayofaKkwXULKT+D1ltisyx8WdsvYd72zXdk=;
 b=p0/YhfaO1JgeRnIHAQDAX7+weHc0wV3pyXEM7rc2KpznnTJSlAduImsC/v2kmyGwQbvSP7
 SOv6CDTf50BcFaR8VKI8MepB7eJOe7tZ/A9pdj0CbJoE6V3wT0UEwl7+R7ka9tI8X9UguO
 rIZThJ9HW3KLh2VshkTBfSRoDFWWkNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720687521;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o2kXSJ9OayofaKkwXULKT+D1ltisyx8WdsvYd72zXdk=;
 b=PrJdHlbd6YeZ3zyLpG5jklVXi2N8799blcgwGAFNImZogbZtJtw7TE7euHNywRYV7jwlnF
 ZlxFoH6pnFZcXmCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="p0/YhfaO";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PrJdHlbd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720687521;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o2kXSJ9OayofaKkwXULKT+D1ltisyx8WdsvYd72zXdk=;
 b=p0/YhfaO1JgeRnIHAQDAX7+weHc0wV3pyXEM7rc2KpznnTJSlAduImsC/v2kmyGwQbvSP7
 SOv6CDTf50BcFaR8VKI8MepB7eJOe7tZ/A9pdj0CbJoE6V3wT0UEwl7+R7ka9tI8X9UguO
 rIZThJ9HW3KLh2VshkTBfSRoDFWWkNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720687521;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o2kXSJ9OayofaKkwXULKT+D1ltisyx8WdsvYd72zXdk=;
 b=PrJdHlbd6YeZ3zyLpG5jklVXi2N8799blcgwGAFNImZogbZtJtw7TE7euHNywRYV7jwlnF
 ZlxFoH6pnFZcXmCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98331136AF;
 Thu, 11 Jul 2024 08:45:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MwuoJKGbj2bXJwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Jul 2024 08:45:21 +0000
Date: Thu, 11 Jul 2024 10:45:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240711084520.GA35371@pevik>
References: <20240710-landlock-v2-0-ff79db017d57@suse.com>
 <20240710-landlock-v2-11-ff79db017d57@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240710-landlock-v2-11-ff79db017d57@suse.com>
X-Rspamd-Queue-Id: A576C21BD1
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.29 / 50.00]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 11/11] Add landlock06 test
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

Hi Andrea,

...
> +static void run(void)
> +{
> +	if (!SAFE_FORK()) {
> +		int flag;
> +		size_t sz = 0;
> +
> +		TST_EXP_PASS(ioctl(file_fd, FIONREAD, &sz));
> +
> +		/* check unrestrictable commands */
> +		TST_EXP_PASS(ioctl(dev_fd, FIOCLEX));
> +		TST_EXP_PASS(ioctl(dev_fd, FIONCLEX));
> +		TST_EXP_PASS(ioctl(dev_fd, FIONBIO, &flag));
> +		TST_EXP_PASS(ioctl(dev_fd, FIOASYNC, &flag));
> +
> +		_exit(0);
> +	}
nit: I would avoid indentation with return:

	if (SAFE_FORK())
		return;

	int flag;
	size_t sz = 0;

	TST_EXP_PASS(ioctl(file_fd, FIONREAD, &sz));

	/* check unrestrictable commands */
	TST_EXP_PASS(ioctl(dev_fd, FIOCLEX));
	TST_EXP_PASS(ioctl(dev_fd, FIONCLEX));
	TST_EXP_PASS(ioctl(dev_fd, FIONBIO, &flag));
	TST_EXP_PASS(ioctl(dev_fd, FIOASYNC, &flag));

	_exit(0);

(minor detail, I can change it during merge)

...
> +	.format_device = 1,
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1,
> +	.skip_filesystems = (const char *[]) {
> +		"vfat",
Unfortunately also exfat needs to be skipped (can be done during merge).
> +		NULL

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
