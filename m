Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EDFC25B75
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 01:43:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54ABA3CF92C
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 03:43:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D2003CF804
 for <ltp@lists.linux.it>; Thu, 16 May 2024 03:43:07 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A2A2A141CE8E
 for <ltp@lists.linux.it>; Thu, 16 May 2024 03:43:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 637B920244;
 Thu, 16 May 2024 01:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715823785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UYzgKQKuRoVATO3d+3v0Lg8ldaR79lFI/44mEq8O0no=;
 b=UBWtgpTTVIVPm+jvyo+WKMrJPj3Z8fdfbD+UaaeKMlmMZlBdrb3+6ScDTS7KVM9qB1uUvW
 YELOJEohfxir9hxRZZOqkptNMOp2mk9sxV/0CSmG7mZUWgT7So/h6h6pwlzeVeqC/xMP0m
 DRNbCMV7+rAZWAHxMmPjMp2mw+0f9fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715823785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UYzgKQKuRoVATO3d+3v0Lg8ldaR79lFI/44mEq8O0no=;
 b=aR+ZiWnD0AcKKT69GsgPFzfcodpBdR+Y6K5j8NiS+byOmximIgTRpSjaUW+exn2rPZ6Be4
 P7laZtSIr/YgI6Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715823785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UYzgKQKuRoVATO3d+3v0Lg8ldaR79lFI/44mEq8O0no=;
 b=UBWtgpTTVIVPm+jvyo+WKMrJPj3Z8fdfbD+UaaeKMlmMZlBdrb3+6ScDTS7KVM9qB1uUvW
 YELOJEohfxir9hxRZZOqkptNMOp2mk9sxV/0CSmG7mZUWgT7So/h6h6pwlzeVeqC/xMP0m
 DRNbCMV7+rAZWAHxMmPjMp2mw+0f9fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715823785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UYzgKQKuRoVATO3d+3v0Lg8ldaR79lFI/44mEq8O0no=;
 b=aR+ZiWnD0AcKKT69GsgPFzfcodpBdR+Y6K5j8NiS+byOmximIgTRpSjaUW+exn2rPZ6Be4
 P7laZtSIr/YgI6Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A79513A5D;
 Thu, 16 May 2024 01:43:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /DrGEKlkRWY7FQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 May 2024 01:43:05 +0000
Date: Thu, 16 May 2024 03:43:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20240516014300.GE260285@pevik>
References: <20240422083528.28355-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240422083528.28355-1-xuyang2018.jy@fujitsu.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getsockname01: Add case for errno EINVAL
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

Hi Xu,

...
> +++ b/testcases/kernel/syscalls/getsockname/getsockname01.c
> @@ -12,6 +12,7 @@
>   * - EBADF on a not open file
>   * - ENOTSOCK on a file descriptor not linked to a socket
>   * - EFAULT on invalid socket buffer o invalid socklen
> + * - EINVALI on an invalid addrlen
>   */

>  #include "tst_test.h"
> @@ -19,6 +20,7 @@
>  static struct sockaddr_in sin0, fsin1;
>  static int sock_null, sock_bind, sock_fake;
>  static socklen_t sinlen;
> +static socklen_t sininval;

Merged with following changes:

static socklen_t sininval = -1;


>  static struct test_case {
>  	int *sock;
> @@ -37,6 +39,8 @@ static struct test_case {
>  		.experrno = EFAULT, "invalid aligned salen"},
>  	{ .sock = &sock_bind, .sockaddr = &fsin1, .addrlen = (socklen_t *) 1,
>  		.experrno = EFAULT, "invalid unaligned salen"},
> +	{ .sock = &sock_bind, .sockaddr = &fsin1, .addrlen = &sininval,
> +		.experrno = EINVAL, "invalid socklen"},
>  };

>  static void check_getsockname(unsigned int nr)
> @@ -57,6 +61,7 @@ static void setup(void)
>  	sock_bind = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
>  	SAFE_BIND(sock_bind, (struct sockaddr *)&sin0, sizeof(sin0));
>  	sinlen = sizeof(sin0);
> +	sininval = -1;

and thus removed it here.

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
