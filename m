Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3810C433F5
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 07:24:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80B863C964B
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 08:24:32 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4329A3C9506
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 08:24:22 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8801A60044E
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 08:24:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642490659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zmYkPiM7+xnnKuiYFSA7s6HCbWMZOtEuP2cXxBfnTU8=;
 b=VEB505hqj2/I5/ulDF/4lZvUibv2pRxT2ASRNA/+HLyVdWSCXbBI/aqYuCC9y0EKwhIQeU
 kUoo+mbxuD5Ecv5gGWnGkeHhkXFVACckR/j63L/AxhxSKpu5vaBEqo1ntkg8Rr34y34p71
 uE7f2nKykoKUTxJuB5pISk6zgdmhjxw=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-46CXiO5gMWyVpkKaUfbRiw-1; Tue, 18 Jan 2022 02:24:18 -0500
X-MC-Unique: 46CXiO5gMWyVpkKaUfbRiw-1
Received: by mail-yb1-f199.google.com with SMTP id
 s38-20020a252d66000000b0061291f9e395so3323950ybe.15
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 23:24:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zmYkPiM7+xnnKuiYFSA7s6HCbWMZOtEuP2cXxBfnTU8=;
 b=0ug2Ynifm+8AkP19LOX1u80Apufx6NDnnDkGyzO2Z9ERXOxnZAaOYUjekwZiBXuMJj
 5gJxjHth/mWbK+4QGdzHYFN8H7EaaSSJFcBKIbWKaTxQIzlRSGbLXPt2GxirW7i2G98H
 cPDpxuDQm9lfmrRWjVJZSRSHvOC7uPRbIVNU3efwfGygZS6aETfeShwNfa7EszBEpz2+
 Z2qPkUp1UNB94JpqFwo+nbQHWHfKdmA9Wr4d/pcK/wIc1NWGx8kX2UMEpu5j8MNd1IiH
 8eQMP5CP0yJVBtrBQwZar3nx3WiCoimip5kTvvm9ZUTd8PMtP8AVXNsKRow36pmrv0NW
 j/EQ==
X-Gm-Message-State: AOAM5321TSTmWE4zByZFCXmohpJvNebbQcZxOdoniSAP9ru5uN5fpQQK
 ci+kS62U4NLa08TqczuD5gge87MgkOD7KPp4R/Q01LvJB6Xarhwh+nKa3NnbBtHSCjL9nvasMLu
 ggpdIikGPA5JGqDcHdMUoT8NfF5E=
X-Received: by 2002:a25:388a:: with SMTP id
 f132mr32136686yba.102.1642490657595; 
 Mon, 17 Jan 2022 23:24:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzduiNyBOABqxasRYeU3rXYAsk2ibkr2Q5/b8MFia0wHI9Sb4Wfnn7T310WXobZpwwBm/8kvIIVWEFU5p6hZbs=
X-Received: by 2002:a25:388a:: with SMTP id
 f132mr32136670yba.102.1642490657368; 
 Mon, 17 Jan 2022 23:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20220114210034.16177-1-pvorel@suse.cz>
 <CAEemH2ddzfJ48prJTejCBq-=u4O-w0ENR27A_DjUo_OsqShCow@mail.gmail.com>
 <CAEemH2cMpFUz1nzq6DDfe+S-bYam3fYvb8ci=hfXHkjbfxbkeQ@mail.gmail.com>
 <YeUxCq4rsLX98E3d@pevik>
In-Reply-To: <YeUxCq4rsLX98E3d@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Jan 2022 15:24:04 +0800
Message-ID: <CAEemH2eLo7BF5+WuQS8jerbQc6Dzcg4quQK6=HC_7KsrQZXbQQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] utime03.c: Fix filesystem name
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Jan 17, 2022 at 5:04 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Li, Cyril,
>
> > > > +++ b/testcases/kernel/syscalls/utime/utime03.c
> > > > @@ -93,7 +93,7 @@ static struct tst_test test = {
> > > >         .mntpoint = MNTPOINT,
> > > >         .all_filesystems = 1,
> > > >         .skip_filesystems = (const char *const[]) {
> > > > -               "v9",
> > > > +               "9p",
>
> > > I'm wondering does it really take effect with whatever "v9" or "9p"?
> > > Because the fs_type_whitelist[] does not include any of them.
> +1. Do we want to add 9p to fs_type_whitelist[]? I suppose not, because (despite

I agree with you, as 9p is not a widely used filesystem for Linux distribution.

> of the name containing "whitelist" it's the list of filesystems actually being
> tested - this is a bit confusing to me).

Yes, it is actually the filesystem list that LTP will be tested on.
or maybe rename it to better understand.

>
> > Unless removing the .all_filesystems as well otherwise, it is impossible
> > has a chance to test on 9p.
> Yep. I forgot that .skip_filesystems works also on single fs.
> So correct entry in .skip_filesystems is kind of documentation in case of
> .all_filesystems being removed. I guess we should just remove the entry.

Sorry, what does that 'remove the entry' mean? I didn't catch your point here.

--
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
