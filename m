Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25EDCD54AB
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 09:34:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EED73CE47F
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 11:34:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09BAD3C9956
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 11:33:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D55C81BC3D22
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 11:33:55 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id B6B941FDBE
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 09:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695116034;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5c3RAo2mOprImNjsDhPXWT3Mohyqq2WIwfW8VPZFyuI=;
 b=AM2wYb9bYUImZA1W2kQw+eVeiNKHErY7jT5q1toktYshWkhs+xLLk8GKspA9wdY+ZDKFIY
 BMWXPrWe8Gv8TmIM0YjKzlCLCl+2436y20D4/8ypToQ0jwOkPbIxJAfh7RpNup67BQDtEn
 rWSBo80ED1AznaSTjlaKyfnEdf1Ed4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695116034;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5c3RAo2mOprImNjsDhPXWT3Mohyqq2WIwfW8VPZFyuI=;
 b=ZGz7FnDeJLXufWitZXmQ6MEYTSWxZ2rMSofgsivDtq8CN87CYs9aBS2bfBeD2swAVrotCo
 fedYqczkf0G3s+DQ==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 5FF0B2C142;
 Tue, 19 Sep 2023 09:33:54 +0000 (UTC)
References: <ZQF5J0UJ25_QLwcQ@yuki> <20230918112310.GB29246@pevik>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 19 Sep 2023 10:33:10 +0100
Organization: Linux Private Site
In-reply-to: <20230918112310.GB29246@pevik>
Message-ID: <87wmwmfqwu.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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

> Hi all,
>
> Richie suggested [1] to merge my fix for zram01.sh [2] [3].
> If we agree on this, I'll send v2 with renamed function
> check_read_mem_used_total() as Li suggested [4].

Sorry didn't see this, I have already done that and merged it.

>
> Kind regards,
> Petr
>
> [1] https://lore.kernel.org/ltp/87a5tjhl24.fsf@suse.de/
> [2] https://lore.kernel.org/ltp/20221107191136.18048-2-pvorel@suse.cz/
> [3] https://patchwork.ozlabs.org/project/ltp/patch/20221107191136.18048-2-pvorel@suse.cz/
> [4]
> https://lore.kernel.org/ltp/CAEemH2fYv_=9UWdWB7VDiFOd8EC89qdCbxnPcTPAtGnkwLOYFg@mail.gmail.com/


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
