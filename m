Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E123C433EF
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 09:27:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08B843CA531
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 11:27:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAD353C0D24
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 11:27:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B87D7600853
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 11:27:29 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id C34D01F38D;
 Mon, 11 Apr 2022 09:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649669248;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ly5Nnby8HGl7WTzRluEJCIKFuUiivSpS0KTFBBgYdyw=;
 b=Tpbe181b2qpVNfGu26lA+856+YcaBc7CGrbduh3QQGLWb4PGOvp0FDloMEbacV4pxC8DuO
 MULvRCCFeuqElEHv8tD4XQ2jTnJQxs/oH5MXmQL61s93r9OkkFOB5GJIfUZMcQVNTnGrY0
 aaIUQRtlz2BmY0TuPTaAI32FAdLvRuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649669248;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ly5Nnby8HGl7WTzRluEJCIKFuUiivSpS0KTFBBgYdyw=;
 b=5VF02ZrIEopaFSjlTg7Sv6Ui7x8WVks2f/S3v0thr67Yo4Si6GnkHM10chAa5Wf+4IYXmu
 /latqiQBxPxuPzBg==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 79590A3B83;
 Mon, 11 Apr 2022 09:27:28 +0000 (UTC)
References: <20220405170607.3596657-1-edliaw@google.com>
 <CAEemH2dZiWZjHWMzrRuuiar5YQHF741TMu4p=uMtWgTPG4Oh+w@mail.gmail.com>
 <87sfqkggtq.fsf@suse.de>
 <CAEemH2eh=AX6-DMW1UaVs+MGtqFXq8HoJD41D3paB93vQZ9ZUw@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Mon, 11 Apr 2022 10:17:09 +0100
In-reply-to: <CAEemH2eh=AX6-DMW1UaVs+MGtqFXq8HoJD41D3paB93vQZ9ZUw@mail.gmail.com>
Message-ID: <87k0bwgebk.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fzsync: break inf loop with flag vs
 pthread_cancel
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
Cc: kernel-team <kernel-team@android.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Li,

Li Wang <liwang@redhat.com> writes:

> Hi Richard, Edward,
>
> On Mon, Apr 11, 2022 at 4:33 PM Richard Palethorpe <rpalethorpe@suse.de> wrote:
>  
>  > Looking at tst_fzsync_run_a, if anything goes wrong in other places
>  > (thread_b) and break with setting 'pair->exit' to 1 to end the looping. 
>  > It doesn't work for thread_a because tst_atomic_store(exit, &pair->exit)
>  > will reset it back to 0 (int exit = 0).
>
>  I don't think we have ever handled thread B breaking gracefully?
>
> Right, that exist before Edward's patch :).
>
>  
>  
>  If B breaks and it calls tst_fzsync_pair_cleanup then it will try to
>  join to itself and we will probably get EDEADLK.
>
> Exactly, maybe do something to make tst_fzsync_pair_cleanup
> avoid joining to itself when the invoke come from B?

I suppose we could save thread A or B's TID and then check it. I think
that should be in a seperate patch.

>
>   
>  > +                       tst_atomic_store(1, &pair->exit);
>  > +                       usleep(100000);
>
>  Why do we need usleep?
>
> Seems not very needed. 

+1

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
