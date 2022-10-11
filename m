Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AD4C433FE
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 09:10:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF6EE3CAE9F
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 11:10:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5B6A3CAE81
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 11:10:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8FEEB600872
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 11:10:23 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id CCCD4219D9;
 Tue, 11 Oct 2022 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665479422;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lGJ9Ph8kabsGzl/DNKhbQ2lRcvv5CxP5EAEZjYKJuuw=;
 b=lMlLqsOoyD0FZDxIsFlkMqrbEFEcSF0ewni2XK1o/dG6Ssodl4QVoJDpj9jtnMxbNLItGE
 0tsUEJE+7Mc5AESXJhaXXgiejlcQ8ERtzqoCdr5fwK9q5eY5eyQPxPY5/xYXuBquqPd6A1
 /yHhlPCWaIQV2K0ZirdYiQIoOiDa5RM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665479422;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lGJ9Ph8kabsGzl/DNKhbQ2lRcvv5CxP5EAEZjYKJuuw=;
 b=ynjpD76M+GowvK34+bXObD4JNV6WDVqSSWgnkv+qmpv4ZxA+s9RabPQpcReX9EbC0rUNwP
 QHj647r64y6ZELCA==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 61BE02C142;
 Tue, 11 Oct 2022 09:10:22 +0000 (UTC)
References: <87a663als4.fsf@suse.de>
 <1665469442-2051-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <87wn9692zk.fsf@suse.de>
 <e797b6d1-c42e-46df-df5f-d1e96470ed1b@fujitsu.com>
 <87o7ui923l.fsf@suse.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Date: Tue, 11 Oct 2022 10:08:11 +0100
In-reply-to: <87o7ui923l.fsf@suse.de>
Message-ID: <87k056914y.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/prctl10: Add basic test for
 PR_SET/GET_TSC
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


Hi,

Merged also with a preprocessor statement wrapping the asm so that it is
not compiled on non-x86 arches.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
