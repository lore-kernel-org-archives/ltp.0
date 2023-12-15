Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DCBC4167B
	for <ltp@archiver.kernel.org>; Fri, 15 Dec 2023 19:48:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB7563CF44E
	for <ltp@archiver.kernel.org>; Fri, 15 Dec 2023 20:48:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D68F3CB32D
 for <ltp@lists.linux.it>; Fri, 15 Dec 2023 20:47:56 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8DE241400E4A
 for <ltp@lists.linux.it>; Fri, 15 Dec 2023 20:47:55 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 09BFE1F84C;
 Fri, 15 Dec 2023 19:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702669674;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lKYy9cMtcb91PYFXu0bvvf6X5ZeB8JCX6ZeM7BpI5Kc=;
 b=DXfzkKTtP2rLJOQfFplJIvVn+Y10boyDEJvaApjHO18O24TDZushbmyZQqi7Pe0QLK4/to
 H4ZFZir7sNehZDB3eiB5SwK0s/KxZ9uRmdoLgOzmgcNVcYsiEJDfdRjC1xALECOyw956f6
 S9yxX1e0DF67tCg+mQdFKrWFgz4eUZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702669674;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lKYy9cMtcb91PYFXu0bvvf6X5ZeB8JCX6ZeM7BpI5Kc=;
 b=Afwnxa1BWb1tWtHYUVFp0wI6EAUhvczZjKfO+wGvTrDMl2O5sztgCRMM4xvZ0tJi95aEiU
 UOzDNv29uyXhlCBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702669674;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lKYy9cMtcb91PYFXu0bvvf6X5ZeB8JCX6ZeM7BpI5Kc=;
 b=DXfzkKTtP2rLJOQfFplJIvVn+Y10boyDEJvaApjHO18O24TDZushbmyZQqi7Pe0QLK4/to
 H4ZFZir7sNehZDB3eiB5SwK0s/KxZ9uRmdoLgOzmgcNVcYsiEJDfdRjC1xALECOyw956f6
 S9yxX1e0DF67tCg+mQdFKrWFgz4eUZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702669674;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lKYy9cMtcb91PYFXu0bvvf6X5ZeB8JCX6ZeM7BpI5Kc=;
 b=Afwnxa1BWb1tWtHYUVFp0wI6EAUhvczZjKfO+wGvTrDMl2O5sztgCRMM4xvZ0tJi95aEiU
 UOzDNv29uyXhlCBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DE3C213A08;
 Fri, 15 Dec 2023 19:47:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id us75M2mtfGUbQQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 15 Dec 2023 19:47:53 +0000
Date: Fri, 15 Dec 2023 20:47:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20231215194751.GB67360@pevik>
References: <20231206105318.11832-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231206105318.11832-1-wegao@suse.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DXfzkKTt;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Afwnxa1B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_SHORT(-0.20)[-0.992];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 09BFE1F84C
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] getcwd01: Implement .test_variants
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

Hi Wei,

>  /*
>   * DESCRIPTION
> - * Testcase to test that getcwd(2) sets errno correctly.
> - * 1) getcwd(2) fails if buf points to a bad address.
> - * 2) getcwd(2) fails if the size is invalid.
> - * 3) getcwd(2) fails if the size is set to 0.
> - * 4) getcwd(2) fails if the size is set to 1.
> - * 5) getcwd(2) fails if buf points to NULL and the size is set to 1.
> - *
> - * Expected Result:
> - * 1) getcwd(2) should return NULL and set errno to EFAULT.
> - * 2) getcwd(2) should return NULL and set errno to EFAULT.
> - * 3) getcwd(2) should return NULL and set errno to ERANGE.
> - * 4) getcwd(2) should return NULL and set errno to ERANGE.
> - * 5) getcwd(2) should return NULL and set errno to ERANGE.
> + * Testcase to test that getcwd() sets errno correctly.

We prefer to keep info about tested errno (you can write errno or errnos if they
are different for syscall into it).

* 1) getcwd(2) fails if buf points to a bad address (EFAULT)
* 2) getcwd(2) fails if the size is invalid (ERANGE)

>  #include <errno.h>
> @@ -27,28 +16,68 @@
>  #include "lapi/syscalls.h"

>  static char buffer[5];
> -
> -static struct t_case {
> +struct getcwd_variants {
> +	void (*getcwd)(char *buf, size_t size, int exp_err);
>  	char *buf;
>  	size_t size;
>  	int exp_err;
> -} tcases[] = {
> -	{(void *)-1, PATH_MAX, EFAULT},
> -	{NULL, (size_t)-1, EFAULT},
> -	{buffer, 0, ERANGE},
> -	{buffer, 1, ERANGE},
> -	{NULL, 1, ERANGE}
>  };

> +static void verify_getcwd_raw_syscall(char *buf, size_t size, int exp_err);
> +static void verify_getcwd(char *buf, size_t size, int exp_err);
> +
> +static struct getcwd_variants variants[] = {
> +#ifdef __GLIBC__
> +	{ .getcwd = verify_getcwd, .buf = NULL, .size = (size_t)-1, .exp_err = ENOMEM},
> +	{ .getcwd = verify_getcwd, .buf = NULL, .size = 1, .exp_err = ERANGE},
> +#endif
> +	{ .getcwd = verify_getcwd, .buf = (void *)-1, .size = PATH_MAX, .exp_err = EFAULT},
> +	{ .getcwd = verify_getcwd, .buf = buffer, .size = 0, .exp_err = EINVAL},
> +	{ .getcwd = verify_getcwd, .buf = buffer, .size = 1, .exp_err = ERANGE},
> +	{ .getcwd = verify_getcwd_raw_syscall, .buf = buffer, .size = 0, .exp_err = ERANGE},
> +	{ .getcwd = verify_getcwd_raw_syscall, .buf = (void *)-1, .size = PATH_MAX, .exp_err = EFAULT},
> +	{ .getcwd = verify_getcwd_raw_syscall, .buf = NULL, .size = (size_t)-1, .exp_err = EFAULT},
> +	{ .getcwd = verify_getcwd_raw_syscall, .buf = buffer, .size = 0, .exp_err = ERANGE},
> +	{ .getcwd = verify_getcwd_raw_syscall, .buf = buffer, .size = 1, .exp_err = ERANGE},
> +	{ .getcwd = verify_getcwd_raw_syscall, .buf = NULL, .size = 1, .exp_err = ERANGE},

Well, this is works, but we don't use test variants this way. We define
.test_variants in struct tst_test. Please have look how getdents01.c for
example.

Why it's important (besides consistency of how we write tests)? We parse
test_variants in our documentation.
https://github.com/linux-test-project/ltp/releases/download/20230929/metadata.20230929.html
=> see metadata.html#test_variants in your locally downloaded file, or run:
cd metadata && make && chromium ../docparse/*.html

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
