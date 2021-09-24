Return-Path: <SRS0=uWjX=OO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25DBC433EF
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 09:33:13 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3D066124B
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 09:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F3D066124B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5338A3C8F29
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 11:33:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B48523C8610
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 11:33:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DF0346013E4
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 11:33:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1F87F1FFDF;
 Fri, 24 Sep 2021 09:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632475980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ijp64tHTi+aS6uziVK1SHMbBmXEwK0BkX2L1sz4TGX0=;
 b=TTU5R57WocH/u+mHAb9ayfjvh6l7PK64ALna03N6XDAQwXKIXuXbZPug/TpWRZulllZkU6
 gRMXFEtzR0XsjGK1ofryhoQgeRqFL/PrT6JQrlFpodN+sziPHcBbv0Zn8GEy7EtbXKR/9A
 GnCPQetxV0B5u6Xzn/jwIaDD1ZYnik0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632475980;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ijp64tHTi+aS6uziVK1SHMbBmXEwK0BkX2L1sz4TGX0=;
 b=abRgc4BnKJ2dnusAebRWauQWpPzmGGk2z501yxPggez07pfahNMAFNakC+jMJWK1fuWo7e
 OmrlOatDxwWq3+Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06563139F0;
 Fri, 24 Sep 2021 09:33:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Tsp+AUybTWFnMwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 24 Sep 2021 09:33:00 +0000
Date: Fri, 24 Sep 2021 11:33:32 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YU2bbLCJg2PorGI+@yuki>
References: <20210921203349.GA2014441@maple.netwinder.org>
 <CAEemH2dMCmYDkZYxfaeJ_oQCCcHzeMgSOGVQ_wS6BwCrp0YiQw@mail.gmail.com>
 <YUrnljqYd5Hx/fi+@yuki>
 <CAEemH2dDRT-iQPH0a-Aip8OZDUpp2Z3_x4dgVBEg4tv_pyWvfw@mail.gmail.com>
 <YUr9676LXNi0xMs6@yuki>
 <CAEemH2c37Qx6uEG40utX8pGC2Gp0ZLtT_z194L4RVNm6N2CefQ@mail.gmail.com>
 <YUs+jf35Zqp8GjJl@yuki>
 <20210922165218.GA3081072@maple.netwinder.org>
 <YUyQMBLPbCs4/Gur@yuki>
 <CAEemH2fRGX50RAgdAYJMW6FXX33FZG6kH=ygCQSGO6PHAi-S8g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fRGX50RAgdAYJMW6FXX33FZG6kH=ygCQSGO6PHAi-S8g@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
> > FYI I've tried to run syscalls on a VM with 256MB RAM just to see what
> > explodes and it looks like futex_cmp_requeue01 fails as well because we
> > don't have enough memory to fork 1000 processes. I guess that we really
> > need an API for at least rough scaling for the number of processes we
> > can run based on free memory. With that we could finally fix the
> > msgstress testcases as well.
> >
> 
> +1 Sounds good.
> 
> [Cc Fang Ping]
> 
> Btw, AFAIK, pifang@ is working on an SUT ability(io, memory, ..) evaluation
> before running the test, then set test parameters intelligently according
> to the
> lite benchmark result. This will definitely help make a proper runtest file
> for LTP,
> but I'm not sure if he plans to integrate it in LTP internally.
> 
> I will talk to him to learn more details.

This is a complex problem, but for now I guess that putting the logic in
the test library would be easiest solution, that allows the tests at
least skip subset of scenarios.

In the long term I guess that the logic can be put into runltp-ng but I
do not think that we can make it work anytime soon. At least this would
require definition of some kind of (JSON based) API that would explain
the test parameters to the testrunner.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
