Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F110FC4332F
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 11:19:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DEF03CBA84
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 12:19:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7487B3CBA4A
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 12:19:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 62ACF1A0089A
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 12:19:26 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 182D1377F5;
 Tue, 20 Dec 2022 11:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671535165;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7YBzdzMt3WqBeVbjaMjrKI8cqKJp8OMsHu3HtT5bF44=;
 b=1eb69OzKO8nYEKCIuVKXhqptf1fXD0W+HEWSy8XvwGU07xQDCWjJMGadkRSEqvQs4RW/bc
 11FsxtXcKL+lYzNMDSSICrMZ84YWCCGSXiBhp4KIVOBEs5p/hZ8xSqikD6StlJl1rst1fA
 +TpWlI5OKUG/7D0oV1X8cdpdXpegkGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671535165;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7YBzdzMt3WqBeVbjaMjrKI8cqKJp8OMsHu3HtT5bF44=;
 b=eVKwc7f+LpaqoYPAXl3NJZ8/ra1hCb6q1y+Dngp/BPEu3IR7V4FAdtn+4xx3eAXHnJFKpu
 ZGaoOk7+Q0PFn/DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8137A1390E;
 Tue, 20 Dec 2022 11:19:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LnUdHjyaoWMqUwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 20 Dec 2022 11:19:24 +0000
Date: Tue, 20 Dec 2022 12:19:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Y6GaNcnDTAEGaAh9@pevik>
References: <20221216094611.2924-1-pvorel@suse.cz>
 <20221216094611.2924-2-pvorel@suse.cz>
 <CAASaF6yUfeCS_MnTiYR1v291d=A0xzijDRJqz1SgGORvnCEXbg@mail.gmail.com>
 <CAEemH2d=kNwrAmrvy21Si4wF9H0qqg_Zkq=12S9ZC=11MQKFSw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2d=kNwrAmrvy21Si4wF9H0qqg_Zkq=12S9ZC=11MQKFSw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/2] doc: State the minimal kernel version
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jan =?iso-8859-2?Q?L=FCbbe?= <jlu@pengutronix.de>,
 Khem Raj <raj.khem@gmail.com>, Richard Palethorpe <rpalethorpe@suse.com>,
 ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Mon, Dec 19, 2022 at 5:52 PM Jan Stancek <jstancek@redhat.com> wrote:

> > On Fri, Dec 16, 2022 at 10:46 AM Petr Vorel <pvorel@suse.cz> wrote:

> > > Because the tested version does not automatically mean the minimal
> > > supported.

> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > > Hi all,

> > > I'm sorry to bother you, many of you concentrate on current mainline (or
> > > supported stable) instead of digging into history. But you might know
> > > about somebody who still cares about 3.x. Although not many of these
> > > people would try to run recent LTP on these old versions, but we never
> > > know.

> > > I started with 3.0 as that was the result of the old discussions over
> > > ML.  I'm perfectly ok, if we raise it to 3.10, which is tested.
> > > I guess after CentOS 7 EOL we should raise support even higher.

> > I'd be fine with raising it to 3.10, that still covers CentOS7 for now.
> > (3.10 will be 10 years old in couple months)


> +1 that's exactly!

OK, is anybody against raising the support to 3.10?

If not, I can change it:

-Minimal supported (although untested) kernel version is 3.0.
+Minimal supported kernel version is 3.10.

Kind regards,
Petr

> Reviewed-by: Li Wang <liwang@redhat.com>



> > Acked-by: Jan Stancek <jstancek@redhat.com>


> > > The motivation is to state the version here, instead in
> > > doc/c-test-api.txt

> > https://patchwork.ozlabs.org/project/ltp/patch/1671166923-2173-7-git-send-email-xuyang2018.jy@fujitsu.com/

> > > Also stating kernel version limits minimal libc version.
> > > Thus I'm not going to start a discussion about what libc version we
> > > support.

> > > Kind regards,
> > > Petr

> > >  doc/supported-kernel-libc-versions.txt | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)

> > > diff --git a/doc/supported-kernel-libc-versions.txt
> > b/doc/supported-kernel-libc-versions.txt
> > > index e48e3aeae3..f89c4882fb 100644
> > > --- a/doc/supported-kernel-libc-versions.txt
> > > +++ b/doc/supported-kernel-libc-versions.txt
> > > @@ -51,7 +51,12 @@ distribution you may as well reconsider you life
> > choices.
> > >  | s390x         | cross compilation
> > >  |==================================

> > > -1.3 Supported libc
> > > +1.3 Minimal supported kernel version
> > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > +
> > > +Minimal supported (although untested) kernel version is 3.0.
> > > +
> > > +1.4 Supported libc
> > >  ~~~~~~~~~~~~~~~~~~

> > >  [align="center",options="header"]
> > > --
> > > 2.39.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
