Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E7BC433EF
	for <ltp@archiver.kernel.org>; Thu, 31 Mar 2022 10:41:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 723CE3C9363
	for <ltp@archiver.kernel.org>; Thu, 31 Mar 2022 12:41:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D09A3C0711
 for <ltp@lists.linux.it>; Thu, 31 Mar 2022 12:41:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0DF5E1400C47
 for <ltp@lists.linux.it>; Thu, 31 Mar 2022 12:41:38 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id E2AAA1F37D
 for <ltp@lists.linux.it>; Thu, 31 Mar 2022 10:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648723297;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sH763GBQAJp27LyCJ9Cr1ngHofhlDthOd+/dS+D2pEI=;
 b=DfbxAXqwm0J3fUOKqYIpKrLlWkUtaFGZjyqHf0J+YvTQ9orZcYQchGoAjFETgRukMiCppA
 YwWnAgu7OhOxO0k/nh/nBUij7vHr7N9UneVfKXkir/pZ/Fz3qXDPMQt9XDkf1McieAkdOa
 pVU32pgs10lhiTN0Aaf3SVP5msvKfXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648723297;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sH763GBQAJp27LyCJ9Cr1ngHofhlDthOd+/dS+D2pEI=;
 b=KbypogModDmYtze/W+ZeKHTYrJH7U8jF8prMGezqiW8gvTFo/30Ql9/55+sbILaNkJNy3F
 UywQxDbaOA78BbAg==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A95CAA3B8A;
 Thu, 31 Mar 2022 10:41:37 +0000 (UTC)
References: <20220310105533.3012-1-chrubis@suse.cz> <YinZzNWCiKalyWhd@yuki>
 <87ee2vclsf.fsf@suse.de> <c9f5b441-2f3f-f2c3-2c3c-32dd3f9595ae@suse.cz>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 31 Mar 2022 11:07:43 +0100
In-reply-to: <c9f5b441-2f3f-f2c3-2c3c-32dd3f9595ae@suse.cz>
Message-ID: <8735iyl7z8.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/waitid10: Fix on ARM,
 PPC and possibly others
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

Martin Doucha <mdoucha@suse.cz> writes:

> On 21. 03. 22 16:48, Richard Palethorpe wrote:
>> I'm wondering if we should branch on the architecture. If it's x86[_64]
>> then we only do divide by zero as it's reasonable to think that if the
>> signal is not raised then this is a bug.
>
> It's more likely to be a hardware bug/missing feature though. Do we
> really care? I'd argue that removing the division altogether and just
> calling raise(SIGFPE) in the child process is all we need in this
> particular test.

I suppose it depends on if there is a substantial difference in how the
signal is raised between div by zero and raise. I guess there is some
configuration to trap the faulting instruction and raise a
signal.

I don't have a strong opinion as, by definintion, testing undefined
behaviour has uncertain results.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
