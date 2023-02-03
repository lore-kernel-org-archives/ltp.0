Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA94C61DA4
	for <ltp@archiver.kernel.org>; Fri,  3 Feb 2023 02:04:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 208623CC4B8
	for <ltp@archiver.kernel.org>; Fri,  3 Feb 2023 03:04:17 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4ED83CB282
 for <ltp@lists.linux.it>; Fri,  3 Feb 2023 03:04:05 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 51213600B62
 for <ltp@lists.linux.it>; Fri,  3 Feb 2023 03:04:05 +0100 (CET)
Received: by mail-yb1-xb2f.google.com with SMTP id m199so4703515ybm.4
 for <ltp@lists.linux.it>; Thu, 02 Feb 2023 18:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pKmQNI1LZRNZlwzqHmQUYSwaP0OiWBdk0cjJ1yQQsmw=;
 b=O27AhT54kEBcPUPI1Pz/8HDQuTV8LfLondMTbRjPbNI26gwiyeUW9A6mt4be5A9Fws
 INiegB0WozvJPiEcedxvj8i8joUmC2pB20CJAmSH41OCg8hkjF2wibdqTqGTWgz3Y34h
 D564CQFNqOciU/PBseayMBzmiUiOt5OwLQW1LdZHnSTU4VQnGVGhZj7W4haqkHRlk6aC
 Qi/tu+Bas1DOpoPlOxM2mwDtFUO7avLATeBN+Jrmp1A5VGs0ftyfwZ2+GjyDW9Cvx4v4
 nK5To9an6x7i28d2xvUxFsxJWhqOk262fx1UU710+SZaN7NOvX1ve+y40xfRQljRtZGh
 enrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pKmQNI1LZRNZlwzqHmQUYSwaP0OiWBdk0cjJ1yQQsmw=;
 b=Q9mEHGWYHP2GpUbWDVswuodvL/60xb9utQudkLH1cad0LyeASpWhOLYT//aAqaZwsI
 tX53B3KB3cjx8yJPrSxLzJer8FMtKlLwqM6keePcZGseg3NNvom9hfhceaJeQKTuH4ff
 aL3VTSxDrhs6Y3pH/Vf2fVCdp3gBifVDu+a555KxI6eWSvNGnU2s5Fr1NMf7bQO/Tdgt
 gwoFkxxjI+yL+9iBqwEVWPLjvL+6j6R61EeRkFmBCYTLwbENICLh7oMjoW+fn0Q8ywZl
 szmUGFQaNcdlKoDnA7b0ZMlz3ElBbBiE852IoVYaRXRKkKh7F+ayf9cv7QjRqZR2DTia
 09Yw==
X-Gm-Message-State: AO0yUKWw1balMSEALzgkEnJfkU6Ns684WaWK3aVIwzgQ7kkUlQjIkLx0
 dZo0DXH+GkhrcilbaYU1nm1pjWuHEelabuN+4I/3bQ==
X-Google-Smtp-Source: AK7set80hhGD6baCIYlKTiryH3ylG8GiQUEm/ZNgr5YaTiJrpcepwcTOyJCiPlUGqcz4YcBhTcgUDI1CVX5XQdjtsEc=
X-Received: by 2002:a25:9d81:0:b0:7ba:e354:5aaf with SMTP id
 v1-20020a259d81000000b007bae3545aafmr207869ybp.37.1675389843965; Thu, 02 Feb
 2023 18:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20230131002532.459456-1-edliaw@google.com>
 <Y9paGafh97zKnu/j@pevik>
 <CAG4es9V2773dyVrDwt7fiUq=VkUrn0Tr8icCC=X3xx+RGrbR9A@mail.gmail.com>
 <Y9trG4QnXUEbhBbJ@pevik>
 <CAASaF6xQPu1ZgAFKMLjbLtcP4woq7+uQ_H4phB5TO_6CLsy_kQ@mail.gmail.com>
 <Y9tyNEspOUlHMOGU@pevik>
In-Reply-To: <Y9tyNEspOUlHMOGU@pevik>
Date: Thu, 2 Feb 2023 18:03:37 -0800
Message-ID: <CAG4es9X=_vaE_3oX4JD598BNSX8RmQmAKVJS2kZdE1XzUjRu+A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Oh, lucky coincidence I guess.  Thanks, Petr!

On Thu, Feb 2, 2023 at 12:20 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> > On Thu, Feb 2, 2023 at 8:50 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> > > Hi Edward,
>
> > > > Hi Petr,
>
> > > > > > +++ b/include/lapi/close_range.h
> > > > > > @@ -25,4 +25,17 @@ static inline int close_range(unsigned int fd, unsigned int max_fd,
> > > > > >       return tst_syscall(__NR_close_range, fd, max_fd, flags);
> > > > > >  }
> > > > > >  # endif
> > > > > > +
> > > > > > +static inline void close_range_supported_by_kernel(void)
> > > > > > +{
> > > > > > +     long ret;
> > > > > > +
> > > > > > +     if ((tst_kvercmp(5, 9, 0)) < 0) {
> > > > > > +             /* Check if the syscall is backported on an older kernel */
> > > > > BTW what particular use case this fixed? Is it backported to some android
> > > > > kernel? Or to some enterprise distro? Because I don't think kernel stable trees
> > > > > accept new functionality, just fixes.
>
> > > > Oops, should I use .min_kver instead?  It isn't backported on Android;
> > > > I just wasn't sure what the right approach was.
>
> > > Actually, looking into SLES kernel sources, we backported close_range() to SLES
> > > 15-SP3 (bsc#1179090), which was 5.3.18 based. Thus you actually did good work :).
>
> > > @Li, @Jan out of curiosity, was this backported to RHEL kernel as well?
> > > It'd be useful to note that (one day we will be able to remove it once kernels
> > > which backported are EOL).
>
> > Yes, it's present in 8.4 since kernel-4.18.0-290.el8.
>
> Jan, thanks a lot!
>
> @Edward we have Hackweek at SUSE, I'll merge this on Monday,
> noting the reason why to keep this instead simple .min_kver.
>
> Kind regards,
> Petr
>
> > > Kind regards,
> > > Petr
>
> > > > Thanks,
> > > > Edward
>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
