Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD99CC433EF
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 14:20:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD36F3CAA01
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 16:20:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC3B13CA588
 for <ltp@lists.linux.it>; Fri, 13 May 2022 16:20:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8956D1000484
 for <ltp@lists.linux.it>; Fri, 13 May 2022 16:20:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 91BC321B77;
 Fri, 13 May 2022 14:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652451622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=06c/PV8gXOfZhoWFnHHK9uRsj3RQ4DaQxq778cUfUEs=;
 b=mJFyD9pE9j89Ch5kOJo4inZbD54J0/K3il9UcG54a/3XUpclnYsle2nSj6fCTdbMVRVEM2
 4Z6IT5+mvNkrUd5bETPqjfvGAXErlQaZ6ad6d1CObZk5MMt7M6wUUEAnGlWFX/Q22r9zAB
 j6rkRU2F9Hk41cuLiN5zN1EqWIyp2fQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652451622;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=06c/PV8gXOfZhoWFnHHK9uRsj3RQ4DaQxq778cUfUEs=;
 b=fH5qGfcvaP18wdRGUskehJcCm9btk8/y/QXoETxEgRwPPNkpXE1+V4jpfzd6HfAkLGfYId
 q9n23BziBbsBceCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7EE9C13A84;
 Fri, 13 May 2022 14:20:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id a2A0HSZpfmJ4CAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 13 May 2022 14:20:22 +0000
Date: Fri, 13 May 2022 16:22:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Yn5prUjpZEUjoxbL@yuki>
References: <20220512123816.24399-1-chrubis@suse.cz>
 <20220512123816.24399-23-chrubis@suse.cz>
 <CAEemH2dAfUEjA877h0Lwy9Qw12YgQ6zgQbf1BJemyr7=xfj0Rg@mail.gmail.com>
 <Yn5NGPpfoddFYTs2@yuki>
 <CAEemH2fHsa+JECK5dW64-coQBwdGR3W9W+jKex8zRmKzfLX1=w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fHsa+JECK5dW64-coQBwdGR3W9W+jKex8zRmKzfLX1=w@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 22/29] fuzzy_sync: Convert to runtime
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > I hit a new problem while testing new pty03, that seems here
> > > will fall into an infinite loop and test timed out finally. The printf
> > > shows rem_p will be overflow I haven't figured out why.
> > >
> > > But with comparing with 0.9, it always gets passed on to the same system.
> >
> > That is strange, since we do:
> >
> >         rem_p = 1 - tst_remaining_runtime()/pair->time_exec_start;
> >
> 
> I guess the root cause is that 'pair->time_exec_start' has a possibility
> to reach zero. in pty03 it has ".tcnt = 9" which made the
> tst_fzsync_pair_reset()
> to be re-run many times, but in that function 'pair->time_exec_start' will
> be set only based on the original .max_runtime, with time elapsed the
> remaining time tends to be zero.

I guess that that the interaction of tcnt and runtime is not optimal
here. You are right that as long as we call tst_fzsync_pair_reset() on
each invocation of the run() function we may eventually get to state
where the runtime is exhausted, especially on slower hardware we end up
with division by zero and overflow.

The cleanest solution would be to rewrite the test to use .test_variants = 9
and setting the .max_runtime to a smaller value. That way we would have
precisely defined runtime for each iteration. What do you think?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
