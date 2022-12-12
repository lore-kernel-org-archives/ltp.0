Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7660C4332F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 14:48:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 633E33CBE80
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 15:48:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD2963CA4DD
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 15:48:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CD63A1000417
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 15:48:33 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id E086A1FDD8
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 14:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670856512;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HymRrnPKc4UG+0+pUgwyEjmoHIH4iL2aBp0lX8cS7k0=;
 b=f1VOb6qBrgj/xk2ZLc6jVrdJnbG3wvBSoDVfKGGkjkS1aXimaS44onywP8c6/JFV2qW9yJ
 STy/440ovL9S2BWMgIyipIowZNdhccsbm0gZx8PqIMuMjrcY5Z9hp9vAd0V7OnSSh2T/l2
 98olu5u/oYLCzYH/Tg6+4DGguzyNniQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670856512;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HymRrnPKc4UG+0+pUgwyEjmoHIH4iL2aBp0lX8cS7k0=;
 b=caBaxrVClPpSe3hsSPxIodCA6uEZanQd+HBQsca4z96mAvhikLJSKUaYmCxf6PhPccL0fw
 lUlNDPailTmNqmAA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B28B02C141;
 Mon, 12 Dec 2022 14:48:32 +0000 (UTC)
References: <20221212135524.1333-1-rpalethorpe@suse.com>
 <20221212135524.1333-3-rpalethorpe@suse.com> <Y5c75/uA9lvmVoqQ@rei>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Dec 2022 14:47:19 +0000
Organization: Linux Private Site
In-reply-to: <Y5c75/uA9lvmVoqQ@rei>
Message-ID: <87iligu18f.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] tst_fill_fs: Add alternate access pattern
 "flat"
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

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> +enum tst_fill_access_pattern {
>> +	TST_FILL_FLAT_VEC,
>
> Not sure if this is a good name, maybe TST_FILL_BLOCKS or
> TST_FILL_PAGES.

hhmm, OK blocks then.

>
>> +	TST_FILL_RANDOM
>> +};
>
> Otherwise the whole patchset looks good to me.
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thanks


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
