Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058FCFA3740
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 14:25:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13C693C9808
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 16:25:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81C1A3C8F91
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 16:25:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8FE032005D0
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 16:25:15 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 72A1A21DE0;
 Mon, 24 Oct 2022 14:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666621515;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pxA6c0YHnMKsb13BaRcVVSJnCa3JKtN55kg3jp8Ecro=;
 b=ObnnAJQkQFUs379eQPcpt/pHhdbk6HJv23mffuk7ZKbjVF1HkNGOOHBSbAly8NFaL7H496
 +/WP7VJjub6kE1PzndN+fKB74ZZLGTzil1ygw94MgK7a43OO+wymCxIo4VLbRQzsfDRNn4
 O5mKD7GFv3xzsJcHh1q61wVBVkJB1KM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666621515;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pxA6c0YHnMKsb13BaRcVVSJnCa3JKtN55kg3jp8Ecro=;
 b=+CDPzGZ4CpmllNu8LDQgm1e9Yz41nlieW2fJ/Vqy7fAf1kyvD57AWFpufJZY62CeBLtUnW
 2OlRSD7IYONU2zCg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id DF4A32C141;
 Mon, 24 Oct 2022 14:25:14 +0000 (UTC)
References: <20221024103836.6394-1-rpalethorpe@suse.com>
 <20221024103836.6394-2-rpalethorpe@suse.com>
 <a11efac8-0fb3-df82-6fab-a722630425f7@suse.cz>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 24 Oct 2022 15:25:04 +0100
In-reply-to: <a11efac8-0fb3-df82-6fab-a722630425f7@suse.cz>
Message-ID: <87k04pxprq.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] cpuid/ptrace07: Only compile on x86_64
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Martin Doucha <mdoucha@suse.cz> writes:

> On 24. 10. 22 12:38, Richard Palethorpe wrote:
>> Both cpuid.h and ptrace07 contain inline ASM for x86(_64). There is no
>> need to compile any part of the test or cpuid.h
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> Suggested-by: Martin Doucha <martin.doucha@suse.com>
>
> Hi,
> for both patches:
>
> Acked-by: Martin Doucha <martin.doucha@suse.com>

Merged, Thanks!
-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
