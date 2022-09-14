Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FFEECAAD3
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 20:34:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01C573CAC18
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 22:34:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 365233CABD6
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 22:34:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C457D6020CF
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 22:34:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1215B33999;
 Wed, 14 Sep 2022 20:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663187671;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K9zK9Jac7FnsftYJ2Ff0mM76Qs6vCDb7O+bMmYvE/QY=;
 b=OFbOJAJptFCEi+iHekFvEYtnOegZLSoKGaaMono+YFHEWe6d+bMLJEzJqW79eYsh6RRVKg
 F3IgH7dMJZtmQuKCP0m685PDWw42Gy+BsTomNue68XB2QUL+39r30Wz9Z0W85lcwfJI3du
 k7TXvKiNz504JEqBVm06UcghIwSglrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663187671;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K9zK9Jac7FnsftYJ2Ff0mM76Qs6vCDb7O+bMmYvE/QY=;
 b=N1WNIm1eay6vIwXAmrHm/QRzb4oZy7lImzZLmnIF2Mf47PgheUPo7B+dfiNE4/Zk+e8gmB
 +ImYf26EVYqKrpCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBE3913494;
 Wed, 14 Sep 2022 20:34:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RQsYNNY6ImNpLAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 14 Sep 2022 20:34:30 +0000
Date: Wed, 14 Sep 2022 22:34:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YyI61cS0esk6UOp6@pevik>
References: <20220914161930.27681-1-mdoucha@suse.cz>
 <20220914161930.27681-6-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220914161930.27681-6-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/5] sendfile09: Add max_runtime
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

Hi Martin, Jan,

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---

> Changes since v1:
> - Changed max_runtime from 20 to 120

Reviewed-by: Petr Vorel <pvorel@suse.cz>

>  testcases/kernel/syscalls/sendfile/sendfile09.c | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/testcases/kernel/syscalls/sendfile/sendfile09.c b/testcases/kernel/syscalls/sendfile/sendfile09.c
> index 320649dcd..07c43eb59 100644
> --- a/testcases/kernel/syscalls/sendfile/sendfile09.c
> +++ b/testcases/kernel/syscalls/sendfile/sendfile09.c
> @@ -97,6 +97,7 @@ static struct tst_test test = {
>  	.test = run,
>  	.tcnt = ARRAY_SIZE(tc),
>  	.min_kver = "2.6.33",
> +	.max_runtime = 120,
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "5d73320a96fcc"},
>  		{}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
