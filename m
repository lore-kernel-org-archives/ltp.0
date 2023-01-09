Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21D0C54EBD
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 11:06:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCCB03CCBB1
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 12:06:17 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41A013C6E7C
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 12:06:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6536A200746
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 12:06:07 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 9450276990
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 11:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673262366;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yet+cbxdHmKlXZYyUKFnx1hy7qLEo0PvV/woao4/40o=;
 b=LYZOIGQ/knwC+xWR3xJOrXYiCu1XJgya4cSm4oDbTJly0TUjzbIjylmf4THW5nqQRjK1iX
 fQzE+TgQQYWWZXBSvo1HBLI8C3nkDuUIjl8yK3wDl1eGOkFLjgadIcdgYTHThrBb/FJx3C
 6fo4BeZwtKNssd1vmFGJ+EoB39x/pSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673262366;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yet+cbxdHmKlXZYyUKFnx1hy7qLEo0PvV/woao4/40o=;
 b=MFPTvz3438qipcnfME7TY5N5BD/Z8RqVTYYDapJTN9QNjxixjUc5Hul5Qg8AB8RbGBfOZk
 LDnd1uLUJe6jNrBA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 691222C141;
 Mon,  9 Jan 2023 11:06:06 +0000 (UTC)
References: <20221216114331.28883-1-pvorel@suse.cz> <Y5xaew0XH0mE3DZw@pevik>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 09 Jan 2023 10:58:35 +0000
Organization: Linux Private Site
In-reply-to: <Y5xaew0XH0mE3DZw@pevik>
Message-ID: <877cxwj7c2.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] aio-stress: TCONF on O_DIRECT on tmpfs
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

Petr Vorel <pvorel@suse.cz> writes:

> Hi Andrea,
>
>> O_DIRECT is not supported on tmpfs. This flag is added by -O option,
>> thus cannot be filtered with .skip_filesystems.
>
> NOTE: it fixes
> aio-stress.c:1339: TBROK: open(file0.bin,16450,0600) failed: EINVAL (22)
>
> Kind regards,
> Petr

I merged this, although I don't think it is quite correct to say tmpfs
doesn't support O_DIRECT. It's more like it is in O_DIRECT mode by
default. Either way though we don't need to run the test with O_DIRECT
and without it.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
