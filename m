Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57861CA100F
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 21:07:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC3C33CDE74
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 23:07:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4086E3C6EF3
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 23:07:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7E90C200091
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 23:07:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C2B2F1F7F7;
 Mon, 22 Sep 2025 21:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758575244;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IJ+DzzZ69mkOKrQWdJ87jjwMbJsxQzGTh4qIgHpLhBM=;
 b=t4Ug3G5LSte2YJdmZnVZR9/AaFoTFTpwL3yV/I1FTdbMrfIayisDTZN5ZHBj9mnNyMz07p
 u29GiiIt/xcjMhMlcoxOe/pw9mWjGbLUKasUyQIWptdXd09gx7wviEQEccIesBOFl8zIeF
 cPo4p5zqhSDRwdMfiCNBTckzu+PCWyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758575244;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IJ+DzzZ69mkOKrQWdJ87jjwMbJsxQzGTh4qIgHpLhBM=;
 b=eghsVoIN2C3qd2sr5DshRTLfYL5WLls+dJcxpuzcDCFTwo2CwVholGxe4SgSaAyAfYNtdI
 k3Ix7m5ddteRPeAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758575244;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IJ+DzzZ69mkOKrQWdJ87jjwMbJsxQzGTh4qIgHpLhBM=;
 b=t4Ug3G5LSte2YJdmZnVZR9/AaFoTFTpwL3yV/I1FTdbMrfIayisDTZN5ZHBj9mnNyMz07p
 u29GiiIt/xcjMhMlcoxOe/pw9mWjGbLUKasUyQIWptdXd09gx7wviEQEccIesBOFl8zIeF
 cPo4p5zqhSDRwdMfiCNBTckzu+PCWyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758575244;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IJ+DzzZ69mkOKrQWdJ87jjwMbJsxQzGTh4qIgHpLhBM=;
 b=eghsVoIN2C3qd2sr5DshRTLfYL5WLls+dJcxpuzcDCFTwo2CwVholGxe4SgSaAyAfYNtdI
 k3Ix7m5ddteRPeAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 892F51388C;
 Mon, 22 Sep 2025 21:07:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PQjJH4y60WjZBwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 22 Sep 2025 21:07:24 +0000
Date: Mon, 22 Sep 2025 23:07:23 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20250922210723.GA44059@pevik>
References: <20250922203927.14552-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250922203927.14552-1-akumar@suse.de>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Introduce ioctl_pidfd_get_info_supported()
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

thanks for fixing this!
...
>  	if (ret == -1) {
> +		if (errno == ENOTTY)
> +			return -1;
> +
> +		if (errno == EINVAL || errno == ESRCH)
> +			return 0;
> +
> +		tst_brk(TBROK | TERRNO, "unexpected ioctl(PIDFD_GET_INFO) error");
>  	}

> -	SAFE_CLOSE(pidfd);
> +	return info.mask;

Because ioctl_pidfd_get_info_supported() returns 3 different states
(-1 (not supported), 0 (supported) and >= 0 (mask) it wouldn't harm to document
return type.

All the more so because ioctl_pidfd_info_exit_supported() uses reversed
conditions for supported (1) / not supported (0).

I understand chosen values, but because names suggest the same functionality doc
would help.

> +}
> +
> +static inline int ioctl_pidfd_info_exit_supported(void)
This could be bool, that's itself a documentation (just 2 possible values, not
more).

Kind regards,
Petr

> +{
> +	long mask;
> +
> +	if (tst_kvercmp(6, 15, 0) >= 0)
> +		return 1;
> +
> +	mask = ioctl_pidfd_get_info_supported();
> +	if (mask == -1)
> +		return 0;

> -	return supported;
> +	return !!(mask & PIDFD_INFO_EXIT);
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
