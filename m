Return-Path: <SRS0=jFKu=PB=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A78FC433F5
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 06:59:32 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6407261039
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 06:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6407261039
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7017D3C0F97
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 08:59:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D0F93C0E8B
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 08:59:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DF369601062
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 08:59:19 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 04466222B1;
 Wed, 13 Oct 2021 06:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634108359;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TgrQpV7dUv3XT5eMfaqZg04JF0av0iLLwYxI/E4ybOM=;
 b=ZUDdblgJrb/nIF9xVq/KE6mohtUDw+6uKzhyGuaJYQnasyimcBM/HM3E8fCuqU1Mw0FRg3
 PaYOYcBS4ouoDVnXfCC6YT2G1WclhSiIXaS/leMAxMbsKDrdJr+49zF99h7LSQHw+j6ZKY
 FAzLPeP+HLTWzQw+6zbe65yhFpQuVvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634108359;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TgrQpV7dUv3XT5eMfaqZg04JF0av0iLLwYxI/E4ybOM=;
 b=WVDiZrljaGtsNOJV6fwoJ5uF4XrMvaID0T/l/M524kfLbef9s2VgyRDl7optq3BQlLPOQ0
 nMwyBFGhK1d51qBA==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id C70FBA3B89;
 Wed, 13 Oct 2021 06:59:18 +0000 (UTC)
References: <1634087649-2137-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1634087649-2137-2-git-send-email-xuyang2018.jy@fujitsu.com>
User-agent: mu4e 1.6.5; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Wed, 13 Oct 2021 07:54:26 +0100
In-reply-to: <1634087649-2137-2-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <87bl3t9zr3.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] scenario_groups/default: Add irq into default
 run
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

Yang Xu <xuyang2018.jy@fujitsu.com> writes:

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  scenario_groups/default | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scenario_groups/default b/scenario_groups/default
> index 439783dac..1dc2987d5 100644
> --- a/scenario_groups/default
> +++ b/scenario_groups/default
> @@ -6,6 +6,7 @@ dio
>  io
>  mm
>  ipc
> +irq
>  sched
>  math
>  nptl
> -- 
> 2.23.0

I'm not sure this should go in the default group at this time. The only
test in irq (irqbalance), only works on some configurations. As
discussed in the test review, the user must figure out if they should
run it or not.

Perhaps we need a new scenario group?

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
