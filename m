Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E71CD3436
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 14:08:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4BFB3C4F85
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 16:08:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B3C73C4B95
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 16:08:26 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 70F96206C35
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 16:08:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 849881F385;
 Tue,  3 Sep 2024 14:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725372505;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TZeRD7vuOxxv5JO4MruLU8+5o7+TY2Xpa1Zf0hZqnKI=;
 b=U4uUz9yPyuUb5iizgabBt3eHHON5rfVvOigF+69UYx+6funzdwP3GqeY4xEXpssfs3DegX
 Fi5XBEbiQiYGZr8qZzv2AOeB2XO8nQ7n/Ewf0a9zD6eWTiX/WLcBKswLu1rO2E7u1UQLo2
 qb27afw65aQ6aQXH2B8KNDTnw3wKIQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725372505;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TZeRD7vuOxxv5JO4MruLU8+5o7+TY2Xpa1Zf0hZqnKI=;
 b=xOC2JaSRvTvvHsG5xJi3SDax8zT8jyNu4+DXALocICS8ihMRNf9GmZJHZBCsaRFM5cOHX6
 sR3LsDcCsKf5HfCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725372504;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TZeRD7vuOxxv5JO4MruLU8+5o7+TY2Xpa1Zf0hZqnKI=;
 b=USvmgaTzSNPrnDRNrvEXUH0mzy2+GCTX4PRwysUkFqVPscUrRnS7Z4cGvFDSo9b+9rTi5y
 +4IXJcjbO+LlzVAvgk2C/XrdEKcF6ucjhRPkDPIGyrOstSUULwaY5UY38k/V1zKrwXkqXp
 lDN/mhhfn4eR5AFW1JYTWaKebh2D+GY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725372504;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TZeRD7vuOxxv5JO4MruLU8+5o7+TY2Xpa1Zf0hZqnKI=;
 b=8c2VaD2U1zhTFc32K9aANGzsuSzoi03IBdc6fwfrzYe60oQEUBiSaCwhzG9gxfww+wHrD7
 A9QflM/phRemDtCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F58013A52;
 Tue,  3 Sep 2024 14:08:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4iSGEVgY12ZPVAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 03 Sep 2024 14:08:24 +0000
Date: Tue, 3 Sep 2024 16:08:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Zizhi Wo <wozizhi@huawei.com>
Message-ID: <20240903140807.GA762653@pevik>
References: <20240830130003.3245531-1-wozizhi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240830130003.3245531-1-wozizhi@huawei.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,suse.cz,gmail.com,huawei.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify10: Calling drop_cache twice to ensure
 the inode is evicted
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
Cc: yangerkun@huawei.com, jack@suse.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> In this test case, some scenarios are designed to verify whether the
> FANOTIFY_EVICTABLE flag takes effect: by verifying that information cannot
> be obtained from the corresponding inode after drop_cache, as this flag
> does not ping the inode.

> However, drop_cache is only performed once here, which may result in the
> inode not being released in NUMA scenarios. Suppose the inode is located
> on NUMA0 and the dentry is located on NUMA1; the first drop_cache can only
> ensure that the inode is added to the LRU list, but does not guarantee that
> evict() can been called because dispose_list does not yet include this
> inode when traversing NUMA0, which causes the testcase execution fail.

I wonder if there can be some detection that inode is evicted.
Or, can it happen that even 2x drop is not enough?

> For the single-file scenario in this testcase, executing drop_cache twice
> is necessary to ensure the inode is evicted, thus allowing the testcase to
> pass.

Acked-by: Petr Vorel <pvorel@suse.cz>

@Amir, Jan, could you please have a look?

Kind regards,
Petr

> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>  testcases/kernel/syscalls/fanotify/fanotify10.c | 2 ++
>  1 file changed, 2 insertions(+)

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> index c6d8ec922..42018de0d 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> @@ -515,6 +515,8 @@ static void drop_caches(void)
>  	if (syncfs(fd_syncfs) < 0)
>  		tst_brk(TBROK | TERRNO, "Unexpected error when syncing filesystem");

> +	/* Need to drop twice to ensure the inode is evicted. */
> +	SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
>  	SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
