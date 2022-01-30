Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0EEC433EF
	for <ltp@archiver.kernel.org>; Sun, 30 Jan 2022 06:10:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 736C23C9795
	for <ltp@archiver.kernel.org>; Sun, 30 Jan 2022 07:10:30 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17CCF3C0CC6
 for <ltp@lists.linux.it>; Sun, 30 Jan 2022 07:10:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 09E23600558
 for <ltp@lists.linux.it>; Sun, 30 Jan 2022 07:10:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643523018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RtT9XT+tfwcZMhSoMnU5wDknbuHfoKFkyDGhYQJ5/74=;
 b=PIXa98/lnGzWhWj9pcF/zzgbel7KVTGFuXEMdpX464GMhuQxXXyZzo+TVPYSRRkWGiNduO
 uJIg2NIf/zJW/wnkQ7vWOY3qHDjQuBsGGlfYL1PWVNVv0o1lm0FBtpArX3fKBEFqBLgMCx
 TjNF+M/V/dFL7WqjbzW+cWtXwP0Ft+g=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-tUFcseNdPdSkUMa77-GQ9w-1; Sun, 30 Jan 2022 01:10:14 -0500
X-MC-Unique: tUFcseNdPdSkUMa77-GQ9w-1
Received: by mail-yb1-f200.google.com with SMTP id
 c7-20020a25a2c7000000b00613e4dbaf97so20732652ybn.13
 for <ltp@lists.linux.it>; Sat, 29 Jan 2022 22:10:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RtT9XT+tfwcZMhSoMnU5wDknbuHfoKFkyDGhYQJ5/74=;
 b=336qyssBeMwji5iaKWhZBm+ZQCsfeRIwkQOC+9J96jyANMar4/6Cf+BIx9XdI/mVwT
 DZALkM53du/F2BmG9DqGDtEydsNzh7CwLtiKgCHEKSNnbNj3jF/UCwda5xs7pxdTtG0O
 7X1E78yC9wt/GOQaugB/6jLYRutQdcwcsQ78Slf1Hpi3UmjBEf1b/H9/Dek3KGQgitC1
 6tLqHjin339rqy54BDFp5IzuTV/kU68Q6p+wNkh/dwAYDudp+6gYP6WEQN4y4d7Ce/j3
 vsM4/QQBaIaVHOxnOC8W8yUt9KKwT/JS0RhF1yMOedX5Yaz2HKsHedTL9d4rnjdxrmNi
 3ejw==
X-Gm-Message-State: AOAM533qsnhLdQK/X671u/F7g0kMZXB4W2TWTHPVWE0zlJmF3rMNc5Jn
 l0sFyfJoIUthJrcJf6G6l0KWevJqtVm/da7f6Ss+RzWvMwX8t9MUmWbjya2f84gSClqeNG+P9Az
 xystNC/pENpSCJOtPo3zjWzoB/MM=
X-Received: by 2002:a25:c70f:: with SMTP id w15mr23632293ybe.32.1643523013561; 
 Sat, 29 Jan 2022 22:10:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZYmc1Njwo/tX6G6Nq3pQ4Epc8a+QcNSoPDmJlSiZ14SXXB7tMMGNWlf6fXVAJggtotlzKhpSHlVGAZZ989pY=
X-Received: by 2002:a25:c70f:: with SMTP id w15mr23632282ybe.32.1643523013350; 
 Sat, 29 Jan 2022 22:10:13 -0800 (PST)
MIME-Version: 1.0
References: <20220127171455.9809-1-pvorel@suse.cz>
 <61F609C7.1080803@fujitsu.com>
In-Reply-To: <61F609C7.1080803@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Sun, 30 Jan 2022 14:09:57 +0800
Message-ID: <CAEemH2df5D=MV-bCP5d39F-CxTngHB-OUGxZBfDx+pj5uRTyjw@mail.gmail.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] lib: Print in summary also tests not run
 at all
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Sun, Jan 30, 2022 at 11:44 AM xuyang2018.jy@fujitsu.com
<xuyang2018.jy@fujitsu.com> wrote:
>
> Hi Petr
> > We count only tests which TCONF. In case tst_brk() some tests might be
> > skipped without even trying to run them), thus print them.
> >
> > Signed-off-by: Petr Vorel<pvorel@suse.cz>
> > ---
> > Hi,
> >
> > probably quite confusing to have "skipped" and "not run".
> > Maybe rename s/skipped/cancelled/ and s/not run/skipped/ ?
> > Or just to increase cound of skipped?

Both fine to me, I slightly think "not-run" might more precise to describe that.

> >
> > E.g. instead of:
> >
> > bind05.c:132: TCONF: socket(10, 2, 0) failed: EAFNOSUPPORT (97)
> >
> > Summary:
> > passed   8
> > failed   0
> > broken   0
> > skipped  1
> > warnings 0
> > not run  5
> >
> > have
> > bind05.c:132: TCONF: socket(10, 2, 0) failed: EAFNOSUPPORT (97)
> >
> > Summary:
> > passed   8
> > failed   0
> > broken   0
> > skipped  6
> > warnings 0
> >
> > Kind regards,
> > Petr
> >
> >   lib/tst_test.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index 844756fbd7..e5ea9e6165 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -811,6 +811,9 @@ static void do_exit(int ret)
> >               fprintf(stderr, "broken   %d\n", results->broken);
> >               fprintf(stderr, "skipped  %d\n", results->skipped);
> >               fprintf(stderr, "warnings %d\n", results->warnings);
> > +             fprintf(stderr, "not run  %d\n", tst_test->tcnt -
> > +                             results->passed - results->failed - results->broken -
> > +                             results->skipped - results->warnings);
> IMO, these values are not necessary related. Refer to quotactl01.c(
> tst_test->tcnt is less than results->passed)

That's because of the test looping 'tst_variant + 1' times.
Maybe we can just multiply it eliminate the distractions?

   tst_test->tcnt * (tst_variant + 1)


>
> Also, if you want to add a new tag, you should define the situation for it.

Theoritically yes, but the problem here is hard to count the
not-run numbers. Because some of the test items will never
be performed if test return by test environment unmatch.
I'm sure we have quite lot of test doing like that.


>
> Best Regards
> Yang Xu
>
> >       }
> >
> >       do_cleanup();
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
