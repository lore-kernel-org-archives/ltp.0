Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8D1C3A5A7
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 09:47:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 165D13CC063
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 10:47:20 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CEF893CC039
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 10:47:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0A5622009A8
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 10:47:08 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 794D33372E;
 Thu,  8 Dec 2022 09:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670492827;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WORg1Sj49f/KX07STGAkh/7zwmHpJL9RkCjV99szYus=;
 b=pzvDM8HPh+LeuSwPLNoo32E7ok5tWv+bp3AgzYm3CQr1hYoOaqWrPKg9JJR6fgw4cvXfps
 HVXB/447NmFGgDidtu3dzo4N/tCSQ34XQ8PU0Bv6hLNoGHJofTX3eTLrBJehoYMMUyS5k9
 cpf0F08mruNYzA2Kkbh9JS08TqMqIsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670492827;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WORg1Sj49f/KX07STGAkh/7zwmHpJL9RkCjV99szYus=;
 b=ZEFgoFO4uUYLcTxNNL2QqhZsDIeQs3KxgoDWW9TinmA2uOOgJ2lMv8uflJ5JqBvd2lO6Df
 ECcQW0BcCgOSOIBQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 45EAC2CAB0;
 Thu,  8 Dec 2022 09:47:07 +0000 (UTC)
References: <20221130135451.28399-1-andrea.cervesato@suse.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 08 Dec 2022 09:46:11 +0000
Organization: Linux Private Site
In-reply-to: <20221130135451.28399-1-andrea.cervesato@suse.com>
Message-ID: <87k032qlb9.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v10 0/2] Rewrite aio-stress test
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

Hi,

Would you like to add your tags to this one?

Andrea Cervesato via ltp <ltp@lists.linux.it> writes:

> aio-stress-test has been rewritten and runtest files merged.
>
> Andrea Cervesato (2):
>   Rewrite aio-stress test using LTP API
>   Merge ltp-aio-stress part2 with part1
>
>  runtest/ltp-aio-stress                      |  55 ++
>  runtest/ltp-aio-stress.part1                |  79 --
>  runtest/ltp-aio-stress.part2                |  38 -
>  testcases/kernel/io/ltp-aiodio/aio-stress.c | 973 ++++++++------------
>  4 files changed, 459 insertions(+), 686 deletions(-)
>  create mode 100644 runtest/ltp-aio-stress
>  delete mode 100644 runtest/ltp-aio-stress.part1
>  delete mode 100644 runtest/ltp-aio-stress.part2
>
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
