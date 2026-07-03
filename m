Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975F1C43458
	for <ltp@archiver.kernel.org>; Fri,  3 Jul 2026 13:19:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1426F3E72D4
	for <ltp@archiver.kernel.org>; Fri,  3 Jul 2026 15:19:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F64F3E5F1B
 for <ltp@lists.linux.it>; Fri,  3 Jul 2026 15:19:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B5F14600070
 for <ltp@lists.linux.it>; Fri,  3 Jul 2026 15:19:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED1597490D;
 Fri,  3 Jul 2026 13:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783084753;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GIN+0QA0468eflGw9QYFT2daRNNz542gU9x3JlXTgx8=;
 b=RcuuvmgPEvtP2WytgaRy+MBryxWq3GqnSwPCdi47iAiHCr6pUJN7X1UtbJXIrO6fzXj9dN
 w13ad/gykPz7hUWskO3t6cRC7zEJa1jdQ2j0kucZQl8i+sTElYi4TzVbJTdH+nGeVNa09y
 CwaHYJciEjNSNBOZ0Ix5F8f+uagK8F8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783084753;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GIN+0QA0468eflGw9QYFT2daRNNz542gU9x3JlXTgx8=;
 b=/btOqXhi0sFzO7OX8eKgtmMPLv9/W3CA8wO5pfPh55GW+Mb9WN7Tv24nIZXmJZwDztOOUk
 Sguvhle4+bUQyUBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783084752;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GIN+0QA0468eflGw9QYFT2daRNNz542gU9x3JlXTgx8=;
 b=V/G6BF7d72z8QTW7QDOKjyDvUqSuRCFmFZf0hLj+CNFH+8elJ/MxEtIvk2ScxL7wWlaAsp
 h6md/Bt2XUDjvParFVJm9eW+YXqXtCkb+17oj8FthaR2OTPo9GfMxFC9kXjHzt7LYWvpOc
 mnA3Y64EYqjxgQifHXaZp2DWPG7AEuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783084752;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GIN+0QA0468eflGw9QYFT2daRNNz542gU9x3JlXTgx8=;
 b=hObmKBr9n+dxM2SQMQlZMdCQ1dGmxSXd2Nt+YWfuNeerPxEo2sag7RtPuaoCtKVWRDjuQs
 2EWIJxaucq5/l8Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6C2C779AA;
 Fri,  3 Jul 2026 13:19:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id scYXKdC2R2rwVQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 03 Jul 2026 13:19:12 +0000
Date: Fri, 3 Jul 2026 15:19:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Michael Menasherov <mmenashe@redhat.com>
Message-ID: <20260703131911.GA407003@pevik>
References: <20260621150951.66407-1-mmenashe@redhat.com>
 <20260621150951.66407-3-mmenashe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260621150951.66407-3-mmenashe@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v16 2/2] futex_cmp_requeue03: Add EFAULT error
 coverage test
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

Hi Michael,

...
> +static struct testcase {
> +	const char *desc;
> +	futex_t **uaddr;
> +	futex_t **uaddr2;
> +	int exp_errno;
> +} testcases[] = {
> +	{
> +		.desc = "uaddr unmapped",
> +		.uaddr = &unmapped_addr,
> +		.uaddr2 = &futex_ptr,
> +		.exp_errno = EFAULT,
> +	},
> +	{
> +		.desc = "uaddr2 unmapped",
> +		.uaddr = &futex_ptr,
> +		.uaddr2 = &unmapped_addr,
> +		.exp_errno = EFAULT,
> +	},
> +	{
> +		.desc = "uaddr PROT_NONE",
> +		.uaddr = &prot_none_addr,
> +		.uaddr2 = &futex_ptr,
> +		.exp_errno = EFAULT,
> +	},
> +	{
> +		.desc = "uaddr2 PROT_NONE",
> +		.uaddr = &futex_ptr,
> +		.uaddr2 = &prot_none_addr,
> +		.exp_errno = EFAULT,
> +	},
> +};
nit: also here I'd use EFAULT directly in TST_EXP_FAIL(), but that's a minor
detail.

The rest LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
