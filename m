Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8BFC433EF
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 11:50:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E400F3CA0A3
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 12:50:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1954F3C9EF6
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 12:50:02 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B875E2005E5
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 12:49:58 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AF9C121763;
 Wed, 16 Feb 2022 11:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645012197;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=coqIEUKIY7as/f5Xn7Dk8+shHRGQPppO1LoBowitkSE=;
 b=B6Iuyl/U5EgQfW2FHfHaXBLUiZYmAv70o14aXjzWXM7ebP8Bi3HTIAtQ1xgVth4oLs3Xxv
 wioHXwc24l3ypQ3TCXC1DEbjqJ86dv9z/oNm7Ai1oKaQlmYKNS9oYtETyu39v6+zfqI3bb
 Byew3Ba9Ss2Opk1OTzA/i5yMFTTlI3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645012197;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=coqIEUKIY7as/f5Xn7Dk8+shHRGQPppO1LoBowitkSE=;
 b=xCCdY2xzIuzypHl8Hsvbx2f9RRBYIn4lO2M63r3SHu2JSNpJhYxWIvgkYYhf0UWGImc3d6
 L8eNMnEusxvvajBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 757B013AF3;
 Wed, 16 Feb 2022 11:49:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 323qGOXkDGLGOQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 16 Feb 2022 11:49:57 +0000
Date: Wed, 16 Feb 2022 12:49:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Ygzk49BrnQVs+6Vc@pevik>
References: <20220216104026.18326-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220216104026.18326-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewrite getcontext01.c test using new LTP API
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

> Removed old LTP API from getcontext01.c test and check if getcontext is
> present in the current system. The check is useful in those systems
> where libmusl is used by default.
nit: "libmusl": it's musl libc or just musl (https://musl.libc.org/about.html).
I got really confused you mean some other library on the top of musl
(e.g. there is musl-fts implementation https://github.com/void-linux/musl-fts
because musl refuses to implement fts.h).

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
> ---
>  configure.ac                                  |  1 +
>  .../kernel/syscalls/getcontext/getcontext01.c | 93 +++++--------------
>  2 files changed, 24 insertions(+), 70 deletions(-)

> diff --git a/configure.ac b/configure.ac
> index 8d2c5b1c4..41a21a636 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -97,6 +97,7 @@ AC_CHECK_FUNCS_ONCE([ \
>      fspick \
>      fstatat \
>      getauxval \
> +    getcontext \
I was surprised that getcontext is still not in musl (but it's in ucontext.h header),
but it's deliberate:
https://wiki.musl-libc.org/open-issues.html#ucontext.h

Also not sure if it's in bionic
(https://android.googlesource.com/platform/bionic).

Thus ack using autotools (I'm trying to remove old unneeded check to speedup
configure runtime).

It might be worth to add .test_variants to test raw syscall,
but that'd be another effort (no need to bother with it now).

>  	TEST(getcontext(&ptr));
...

> +	if (TST_RET < 0)
> +		tst_res(TFAIL, "getcontext: %s", tst_strerrno(TST_ERR));

...
> +	if (TST_RET == 0)
> +		tst_res(TPASS, "getcontext passed");
> +	else
> +		tst_res(TFAIL, "Unexpected return value %li", TST_RET);
>  }


For this code:
	if (TST_RET < 0)
		tst_res(TFAIL, "getcontext: %s", tst_strerrno(TST_ERR));

I'd personally add else if here below:
	if (TST_RET == 0)
		tst_res(TPASS, "getcontext passed");
	else
		tst_res(TFAIL, "Unexpected return value %li", TST_RET);

But how about instead of all this just using
TST_EXP_PASS(getcontext(&ptr));

...
> +static struct tst_test test = {
> +	.test_all = run,
> +};

>  #else /* systems that dont support obsolete getcontext */
I'm going to remove this useless comment before merge ^
> -int main(void)
> -{
> -	tst_brkm(TCONF, NULL, "system doesn't have getcontext support");
> -}
> +TST_TEST_TCONF("system doesn't have getcontext support");
>  #endif

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
