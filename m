Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48768C61DA4
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 10:11:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9F153CBED0
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 11:11:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26A2F3CB10B
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 11:10:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4BB8A20097F
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 11:10:56 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id A7BD622307
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 10:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676542255;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qyhnBjTn5TWtkD8tzWU3w4UPBvRMfduQbFmF3E42hmQ=;
 b=pu0quZCSsifjkVxCVYD9/xv8rWbZyZ5MlporH+8skECAyz2WkyYaW3qexLePoOBY1b6RxQ
 1eXd/PpEwIVgoZuxxF0buYOoWkW7aZUldiRRardDhXWu2f4RZRiYcW4jtnt3Halv7WoFVh
 jhCHo6mVRNGG2BBMsVrSf0n3wI2UHic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676542255;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qyhnBjTn5TWtkD8tzWU3w4UPBvRMfduQbFmF3E42hmQ=;
 b=IczszSkf6hVRzYtC3g+6bAmEc05qEKh9fosDCi5yC3XQp2Nc2MHKhR7EWIENHTFEK2fr8E
 j1XrWlChJ8vi2eCg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 7A86F2C142;
 Thu, 16 Feb 2023 10:10:55 +0000 (UTC)
References: <20230215144225.25008-1-mdoucha@suse.cz>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 16 Feb 2023 09:24:51 +0000
Organization: Linux Private Site
In-reply-to: <20230215144225.25008-1-mdoucha@suse.cz>
Message-ID: <87pma9rkcx.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve-2015-3290: Fix tst_syscall() return value
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

Martin Doucha <mdoucha@suse.cz> writes:

> The modify_ldt() syscall returns 32-bit signed integer value. Recent changes
> in tst_syscall() caused the value to be interpreted as unsigned on older
> kernels/glibc, which breaks the cve-2015-3290 test. Add explicit type cast
> to fix it.

This is strange, currently for the test to work the return 32bit return
value must be sign extended to 64bit so that it equals -EINVAL (right?).

Meanwhile kernel has never changed the return value, it's always 32bit
("which is a bug"). I can't find any change in glibc either that would
explain it.

I am missing something or is it a mystery?

>
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/cve/cve-2015-3290.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/cve/cve-2015-3290.c b/testcases/cve/cve-2015-3290.c
> index f61d2809b..a2a8fcedd 100644
> --- a/testcases/cve/cve-2015-3290.c
> +++ b/testcases/cve/cve-2015-3290.c
> @@ -195,7 +195,8 @@ static void set_ldt(void)
>  		.useable	 = 0
>  	};
>  
> -	TEST(tst_syscall(__NR_modify_ldt, 1, &data_desc, sizeof(data_desc)));
> +	TEST((int)tst_syscall(__NR_modify_ldt, 1, &data_desc,
> +		sizeof(data_desc)));
>  	if (TST_RET == -EINVAL) {
>  		tst_brk(TCONF | TRERRNO,
>  			"modify_ldt: 16-bit data segments are probably disabled");
> -- 
> 2.39.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
