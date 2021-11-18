Return-Path: <SRS0=Poid=QF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD2CC433F5
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 10:47:59 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6349261B29
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 10:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6349261B29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBBB23C89B1
	for <ltp@archiver.kernel.org>; Thu, 18 Nov 2021 11:47:55 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1EDE3C0CCD
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 11:47:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4CDDD601E39
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 11:47:45 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 2E3891FD29;
 Thu, 18 Nov 2021 10:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637232465;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pWcds0TJjeoViB5E7UM8in38jrxAWdVWsNcqTwvu/QU=;
 b=NY0xsFE5g56ZQpixo1Vbgu8NB/MFRWzxuhlJdN7BM8wgEYpNmabbVFvMqvuVho4poU76g4
 sO5jIoyiIupm5sxtbgHdtpCRmm1V212JZtk+nZpMePq9PXg7HFYdxNajVuH3xeaXDtRjvR
 h7Z4Ip/SyiKG17aJWGd6ogrwsGK3WY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637232465;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pWcds0TJjeoViB5E7UM8in38jrxAWdVWsNcqTwvu/QU=;
 b=1NP5T4pLqJosPdd4rpNE7/hOPvcdNyyiAEpID4eTdUY2GR/f9SzWwDKTnz3y2Km4A6XQGf
 m05E3x7V5nHf9OCw==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id C7AE9A3B85;
 Thu, 18 Nov 2021 10:47:44 +0000 (UTC)
References: <1637137469-13184-1-git-send-email-xuyang2018.jy@fujitsu.com>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Thu, 18 Nov 2021 10:25:05 +0000
In-reply-to: <1637137469-13184-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <87ee7dagfp.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/finit_module02: Add ETXTBSY error for
 read-write fd
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

Hello Yang,

Yang Xu <xuyang2018.jy@fujitsu.com> writes:

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

> ---
>  testcases/kernel/syscalls/finit_module/finit_module02.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
> index 47b5edbfb..b3437b5d0 100644
> --- a/testcases/kernel/syscalls/finit_module/finit_module02.c
> +++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
> @@ -72,6 +72,8 @@ static struct tcase tcases[] = {
>  		NULL},
>  	{"file-not-readable", &fd, "", O_WRONLY | O_CLOEXEC, 0, 0, EBADF, 0,
>  		NULL},
> +	{"file-readwrite", &fd, "", O_RDWR | O_CLOEXEC, 0, 0, ETXTBSY, 0,
> +		NULL},
>  	{"directory", &fd_dir, "", O_RDONLY | O_CLOEXEC, 0, 0, 0, 0, dir_setup},
>  };
>  
> @@ -134,6 +136,7 @@ static void run(unsigned int n)
>  static struct tst_test test = {
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "032146cda855"},
> +		{"linux-git", "39d637af5aa7"},
>  		{}
>  	},
>  	.test = run,
> -- 
> 2.23.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
