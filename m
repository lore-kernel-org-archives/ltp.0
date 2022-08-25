Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27C2C28D13
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 14:03:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C1A33CA453
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 16:03:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BA2F3C01CF
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 16:03:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A1E931A00372
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 16:03:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C428B338B5;
 Thu, 25 Aug 2022 14:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661436226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lehQQg5pmDvhqZLXGxQ8ZTsUnlfmeAvNKrOnt5wAvVQ=;
 b=ULENFYMCQcZKkSWfLKgRIB/rjQOyuF1r7tSw9bnNOVXNZtahzaOt0Id3NMWw5bi1vGoleu
 Foj+DxLEh1popxu8Vfwni4j9u8+CwMBJLOLept6qV3JGoki0pMZZHzX0/ju1ejMQblPLih
 +Ur0H/pqLHS6XTutHj32yq9xaprQZEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661436226;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lehQQg5pmDvhqZLXGxQ8ZTsUnlfmeAvNKrOnt5wAvVQ=;
 b=5j5V5lAPHEgDSfsui/FBWxyurnCMwn33b7iFzC/fHnnyZ5Qls1YTGdosh+PE5OPLaddI0L
 VWgPzU1CT9r6bnDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B021B13517;
 Thu, 25 Aug 2022 14:03:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gjb8KkKBB2NZQQAAMHmgww
 (envelope-from <jack@suse.cz>); Thu, 25 Aug 2022 14:03:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 493ADA0679; Thu, 25 Aug 2022 16:03:46 +0200 (CEST)
Date: Thu, 25 Aug 2022 16:03:46 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20220825140346.kgedkgjyge3kzvzj@quack3>
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-6-amir73il@gmail.com>
 <CAASaF6wSYFOTsuZUN-B6QNrvrRxVavpujhLNXS4FBSeysDBgDQ@mail.gmail.com>
 <CAOQ4uxj9Tq9NL2tic+6GtS6q5tBWdo-ixHPPkovKQdvU6NpHMQ@mail.gmail.com>
 <CAASaF6w2NqMNCNY+MEgOB6sUKz19foF6a27ZCO-7qFe9dCarpQ@mail.gmail.com>
 <CAOQ4uxiJ2kb42XzQc8P2cZ6LKdrYNK3-P9u_cLS_WHYx4LzwzA@mail.gmail.com>
 <CAASaF6y_KPnQh_ezG5njXaVOyFxtnTWDne2gf7S5XjMDZYa=rg@mail.gmail.com>
 <20220824152420.57scfzhhc6ufnwov@quack3>
 <CAASaF6zZC=PM7yvAApqXAMcKeJjznusUqiJrF4h33rEMbkouBA@mail.gmail.com>
 <CAOQ4uxgb4nerXNwFWu3zp0ztZRiexnM2Ya=+L3hxw=V-4UxjPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgb4nerXNwFWu3zp0ztZRiexnM2Ya=+L3hxw=V-4UxjPQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] syscalls/fanotify10: Add test cases for
 evictable ignore mark
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>,
 Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu 25-08-22 16:47:53, Amir Goldstein wrote:
> > > Is this still an issue?
> >
> > It still rarely fails - two instances in last 3 weeks:
> > 6.0.0-0.rc1.13.test.eln
> > https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/08/15/redhat:613661619/build_x86_64_redhat:613661619_x86_64/tests/3/results_0001/job.01/recipes/12445146/tasks/10/logs/syscalls.fail.log
> >
> > 5.20.0-0.rc0.aea23e7c464b
> > https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/08/14/redhat:613063904/build_x86_64_redhat:613063904_x86_64_debug/tests/2/results_0001/job.01/recipes/12440847/tasks/9/logs/syscalls.fail.log
> >
> > > I didn't see anything happening in the fanotify10
> > > test upstream. If the issue still happens, maybe something like the
> > > attached patch may improve the situation? Jan, do you have a chance to test
> > > it?
> >
> > I can't reproduce failure on demand. If the patch doesn't have any
> > side-effects, then let's apply it, and we'll see in couple weeks.
> >
> 
> Yes, let's do that please.
> 
> Acked-by: Amir Goldstein <amir73il@gmail.com>

Agreed. Done official submission.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
