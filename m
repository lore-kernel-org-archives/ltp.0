Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C54C54EBD
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 08:13:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55D353CCA59
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 09:13:31 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 431B23C2FC4
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 09:13:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 707B02009D3
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 09:13:20 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7B2093F63C;
 Thu, 12 Jan 2023 08:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673511199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0KnDZhyZ1FJILqr6uVge5FEluREsFezu7USfEZZpv0=;
 b=tGISy0ULvc9gjkhjQ3/1sNpQkk6G/ei3yT89Wm0HWq5suYeUG6qPv9mut/7Rx6zjWRAU50
 UOU5R72ukxkTECqP1Ufoh3eUPNZ+mJS4mIMMWh6wjXF2cdSgzpdrSsvbCVRCq39FIJEL7m
 v+ufHD3qSS678wOGBlpnQ63/22R+QtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673511199;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0KnDZhyZ1FJILqr6uVge5FEluREsFezu7USfEZZpv0=;
 b=/FK/aiw9xiMsfGv3quou1o4E8x7ouYvsHFrBYZBOTI99GyRYH4E5KWZTJ07xK0kmtyZ+Jk
 nWa4aEuKfDaz5QAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74168134B3;
 Thu, 12 Jan 2023 08:13:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BDBqDR7Bv2OUaQAAMHmgww
 (envelope-from <akumar@suse.de>); Thu, 12 Jan 2023 08:13:18 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Jan 2023 13:43:15 +0530
Message-ID: <2775880.erAxF3upz8@localhost>
Organization: SUSE
In-Reply-To: <Y79O1AlWHL5SD/zJ@pevik>
References: <20230111141616.20011-1-akumar@suse.de> <Y79O1AlWHL5SD/zJ@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] c-test-tutorial-simple.txt: improve documentation
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On Thursday, January 12, 2023 5:35:40 AM IST Petr Vorel wrote:
> Hi Avinesh,
> 
> > Signed-off-by: Avinesh Kumar <akumar@suse.de>
> > ---
> >  doc/c-test-tutorial-simple.txt | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> > diff --git a/doc/c-test-tutorial-simple.txt b/doc/c-test-tutorial-simple.txt
> > index 89b0ad4e7..c5861cb36 100644
> > --- a/doc/c-test-tutorial-simple.txt
> > +++ b/doc/c-test-tutorial-simple.txt
> > @@ -333,16 +333,16 @@ call in the +*.in+ files (e.g. +x86_64.in+) which are used to generate
> >  may find the system call number is missing from the +*.in+ files and will need
> >  to add it (see +include/lapi/syscalls/strip_syscall.awk+).
> 
> > -System call numbers vary between architectures, hence why there are multiple
> > +System call numbers vary between architectures, hence there are multiple
> >  +*.in+ files for each architecture. You can find the various values for the
> > -+statx+ system call across a number of +uinstd.h+ files in the Linux kernel.
> > ++statx+ system call across a number of +unistd.h+ files in the Linux kernel.
> 
> >  Note that we don't use the system-call-identifier value available in
> > -+/usr/include/linux/uinstd.h+ because the kernel might be much newer than the
> > ++/include/uapi/linux/unistd.h+ because the kernel might be much newer than the
> NOTE: /include/uapi/linux/unistd.h does not exists. include/uapi/linux/unistd.h
> is relative path in kernel git tree. The same file exists as
> /usr/include/linux/unistd.h as part of kernel headers distro package.
> 
> I'd prefer to keep /usr/include/linux/unistd.h as a real path.
Thank you for your review and correcting this.

> 
> The other changes are good. Thank you for carefully reading docs and fixing
> them!
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Kind regards,
> Petr
> 
> >  user land development packages.
> 
> > -For +statx+ we had to add +statx 332+ to +testcases/kernel/include/x86_64.in+,
> > -+statx 383+ to +testcases/kernel/include/powerpc.in+, etc.  Now lets look at
> > +For +statx+ we had to add +statx 332+ to +include/lapi/syscalls/x86_64.in+,
> > ++statx 383+ to +include/lapi/syscalls/powerpc.in+, etc.  Now lets look at
> >  the code, which I will explain in more detail further down.
> 
> >  [source,c]
> > @@ -1007,7 +1007,7 @@ We can then send this patch with the following command sans +--dry-run+.
> >  $ git send-email --dry-run output/v2-0001-tutorial-Add-a-step-by-step-C-test-tutorial.patch
> >  --------------------------------------------------------------------------------
> 
> > -Git will ask some questions (which you an ignore) and then tell you what it
> > +Git will ask some questions (which you can ignore) and then tell you what it
> >  would do if this weren't a dry-run. In order for this to work you have to have
> >  a valid SMTP server set in +.gitconfig+ and also be signed up to the LTP
> >  mailing list under the same e-mail address you have configured in Git. You can
> 

Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
