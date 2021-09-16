Return-Path: <SRS0=QfDu=OG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3735C433EF
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 13:54:47 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3227B61056
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 13:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3227B61056
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 948A33C8988
	for <ltp@archiver.kernel.org>; Thu, 16 Sep 2021 15:54:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66CDE3C1D2F
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 15:54:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CD1FC600967
 for <ltp@lists.linux.it>; Thu, 16 Sep 2021 15:54:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F27B820230;
 Thu, 16 Sep 2021 13:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631800474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vXxHRmo8FVwbn0lB/MnSvfbE/0WdaFKHCkq9bZCs+Fo=;
 b=n4rTkpd8rQqUF72u86XVl+qBe8nIABbracS4gOIubaot6SZRla9SAf5pSWOjQyzBRdvu6G
 vr6Qed+st2s8ShkpUWSo8JYuknxuTba+MkYCf1ZD9Pptr82jjjZBl1a01BqxRzQwCyg11H
 R6SnOQamL7R8p1n1hj4ouC2seIYNJNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631800474;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vXxHRmo8FVwbn0lB/MnSvfbE/0WdaFKHCkq9bZCs+Fo=;
 b=YLE1p6rQTbl9PeiFK8nQDjxDMbTA3BgjqAqj3w2oHntqPf4BpuX91OYEEGih9WTf4PNIM2
 XMeyroCe6ZoR+kDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D497413480;
 Thu, 16 Sep 2021 13:54:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id D9noMZpMQ2EAdAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 16 Sep 2021 13:54:34 +0000
Date: Thu, 16 Sep 2021 15:54:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YUNMslRngkq7ym20@yuki>
References: <20210915134505.22771-1-mdoucha@suse.cz>
 <20210915134505.22771-4-mdoucha@suse.cz> <YUM+76XsQB57U3rE@yuki>
 <1973857f-53fd-6f16-1f7d-d65a371f9c60@suse.cz>
 <YUNJ2yuO7UAylQNk@yuki>
 <dc4129ec-afe5-3d97-ff1d-326a217a63ad@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dc4129ec-afe5-3d97-ff1d-326a217a63ad@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] syscalls/utime03: Convert to new API
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
Message-ID: <20210916135458.jqUv_9vc07KHixiRCAhRsQN_0xH0jNmgvkb-ZjQo-LM@z>

Hi!
> > I guess that it would also depend on a underlying filesystem and how
> > timestamps are rounded in there, so I guess that we should turn on the
> > .all_filesystems flag for the test as well. What do you think?
> 
> That sounds like a good idea.

I've added the support for all_filesystems and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
