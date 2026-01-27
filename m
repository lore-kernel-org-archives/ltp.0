Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C60CD2F011
	for <ltp@archiver.kernel.org>; Tue, 27 Jan 2026 13:18:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A072C3CB27E
	for <ltp@archiver.kernel.org>; Tue, 27 Jan 2026 14:18:21 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D9703CAC7E
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 14:18:01 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7C9A21400DD5
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 14:18:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B661C5BCC2;
 Tue, 27 Jan 2026 13:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769519880;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F7CfnF2kx0qMIIPnj5Jo/t+HYTn/GkMopLuRmOO+Hi0=;
 b=fKRZetWfMZbqeVsYgRCfG2lF88zv2A8Gb7PtBYhZGVY9dmnqqhXi6FyhMsXKzVArEzZMbS
 QuqhOHmYt/l+6g2ZOy4NLwHiZPQAvsPGciPJ3hx5smQ6BDOmm1Dnm0/sQR3fM+B4iSjQx8
 Y1exqAWPcFo5n1iHeuxh9VLsJTsAZ48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769519880;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F7CfnF2kx0qMIIPnj5Jo/t+HYTn/GkMopLuRmOO+Hi0=;
 b=ziIfFb0fKF5nSyZFk3tEpsP/4CcUozxdaY0p0FP3wxlvDuV4M0eAbXmpWr65Pu2EQM36Ip
 CVtZWYaQBAUIPbCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769519880;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F7CfnF2kx0qMIIPnj5Jo/t+HYTn/GkMopLuRmOO+Hi0=;
 b=fKRZetWfMZbqeVsYgRCfG2lF88zv2A8Gb7PtBYhZGVY9dmnqqhXi6FyhMsXKzVArEzZMbS
 QuqhOHmYt/l+6g2ZOy4NLwHiZPQAvsPGciPJ3hx5smQ6BDOmm1Dnm0/sQR3fM+B4iSjQx8
 Y1exqAWPcFo5n1iHeuxh9VLsJTsAZ48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769519880;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F7CfnF2kx0qMIIPnj5Jo/t+HYTn/GkMopLuRmOO+Hi0=;
 b=ziIfFb0fKF5nSyZFk3tEpsP/4CcUozxdaY0p0FP3wxlvDuV4M0eAbXmpWr65Pu2EQM36Ip
 CVtZWYaQBAUIPbCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90D9F3EA61;
 Tue, 27 Jan 2026 13:18:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PYBkIgi7eGmqfwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 27 Jan 2026 13:18:00 +0000
Date: Tue, 27 Jan 2026 14:17:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20260127131755.GA146899@pevik>
References: <20260121083343.127613-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260121083343.127613-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ima_setup.sh: Fix check of signed policy
 requirement
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Mimi, all,

> Kernel code in arch_get_ima_policy() depends also on
> CONFIG_IMA_ARCH_POLICY added in v5.0:
> d958083a8f640 ("x86/ima: define arch_get_ima_policy() for x86")

> Fixes: c38b528783 ("ima_{conditionals, policy}: Handle policy required to be signed")
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi Mimi, all,

> FYI I'd like to merge it this week to get it into LTP release.

> Kind regards,
> Petr

I dared to merge this to get it into upcoming LTP release (this/next week).

Kind regards,
Petr

>  testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> index 1bce78d425..df0b8d1532 100644
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -466,10 +466,11 @@ require_evmctl()
>  }

>  # 56dc986a6b20b ("ima: require signed IMA policy when UEFI secure boot is enabled") # v6.5-rc4
> +# d958083a8f640 ("x86/ima: define arch_get_ima_policy() for x86") # v5.0
>  check_need_signed_policy()
>  {
>  	tst_secureboot_enabled && tst_kvcmp -ge '6.5' && tst_require_kconfigs \
> -		'CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY'
> +		'CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY,CONFIG_IMA_ARCH_POLICY'
>  }

>  # loop device is needed to use only for tmpfs

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
