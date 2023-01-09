Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF596C5479D
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 10:08:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DC673CCBE6
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 11:07:59 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F91B3CA6C2
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 11:07:50 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0BAD72001B3
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 11:07:49 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 47EAF33A91;
 Mon,  9 Jan 2023 10:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673258868;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j8b4Xf9/8SM1z2exIxub0rUoVkppGlaGlJH156gkRwY=;
 b=k6LVzvFz8YuCRlKSEtA8qSspxWjzVZP1PCZI6+94BbwMink62wnvAdcMZ2FyohGm++HPVm
 kWzxo1fCaWSx6dwfLwyvn65VzJKFej2Ouk1hgz9fP0uHTUCajNw27tMp+Ell2/i7ax841c
 eZtZ8/UkwPnRBitAXDksnISEgVLwveU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673258868;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j8b4Xf9/8SM1z2exIxub0rUoVkppGlaGlJH156gkRwY=;
 b=v8Tfpm0ltRYCeh2l4DZXCuDpubnUvKh9WibUEkAQo3fc4vYUph9aB3pbWALOMJFZplYGgR
 TickgRds600lF4CQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 1DD942C141;
 Mon,  9 Jan 2023 10:07:48 +0000 (UTC)
References: <CAEemH2ceBni8N00EhZfqwZk_4mZch7ONMcL1oMKuVH-QtNmU_Q@mail.gmail.com>
 <20221230032102.2748123-1-liwang@redhat.com> <Y7KYsmc/ymdrbcb+@pevik>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 09 Jan 2023 10:07:10 +0000
Organization: Linux Private Site
In-reply-to: <Y7KYsmc/ymdrbcb+@pevik>
Message-ID: <87bkn8ja1a.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] set_mempolicy01: adjust the maximum runtime
 base on nodes
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

> Hi Li,
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> LGTM, really better than unlimited time.

Yes, pushed, thanks!

>
> Kind regards,
> Petr


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
