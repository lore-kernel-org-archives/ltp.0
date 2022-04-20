Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7902CC433F5
	for <ltp@archiver.kernel.org>; Wed, 20 Apr 2022 12:50:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE73D3CA6DC
	for <ltp@archiver.kernel.org>; Wed, 20 Apr 2022 14:50:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DA933C192A
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 14:49:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7D20C1000525
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 14:49:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A198D1F385;
 Wed, 20 Apr 2022 12:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650458995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GQ54dpu40iqhtyVJPhee3LyPohY7cMkdlErzpVJpdb4=;
 b=qKDsC4jKqTH4DqZFV54zVv6CTxuNwMHYM2/fgBO7KmCe3N73xbzDrcHd5GlmcGmV/M0lcq
 M9WA8pnxD7lkPeVhsUhEii9L9wdGq6B92f/OPrcAfIm2cZy6Wqn6tQ1in9lN3B5rXY8HV5
 q09JZ0NRFC4Sa/Werbn/NLUCXVKtk+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650458995;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GQ54dpu40iqhtyVJPhee3LyPohY7cMkdlErzpVJpdb4=;
 b=4sWOZ4nC8qsR7+WnrjG8C6VI1KdKIgssLP1rEDTq4jFfefHUwYvkqYaf93IUMi/4QOrP2I
 Z/jMeLxwxqioGTDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89E2113AD5;
 Wed, 20 Apr 2022 12:49:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rulQIHMBYGLubQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 20 Apr 2022 12:49:55 +0000
Date: Wed, 20 Apr 2022 14:52:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YmAB++5hoIjNwMkB@yuki>
References: <20220420114720.1463473-1-liwang@redhat.com>
 <Yl/3FchHScs8YS6c@yuki>
 <CAEemH2dTCBpynB3wj_8eTVvvJR_V4fGPZNvt_35noqdykKi52g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dTCBpynB3wj_8eTVvvJR_V4fGPZNvt_35noqdykKi52g@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] ioctl09: wait for udevd complete the uevent
 handling
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
> timeout isn't that enough? And if it isn't wouldn't simply increasing
> > the timeout to a minute or two fix the issue?
> >
> 
> 
> That should be better, I just have a try on my reproducible system,
> but it does not work with enlarged to 180 seconds.

You have to set the test timeout to be four times of this timeout
otherwise it will report that the test had timeouted sporadically.

> ioctl09.c:52: TPASS: access /dev/loop0p1 succeeds
> octl09.c:47: TFAIL: access /sys/block/loop0/loop0p2 fails
> Test timeouted, sending SIGKILL!
> tst_test.c:1509: TINFO: If you are running on slow machine, try exporting
> LTP_TIMEOUT_MUL > 1
> tst_test.c:1511: TBROK: Test killed! (timeout?)
> 
> 
> Note, the `udevadm settle` uses 180s as default timeout as well,
> but it can work, I will look into udevadm.c to see if that does
> something additional besides the waiting.

I guess that the difference is that when we wait on a socket actively we
return sooner than with the exp backoff. By definition the exp backoff
may wait for twice as long as the udevadm and because of that the test
may actually timeout because we waited just a little bit longer.

> If so, we might need to remove the TST_RETRY_FN_EXP_BACKOFF
> from this test.

That would be valid option, remove the exp backoff and wait activelly.
Btw we already have an infrastructure for matching kernel event uevents
in the kernel/uevent/ directory. If we split the uevent.h there into a
header and libs/ltpuevent/ we could simply wait for the event by filling
in the uevent_desc structure and calling wait_for_uevents().

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
