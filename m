Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6056C433F5
	for <ltp@archiver.kernel.org>; Fri,  8 Apr 2022 07:58:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E9793CA4F9
	for <ltp@archiver.kernel.org>; Fri,  8 Apr 2022 09:58:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BAE53CA4DC
 for <ltp@lists.linux.it>; Fri,  8 Apr 2022 09:57:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9C5FF600BCB
 for <ltp@lists.linux.it>; Fri,  8 Apr 2022 09:57:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4FD41215FE;
 Fri,  8 Apr 2022 07:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1649404667;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yMdabuL9t38VjM2E3r8kotZA7W39PXBxP3yvgSy0Qy0=;
 b=ZxZiI/hK9TExvZkvXBMf775crVTJkPt4otOllPDx+A6ZSw44Wpxg6TuiUXEW8jSbg+zcn+
 0VsMBoydJGy0toi+kQIFdsopZXV2M9dAuqKbMTaQiH1Wj0MWlpzNKoLQfdWuGUowpjwSC3
 VW6tjNQ6CzKX2IMUqKfJLpA5ooAHlgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1649404667;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yMdabuL9t38VjM2E3r8kotZA7W39PXBxP3yvgSy0Qy0=;
 b=S+HsAd67h+gcsNlgxdeT4sHZckS7YcQihGjOcD+obyESO7c9I+JPXZFjbiSfQeXs9qv21f
 YEqg7DUJUZFU0UAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E54DA13AA9;
 Fri,  8 Apr 2022 07:57:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Uq2bNvrqT2JYHgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 08 Apr 2022 07:57:46 +0000
Date: Fri, 8 Apr 2022 09:57:44 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Yk/q+G8biLcjpnhX@pevik>
References: <20220328114921.182315-1-zhaogongyi@huawei.com>
 <YkxNEjvaLAsWZSaq@pevik>
 <CAEemH2e4WMF98j7auOJZd8+YhKk69bZ63+sLURFLNpq6qUeCRA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e4WMF98j7auOJZd8+YhKk69bZ63+sLURFLNpq6qUeCRA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] io_submit01/io_submit02: Bugfix for running with
 the option "-i"
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Martin Doucha <martin.doucha@suse.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Tue, Apr 5, 2022 at 10:08 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi all,

> > > For io_submit01, add io_destroy before test return, or the test
> > > would fail and report EAGAIN.
> > > For io_submit02, move the io_destroy to the suitable location, or
> > > the test would fail and report EAGAIN.

> > $ ./io_submit01 -i150
> > ...
> > io_submit01.c:122: TPASS: io_submit() with NULL iocb pointers failed with
> > EFAULT
> > io_submit01.c:127: TFAIL: io_submit() returned -11(EAGAIN/EWOULDBLOCK),
> > expected EBADF(-9)
> > io_submit01.c:127: TFAIL: io_submit() returned -11(EAGAIN/EWOULDBLOCK),
> > expected EBADF(-9)
> > io_submit01.c:127: TFAIL: io_submit() returned -11(EAGAIN/EWOULDBLOCK),
> > expected EBADF(-9)
> > io_submit01.c:127: TFAIL: io_submit() returned -11(EAGAIN/EWOULDBLOCK),
> > expected SUCCESS(1)

> > $ ./io_submit02 -i150
> > ...
> > io_submit02.c:76: TPASS: io_submit() returns 0 if nr is zero
> > io_submit02.c:78: TFAIL: io_submit() returns -1, expected 1

> > @Cyril, Li, Martin, Viresh: while this fix is valid using memset() (which
> > is required)
> > slows down testing a lot. Any idea whether this can be avoid to keep the
> > speed?


> It would not be a serious problem if only execute the test once,
> I'm wondering if it really necessary to rerun many times(i.e. 150)?
Hi Li,

I guess for stressing particular subsystem can be useful to run some test many
times (but I don't personally do it).

Sure, we could limit test to run only few times (e.g. < 50).

> BTW, the patch generally looks good to me.
+1

Let's wait for other input.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
