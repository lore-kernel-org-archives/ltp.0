Return-Path: <SRS0=2Bls=OD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB079C433F5
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 07:31:44 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B92F604DA
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 07:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B92F604DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8492B3C22F6
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 09:31:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49A973C1DC0
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 09:31:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AA1B71000D09
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 09:31:32 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A3E6421F95;
 Mon, 13 Sep 2021 07:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631518291;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D/ss3h6pW+q+unN2XCYFs+Lvj1kqqRD0KQLZqmzUK2U=;
 b=o1ccTSxQj97DCQR4LCj0nyG5HhegL3yn39WkYf+3zjSPZd28Jq3AyDhxvQYvt4Krd6NmA7
 jNPCFt9x7teDddBn30/8HQzDO8iv0lXLufRsOTfwevtYtEDMHNmw5DI8h2kG+4mF17VScb
 4DjXtQZ4ONKSphcuD7Zd2Nyrhuolw2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631518291;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D/ss3h6pW+q+unN2XCYFs+Lvj1kqqRD0KQLZqmzUK2U=;
 b=YGhsv+JIQxRWyoZVR/FNwtsgIxM7nQ7TTKabFEDa04wfuiJwMShRXvXvGsTJGnFO3VS83c
 xs0U40+UsZTqn7Dw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 77AA6132AB;
 Mon, 13 Sep 2021 07:31:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id R8z/GlP+PmEzAQAAGKfGzw
 (envelope-from <pvorel@suse.cz>); Mon, 13 Sep 2021 07:31:31 +0000
Date: Mon, 13 Sep 2021 09:31:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YT7+UU1d3llds9br@pevik>
References: <20210910130820.21141-1-pvorel@suse.cz>
 <CAEemH2evPtStSndYb0viwt-+x+g4dB3FER366_KEjcRUn7pWYg@mail.gmail.com>
 <YT7wZrmi8Jc0YHfL@pevik>
 <CAEemH2cO31kSwK3=tk6krB8ZZYPPaP+c-+5D7FGRK2ofYSmbtg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cO31kSwK3=tk6krB8ZZYPPaP+c-+5D7FGRK2ofYSmbtg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/7] Cleanup sched/process.c
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210913073129.Hgh6pP8guJa_9fmX_J-hfc6McdWxPPVR91lirSdbM8M@z>

> > > But I just wondering, is there a run test file to perform this test case?
> > > I greped the runtest/* but find no file currently includes this:(.

> > IMHO it's in sched:
> > $ git grep -w process runtest/
> > runtest/sched:hackbench01 hackbench 50 process 1000


> Hmm, here "process" is only a parameter to hackbench01, it
> has no direct relevance to the process_stress/process.c.

> After checking the history a while, I think that process_stress/process.c
> is an independent test and obsoleted for a quite long time, maybe
> we can add online back to runtest/sched file or just let is there until
> someone converting to the new API.

> commit 576f1ee560b2370818b49366bad581952af3dd70
> Author: robbiew <robbiew>
> Date:   Fri Feb 1 16:39:39 2002 +0000

>     Removed a test that was not correctly running.

Ah, good catch! I didn't check it's not a binary which would be required.
I'll recheck it once again and send a patch to remove it then.

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
