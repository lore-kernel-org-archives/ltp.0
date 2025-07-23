Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBF3C83F17
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 13:08:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A70B3CCD96
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 15:08:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 382DE3CCCCC
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 15:08:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 54D731400B6E
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 15:08:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A24F121891;
 Wed, 23 Jul 2025 13:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753276086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K5gbVBUX3OXDLyMXt5Lvd0JsorsSPpsFt8yIFE3lWhQ=;
 b=3PNIemoxZsSfat3dd7B2NOVJflOO4s4ZfftPCMJt6z91t/7DPTI7GDY8mzcljZZDsZr8k9
 ND1XaRWG12GupDcODlsa0eC8odBDbmBFZLB/xA9FQnegiAF6ZvBRB82eGh2OouMjaRUANf
 lu9lsGhuTancQvWEbUZ0F2/MiiifHoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753276086;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K5gbVBUX3OXDLyMXt5Lvd0JsorsSPpsFt8yIFE3lWhQ=;
 b=4q6gRY9QsodVpC4X+fPn5anJNE36jXENXKII956mMHPNmnC3I+rxPM5xC9NhcrQrMbQhlR
 0oIPh+OYh8rvqyCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3PNIemox;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4q6gRY9Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753276086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K5gbVBUX3OXDLyMXt5Lvd0JsorsSPpsFt8yIFE3lWhQ=;
 b=3PNIemoxZsSfat3dd7B2NOVJflOO4s4ZfftPCMJt6z91t/7DPTI7GDY8mzcljZZDsZr8k9
 ND1XaRWG12GupDcODlsa0eC8odBDbmBFZLB/xA9FQnegiAF6ZvBRB82eGh2OouMjaRUANf
 lu9lsGhuTancQvWEbUZ0F2/MiiifHoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753276086;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K5gbVBUX3OXDLyMXt5Lvd0JsorsSPpsFt8yIFE3lWhQ=;
 b=4q6gRY9QsodVpC4X+fPn5anJNE36jXENXKII956mMHPNmnC3I+rxPM5xC9NhcrQrMbQhlR
 0oIPh+OYh8rvqyCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87BC113302;
 Wed, 23 Jul 2025 13:08:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gVcUH7begGgIGwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 23 Jul 2025 13:08:06 +0000
Date: Wed, 23 Jul 2025 15:08:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aIDe4n_4kTZE9feR@yuki.lan>
References: <20250707-ioctl_pidfd_suite-v3-0-22ba4d15ee02@suse.com>
 <20250707-ioctl_pidfd_suite-v3-8-22ba4d15ee02@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250707-ioctl_pidfd_suite-v3-8-22ba4d15ee02@suse.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: A24F121891
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 8/8] Add ioctl_pidfd06 test
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
> +	int pidfd;
> +	pid_t pid_child;
> +
> +	memset(args, 0, sizeof(struct tst_clone_args));
> +	memset(info, 0, sizeof(struct pidfd_info));
> +
> +	info->mask = PIDFD_INFO_EXIT;
> +
> +	args->flags = CLONE_PIDFD | CLONE_NEWUSER | CLONE_NEWPID;
> +	args->pidfd = (uint64_t)&pidfd;
> +	args->exit_signal = SIGCHLD;
> +
> +	pid_child = SAFE_CLONE(args);
> +	if (!pid_child)
> +		exit(100);
> +
> +	SAFE_WAITPID(pid_child, NULL, 0);
> +
> +	memset(args, 0, sizeof(struct tst_clone_args));
> +
> +	args->flags = CLONE_NEWUSER | CLONE_NEWPID;
> +	args->exit_signal = SIGCHLD;
> +
> +	if (!SAFE_CLONE(args)) {
> +		TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, info), ESRCH);
> +		exit(0);
> +	}

SAFE_CLOSE(pid_child) here?

Otherwise we end up out of file descriptors with large enough -i
parameter.

Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
