Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D693C433EF
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 12:59:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D44693CA097
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 13:59:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A3A8F3CA0B7
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 13:59:33 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DC1911001348
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 13:59:32 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 31EED21891;
 Wed, 16 Feb 2022 12:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645016372;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zz2o6r3wYezqCZBmEJeZnxB6BqkZz7gl4rYPaaHuSBc=;
 b=abBFNaoZApSTYV+ea0X7t8WQQ2UE9lsgxYJ+8Gcj5VTcWqbCL7lMWSn4ansobTE8E1aw/3
 Bb1F5GvXNDSokYFLOi0Q+5TVfuBZgA22gVfdyvJ/++K1ldvMpaLB75xYQg5/k6RfkqqOnt
 kGgzElW3QiJSD9Uc0EHggUvMNSZHbxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645016372;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zz2o6r3wYezqCZBmEJeZnxB6BqkZz7gl4rYPaaHuSBc=;
 b=/ll3M6LdmsbaxebcLTGmY990TFVOZT9jlYFiZOyZemS3j72fsJa6rLTuVZfn6xozfOnR4M
 8LCvcQ9D11mvy5Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E07313B0A;
 Wed, 16 Feb 2022 12:59:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0fHYATT1DGJ9XwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 16 Feb 2022 12:59:32 +0000
Date: Wed, 16 Feb 2022 13:59:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Ygz1MSFe89HE5Ybx@pevik>
References: <20220216111013.32056-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220216111013.32056-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewrite confstr01.c test using new LTP API
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

Hi Andrea,

thanks for looking into this.

I was looking into the test in the past. The reason I haven't sent it is that
some of the definitions are in the legacy definition:
https://pubs.opengroup.org/onlinepubs/000095399/functions/confstr.html

in newer it's not:
https://pubs.opengroup.org/onlinepubs/9699919799/functions/confstr.html

...
>  static struct test_case_t {
>  	int value;
>  	char *name;
>  } test_cases[] = {
> -	{_CS_PATH, "PATH"},
> -	{_CS_XBS5_ILP32_OFF32_CFLAGS, "XBS5_ILP32_OFF32_CFLAGS"},
> -	{_CS_XBS5_ILP32_OFF32_LDFLAGS, "XBS5_ILP32_OFF32_LDFLAGS"},
> -	{_CS_XBS5_ILP32_OFF32_LIBS, "XBS5_ILP32_OFF32_LIBS"},
> -	{_CS_XBS5_ILP32_OFF32_LINTFLAGS, "XBS5_ILP32_OFF32_LINTFLAGS"},
> -	{_CS_XBS5_ILP32_OFFBIG_CFLAGS, "XBS5_ILP32_OFFBIG_CFLAGS"},
> -	{_CS_XBS5_ILP32_OFFBIG_LDFLAGS, "XBS5_ILP32_OFFBIG_LDFLAGS"},
> -	{_CS_XBS5_ILP32_OFFBIG_LIBS, "XBS5_ILP32_OFFBIG_LIBS"},
> -	{_CS_XBS5_ILP32_OFFBIG_LINTFLAGS, "XBS5_ILP32_OFFBIG_LINTFLAGS"},
> -	{_CS_XBS5_LP64_OFF64_CFLAGS, "XBS5_LP64_OFF64_CFLAGS"},
> -	{_CS_XBS5_LP64_OFF64_LDFLAGS, "XBS5_LP64_OFF64_LDFLAGS"},
> -	{_CS_XBS5_LP64_OFF64_LIBS, "XBS5_LP64_OFF64_LIBS"},
> -	{_CS_XBS5_LP64_OFF64_LINTFLAGS, "XBS5_LP64_OFF64_LINTFLAGS"},
> -	{_CS_XBS5_LPBIG_OFFBIG_CFLAGS, "XBS5_LPBIG_OFFBIG_CFLAGS"},
> -	{_CS_XBS5_LPBIG_OFFBIG_LDFLAGS, "XBS5_LPBIG_OFFBIG_LDFLAGS"},
> -	{_CS_XBS5_LPBIG_OFFBIG_LIBS, "XBS5_LPBIG_OFFBIG_LIBS"},
> -	{_CS_XBS5_LPBIG_OFFBIG_LINTFLAGS, "XBS5_LPBIG_OFFBIG_LINTFLAGS"},
> -	{_CS_GNU_LIBC_VERSION, "GNU_LIBC_VERSION"},
> -	{_CS_GNU_LIBPTHREAD_VERSION, "GNU_LIBPTHREAD_VERSION"},
> +	{ _CS_PATH, "PATH" },
> +	{ _CS_GNU_LIBC_VERSION, "GNU_LIBC_VERSION" },
man CONFSTR(3) shows
 _CS_GNU_LIBC_VERSION (GNU C library only; since glibc 2.3.2)

And indeed it fails on musl:
confstr01.c:102: TFAIL: confstr: GNU_LIBC_VERSION, EINVAL

But musl defines in include/unistd.h:
#define _CS_GNU_LIBC_VERSION    2

to allow to compile but in src/conf/confstr.c is check which causes EINVAL:

https://git.etalabs.net/cgit/musl/tree/src/conf/confstr.c
size_t confstr(int name, char *buf, size_t len)
{
	const char *s = "";
	if (!name) {
		s = "/bin:/usr/bin";
	} else if ((name&~4U)!=1 && name-_CS_POSIX_V6_ILP32_OFF32_CFLAGS>33U) {
		errno = EINVAL;
		return 0;
	}
	// snprintf is overkill but avoid wasting code size to implement
	// this completely useless function and its truncation semantics
	return snprintf(buf, len, "%s", s) + 1;
}

IMHO this one should be wrapped with #ifdef __GLIBC__.
Also not sure how about uclibc (it defines __GLIBC__ and it has compatible
headers, but sometimes things aren't implemented). It defines
_CS_GNU_LIBC_VERSION as "GNU_LIBC_VERSION", but code which is in posix/confstr.c
is missing. I might force myself to check it after work time.

...

> +	TEST(confstr(test_cases[i].value, NULL, (size_t)0));

> +	if (TST_RET) {
> +		len = TST_RET;
> +		buf = SAFE_MALLOC(len);

> +		TEST(confstr(test_cases[i].value, buf, len));

> +		if (buf[len - 1] != '\0') {
> +			tst_brk(TFAIL, "confstr: %s, %s", test_cases[i].name,
> +				tst_strerrno(TST_ERR));
> +		} else {
> +			tst_res(TPASS, "confstr %s = '%s'", test_cases[i].name, buf);
>  		}
> +	} else {
> +		tst_brk(TFAIL, "confstr: %s, %s", test_cases[i].name, tst_strerrno(TST_ERR));
> +	}

Again, to use some TST_EXP_*() macros?
Maybe:

	TST_EXP_POSITIVE(confstr(test_cases[i].value, NULL, (size_t)0));

	if (!TST_PASS)
		return;

	len = TST_RET;
	buf = SAFE_MALLOC(len);

	TEST(confstr(test_cases[i].value, buf, len));

	if (buf[len - 1] != '\0') {
		tst_brk(TFAIL, "confstr: %s, %s", test_cases[i].name,
			tst_strerrno(TST_ERR));
	} else {
		tst_res(TPASS, "confstr %s = '%s'", test_cases[i].name, buf);
	}

	free(buf);

=> code is simpler and works also on musl.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
