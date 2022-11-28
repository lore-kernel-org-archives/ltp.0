Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A91C433FE
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 10:57:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9938A3CC671
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 11:57:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 763B33C585E
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 11:57:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C5E3A600067
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 11:57:30 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id AEEC821BAD;
 Mon, 28 Nov 2022 10:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669633048;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JcEaquxoXtn8HmyD8md++Pm48ckDjvDENpwTw12h828=;
 b=FVpWhdXEkbuqCSkOPn2v4xK5ILDy7AEjZ1/nr/r6avp7fF6eYGeTMt62X38NDjmp7Pko8A
 5wkkgQCMTgUCCffBmDEkfZQYWaGWkoCueQmftLiV49XE5X5Y4WBsycEWGOQYEqY+REXMgD
 56S/NaOCMF80ue4Tg1zXwO/rG41nLao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669633048;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JcEaquxoXtn8HmyD8md++Pm48ckDjvDENpwTw12h828=;
 b=Snmv577f5+eTCdwJRx4B4hcd1h+rYoExfUfWVB8ahD3ha1tGy3bVcsCSYYXYAShfHWSAwN
 pZzCeVSUQ87/i/Ag==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 87EAF2C141;
 Mon, 28 Nov 2022 10:57:28 +0000 (UTC)
References: <20221028132455.26586-1-andrea.cervesato@suse.com>
 <20221028132455.26586-2-andrea.cervesato@suse.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Mon, 28 Nov 2022 10:39:22 +0000
Organization: Linux Private Site
In-reply-to: <20221028132455.26586-2-andrea.cervesato@suse.com>
Message-ID: <87y1rvuz1k.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 1/2] Rewrite aio-stress test using LTP API
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

Andrea Cervesato via ltp <ltp@lists.linux.it> writes:

> +	int maxaio;
> +	int stages_i;
> +
> +	page_size_mask = tst_dev_block_size(".");

Did you change the meaning of page_size_mask, but did not rename the
variable?

Also what happens if we are running on tmpfs? I don't think there is
blocksize in such a case. The page size is probably the closest thing
there is.

Setting to changes requested because the test fails with TBROK when /tmp
is on tmpfs. Previously this probably worked, but tst_dev_block_size has
been changed since.

Possibly we need a version of tst_dev_block_size which does not break,
but returns zero when it can't get a block size. In this case it is safe
to substitute the page size, but that is not always true. Another is
just to always use page size. Block size can be left for another day.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
