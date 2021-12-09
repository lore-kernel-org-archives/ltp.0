Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAD4C433EF
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 15:14:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 384B83C7D1F
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 16:14:02 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 269243C1836
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 16:13:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 904F460047E
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 16:13:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A857721106;
 Thu,  9 Dec 2021 15:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639062831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0MdUzRjo51tyoxuTenu+KurTDzOWbbePGMqQ0v6ZlL4=;
 b=FL/hprM+bXuqoDceT+uiwTZIWePV78YdwIt0aU7UX3VDcAd3F8jioroeelOtGTaY9RyRDO
 fVKBsO3myc/1ZHfkQ1QDDafhfr/0H6I2KEqga0Fzprk16tWREsuVaFoC4rzf9YMUYQgN99
 /PmI5vF5aO04WVGGVRXSvkD9LpByQb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639062831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0MdUzRjo51tyoxuTenu+KurTDzOWbbePGMqQ0v6ZlL4=;
 b=jhtVi0Ot4RukSmnwlypLjm54Dir4XkAMS4PKtsMLCrR6lQe4x8XU1tGlOE15zwuuTw5mQS
 JB/2R+t6b6jwoKAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C55213B2D;
 Thu,  9 Dec 2021 15:13:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cqg3IC8dsmHUPQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 09 Dec 2021 15:13:51 +0000
Date: Thu, 9 Dec 2021 16:15:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YbIdflpXAZ8Z03y+@yuki>
References: <1639035823-5786-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1639035823-5786-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] swapping01: skip test if zram-swap is being
 used
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> ---
>  testcases/kernel/mem/swapping/swapping01.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
> index 392b79d65..29c1e0443 100644
> --- a/testcases/kernel/mem/swapping/swapping01.c
> +++ b/testcases/kernel/mem/swapping/swapping01.c
> @@ -67,6 +67,11 @@ static void test_swapping(void)
>  #ifdef TST_ABI32
>  	tst_brk(TCONF, "test is not designed for 32-bit system.");
>  #endif
> +	int ret;
> +
> +	ret = tst_system("zramctl | grep SWAP");
> +	if (!ret)
> +		tst_brk(TCONF, "zram-swap is being used!");

Actually what the zramctl does is to open the /proc/swaps file and looks
for the /dev/zram* in there. I guess that we can as well read the the
file ourselves...

>  	init_meminfo();
>  
> @@ -155,4 +160,8 @@ static struct tst_test test = {
>  	.needs_root = 1,
>  	.forks_child = 1,
>  	.test_all = test_swapping,
> +	.needs_cmds = (const char *[]) {
> +		"zramctl",
> +		NULL
> +	}
>  };
> -- 
> 2.23.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
