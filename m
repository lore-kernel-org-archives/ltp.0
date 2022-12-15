Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B412C4332F
	for <ltp@archiver.kernel.org>; Thu, 15 Dec 2022 11:20:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AE1C3CBCC3
	for <ltp@archiver.kernel.org>; Thu, 15 Dec 2022 12:20:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F15803CBC83
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 12:20:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E56131400965
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 12:20:44 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id E42F121D6D;
 Thu, 15 Dec 2022 11:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1671103243;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CEKMLnU/pRNrWlcwWOtekyhROIFc5uOjyUvAltNKzHM=;
 b=0BvDHRJu9rorel7yP9LUYqYhVO1dkWqbVqr1MXWIPvVFYhuOBQ0RCx2H5icHL895mrm/1J
 pOWj8wPmN90JVY8RGTbzPm2Wyr4MXjbQ6eAVXsWhlN5FZ+xYFspQR3BGNkyigJ0sEKLo7y
 B9KZgquPL5TgJwHszzGhBWSLCChgNFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1671103243;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CEKMLnU/pRNrWlcwWOtekyhROIFc5uOjyUvAltNKzHM=;
 b=A6ilMrVPzZvtlRzAPRl3jszZVV2iTnzkFWr5KuWD5X7zwLMt145NI21Bwrirxz2u3uXDnX
 OlbWyA2IdzB7UCCw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id BA8542C141;
 Thu, 15 Dec 2022 11:20:43 +0000 (UTC)
References: <20221215101322.14417-1-rpalethorpe@suse.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 15 Dec 2022 11:16:26 +0000
Organization: Linux Private Site
In-reply-to: <20221215101322.14417-1-rpalethorpe@suse.com>
Message-ID: <87h6xwq5f8.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] getcpu01: Reinstate node_id test
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

Richard Palethorpe via ltp <ltp@lists.linux.it> writes:

> Presently the node_id is only checked on i386 and it is broken. The
> sched_getcpu call was substituted for getcpu when
> available. sched_getcpu does not have the node_id parameter, it's not
> the same thing as getcpu.
>
> Also we can check the node_id on any platform which has NUMA. Which
> includes more than just x86.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Cc: Cyril Hrubis <chrubis@suse.cz>

Maybe this is a bit impatient (although v2 was submitted some time ago),
but no response, so merged.


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
