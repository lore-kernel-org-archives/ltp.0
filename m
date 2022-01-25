Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BBBC433EF
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 11:52:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 643433C9593
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 12:52:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 778303C928A
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 12:51:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EA0B3140074A
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 12:51:54 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DF6301F380;
 Tue, 25 Jan 2022 11:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643111513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HKeLp5bPVY4iF5ryKAw2eNpj0wBTqWRvBaL0iZnvL6g=;
 b=ZCATx+7kK0/kwXtPb9tl2bPXhnUeSCCh7W4bYYvRJ312nNFtNrvmU7AN86aVxjxguMb0Hl
 M2uHez7a2exYyHH7xSWMqr+PZu0S9zkoqNQKo6Oie1Zw8HMQqTUU04hhomsBgtS2kBJpOi
 ahtxTzZU8tVmgK8LJwFC/RThFldJfqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643111513;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HKeLp5bPVY4iF5ryKAw2eNpj0wBTqWRvBaL0iZnvL6g=;
 b=dnEbha8ozwT1HQv3N9eHNGoUB/P5a/Y3sRusVTyeYzuLB/+JCjfepbikb0Ap4K9n3bQHmD
 DHm9CO14dqRuDcAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C36F213DC8;
 Tue, 25 Jan 2022 11:51:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bvokLlnk72FZGQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 25 Jan 2022 11:51:53 +0000
Date: Tue, 25 Jan 2022 12:53:42 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <Ye/kxq1oXnj5z1hd@yuki>
References: <20220124173651.652-1-rpalethorpe@suse.com>
 <20220124173651.652-2-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220124173651.652-2-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] memcontrol02: Fix anon memory comparison
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
> All memory is being compared with the size malloc'ed instead of just
> anon.
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  testcases/kernel/controllers/memcg/memcontrol02.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/controllers/memcg/memcontrol02.c b/testcases/kernel/controllers/memcg/memcontrol02.c
> index 411f5aea6..0d144cf2d 100644
> --- a/testcases/kernel/controllers/memcg/memcontrol02.c
> +++ b/testcases/kernel/controllers/memcg/memcontrol02.c
> @@ -68,7 +68,7 @@ static void alloc_anon_50M_check(void)
>  
>  	TST_EXP_EXPR(anon > 0, "(memory.stat.anon=%zd) > 0", anon);
>  	TST_EXP_EXPR(values_close(size, current, 3),
> -		     "(size=%zd) ~= (memory.stat.anon=%zd)", size, current);
> +		     "(size=%zd) ~= (memory.stat.anon=%zd)", size, anon);

I do not get this, we compare size and current and then print anon?

Should we just change the memory.stat.annon to memory.current instead?

>  	TST_EXP_EXPR(values_close(anon, current, 3),
>  		     "(memory.current=%zd) ~= (memory.stat.anon=%zd)",
>  		     current, anon);
> -- 
> 2.34.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
