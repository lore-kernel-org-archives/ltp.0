Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911ECC61DA4
	for <ltp@archiver.kernel.org>; Thu,  2 Feb 2023 08:12:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC53C3CC3F3
	for <ltp@archiver.kernel.org>; Thu,  2 Feb 2023 09:12:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B29D83CB27A
 for <ltp@lists.linux.it>; Thu,  2 Feb 2023 09:12:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 039AC1000D2C
 for <ltp@lists.linux.it>; Thu,  2 Feb 2023 09:12:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675325528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iGTW7lu3tTNX366QlNvTtqlT0Q+aTIZ0k6g34ZRup54=;
 b=DIgERmWGElym0SbBwuApVauMgE2a1KuKMFITOr3CfBgo56gOTNNy3dq0bBo9OTAllWgPuN
 nqaLIMs1GyOPoqWfRJ+IxMUt2qR/kuh6gU7jm4dfRDClQUdxlS4rXN9PZ8p06fxkc1DC4B
 jR/Y0LXoMX/KhYJkWdN0uRUbAbmZGgo=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-193-AbF9NRosONmwznN2Xf4c5Q-1; Thu, 02 Feb 2023 03:12:07 -0500
X-MC-Unique: AbF9NRosONmwznN2Xf4c5Q-1
Received: by mail-vk1-f198.google.com with SMTP id
 g63-20020a1fb642000000b003ea9b485123so511557vkf.2
 for <ltp@lists.linux.it>; Thu, 02 Feb 2023 00:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iGTW7lu3tTNX366QlNvTtqlT0Q+aTIZ0k6g34ZRup54=;
 b=SshO1G9IeO9vu7IawfA6i+UJ18w3/fM7J/HvUAVIfNK8jZgwzuHXsfNFCvHM2GxP42
 v4EweKepsfMnCo/dsFViuKf0lEynj1CYZ95IGOljoumsrBmmxnZA1eds+O4g9mQoWzPR
 X+AJBmZiJrSI2RolEw03MkxyMg0yKciyxNqFd5UgOI7AzJGMSvkghHptD0QkCKOQ8pa3
 pwCXxhWNz+DXFJ7TbiJxa4zxu3hxBm7EWk/Q1caOU1NZ6sV0DFgoZucVzwqQNcZWyvuJ
 d1EELjwkOM7aJh61BZIRVzQz/xuW8munxsTRG5lf0fIbfGrKhnthDPRFfruQ5yz2PUXA
 r5rQ==
X-Gm-Message-State: AO0yUKX6rhqda1UspeNhlr7FZc5VEmER/b+VNEtIHLuXVNvdvUYIyQgm
 f8EAFBNfNS0yA3vDsWsCHDohCviQiw8LY8/cvCD6Gv5NGwO+0FP3m2nEDKYg/spxGVa0vr6/vg+
 dPJlZZbB3OGDllkNcIzAyj6XW89k=
X-Received: by 2002:a67:b404:0:b0:3f6:8f1:f86b with SMTP id
 x4-20020a67b404000000b003f608f1f86bmr906400vsl.71.1675325526609; 
 Thu, 02 Feb 2023 00:12:06 -0800 (PST)
X-Google-Smtp-Source: AK7set9IBAkVpDltHvp+w4LWhkeT1xFD2ZwDxkuFozksqodW+XjcTRBEBJEjOEHXB9yWwJk1LyPapV24z+ZXatRYJJI=
X-Received: by 2002:a67:b404:0:b0:3f6:8f1:f86b with SMTP id
 x4-20020a67b404000000b003f608f1f86bmr906395vsl.71.1675325526304; Thu, 02 Feb
 2023 00:12:06 -0800 (PST)
MIME-Version: 1.0
References: <20230131002532.459456-1-edliaw@google.com>
 <Y9paGafh97zKnu/j@pevik>
 <CAG4es9V2773dyVrDwt7fiUq=VkUrn0Tr8icCC=X3xx+RGrbR9A@mail.gmail.com>
 <Y9trG4QnXUEbhBbJ@pevik>
In-Reply-To: <Y9trG4QnXUEbhBbJ@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 2 Feb 2023 09:11:49 +0100
Message-ID: <CAASaF6xQPu1ZgAFKMLjbLtcP4woq7+uQ_H4phB5TO_6CLsy_kQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] close_range: check for kernel support below 5.9
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Feb 2, 2023 at 8:50 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Edward,
>
> > Hi Petr,
>
> > > > +++ b/include/lapi/close_range.h
> > > > @@ -25,4 +25,17 @@ static inline int close_range(unsigned int fd, unsigned int max_fd,
> > > >       return tst_syscall(__NR_close_range, fd, max_fd, flags);
> > > >  }
> > > >  # endif
> > > > +
> > > > +static inline void close_range_supported_by_kernel(void)
> > > > +{
> > > > +     long ret;
> > > > +
> > > > +     if ((tst_kvercmp(5, 9, 0)) < 0) {
> > > > +             /* Check if the syscall is backported on an older kernel */
> > > BTW what particular use case this fixed? Is it backported to some android
> > > kernel? Or to some enterprise distro? Because I don't think kernel stable trees
> > > accept new functionality, just fixes.
>
> > Oops, should I use .min_kver instead?  It isn't backported on Android;
> > I just wasn't sure what the right approach was.
>
> Actually, looking into SLES kernel sources, we backported close_range() to SLES
> 15-SP3 (bsc#1179090), which was 5.3.18 based. Thus you actually did good work :).
>
> @Li, @Jan out of curiosity, was this backported to RHEL kernel as well?
> It'd be useful to note that (one day we will be able to remove it once kernels
> which backported are EOL).

Yes, it's present in 8.4 since kernel-4.18.0-290.el8.

>
> Kind regards,
> Petr
>
> > Thanks,
> > Edward
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
