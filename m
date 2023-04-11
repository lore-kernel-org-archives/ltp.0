Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F5CC7619A
	for <ltp@archiver.kernel.org>; Tue, 11 Apr 2023 22:08:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBF123CC9A2
	for <ltp@archiver.kernel.org>; Wed, 12 Apr 2023 00:08:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEE073C0162
 for <ltp@lists.linux.it>; Wed, 12 Apr 2023 00:08:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 22DD4100055B
 for <ltp@lists.linux.it>; Wed, 12 Apr 2023 00:08:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DD5831F74C;
 Tue, 11 Apr 2023 22:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1681250892;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L/XjSc44gwG+nuE0NrNWNRHKpYqRY6i/VDLJHWflJa0=;
 b=nopzy3baTfU9VDTbbEVM85Fa105wcPZ5uvMV5OmwvqnxLv3cnT80UFP7EyYuEjyT3Vzy5/
 kQR3iNlCgf3Ex54h+kZK6WtxpEnelOc4KTGDIwI6k+mnGREbg6XAiRr2NvI7djuCOF9Wv5
 xcdEK++37tZuWWWqi7/zxyFnfXnd4bA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1681250892;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L/XjSc44gwG+nuE0NrNWNRHKpYqRY6i/VDLJHWflJa0=;
 b=uF5k3OzYwEkJqEKMm/E/E5LbQ8NCt9CBWVvDN9l1zf5FrFaBnANjYsmswK2/pjLOP4Tn94
 eiHYut3yEcLDeTAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9472013638;
 Tue, 11 Apr 2023 22:08:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jV4kI0zaNWQ3OAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 11 Apr 2023 22:08:12 +0000
Date: Wed, 12 Apr 2023 00:08:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <20230411220811.GA1798729@pevik>
References: <CA+G9fYtVXsKSbdxcTNiLc8oYRTBOZzWNQRF92daLE58NPbOkFg@mail.gmail.com>
 <96b67ae8-98dd-40fe-9dde-302e09d12551@app.fastmail.com>
 <20230406105646.GB1545779@pevik>
 <CA+G9fYs461=iJqZqKe8_iRkfsMemSSA+ByOPRc9k-kBf4Hp8og@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYs461=iJqZqKe8_iRkfsMemSSA+ByOPRc9k-kBf4Hp8og@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP: list of failures on 32bit and compat mode
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
Cc: Benjamin Copeland <ben.copeland@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 llvm@lists.linux.dev, open list <linux-kernel@vger.kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Thu, 6 Apr 2023 at 16:26, Petr Vorel <pvorel@suse.cz> wrote:

> > > On Thu, Apr 6, 2023, at 11:11, Naresh Kamboju wrote:
> > > > Following LTP syscalls failed on the i386 and arm environments with
> > > > Linux next / mainline kernels. The userspace is coming from Open
> > > > Embedded kirkstone.

> > > Thanks for the report and summary! I went through the list and found
> > > that most if not all of the bugs looks like incompatibilities
> > > with musl, not with 32-bit. It's probably not well tested with
> > > musl.

> > > Can you try again with glibc and see if there are any remaining
> > > issues then? LTP should probably be fixed to work with both, but
> > > if nobody has done that so far, it's likely that this has come
> > > up in the past but ran into problems upstreaming the fixes.

> > > > Anyone seeing this problem on 32-bit i386 or arm ?
> > > > You get to see "segfault" in the following logs that have been noticed
> > > > on i386 only.

> > > > This is not a new problem. We have been noticing these failures for a
> > > > really long time.
> > > > Would it be worth investigating the reason for failures on 32bit architectures ?

> > > > Test logs,
> > > > -----
> > > > [    0.000000] Linux version 6.3.0-rc5-next-20230406 (tuxmake@tuxmake)
> > > > (i686-linux-gnu-gcc (Debian 11.3.0-11) 11.3.0, GNU ld (GNU Binutils
> > > > for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC @1680759389


> > > > Test environment: i386
> > > > Suite: ltp-syscalls
> > > > Toolchain: gcc-11


> > > > fstatfs02
> > > > fstatfs02    1  TPASS  :  expected failure - errno = 9 : Bad file descriptor
> > > > fstatfs02    2  TBROK  :  tst_sig.c:232: unexpected signal SIGSEGV(11)
> > > > received (pid = 17841).
> > > > fstatfs02    3  TBROK  :  tst_sig.c:232: Remaining cases broken
> > This is IMHO using the old LTP API.
> > testcases/kernel/syscalls/fstatfs/fstatfs02.c was converted to new LTP API in
> > 5a8f89d35 ("syscalls/statfs02, fstatfs02: Convert to new API"), which was
> > released in 20220930. There is already newer release 20230127.
> > Generally it's safer to test mainline kernel with LTP master,
> > but this fix has already been in the latest LTP release 20230127.
> > And this error has been later fixed with
> > 492542072 ("syscalls/statfs02, fstatfs02: Accept segfault instead of EFAULT")
I'm sorry, I was wrong stating that unexpected signal SIGSEGV(11)
error was fixed by 492542072.

> Thanks for insite about the failed test investigations.


> > @Naresh which LTP do you use for testing? It must be some older LTP :(.

> Our build system started running LTP version 20230127.
I'm sorry, I obviously misinterpreted the test output as old LTP code.

> I will keep you posted with the latest findings.
Thanks!

Kind regards,
Petr

> - Naresh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
