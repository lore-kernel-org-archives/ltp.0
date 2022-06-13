Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C15EC43334
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 15:48:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5A323C9413
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 17:48:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 403373C257E
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 17:48:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ACBE71A00668
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 17:48:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D149D1F38A;
 Mon, 13 Jun 2022 15:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655135288;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ayAbZ8q10LQYRXYT6b9LVTaDsMseQH72OZL8KJUrzcg=;
 b=JKAnT1Oyxdf6x4XZJupkHcyop69f6Z5k5g9GWucQ6bF8UYhm+sCKnz+QyeQ4VK0es7W3Fn
 RxPcARysZCCFUUfxnCt24/ypHR91+YR99KqwyyilsKifSBLg84rda4HUR6VWPC/zwZMTJc
 mV4Zbujxhbj14uuWG7BV8Ynn5vceyrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655135288;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ayAbZ8q10LQYRXYT6b9LVTaDsMseQH72OZL8KJUrzcg=;
 b=sBmeZby9jMue9OcvRYna0ZMNQMdFwJr/MitDSDzkFGoyFHnQI+EWcjKugSPu9b+K92QW8M
 bvDXrbDoCcv0GaAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D697134CF;
 Mon, 13 Jun 2022 15:48:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id d9jNHzhcp2L0YgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Jun 2022 15:48:08 +0000
Date: Mon, 13 Jun 2022 17:48:06 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YqdcNkVIK07TnI/S@pevik>
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220613143826.1328830-2-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] syscalls/inotify12: Introduce test for
 inotify mask flags
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir,

...
> +/*\
> + * [Description]
> + * Test special inotify mask flags.
> + *
> + * Regression test for kernel commit a32e697cda27:
> + *
> + *     inotify: show inotify mask flags in proc fdinfo

For our documentation it's better to be formatted like:
 * Regression test for kernel commit:
 * a32e697cda27 ("inotify: show inotify mask flags in proc fdinfo")

because spaces before text make it formatted as code.
No need to repost, I'll fix it before merge.

...
> +static struct tcase {
> +	const char *tname;
> +	unsigned int mask;
> +	int expect_events;
> +} tcases[] = {
> +	{
> +		"Watch for multi events",
> +		IN_MODIFY,
> +		2,
> +	},
> +	{
> +		"Watch for single event",
> +		IN_MODIFY | IN_ONESHOT,
> +		1,
> +	},
> +	{
> +		"Watch for events on linked file",
> +		IN_MODIFY | IN_EXCL_UNLINK,
> +		1,
> +	},
> +};
> +
> +int fd_notify;
nit: this should be static
(make check or make check-inotify12 is your friend).
Again, no need to repost, I'll fix it before merge.

Code itself looks pretty good as always, thanks!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
