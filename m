Return-Path: <SRS0=3vE2=ON=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018EDC433F5
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 13:10:35 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A8D26103D
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 13:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A8D26103D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 158343CA1CF
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 15:10:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59ACD3C79C0
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 15:10:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DE9941A0043C
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 15:10:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 591511FFB0;
 Thu, 23 Sep 2021 13:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632402622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W354F09ONwgX75K2dvTIcwQk0FN5LIkn8BFzLSh6MfQ=;
 b=KJZt5/bvOZx9r6zY+aIfRtwgz28imya9wUjE820w//za1WM3rYpu75hKX571x7nH7RrjC1
 BVKgfs9wX1TZwUsMHofqzzaxkYbh1eAQsNRtSMcHjV+qH3qv8gEh/XVGiF9/N1nDwWzCkC
 JjQ5ok8/DK7azsXeUpfOmFbG8UettPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632402622;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W354F09ONwgX75K2dvTIcwQk0FN5LIkn8BFzLSh6MfQ=;
 b=13SqDIcgVH5/G/F3Ob3jDsiB3nFN5riyqr99sNM+6V1i9vkn+HVumMdaFX5wu/IKak1w/D
 csuc2KQ+csCyxCDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4557A13DD5;
 Thu, 23 Sep 2021 13:10:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ruXiD758TGHsQAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 23 Sep 2021 13:10:22 +0000
Date: Thu, 23 Sep 2021 15:10:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YUx83R4D+P2969Nx@yuki>
References: <20210817104625.2559362-1-liwang@redhat.com>
 <20210921203349.GA2014441@maple.netwinder.org>
 <CAEemH2dMCmYDkZYxfaeJ_oQCCcHzeMgSOGVQ_wS6BwCrp0YiQw@mail.gmail.com>
 <YUrnljqYd5Hx/fi+@yuki>
 <CAEemH2e5P-VbEw1xM=tvR=F9Bd+45==hW4rcP2xAbVTuy8rmDg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e5P-VbEw1xM=tvR=F9Bd+45==hW4rcP2xAbVTuy8rmDg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] fallocate05: increase the fallocate and
 defallocate size
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > I do not think that it's a good idea to pass ~100MB buffer to a single
> > write()
> > and expect it to succeed anyways.
> >
> 
> I suddenly realized that it is 1MB buffer but not 100MB, so that block
> number
> is not the key point for OOM.
> 
> 1 Block == 4k on x86_64,
> 256 * 4k == 1024kB == 1MB

Uff my bad. Indeed the problem is the tmpfs that have been added to the
list of filesystems to test recently.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
