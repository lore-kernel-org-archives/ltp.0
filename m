Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B49C27C4F
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 12:01:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 025763D0EA6
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 14:01:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D699A3CE02D
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 14:00:56 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C04A1200DD5
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 14:00:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BF3AE21AF8;
 Fri, 21 Jun 2024 12:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718971254;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0QWqHR++TohAWcHMvcJ/87g5qN5NUGKzNiEQOBfBG6c=;
 b=h3O2zSx7NpnHHqQ9bOncucv2IULmAmgl8IcL69gIIuLpary4qcClASkWzibvZx+BBhCPU2
 htzaXK0ouJw6WMbAflQz/xxb0dFuYWu0QaBX221uaHgOSFgDYWKk+iqQf5zYEDqAl+sbo8
 Zgf9ApV77nfsbrbVlR2w9ihDLsyL1+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718971254;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0QWqHR++TohAWcHMvcJ/87g5qN5NUGKzNiEQOBfBG6c=;
 b=QL5Bj30XcEHQ35EtBkVied1sCfidgkCs3icyMN4dKlI9oXFtaXeGPVczhf+k88zpHY9TAa
 XLRXcpHCo0N8ojAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718971254;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0QWqHR++TohAWcHMvcJ/87g5qN5NUGKzNiEQOBfBG6c=;
 b=h3O2zSx7NpnHHqQ9bOncucv2IULmAmgl8IcL69gIIuLpary4qcClASkWzibvZx+BBhCPU2
 htzaXK0ouJw6WMbAflQz/xxb0dFuYWu0QaBX221uaHgOSFgDYWKk+iqQf5zYEDqAl+sbo8
 Zgf9ApV77nfsbrbVlR2w9ihDLsyL1+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718971254;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0QWqHR++TohAWcHMvcJ/87g5qN5NUGKzNiEQOBfBG6c=;
 b=QL5Bj30XcEHQ35EtBkVied1sCfidgkCs3icyMN4dKlI9oXFtaXeGPVczhf+k88zpHY9TAa
 XLRXcpHCo0N8ojAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AD3D13AAA;
 Fri, 21 Jun 2024 12:00:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XyDpJHZrdWYxdQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jun 2024 12:00:54 +0000
Date: Fri, 21 Jun 2024 14:00:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: lufei <lufei@uniontech.com>
Message-ID: <20240621120053.GA683401@pevik>
References: <20240606065506.1686-1-lufei@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240606065506.1686-1-lufei@uniontech.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] acct01: add EFAULT errno check
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

Hi Lu,

> 1. add EFAULT errno check.
> 2. fix make check errors and warnings.

Changes LGTM, but could you please separate these changes into it's own commit?

FYI it's a good habit to separate changes (easier to review, it would not be
clear what is EFAULT related change). We sometimes just mix these changes, but
here both changes are quite big + you even touch a different test.

> ---
...
>  testcases/kernel/syscalls/acct/acct01.c | 31 +++++++++++++++++--------
> -	TEST(acct(NULL));
> -	if (TST_RET == -1 && TST_ERR == ENOSYS)
> -		tst_brk(TCONF, "acct() system call isn't configured in kernel");
Good point. This was added in 2013 ba3bf0e34 ("acct01: add a check routine for
acct implementation") and was valid until you added now:

> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_BSD_PROCESS_ACCT=y",
> +	},

@Cyril: would you replace ENOSYS with CONFIG_BSD_PROCESS_ACCT=y ?
I would try to avoid using .needs_kconfigs when ENOSYS can be checked.

Kind regards,
Petr

>  };
> diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
> index d3f3d9d04..74019f430 100644
> --- a/testcases/kernel/syscalls/acct/acct02.c
> +++ b/testcases/kernel/syscalls/acct/acct02.c
> @@ -186,7 +186,7 @@ static void run(void)

>  		if (read_bytes != acct_size) {
>  			tst_res(TFAIL, "incomplete read %i bytes, expected %i",
> -			        read_bytes, acct_size);
> +					read_bytes, acct_size);
>  			goto exit;
>  		}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
