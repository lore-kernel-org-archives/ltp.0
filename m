Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20374C4332F
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 04:58:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 180733C6C93
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 05:58:34 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B5963C1B40
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 05:58:18 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8DDFB140042E
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 05:58:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671512295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vQvXuT6GUOv57412JdH7WvIOst7XDKysgJRBD3LlnG4=;
 b=JELdpEM+gyneFmOlonfTWunIrTQ+wi+cWx+kwu0lCMW/4HVz2sLZcW0HbWkLdyVr1ZgRy2
 0XhcyWG5hjGWtkCUg8usLYPkOfL2Nreb39HINq8sz/a60ZzEhfmZ+hFR51Rea93LTCsl4O
 UOer54ZKy0rTQYKE3i91O1VZW67GC+M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-379-iIDRQapdNXKRQ3tbxgSDxA-1; Mon, 19 Dec 2022 23:58:14 -0500
X-MC-Unique: iIDRQapdNXKRQ3tbxgSDxA-1
Received: by mail-wm1-f70.google.com with SMTP id
 f20-20020a7bc8d4000000b003d1cda5bd6fso2201398wml.9
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 20:58:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vQvXuT6GUOv57412JdH7WvIOst7XDKysgJRBD3LlnG4=;
 b=A3+XcvZv63bOwyjjmYrgmZ34YpCIW3yNlP54/tdKd3ASfvkAMZTrQJrTjVMvhfKwH9
 akpjwHBymmUgiwwSQLsMbalbivIgzy9X7F66Ws1D4FaHEmvb1jJJKSkLA5qgl7nam5xf
 TYHcms8iZikv7dk4TXe3jo5imnWDgiMQrUjGkq1odlnkszDRabyYERxo/AtS4IENuJkn
 tqf7J52mc1/i95TKMuEwFrv/cfozdjbSKHXCufL0H/Il15ZPcLy7byxanVuVKNTZ2Uqh
 Sa6CVur6JGpSFH8xBNbfHK4pQek9e5NryhuhKT5kte9qWnuDBSKGw9IhND5VUXNhZnIX
 oIwA==
X-Gm-Message-State: ANoB5pkZt83gW/UXFxIrbo+DFcxGWY0icXvvxbElNvkGnl6dGQClAqH+
 Az5eQoFCb2OP+4xvSQeAE1LyMdbv/yClcebBrCLi8xebc3MAf+EdqYhOY1mY9etjhfnUUH//+Ry
 +vUKczgcDzpQtFEGzBTXjoWhmkfg=
X-Received: by 2002:a1c:7717:0:b0:3d1:de6e:8afb with SMTP id
 t23-20020a1c7717000000b003d1de6e8afbmr1597782wmi.92.1671512292593; 
 Mon, 19 Dec 2022 20:58:12 -0800 (PST)
X-Google-Smtp-Source: AA0mqf78vY22xNmTm/9eiNlR8eCW+lwpqaouWDP3b+k+KxI4U8efyIZHBfo/IiOUz19OU5sW/N20+37cxZXUZNojllY=
X-Received: by 2002:a1c:7717:0:b0:3d1:de6e:8afb with SMTP id
 t23-20020a1c7717000000b003d1de6e8afbmr1597780wmi.92.1671512292221; Mon, 19
 Dec 2022 20:58:12 -0800 (PST)
MIME-Version: 1.0
References: <20221216094611.2924-1-pvorel@suse.cz>
 <20221216094611.2924-2-pvorel@suse.cz>
 <CAASaF6yUfeCS_MnTiYR1v291d=A0xzijDRJqz1SgGORvnCEXbg@mail.gmail.com>
In-Reply-To: <CAASaF6yUfeCS_MnTiYR1v291d=A0xzijDRJqz1SgGORvnCEXbg@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 20 Dec 2022 12:58:01 +0800
Message-ID: <CAEemH2d=kNwrAmrvy21Si4wF9H0qqg_Zkq=12S9ZC=11MQKFSw@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>, Khem Raj <raj.khem@gmail.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Dec 19, 2022 at 5:52 PM Jan Stancek <jstancek@redhat.com> wrote:

> On Fri, Dec 16, 2022 at 10:46 AM Petr Vorel <pvorel@suse.cz> wrote:
> >
> > Because the tested version does not automatically mean the minimal
> > supported.
> >
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi all,
> >
> > I'm sorry to bother you, many of you concentrate on current mainline (or
> > supported stable) instead of digging into history. But you might know
> > about somebody who still cares about 3.x. Although not many of these
> > people would try to run recent LTP on these old versions, but we never
> > know.
> >
> > I started with 3.0 as that was the result of the old discussions over
> > ML.  I'm perfectly ok, if we raise it to 3.10, which is tested.
> > I guess after CentOS 7 EOL we should raise support even higher.
>
> I'd be fine with raising it to 3.10, that still covers CentOS7 for now.
> (3.10 will be 10 years old in couple months)
>

+1 that's exactly!

Reviewed-by: Li Wang <liwang@redhat.com>


>
> Acked-by: Jan Stancek <jstancek@redhat.com>
>
> >
> > The motivation is to state the version here, instead in
> > doc/c-test-api.txt
> >
> https://patchwork.ozlabs.org/project/ltp/patch/1671166923-2173-7-git-send-email-xuyang2018.jy@fujitsu.com/
> >
> > Also stating kernel version limits minimal libc version.
> > Thus I'm not going to start a discussion about what libc version we
> > support.
> >
> > Kind regards,
> > Petr
> >
> >  doc/supported-kernel-libc-versions.txt | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/doc/supported-kernel-libc-versions.txt
> b/doc/supported-kernel-libc-versions.txt
> > index e48e3aeae3..f89c4882fb 100644
> > --- a/doc/supported-kernel-libc-versions.txt
> > +++ b/doc/supported-kernel-libc-versions.txt
> > @@ -51,7 +51,12 @@ distribution you may as well reconsider you life
> choices.
> >  | s390x         | cross compilation
> >  |==================================
> >
> > -1.3 Supported libc
> > +1.3 Minimal supported kernel version
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +Minimal supported (although untested) kernel version is 3.0.
> > +
> > +1.4 Supported libc
> >  ~~~~~~~~~~~~~~~~~~
> >
> >  [align="center",options="header"]
> > --
> > 2.39.0
> >
>
>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
