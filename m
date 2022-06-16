Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8443C433EF
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 13:28:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E8273C759A
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 15:28:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E06D3C4D6B
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 15:28:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8B3A014010C3
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 15:28:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8D69C21A96;
 Thu, 16 Jun 2022 13:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655386082;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7OaA61U6KRz5NrxBaMJPcTeSk3PJRybPUlmiEQ7AUHM=;
 b=w8ubGAK0U1I52kdoGNVam4p44mRvIb8IPN5QWjOMcH1S3QLpgNEg3iSRdCmhPdbw5L6+6Z
 QsUCjJPwUO0+abjt0rqawbNCV4qpambjFPjHHGWF/PTQrrZ/uWP1jNHDOTOPodLcm/dktU
 vf3hhGbHZMJGbfwYnpdtLXoUGxYmNpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655386082;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7OaA61U6KRz5NrxBaMJPcTeSk3PJRybPUlmiEQ7AUHM=;
 b=RmueKklaZj6BL9TTVyt7/TAvlFrtUdHrPMEX/oJVQKT3vWF3oZf2dE4ju1qZEee3Qo7Tol
 lnWBC/y5EMpME6Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7740613A70;
 Thu, 16 Jun 2022 13:28:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id E1frG+Ivq2KVGQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 16 Jun 2022 13:28:02 +0000
Date: Thu, 16 Jun 2022 15:28:01 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <Yqsv4WQ4iSWVBNC/@pevik>
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-3-amir73il@gmail.com>
 <YqrrkM0bWS+1X192@pevik>
 <CAOQ4uxhnr_t+LTSsUiNQQW8nhOs7pvR2oHw9ii-mHPrhzUPiVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhnr_t+LTSsUiNQQW8nhOs7pvR2oHw9ii-mHPrhzUPiVQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/5] syscalls/fanotify23: Introduce
 FAN_MARK_EVICTABLE test
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> On Thu, Jun 16, 2022 at 11:36 AM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Amir, Jan, all,

> > > Verify that evictable mark does not pin inode to cache and that
> > > drop_caches evicts inode from cache and removes the evictable mark.

> > > Verify that evictable mark can be upgraded to non-evictable but not
> > > downgraded to evictable afterwards.

> > We have policy for merging tests for rc kernels [1], thus I merged this patch
> > (added fanotify23 into runtest/staging).

> Cool. I am glad this issue has been sorted out :)
Yw, we appreciate very much your work maintaining inotify/fanotify tests.


> > I'll discuss with others what to do with fanotify10 (old test getting new
> > functionality for rc kernel).

> Please note, fanotify10 already has:

>         if (tc->ignored_onchild && tst_kvercmp(5, 9, 0) < 0) {
>                 tst_res(TCONF, "ignored mask in combination with flag
> FAN_EVENT_ON_CHILD"
>                                 " has undefined behavior on kernel < 5.9");
>                 return;
>         }

> We could easily do the same for FAN_MARK_EVICTABLE
> and 5.19.0 (although not sure how tst_kvercmp treats 5.19-rc1?)

Sure, that should work, but as feature detection works reliably
(tested on v5.17 and v5.18) I'd keep it as is. If problems turn out we can
always put this detection.

> I doubt that anyone would want to/be able to backport this feature
> to older distro kernels, but even if they do, we could remove the
> tst_kvercmp mitigation once 5.19.0 is release and leave only the
> feature test if someone complains.
Sure.

Kind regards,
Petr

> Thanks,
> Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
