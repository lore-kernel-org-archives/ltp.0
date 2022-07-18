Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711B3C433EF
	for <ltp@archiver.kernel.org>; Mon, 18 Jul 2022 07:27:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2C9E3C9880
	for <ltp@archiver.kernel.org>; Mon, 18 Jul 2022 09:27:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1806D3C8D3E
 for <ltp@lists.linux.it>; Mon, 18 Jul 2022 09:27:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DDB0F1A0078A
 for <ltp@lists.linux.it>; Mon, 18 Jul 2022 09:27:03 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 153C634CA2;
 Mon, 18 Jul 2022 07:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658129223;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HgQ3OWi35ain4Eh80idbbq8x2gRnk6a0cCLkVIYXmhM=;
 b=TWUW3QkAXB9Jrrpn2s0chMf/X94oibWJcoPFP8w2oXmJNxuwEGHHY3ApcZJNrySSnKSbFT
 QxpPA/b9CspEefzOSEgGEDyhmq8BJpNqwYKNpBjNSC8Jfa+HxAL07wk6tMbD8avCPX5yox
 jMd3LNQK1patdE23KQPb/IiZ/ff13fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658129223;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HgQ3OWi35ain4Eh80idbbq8x2gRnk6a0cCLkVIYXmhM=;
 b=+Mw10eWByPwrm3mbqqZ594ITf3xhBAVts3Z4rBjcFBN6VjX67XaoRfj9VMbSvo+7okCmTV
 m7y1rDY9naWWSYDQ==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id AB1BF2C141;
 Mon, 18 Jul 2022 07:27:02 +0000 (UTC)
References: <20220715062519.2480-1-chenhx.fnst@fujitsu.com>
 <YtGZZeUm2iB/uySr@pevik>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 18 Jul 2022 08:14:23 +0100
In-reply-to: <YtGZZeUm2iB/uySr@pevik>
Message-ID: <87y1wqj2yh.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mount03: Convert to new API
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Petr,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Chen,
>
> quite nice work, but more cleanup is needed.
>
>>  testcases/kernel/syscalls/mount/mount03.c | 462 ++++++++--------------
> ...
>>  #define FILE_MODE	(S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
>> -#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
>> -			 S_IXGRP|S_IROTH|S_IXOTH)
>>  #define SUID_MODE	(S_ISUID|S_IRUSR|S_IXUSR|S_IXGRP|S_IXOTH)
>
> @Richie @Li @Metan: There are checkpatch.pl warnings. Yes, kernel folks does not
> like permission warnings. Do we want to follow? Or should we remove these from
> our checkpatch.pl fork (we use constants in many places)?

I'm not sure about the rule. However there is no reason we can't follow
it for new tests. We don't want to have arbitrary style differences
between LTP and the kernel.

Some rules don't make sense in userland for technical reasons, but this
one is purely about readability.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
