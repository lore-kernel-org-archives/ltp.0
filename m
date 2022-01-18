Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49499C433EF
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 09:12:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD4C23C9662
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 10:12:29 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 802313C732F
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 10:12:19 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 801652000DE
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 10:12:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642497137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aGuNamoG43ggz4QGBCiLniWAjcDx65er5JoAzICxyjI=;
 b=XqRw14atJPUrgTulxWiHtqYhtwkY5kGBy+UKpEA/Zo/X476awZ6mesF1NMht8fPtybiseT
 gZFohKlwofVpj7Qoafod7nEBwrRvrHKS2lLgje8GLzLGbfLzkrhwITjfmxINzrq961RZ/I
 zm5fXu4LVC8oTXZ0ow9oPhZ69VfVh0o=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-d4wOFzW2MQSGLeCptUEFVg-1; Tue, 18 Jan 2022 04:12:15 -0500
X-MC-Unique: d4wOFzW2MQSGLeCptUEFVg-1
Received: by mail-yb1-f197.google.com with SMTP id
 a62-20020a25ca41000000b00612ba8ecfcdso2259757ybg.17
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 01:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aGuNamoG43ggz4QGBCiLniWAjcDx65er5JoAzICxyjI=;
 b=f07/2NNXbNKljrit+fX+oHOnPM6jv15exC5q9xktbEipSSaqHGVNcGGkc0R4FPTUmt
 Y6puhEdJ7CDlCEQksELiYF8HW+oa/M+glrBK0TnGHI8oU8BDBiNH41CrW6Gl3koOeWjQ
 A+KeSq/PJs9uMQ+7/hiW0HhOQq1JJc/jrXBZXeVtmsDJLBGVNgJttEZi0RmebA8mmWFT
 0qfNCwnGGLVnKd9ZWzxfLdY2nH+ZqTj3+6Tq0CRpUqng3pHfUaefsD3P5d/6RNe8+j2c
 opQsGJDEvi9LsOiibmpzvQJwmsWc93d9W7gyW+o0df4W9N4P0utvbFPyePPRb1G9VRKA
 a/bw==
X-Gm-Message-State: AOAM532Gak0BiD2KVkVvMwcJFeKJvkTgv6nbbGS73LUutptCFz9TYPQh
 WCLQfapxgV8HLahL6hKufXq9FL4VoEIm7cytBlnoKw6WL1qojTa9gnqjXGiJUpVf+Bhg8ZTj++J
 ZTFiRqz64Pi9UvOqSqLJUgjVrwHw=
X-Received: by 2002:a25:f90d:: with SMTP id q13mr32560567ybe.32.1642497135138; 
 Tue, 18 Jan 2022 01:12:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFEgfnKMNHwqm+WC+dqaZEmsd8mZ5US3EZspI2yVIKxOVyHBe5Tb928Ecoww7lCzFeaWrY3DuPtYFZuWbTFWg=
X-Received: by 2002:a25:f90d:: with SMTP id q13mr32560541ybe.32.1642497134900; 
 Tue, 18 Jan 2022 01:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20220114210034.16177-1-pvorel@suse.cz>
 <CAEemH2ddzfJ48prJTejCBq-=u4O-w0ENR27A_DjUo_OsqShCow@mail.gmail.com>
 <CAEemH2cMpFUz1nzq6DDfe+S-bYam3fYvb8ci=hfXHkjbfxbkeQ@mail.gmail.com>
 <YeUxCq4rsLX98E3d@pevik>
 <CAEemH2eLo7BF5+WuQS8jerbQc6Dzcg4quQK6=HC_7KsrQZXbQQ@mail.gmail.com>
 <YeaB+smLnVt9voPy@pevik>
In-Reply-To: <YeaB+smLnVt9voPy@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Jan 2022 17:11:58 +0800
Message-ID: <CAEemH2fNfFes-eUtiQKX9JJxqEQUQ+O5nWQM8G-yNyTo8sxviw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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

On Tue, Jan 18, 2022 at 5:01 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi all,
>
> > On Mon, Jan 17, 2022 at 5:04 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> > > Hi Li, Cyril,
>
> > > > > > +++ b/testcases/kernel/syscalls/utime/utime03.c
> > > > > > @@ -93,7 +93,7 @@ static struct tst_test test = {
> > > > > >         .mntpoint = MNTPOINT,
> > > > > >         .all_filesystems = 1,
> > > > > >         .skip_filesystems = (const char *const[]) {
> > > > > > -               "v9",
> > > > > > +               "9p",
>
> > > > > I'm wondering does it really take effect with whatever "v9" or "9p"?
> > > > > Because the fs_type_whitelist[] does not include any of them.
> > > +1. Do we want to add 9p to fs_type_whitelist[]? I suppose not, because (despite
>
> > I agree with you, as 9p is not a widely used filesystem for Linux distribution.
>
> > > of the name containing "whitelist" it's the list of filesystems actually being
> > > tested - this is a bit confusing to me).
>
> > Yes, it is actually the filesystem list that LTP will be tested on.
> > or maybe rename it to better understand.
> +1. I'll try to send patch after release.
>
>
> > > > Unless removing the .all_filesystems as well otherwise, it is impossible
> > > > has a chance to test on 9p.
> > > Yep. I forgot that .skip_filesystems works also on single fs.
> > > So correct entry in .skip_filesystems is kind of documentation in case of
> > > .all_filesystems being removed. I guess we should just remove the entry.
>
> > Sorry, what does that 'remove the entry' mean? I didn't catch your point here.
> As you pointed out it does not have any effect now to whitelist 9p.
> It's kind of documentation. Maybe instead of fixing the line we should remove it
> and put a comment above.

Ah sure, I'm fine with that quick fix (before the new release)
unless Cyril has additional comments.

>
>         /* NOTE: also does not work on 9p */
>         .skip_filesystems = (const char *const[]) {
>                 "vfat",
>                 "exfat",
>                 NULL
>         }
>
> Obviously the best would be to recheck if the limitation still exists,
> because whole problem is 10 years old: it was added
> bc5da68248cc963e17862b7a0c556409c29c763e in 2011 by Cyril:

Agree, we can leave this more time to rethink that.

>
>     The functional tests for utime checks if utime updates the
>     modification and access time to current time, however V9FS,
>     similar to NFS, by default uses the server's localtime if
>     client doesnt specify a new time. The current implentation
>     does not run the test if the underlying filesystem is NFS.
>     A similar check for V9FS is also required, hence this patch.
>
> Note later was found that NFS was ok on 2.6.18:
> d623e2c7fe ("splice01/tee01/utime: add kernel version check for NFS test")
> and remove during Martin's rewrite in ec3c3e5462.
>
> Kind regards,
> Petr
>


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
