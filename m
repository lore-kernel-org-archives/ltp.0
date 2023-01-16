Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1220EC54EBE
	for <ltp@archiver.kernel.org>; Mon, 16 Jan 2023 16:32:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B87D3CC94D
	for <ltp@archiver.kernel.org>; Mon, 16 Jan 2023 17:32:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C49AA3CB4BE
 for <ltp@lists.linux.it>; Mon, 16 Jan 2023 17:31:56 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3ED181A000AB
 for <ltp@lists.linux.it>; Mon, 16 Jan 2023 17:31:55 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6E5F75D4CF;
 Mon, 16 Jan 2023 16:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1673886715;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KGKVvHgD54yZ/Bp8RbGr/vn0QDjA6L08JTrfz4Fzj6M=;
 b=tlHQ9fBwOWTsD046nHURBCNbwc5H7D8YF1jLgeDWBGeMotyzWXstfd98Uh0yT/F9pZLjF8
 3B7jfiaqw43sM3qWj+rVPqKReWlfb29Qs4BwM1I9JrT1DPRZ8XnkMxsT2J7CL1PF8tMvmq
 yNWOFvAcAva5MCuljlb9+tkL4kPppxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1673886715;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KGKVvHgD54yZ/Bp8RbGr/vn0QDjA6L08JTrfz4Fzj6M=;
 b=DSvurZCqzFYrCNZOr3czQ7SaX6a5UePZx8llWgrKiFQs4ov+doQLk5gUdorDSqksHJpTQg
 PNMpOwxnAw3b8aCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23E3A138FE;
 Mon, 16 Jan 2023 16:31:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dwobBvt7xWORLwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 16 Jan 2023 16:31:55 +0000
Date: Mon, 16 Jan 2023 17:31:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y8V7+U1p/Zk1LWye@pevik>
References: <Y8VRpdW7LUh4uFm9@yuki>
 <87bkmywlb7.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87bkmywlb7.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, Richie, Wei,

> Hello,

> Cyril Hrubis <chrubis@suse.cz> writes:

> > Hi!
> > It's about the time to start preparing for the LTP January release. Well
> > we should have started at least a week ago, but my family was sick and
> > nobody else seemd to start to work on that...

Thanks for remembering. Time flies + obviously nobody set any calendar event to
remember the release months.

> > Anyways let's start with listing patches that should be considered for
> > the release, looking at patchwork the queueu is nice and short so I
> > suppose there will not be many and that we can start with pre-release
> > testing now and do a git freeze at the start of the next week. Does that
> > sound reasonable?

+1

> > Also are there any volunteers for picking up various release tasks?

> > -- 
> > Cyril Hrubis
> > chrubis@suse.cz

> My fix for fcntl36/34 doesn't seem to fully work for fcntl36 on 32bit
> compat. Hopefully I can fix that before next week.

+1, thanks for working on it.

I'd like to fix tst_rhost_run.sh failing.
@Wei do you plan to fix it or shell I have look into it?

BTW the move of testcases/kernel/containers/share/ content to testcases/lib
which I suggested and we got Cyril's ack [1] is trivial, but as it's just a make
dependency fix, it can wait after the release. The test failure is what matters
more.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/Y8UubJZcN89y77AA@yuki/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
