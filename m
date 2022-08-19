Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3850AC25B0E
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 09:19:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03A4D3CA255
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 11:19:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67D253C010E
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 11:19:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 801821400C58
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 11:19:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A32CE5C574;
 Fri, 19 Aug 2022 09:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660900770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KbDtE+yTgDSgF+cN9godYCbSHzCQG/u+odLcYAsCdmY=;
 b=aVubg9LFBW2zWHvlCtZGqtlWdlZhBOfi+XgUuPn8wmVVp8pBBM3FTDAxNqCsrjAxgxfKGD
 Z8Zl/xK94dpXwg+X9EVM6h8jbr8Oh65NZOijKINsu5IUzbYHwAELnMhHv/OT7XZvtiZqFk
 QwViGkgVwNe6w4OFR2W5WzY6ErUaftg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660900770;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KbDtE+yTgDSgF+cN9godYCbSHzCQG/u+odLcYAsCdmY=;
 b=scD3Pz9HcM1eFDda/Xz/IP2weNeis0mIrzN/1YMKwwNaJ1BQ2MgYI1ye0mvTqj/5FUjXEc
 M0Jj5ytqrpiQE6DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D76E13AC1;
 Fri, 19 Aug 2022 09:19:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pbKpHaJV/2JoegAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 19 Aug 2022 09:19:30 +0000
Date: Fri, 19 Aug 2022 11:21:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Joerg.Vehlow@aox.de
Message-ID: <Yv9WF+Wri0M4GBQ9@yuki>
References: <CAG4es9XhZ7ksvLxwRNO73FC4DQc7KteUQAUPwipbks6kGsvFmw@mail.gmail.com>
 <YvUhZ/9Yf7eZ4a32@yuki> <YvuRAR1DSi67PDzh@pevik>
 <CAG4es9XdXgmPOQK3i+FL3VD-Y8C39sAShwdM6bi7U-CJjk7BQg@mail.gmail.com>
 <YvyxCXTGYpLd8kbQ@pevik>
 <CAG4es9XkRDYnwDr9huepzGhEiHxWdu40DOK9ouA2yWGqv842ow@mail.gmail.com>
 <CAG4es9WmHd52fmjdt7RBkSXEtnGuC2jkBO6UdCTbaHOq8CDgVw@mail.gmail.com>
 <Yv9F8MnPGyLLE0Zm@pevik> <Yv9Msztwn77epwCP@yuki>
 <18f40cb4-1641-4f96-4b0c-85bee0df9e1f@jv-coder.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <18f40cb4-1641-4f96-4b0c-85bee0df9e1f@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] syscalls/signal06: add volatile to loop
 variable
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
Cc: kernel-team <kernel-team@android.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > It's problem with the inline assembly in the body of the while loop, the
> > call to the syscall changes the register value that is used for the D
> > variable in the case of clang, so the loop exits prematurely. We have to
> > add cx register to the clobber list for that asm statement so that
> > compiler knows that it's changed by the assembly.
> > 
> > Interfacing assembly with C is a bit tricky since you have to explain
> > to compiler which registers are changed from the assembly otherwise the
> > results are undefined.
> > 
> > The patch should look like:
> > 
> > diff --git a/testcases/kernel/syscalls/signal/signal06.c b/testcases/kernel/syscalls/signal/signal06.c
> > index 64f886ee3..78efd0fb9 100644
> > --- a/testcases/kernel/syscalls/signal/signal06.c
> > +++ b/testcases/kernel/syscalls/signal/signal06.c
> > @@ -73,7 +73,7 @@ void test(void)
> >                 /* sys_tkill(pid, SIGHUP); asm to avoid save/reload
> >                  * fp regs around c call */
> >                 asm ("" : : "a"(__NR_tkill), "D"(pid), "S"(SIGHUP));
> > -               asm ("syscall" : : : "ax");
> > +               asm ("syscall" : : : "ax", "cx");
> Why is this even split up into two asm instructions?
> I guess there is nothing, that prevents the compiler from reordering the
> asm instructions, because it does not know, that they have side effects
> (they are not marked volatile).
> 
> asm volatile ("syscall" : : "a"(__NR_tkill), "D"(pid), "S"(SIGHUP):
> "rax", "rcx", "r11");
> 
> 
> I am not sure if there is any good reason, to split this up into two asm
> instructions and if there is a good reason, to use the short names of
> the registers.

I was wondering too, I guess it's a direct copy of a reproducer from a
kernel commit see:

https://lore.kernel.org/lkml/1414436240-13879-8-git-send-email-kamal@canonical.com/

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
