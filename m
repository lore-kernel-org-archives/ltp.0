Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42E5CAC5A7
	for <ltp@archiver.kernel.org>; Thu, 25 Sep 2025 11:46:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F18023CDE22
	for <ltp@archiver.kernel.org>; Thu, 25 Sep 2025 13:46:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A3F283CDC95
 for <ltp@lists.linux.it>; Thu, 25 Sep 2025 13:46:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C97282009CD
 for <ltp@lists.linux.it>; Thu, 25 Sep 2025 13:46:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8F0706AB0A;
 Thu, 25 Sep 2025 11:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758800766;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m0Z2+aLmAE8rQ6Fz6wdFPdiXOOqisU3qEbdGJgqbI70=;
 b=HyHkA3Xn8spvZUfSg6tLuz1OU/CsjKUo5s/8yYE7dWIneoM3m80t9YQUAD3I8CSf7igvt2
 n6ryibkaYeQmFwHBS1/VYe8ngzaqGy/t3rCOaIAmdtbDinqsBxyoT8B/nLaIvlIyBqleF6
 3faPJIiVgCXZQe1qu/kGWnu40gUBFUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758800766;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m0Z2+aLmAE8rQ6Fz6wdFPdiXOOqisU3qEbdGJgqbI70=;
 b=ezOpaKjLvGun1uU0RfOmkyh1+j6imFueo8NzdqJGImFCIoBBGtcsgzqeSDsRZbtVUfpM/D
 fOH9ni7shUgkxMBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758800766;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m0Z2+aLmAE8rQ6Fz6wdFPdiXOOqisU3qEbdGJgqbI70=;
 b=HyHkA3Xn8spvZUfSg6tLuz1OU/CsjKUo5s/8yYE7dWIneoM3m80t9YQUAD3I8CSf7igvt2
 n6ryibkaYeQmFwHBS1/VYe8ngzaqGy/t3rCOaIAmdtbDinqsBxyoT8B/nLaIvlIyBqleF6
 3faPJIiVgCXZQe1qu/kGWnu40gUBFUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758800766;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m0Z2+aLmAE8rQ6Fz6wdFPdiXOOqisU3qEbdGJgqbI70=;
 b=ezOpaKjLvGun1uU0RfOmkyh1+j6imFueo8NzdqJGImFCIoBBGtcsgzqeSDsRZbtVUfpM/D
 fOH9ni7shUgkxMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07C1B13869;
 Thu, 25 Sep 2025 11:46:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9OgHOH0r1WhzCwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 25 Sep 2025 11:46:05 +0000
Date: Thu, 25 Sep 2025 13:45:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20250925114555.GA112008@pevik>
References: <CAEemH2f8EjTe-uX1zm5h6L1kUFcxy72Br7bvBe5btr7i6PB1BQ@mail.gmail.com>
 <20250925081912.14822-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250925081912.14822-1-akumar@suse.de>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] Introduce ioctl_pidfd_get_info_supported()
 function
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

Hi Avinesh,

...
> +static inline int ioctl_pidfd_get_info_supported(void)

nit: I liked more the previous version v4, where 'bool' was used.
Actually both functions could use 'bool', but I'm perfectly ok with 'int'.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +{
> +	pid_t pid;
> +	int pidfd, ret;
> +	int supported = 0;
> +	struct pidfd_info info;
> +
> +	if (tst_kvercmp(6, 13, 0) >= 0)
> +		return 1;
> +
> +	memset(&info, 0, sizeof(struct pidfd_info));
> +
> +	pid = SAFE_FORK();
> +	if (!pid)
> +		exit(100);
> +
> +	pidfd = SAFE_PIDFD_OPEN(pid, 0);
> +
> +	ret = ioctl(pidfd, PIDFD_GET_INFO, &info);
> +	SAFE_WAITPID(pid, NULL, 0);
> +
> +	if (ret != -1)
> +		supported = 1;
> +
> +	SAFE_CLOSE(pidfd);
> +	return supported;
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
