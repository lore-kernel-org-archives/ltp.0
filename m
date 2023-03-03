Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700A7C678D4
	for <ltp@archiver.kernel.org>; Fri,  3 Mar 2023 08:36:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05E803CB97F
	for <ltp@archiver.kernel.org>; Fri,  3 Mar 2023 09:36:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 677153CB005
 for <ltp@lists.linux.it>; Fri,  3 Mar 2023 09:35:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AF9772009CE
 for <ltp@lists.linux.it>; Fri,  3 Mar 2023 09:35:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DE038229A1;
 Fri,  3 Mar 2023 08:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1677832555;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GJSFv66c3YE3DlyQW28ZaviUd7YDPAgHQpINLCNc/kw=;
 b=lM2TQdApHyCmR9aROKvs4jYNEaePBOeD1xG8vTC1+Hf2EhHD9uNNJ3K0EEpyo6i8zi46sx
 ZweSOXCMQMCpkvscFhKlJsHeLMYGKWtN3tRh6IccQFz5XwWcXpocsEljY8TtaMADOSYwsX
 j5jHSInEAL2VzfhPYKdxDlgOQyy0Jtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1677832555;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GJSFv66c3YE3DlyQW28ZaviUd7YDPAgHQpINLCNc/kw=;
 b=EvqsOiPE5nwPuN0w6qI/u/qExWtLUCCKx8u273GTTghwg/KRwUstMo3jjfa47dp3MUTER6
 ohNKx8hIHwWgNzAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC74C139D3;
 Fri,  3 Mar 2023 08:35:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xZ3/JmuxAWRfTwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 03 Mar 2023 08:35:55 +0000
Date: Fri, 3 Mar 2023 10:25:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20230303092526.GD4255@pevik>
References: <20230301152818.4427-1-andrea.cervesato@suse.com>
 <20230301152818.4427-4-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230301152818.4427-4-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/6] Refactor mqns_03 using new LTP API
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

...
> +++ b/runtest/containers
> @@ -22,7 +22,8 @@ mqns_02 mqns_02
>  mqns_02_clone mqns_02 -m clone
>  mqns_02_unshare mqns_02 -m unshare
>  mqns_03 mqns_03
> -mqns_03_clone mqns_03 -clone
> +mqns_03_clone mqns_03 -m clone
> +mqns_03_unshare mqns_03 -m unshare
Interesting, it was not run with unshare. +1 for adding it.

>  mqns_04 mqns_04
>  mqns_04_clone mqns_04 -clone

> diff --git a/testcases/kernel/containers/mqns/mqns_03.c b/testcases/kernel/containers/mqns/mqns_03.c
...
> +/*\
> + * [Description]
> + *
> + * Test mqueuefs from an isolated/forked process namespace.
Again, I'd mention supported modes here.
> + *
> + * [Algorithm]
> + *
> + * - create /MQ1
> + * - mount mqueue inside the temporary folder
> + * - check for /MQ1 existance
> + * - create /MQ2 inside the temporary folder
> + * - umount
> + * - mount mqueue inside the temporary folder
> + * - check /MQ1 existance
> + * - check /MQ2 existance
> + * - umount
> + */
>  #define _GNU_SOURCE
I wonder why _GNU_SOURCE was used here and in mqns_04.c. I don't see anything
in man mq_open(3), both tests are working without it.

...
> +static void cleanup(void)
> +{
mqns_04.c checks here:
	if (!devdir)
		return;

Although it's unlikely that SAFE_ASPRINTF(&devdir, "%s/mqueue", tmpdir); in
setup() would fail, I'd add it also here.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
