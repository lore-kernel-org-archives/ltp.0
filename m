Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EE6C52D7B
	for <ltp@archiver.kernel.org>; Thu,  8 Aug 2024 07:44:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEACD3D2057
	for <ltp@archiver.kernel.org>; Thu,  8 Aug 2024 09:44:35 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61D843D1FCE
 for <ltp@lists.linux.it>; Thu,  8 Aug 2024 09:44:21 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CBD59207223
 for <ltp@lists.linux.it>; Thu,  8 Aug 2024 09:44:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 442C721B49;
 Thu,  8 Aug 2024 07:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723103059;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+pSJnGMyEOIVPhMMLhosoDESTTp8q8WHaQ+fOYkKALU=;
 b=XPPNUQxfm4YsjbYzHEfgrsb3Pti6dPu75e44TrZUthEA6ePQXrEYOsSbdx52aE/LUtQGy0
 InoJ552PWeeWGxBST5BOXKUU7GVgAdAD/uYhb1+/VfvOxvTxyh77cmlcq/3DWZ3eAq16J6
 Zg4euXbFIyjRO+uYJ6Pdft5KSlNJPXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723103059;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+pSJnGMyEOIVPhMMLhosoDESTTp8q8WHaQ+fOYkKALU=;
 b=Ei/HFJozscC+kylYqH1zOnpCquUZcFGbdmGlj6KtRkw6ijiGCG0kAqsurLLZv0R3nlJsRp
 obXDWLPwlh6dQqDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XPPNUQxf;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Ei/HFJoz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723103059;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+pSJnGMyEOIVPhMMLhosoDESTTp8q8WHaQ+fOYkKALU=;
 b=XPPNUQxfm4YsjbYzHEfgrsb3Pti6dPu75e44TrZUthEA6ePQXrEYOsSbdx52aE/LUtQGy0
 InoJ552PWeeWGxBST5BOXKUU7GVgAdAD/uYhb1+/VfvOxvTxyh77cmlcq/3DWZ3eAq16J6
 Zg4euXbFIyjRO+uYJ6Pdft5KSlNJPXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723103059;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+pSJnGMyEOIVPhMMLhosoDESTTp8q8WHaQ+fOYkKALU=;
 b=Ei/HFJozscC+kylYqH1zOnpCquUZcFGbdmGlj6KtRkw6ijiGCG0kAqsurLLZv0R3nlJsRp
 obXDWLPwlh6dQqDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC1DD13876;
 Thu,  8 Aug 2024 07:44:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OGx4IFJ3tGZiAgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 08 Aug 2024 07:44:18 +0000
Date: Thu, 8 Aug 2024 09:44:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240808074416.GA306790@pevik>
References: <20240808065732.64328-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240808065732.64328-1-liwang@redhat.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 442C721B49
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pkey01: Adding test for PKEY_DISABLE_EXECUTE
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

Hi Li,

> The pkey_test function now includes a code snippet to test execute
> permissions, ensuring proper handling of execution rights in memory
> protection keys.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

LGTM, thanks!

Few notes + tiny fixes below (which can be done before merge).

...
> +	pkey = pkey_alloc(0, PKEY_DISABLE_EXECUTE);
> +	if (pkey == -1) {
> +		if (errno == EINVAL) {
> +			tst_res(TINFO, "PKEY_DISABLE_EXECUTE hasn't implement.");
nit: maybe "PKEY_DISABLE_EXECUTE not implemented"

> +			execute_supported = 0;
> +		} else {
> +			tst_brk(TBROK | TERRNO, "pkey_alloc failed");
> +		}
> +	}
> +	pkey_free(pkey);
...

>  static void pkey_test(struct tcase *tc, struct mmap_param *mpa)
>  {
>  	pid_t pid;
>  	char *buffer;
>  	int pkey, status;
>  	int fd = mpa->fd;
> +	size_t (*func)();
> +	size_t func_size = -1;
> +
> +	if (!execute_supported && (tc->access_rights == PKEY_DISABLE_EXECUTE))
> +		tst_brk(TCONF, "skip PKEY_DISABLE_EXECUTE test");
NOTE due to possible tst_brk() it'd be good to keep PKEY_DISABLE_EXECUTE as a
last test. Not sure if it's worth to add a comment (or replace with tst_res()
and return).

...
> +	if (mpa->prot == (PROT_READ | PROT_WRITE | PROT_EXEC)) {
> +		func_size = function_size((void (*)(void))function_size);
> +		memcpy(buffer, (void *)function_size, func_size);
> +	}
> +
>  	pkey = pkey_alloc(tc->flags, tc->access_rights);
>  	if (pkey == -1)
>  		tst_brk(TBROK | TERRNO, "pkey_alloc failed");
> @@ -169,6 +203,10 @@ static void pkey_test(struct tcase *tc, struct mmap_param *mpa)
>  			tst_res(TFAIL | TERRNO,
>  				"Write buffer success, buffer[0] = %d", *buffer);
>  		break;
> +		case PKEY_DISABLE_EXECUTE:
> +			func = (size_t (*)())buffer;;
nit: double ; (please remove the last one).
> +			tst_res(TFAIL | TERRNO, "Excute buffer result = %lu", func(func));
s/%lu/%zi/ (otherwise it introduces warnings on 32bit)
nit: s/Excute/Execute/

> +		break;
>  		}
>  		exit(0);
>  	}
> @@ -193,10 +231,16 @@ static void pkey_test(struct tcase *tc, struct mmap_param *mpa)
>  		tst_res(TPASS, "Write buffer success, buffer[0] = %d", *buffer);
>  	break;
>  	case PROT_READ | PROT_WRITE:
> -	case PROT_READ | PROT_WRITE | PROT_EXEC:
>  		*buffer = 'a';
>  		tst_res(TPASS, "Read & Write buffer success, buffer[0] = %d", *buffer);
>  	break;
> +	case PROT_READ | PROT_WRITE | PROT_EXEC:
> +		func = (size_t (*)())buffer;;
> +		if (func_size == func(func))
> +			tst_res(TPASS, "Execute buffer success, result = %lu", func_size);
s/%lu/%zi/
> +		else
> +			tst_res(TFAIL, "Execute buffer with unexpected result: %lu", func(func));
s/%lu/%zi/

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
