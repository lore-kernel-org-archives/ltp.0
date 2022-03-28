Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47434C433F5
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 14:59:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4FADE3C98BB
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 16:59:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52C923C97F1
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 16:59:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BBCD31400538
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 16:59:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E912B210EA;
 Mon, 28 Mar 2022 14:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648479545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W8vECuUMEME+LXoo1GZi0uMABi5nVTDkq80bXtoSlmo=;
 b=QZtZ1He5h/ZM926DlvbBcYuZm2QG1RS4Oj5GlTbbySUCMBzSjHpDK21tPnzAQcRYyVoaOm
 0H4aL6iQEO+qGo76ziMuuinJrK4pBNpJtGe/hqFjGl7kiHSl8okHx7ksHDBrwkp/JFCNmj
 6LRn4EFOLUe9TBc84LNtV1/hiGI6JEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648479545;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W8vECuUMEME+LXoo1GZi0uMABi5nVTDkq80bXtoSlmo=;
 b=P9YFk5w4CmaBPL1LxeCGnScv+3WZWds5vOWo6ft1Y2jZt8IulIxP3zmVJB2xdfgafSDLnR
 MDNiyUv0uqF0e6Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8D4413215;
 Mon, 28 Mar 2022 14:59:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id er3eLznNQWIiPwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 28 Mar 2022 14:59:05 +0000
Date: Mon, 28 Mar 2022 17:01:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YkHNxNcEy/xHv5wz@yuki>
References: <20220328123114.31881-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220328123114.31881-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Fix wqueue09 according with 5.17 kernel updates
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
> Kernel 5.17 introduced many changes in the watch_queue support. In
> particular, commit 3b4c0371928c17af03e8397ac842346624017ce6 changes the
> behaviour of IOC_WATCH_QUEUE_SET_SIZE and ioctl control over watch_queue
> buffer size: now we need to generate more events than before. In
> particular, more than the bitmap size to the number of notes.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
> ---
>  testcases/kernel/watchqueue/wqueue09.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/watchqueue/wqueue09.c b/testcases/kernel/watchqueue/wqueue09.c
> index 55d567249..86feebf4a 100644
> --- a/testcases/kernel/watchqueue/wqueue09.c
> +++ b/testcases/kernel/watchqueue/wqueue09.c
> @@ -29,14 +29,14 @@ static void saw_data_loss(struct watch_notification *n,
>  
>  static void run(void)
>  {
> -	int fd;
> +	int fd, i;
>  	key_serial_t key;
>  
> -	fd = wqueue_watch(1, &wqueue_filter);
> +	fd = wqueue_watch(32, &wqueue_filter);

We may as well keep the 1 here, kernel will rount it to smallest
possible size anyways.

>  	key = wqueue_add_key(fd);
> -	keyctl(KEYCTL_UPDATE, key, "b", 1);
> -	keyctl(KEYCTL_REVOKE, key);
> +	for (i = 0; i < 256; i++)
> +		keyctl(KEYCTL_UPDATE, key, "b", 1);

Have you tried this on any machine with 64k pages? If the minimal size
is rounded to a PAGE_SIZE and we get 32 messages in 4k page that would
mean that we would fit 512 messages in 64k page. So maybe we would need
512 messages on 65k page size?

>  	data_lost = 0;
>  	while (!data_lost)
> -- 
> 2.35.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
