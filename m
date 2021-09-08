Return-Path: <SRS0=D2qq=N6=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3123FC433F5
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 14:32:15 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B96D61102
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 14:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B96D61102
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 855EB3C918D
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 16:32:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB4273C2297
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 16:32:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3B2CB1A01149
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 16:32:01 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3E4B9221FB;
 Wed,  8 Sep 2021 14:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631111521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nt34ZjimyI1nsReHe+PAEpp2EpHySMHLpYthzI93A0U=;
 b=V453tfBNRczbKPxN9s6hFyjL6Wfp/RwkBWPsLAfVhMWDBEORV11tjjuW2NMS1SQDzFl1ux
 4EBlgNcE/ucWQ18up7JGp7Ks2zxy2RmScNL1UYqkwGXkdr2kJ5iYOxFUf+EK1Kiv/kIf8v
 z1VKSUtte2QM6IZxBd/l9RNH/GiVwS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631111521;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nt34ZjimyI1nsReHe+PAEpp2EpHySMHLpYthzI93A0U=;
 b=6m7jenGCTggT5FzlTL2SOLCEFb7kErjIzV6w3RFjLrz/LohHi7CSfspzjW7Lubp+uQDTUm
 L9BTVnLqs2X0rBCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29EB013D0B;
 Wed,  8 Sep 2021 14:32:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tatACWHJOGELFgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 08 Sep 2021 14:32:01 +0000
Date: Wed, 8 Sep 2021 16:32:14 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <YTjJbnPleZA4wZJb@yuki>
References: <20210624132226.84611-1-krzysztof.kozlowski@canonical.com>
 <YTi8qQOZU3NriZvZ@yuki>
 <3308f9e1-7766-8409-0360-9fe798276a90@suse.cz>
 <YTjGCeaaA0Nv56hn@yuki>
 <CA+Eumj53j-AucdNdJ91-wHO6CN=jNg=kpNpxNwnRwqvbxsWMkw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+Eumj53j-AucdNdJ91-wHO6CN=jNg=kpNpxNwnRwqvbxsWMkw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: memutils: don't pollute entire system memory
 to avoid OoM
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210908143214.31_nTSGHrFnzkHBHOT6yC28UwxSRFygP2jqAm7gMHfM@z>

Hi!
> > Sounds good.
> >
> > Krzysztof unless you disagree I will push your patch but change the
> > division factor from 200 to 64.
> 
> 
> Sounds good. In such case please also update the % mentioned at the
> end of commit msg (0.5% -> 1.5%).

Done and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
