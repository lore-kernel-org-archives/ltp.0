Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB73C7619A
	for <ltp@archiver.kernel.org>; Wed, 12 Apr 2023 07:15:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A63DB3CC4AB
	for <ltp@archiver.kernel.org>; Wed, 12 Apr 2023 09:15:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D22AD3C0041
 for <ltp@lists.linux.it>; Wed, 12 Apr 2023 09:14:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3010310006AA
 for <ltp@lists.linux.it>; Wed, 12 Apr 2023 09:14:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 035761F896;
 Wed, 12 Apr 2023 07:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1681283694;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOFbCO2QvsRGjVIbkwUWdDTNOrQjcipph+4xXKb4nHk=;
 b=RZ1cmlbyoAjJj4zpJykutWBDVWn9Zw41LA20k0t+a8AgnE4Io5bbktzknBYil7x9gyZOUR
 zccfZo+BZAYKhRwX7iA1eQllvSYko4PAxc0/fpJd+6+6ltUtcPckrqazb2eXFYqJt3xG5H
 8bTDONsHNLhDPopjflc1tpKEduiQRGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1681283694;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOFbCO2QvsRGjVIbkwUWdDTNOrQjcipph+4xXKb4nHk=;
 b=oqSDwr1faSiuosL2RxRJiWKMdQIFHI557svG+2LvjLS1A8WqRbh3qQoJhcNCCMAJZCZ98+
 7Pi2n+YSygIQMLBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6D3413498;
 Wed, 12 Apr 2023 07:14:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Eod0K21aNmRbMgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 12 Apr 2023 07:14:53 +0000
Date: Wed, 12 Apr 2023 09:14:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Daniel =?iso-8859-2?Q?D=EDaz?= <daniel.diaz@linaro.org>
Message-ID: <20230412071452.GD1949572@pevik>
References: <CA+G9fYtVXsKSbdxcTNiLc8oYRTBOZzWNQRF92daLE58NPbOkFg@mail.gmail.com>
 <96b67ae8-98dd-40fe-9dde-302e09d12551@app.fastmail.com>
 <20230406105646.GB1545779@pevik>
 <CA+G9fYs461=iJqZqKe8_iRkfsMemSSA+ByOPRc9k-kBf4Hp8og@mail.gmail.com>
 <20230411220811.GA1798729@pevik>
 <CAEUSe7_JvM8SD15DVnXOsSyPhS+sF=9JEDzV+NW2XZ=MwVMBUw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEUSe7_JvM8SD15DVnXOsSyPhS+sF=9JEDzV+NW2XZ=MwVMBUw@mail.gmail.com>
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
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hello!

> On Tue, 11 Apr 2023 at 16:08, Petr Vorel <pvorel@suse.cz> wrote:

> > > On Thu, 6 Apr 2023 at 16:26, Petr Vorel <pvorel@suse.cz> wrote:

> > > > > On Thu, Apr 6, 2023, at 11:11, Naresh Kamboju wrote:
> > > > > > Following LTP syscalls failed on the i386 and arm environments =
with
> > > > > > Linux next / mainline kernels. The userspace is coming from Open
> > > > > > Embedded kirkstone.

> > > > > Thanks for the report and summary! I went through the list and fo=
und
> > > > > that most if not all of the bugs looks like incompatibilities
> > > > > with musl, not with 32-bit. It's probably not well tested with
> > > > > musl.

> > > > > Can you try again with glibc and see if there are any remaining
> > > > > issues then? LTP should probably be fixed to work with both, but
> > > > > if nobody has done that so far, it's likely that this has come
> > > > > up in the past but ran into problems upstreaming the fixes.

> > > > > > Anyone seeing this problem on 32-bit i386 or arm ?
> > > > > > You get to see "segfault" in the following logs that have been =
noticed
> > > > > > on i386 only.

> > > > > > This is not a new problem. We have been noticing these failures=
 for a
> > > > > > really long time.
> > > > > > Would it be worth investigating the reason for failures on 32bi=
t architectures ?

> > > > > > Test logs,
> > > > > > -----
> > > > > > [    0.000000] Linux version 6.3.0-rc5-next-20230406 (tuxmake@t=
uxmake)
> > > > > > (i686-linux-gnu-gcc (Debian 11.3.0-11) 11.3.0, GNU ld (GNU Binu=
tils
> > > > > > for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC @1680759389


> > > > > > Test environment: i386
> > > > > > Suite: ltp-syscalls
> > > > > > Toolchain: gcc-11


> > > > > > fstatfs02
> > > > > > fstatfs02    1  TPASS  :  expected failure - errno =3D 9 : Bad =
file descriptor
> > > > > > fstatfs02    2  TBROK  :  tst_sig.c:232: unexpected signal SIGS=
EGV(11)
> > > > > > received (pid =3D 17841).
> > > > > > fstatfs02    3  TBROK  :  tst_sig.c:232: Remaining cases broken
> > > > This is IMHO using the old LTP API.
> > > > testcases/kernel/syscalls/fstatfs/fstatfs02.c was converted to new =
LTP API in
> > > > 5a8f89d35 ("syscalls/statfs02, fstatfs02: Convert to new API"), whi=
ch was
> > > > released in 20220930. There is already newer release 20230127.
> > > > Generally it's safer to test mainline kernel with LTP master,
> > > > but this fix has already been in the latest LTP release 20230127.
> > > > And this error has been later fixed with
> > > > 492542072 ("syscalls/statfs02, fstatfs02: Accept segfault instead o=
f EFAULT")
> > I'm sorry, I was wrong stating that unexpected signal SIGSEGV(11)
> > error was fixed by 492542072.

> > > Thanks for insite about the failed test investigations.


> > > > @Naresh which LTP do you use for testing? It must be some older LTP=
 :(.

> > > Our build system started running LTP version 20230127.
> > I'm sorry, I obviously misinterpreted the test output as old LTP code.

> No, you were right! We were running an older version and because of
> this discussion we have now updated to 20230127 in Kirkstone. This
> update from Naresh and these findings are with 20230127.

Great, thank you! Using the latest release (or git master) really saves of =
all
of us.

Kind regards,
Petr

> Thanks for looking into this! Greetings!

> Daniel D=EDaz
> daniel.diaz@linaro.org

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
