Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC76C4332F
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 10:48:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 440803CBDB0
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 11:48:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E471D3C32DD
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 11:48:01 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5357E1400B69
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 11:48:00 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 6975D1FE8F;
 Tue, 13 Dec 2022 10:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670928480;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m7JI6sjXcuzgrx9odVnXQM+CYT/Y///vIvRgOn7Gw34=;
 b=pcuUN6NCI9taREQggNnMh4H/+Av6a0GykDQbPh0TGH13cRz8W/Hx9lLhDR948M7jnMy8dE
 8ChD5YIT21y5UfEkiS58og1NJVhMn4gv5g+IPLj9hhMUOpx4/ZTTVUexhlKCUb2U5zK56v
 Pcbwqx3ew2X4ZX9rR1/rFdrKxEiIqZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670928480;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m7JI6sjXcuzgrx9odVnXQM+CYT/Y///vIvRgOn7Gw34=;
 b=Ux24fq33i8mE7ALd9o1p9B1hYocRrdjbs0W6/EzBr1m/0mza4y1X8idThLdzDEaOeq/qMb
 Z3C/utOtTg9rMcBQ==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 2D8B92C141;
 Tue, 13 Dec 2022 10:48:00 +0000 (UTC)
References: <20221213003553.3693243-1-zijunzhao@google.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: zijunzhao <zijunzhao@google.com>
Date: Tue, 13 Dec 2022 10:46:32 +0000
Organization: Linux Private Site
In-reply-to: <20221213003553.3693243-1-zijunzhao@google.com>
Message-ID: <87359jshpc.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] signalfd01.c: put the right round bracket to the
 right place in tst_resm
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

The patch is perfect, but you need to add your Signed-off-by git trailer
to the commit (or just respond this e-mail with it).

zijunzhao via ltp <ltp@lists.linux.it> writes:

> ---
>  testcases/kernel/syscalls/signalfd/signalfd01.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/signalfd/signalfd01.c b/testcases/kernel/syscalls/signalfd/signalfd01.c
> index 3df941785..c6a7c3a58 100644
> --- a/testcases/kernel/syscalls/signalfd/signalfd01.c
> +++ b/testcases/kernel/syscalls/signalfd/signalfd01.c
> @@ -249,8 +249,7 @@ void do_test2(int fd, uint32_t sig)
>  		goto out;
>  	} else {
>  		tst_resm(TFAIL, "got unexpected signal: signal=%d : %s",
> -			 fdsi.ssi_signo),
> -			 strsignal(fdsi.ssi_signo);
> +			 fdsi.ssi_signo, strsignal(fdsi.ssi_signo));
>  		goto out;
>  	}
>  
> -- 
> 2.39.0.rc1.256.g54fd8350bd-goog


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
