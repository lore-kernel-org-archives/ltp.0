Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE19CA9EC5
	for <ltp@archiver.kernel.org>; Sun, 11 Oct 2026 01:08:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66CE63E27E8
	for <ltp@archiver.kernel.org>; Sun, 11 Oct 2026 03:08:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B41C13E27E8
 for <ltp@lists.linux.it>; Sun, 11 Oct 2026 03:07:44 +0200 (CEST)
Received: from mta1.migadu.com (out-27.mta1.migadu.com
 [IPv6:2001:41d0:203:375::1b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C5F34600058
 for <ltp@lists.linux.it>; Sun, 11 Oct 2026 03:07:42 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=NmV4eC7fD5k116yDmSffAQ0vWWFUkprKEdoP2AckVD0=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791680862; v=1; x=1792285662;
 b=f0NYSCLftweJJ5ZBlR6ABcv0Ch+3QucO9STgiZ/IlUYWdaGDC5uc5+b8dh3o7xCYQF+M0kuw
 vZHg9pU3byfn5bgEZ2qvV3Wa9CuCLGGGYlAbdKrpg0IdWHes/kyl4vca9mwpjAi9ZwidqBzuOjL
 qIJadXs/76T6zCODI1za2kdg=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 46370832cec5e58c;
 Sun, 11 Oct 2026 01:07:42 +0000
X-Mizu-Trace-ID: 46370832cec5e58c
X-Migadu-Flow: FLOW_OUT
Date: Sun, 11 Oct 2026 09:07:37 +0800
From: Li Wang <li.wang@linux.dev>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <asrhWVwAvAYLtBM3@linux.dev>
Mail-Followup-To: Jan Stancek <jstancek@redhat.com>,
 linuxtestproject.agent@gmail.com, LTP List <ltp@lists.linux.it>
References: <24014310ac600340c4ef9720980eac1c047f4b6f.1791543115.git.jstancek@redhat.com>
 <20261009172601.34695-1-linuxtestproject.agent@gmail.com>
 <asoAKV-Wd-TK5XUe@linux.dev>
 <CAASaF6wO7=9vHVJ3BxE307tFc1n_xbJEihw1EMECsRNhxvvDHw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6wO7=9vHVJ3BxE307tFc1n_xbJEihw1EMECsRNhxvvDHw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: timers/twoevtimers: Wait for both timer signals
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
Cc: LTP List <ltp@lists.linux.it>, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > > On Fri, 9 Oct 2026, Jan Stancek via ltp wrote:
> > > > openposix: timers/twoevtimers: Wait for both timer signals
> > >
> > > > +   PTS_WRITE_MSG("Caught abort signal\n");
> > > > +   PTS_WRITE_MSG("Caught alarm signal\n");
> > > > +           if (errno != EINTR) {
> > > > +                   perror("nanosleep() did not return success\n");
> > > > +                   return PTS_UNRESOLVED;
> > > > +           }
> > >
> > > Medium: PTS_WRITE_MSG() calls write() without preserving errno. If the
> > > second signal arrives after nanosleep() sets EINTR but before the new
> > > errno check, a failed handler write (e.g. EAGAIN on a full nonblocking
> > > stdout pipe) causes a spurious unresolved result even when both timers
> > > fired. Save errno on entry and restore it before returning in both
> > > handlers.
> >
> > The race condition pointed out by the AI seems plausible. Would it make
> > sense to save and restore errno in the signal handlers, like this:
> >
> 
> It seems very unlikely. I was thinking to move the print outside of signal
> handler if we want to address it.

Agreed, moving the prints from the handlers is the better fix. 

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
