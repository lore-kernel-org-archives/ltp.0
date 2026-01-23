Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5512D72350
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 09:46:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 691F53CB4CF
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 10:46:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD1723C048F
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 10:45:48 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 86DAF1400BD3
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 10:45:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4F9B65BCC7;
 Fri, 23 Jan 2026 09:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769161544;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JBznG3ivyUy2bbrTLRHDI6TRsW7oeh6zwlfVrTjhI8M=;
 b=FDiqReS0VIzCWBn/NbVUR+4QrGEs46sOcXf8kNnVCCXdmoSTYwg0hkrf+CXBRVWWWPnBoG
 OGO86+PLi+aVNJ2zWJJ46Q/UM8e9ELYjs6PpIu+kNvjn6xU1PtYzAyx7AiDD13WVlWKu8L
 NzUVA9YUDLi2+5UpeL51uLa3C8vYjc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769161544;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JBznG3ivyUy2bbrTLRHDI6TRsW7oeh6zwlfVrTjhI8M=;
 b=75dVPLRKIgTrE2u8gij8Yx4JcLIdXlH1jnkNIHbJ+09ESNe8KaoI8cwgmna2eAZiwYTZig
 bdqKG9d4xRWO+YBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769161544;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JBznG3ivyUy2bbrTLRHDI6TRsW7oeh6zwlfVrTjhI8M=;
 b=FDiqReS0VIzCWBn/NbVUR+4QrGEs46sOcXf8kNnVCCXdmoSTYwg0hkrf+CXBRVWWWPnBoG
 OGO86+PLi+aVNJ2zWJJ46Q/UM8e9ELYjs6PpIu+kNvjn6xU1PtYzAyx7AiDD13WVlWKu8L
 NzUVA9YUDLi2+5UpeL51uLa3C8vYjc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769161544;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JBznG3ivyUy2bbrTLRHDI6TRsW7oeh6zwlfVrTjhI8M=;
 b=75dVPLRKIgTrE2u8gij8Yx4JcLIdXlH1jnkNIHbJ+09ESNe8KaoI8cwgmna2eAZiwYTZig
 bdqKG9d4xRWO+YBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 238E3136AA;
 Fri, 23 Jan 2026 09:45:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8pu0B0hDc2kADAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 23 Jan 2026 09:45:44 +0000
Date: Fri, 23 Jan 2026 10:45:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260123094538.GA113458@pevik>
References: <20260123054056.131992-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260123054056.131992-1-liwang@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] userfaultfd05: handle kernels rejecting WP
 feature in UFFDIO_API
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
Cc: Ricardo Branco <rbranco@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, Ricardo,

> Commit 485a4cd2ba3 ("userfaultfd05: allow TCONF when UFFD-WP is unsupported")
> added a TCONF path for missing UFFD-WP, but it relied on checking
> uffdio_api.features after a failed ioctl (on RHEL-10).

> That is not sufficient: it did not handle the case where UFFDIO_API
> succeeds but the kernel does not advertise UFFD_FEATURE_PAGEFAULT_FLAG_WP
> in the returned features mask.

> So userfaultfd05 still fails on RHEL-9 s390x platform:

>     userfaultfd05.c:106: TBROK: ioctl(3,((((2U|1U) << (((0+8)+8)+14)) |
> 		    (((0xAA)) << (0+8)) | ((((0x00))) << 0) |
> 		    ((((sizeof(struct uffdio_register)))) << ((0+8)+8)))),...)
> 		    failed: EINVAL (22)

> Now, let's handle both behaviours by retrying UFFDIO_API with features=0
> on EINVAL and treating a successful retry as "WP unsupported" (TCONF).
> Also check the returned features mask after a successful UFFDIO_API and
> skip when WP is not advertised.

...
>  	if (ioctl(uffd, UFFDIO_API, &uffdio_api) < 0) {
> -		if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP))
> -			tst_brk(TCONF, "UFFD write-protect unsupported");
> +		int err = errno;
> +		if (err == EINVAL) {
> +			uffdio_api.api = UFFD_API;
> +			uffdio_api.features = 0;
> +
> +			if (ioctl(uffd, UFFDIO_API, &uffdio_api) == 0)
> +				tst_brk(TCONF, "UFFD write-protect unsupported");
> +		}

Wouldn't be better in this case to check kconfig for
CONFIG_HAVE_ARCH_USERFAULTFD_WP (untested, but it should work

Back to our discussion about how often using kconfig [1]. While I prefer to
avoid using it for tristate (kernel might be configured but module missing), but
here is just a feature.

[1] https://lore.kernel.org/ltp/CAASaF6wOSvi+07Pq5O6+f1Hkrq6WWMgpCaooJxWrO9uOvRM3pw@mail.gmail.com/

But I'm ok with it if you prefer exact check.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> -		tst_brk(TBROK | TERRNO, "ioctl() on userfaultfd failed");
> +		errno = err;
> +		tst_brk(TBROK | TERRNO, "ioctl(UFFDIO_API) failed");
+1
>  	}

Kind regards,
Petr

> +	if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP))
> +		tst_brk(TCONF, "UFFD write-protect unsupported");
> +
>  	uffdio_register.range.start = (unsigned long) page;
>  	uffdio_register.range.len = page_size;
>  	uffdio_register.mode = UFFDIO_REGISTER_MODE_WP;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
