Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4563AC433EF
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 01:40:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D93433C98AB
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 02:40:49 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53A953C9883
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 02:40:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 930B1100054A
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 02:40:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643766036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0PhtJnR5XlsbF8GtPajMtzXVPpqg9KbSTgXzubWyAzY=;
 b=ZwQUplZ6I3yipbKIN/PiyBEFz1nbw0nJpGfJwkL3ni6HN3F1uJSEok5SsgYHt6UKiwWQWB
 jicakMOnd0jjU5otzewBevfbgGQ/uYUSGnZoyGqPJj2iTDuPnz5juZI91njaG9DxVBT7Nf
 iqb4H3nQal2sWteRX+X4W4eZld0OPmo=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-nQVxcSwKNaK83n71n3dlFA-1; Tue, 01 Feb 2022 20:40:35 -0500
X-MC-Unique: nQVxcSwKNaK83n71n3dlFA-1
Received: by mail-yb1-f199.google.com with SMTP id
 v70-20020a25c549000000b006130de5790aso36982029ybe.4
 for <ltp@lists.linux.it>; Tue, 01 Feb 2022 17:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0PhtJnR5XlsbF8GtPajMtzXVPpqg9KbSTgXzubWyAzY=;
 b=m4QQ8YwOBsOfu0HzZaO4+f8xSOlAbiJY2gRsetupObOUa20x4uUL4vV361Q5ugzkRX
 dIw5D6GO8qpz/3zl6J49KIB9SijIQMIc8xjji5w0dhlUgI99YNjv6VL6efAxbK1urtpU
 QNd5v2Fq/A3QWWPuJlRjBLmnAUa77DCC93Ol4PwAtp1mesveuyLUqDu7eCRi8MCDzstT
 wrnwnshnfMizgpFRDH3yChbj3fVBJ3Rtbof27K5+gkQazELr4oprxCecaghpiSQE0OEv
 eQub9lTyoEo+rVRKof/6VQwxpHslJiuGzuIlhI4cVqf5UnPAzAeFXUvdOjyk8bI0rIUR
 6wwA==
X-Gm-Message-State: AOAM5315pQ4A9gOwRiH9RciPLVfl5V186dgRgjpsnqKoIh0nGk3rAAzd
 QOS1FsNQM0PJm22H/GVUgzAh1gxkpEJRoHj04zDsMS3JoZtOoFyJtuSNvzDCudNW1TYZXdBOeDY
 bFLZzEFgJto68EdUPwwsu70ckCqE=
X-Received: by 2002:a5b:14c:: with SMTP id c12mr41447874ybp.71.1643766035136; 
 Tue, 01 Feb 2022 17:40:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzoWN3bgisB04YkZkekg4Owgk4TyGDBaoOm1jtJebki+OX4r9wnloIPZVRQ0GrYZhpE+zs05OwcfG5tXIC+lQ4=
X-Received: by 2002:a5b:14c:: with SMTP id c12mr41447849ybp.71.1643766034756; 
 Tue, 01 Feb 2022 17:40:34 -0800 (PST)
MIME-Version: 1.0
References: <20220127171455.9809-1-pvorel@suse.cz>
 <61F609C7.1080803@fujitsu.com> <YfeN6fG28AVNC44n@pevik>
 <CAEemH2fRtV+OqrW+x49RosgpyOYqCZ1ULxvZvqwypK8HQn6EQA@mail.gmail.com>
 <YflwND3aDJ1lg0ps@pevik>
In-Reply-To: <YflwND3aDJ1lg0ps@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 2 Feb 2022 09:40:21 +0800
Message-ID: <CAEemH2dRwXdEN+eA5BhEyfK_cuvqhKu+mQFgJAtLJwWga1z+PQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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

On Wed, Feb 2, 2022 at 1:39 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Li,
>
> ...
> > Yes, I understand. So how about this way:
>
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -785,6 +785,8 @@ static void print_failure_hints(void)
> >         print_failure_hint("known-fail", "hit by known kernel failures", NULL);
> >  }
>
> > +static unsigned int test_variants = 1;
> > +
> >  static void do_exit(int ret)
> >  {
> >         if (results) {
> > @@ -811,9 +813,11 @@ static void do_exit(int ret)
> >                 fprintf(stderr, "broken   %d\n", results->broken);
> >                 fprintf(stderr, "skipped  %d\n", results->skipped);
> >                 fprintf(stderr, "warnings %d\n", results->warnings);
> > -               fprintf(stderr, "not run  %d\n", tst_test->tcnt -
> > -                               results->passed - results->failed -
> > results->broken -
> > -                               results->skipped - results->warnings);
> > +               if (tst_test->tcnt) {
> > +                       fprintf(stderr, "not-run  %d\n",
> > (tst_test->tcnt * test_variants) -
> > +                                       results->passed -
> > results->failed - results->broken -
> > +                                       results->skipped - results->warnings);
> > +               }
> >         }
>
> >         do_cleanup();
> > @@ -1529,7 +1533,6 @@ unsigned int tst_variant;
> >  void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
> >  {
> >         int ret = 0;
> > -       unsigned int test_variants = 1;
>
> >         lib_pid = getpid();
> >         tst_test = self;
>
> Yep, ack this one, works well. Will you please send a proper patch?

Sure, but I'd hold this until Xu Yang review. In case I have
something thoughtless.

Ps. He might reply late since now is on China NewYear holidays.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
