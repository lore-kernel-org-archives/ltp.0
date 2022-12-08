Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BEAC4332F
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 06:55:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75E3A3CC04A
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 07:55:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33F1F3CC037
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 07:54:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7627160080D
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 07:54:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670482495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cnJ+L0q7b1ZDhsnbwJARJdD05VcTRcIC1t0XWTC7rq4=;
 b=AkEVrjoWUe8uD6G/8bQuloVYB08gKjQexDNxBPyp+8ZMEnHHgBZtmQmltTfMXC0aHec/Wb
 w4AsEsfiS+KW333NFq5RrBRVlwI1zXtQPrUO1E9xVI4DVwFHAKS75UoGx874HwCCnu9a1m
 Mbg1LwdLegfmNQ5/pWwg5LWSSt+UePY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-668-s5Tbg4BUMVG-_wi3eSYYBA-1; Thu, 08 Dec 2022 01:54:54 -0500
X-MC-Unique: s5Tbg4BUMVG-_wi3eSYYBA-1
Received: by mail-wm1-f69.google.com with SMTP id
 c1-20020a7bc001000000b003cfe40fca79so233327wmb.6
 for <ltp@lists.linux.it>; Wed, 07 Dec 2022 22:54:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cnJ+L0q7b1ZDhsnbwJARJdD05VcTRcIC1t0XWTC7rq4=;
 b=WzzJMEX2rrmgd9hRpSrSzVH0HuBGGwKM8jc5EFuKkbJPwFVUcuvUp/m6yo8DJNvm2b
 6HM4rCat5F6mmLQxU/aEFWzOZs+qr5ENSGTPhMnebjTtPujVXcyw91+c/7hD4qWgYPX7
 IrqHst8AskgGykNQFebGm4bG4PEshmJLjOnBkUpLBUN1UzkWhwS95VzpN+qo3wfP1EcT
 P8eXYhbhDp9pBcASJILrwcuApEjAC6pwydF0EGoLzlHy4qOaxvbJj32UX7lqAmw3Hbui
 IxB3i0c0VPvy0+SE0GP6/0HZAuncwYNaQZl5AMsJ0quG9WUd8wEQ2Nz1YdZOW8YkmTAJ
 nNSg==
X-Gm-Message-State: ANoB5pm/WJQANtDj6Y3MHDcpxePXtOk9fGmn/8mLrC8q2/4qrF2xnGKg
 T3OwA3T4DiY/H3DGXKaxeWIIX/FduzJb8byXmgFQKvPVj2tBfGYlv3o5jF9QNPJ8/3Q00yEJdXj
 3HpjekXccMf4LfzUTjAveO6Iksyw=
X-Received: by 2002:a05:600c:3647:b0:3b4:c00d:2329 with SMTP id
 y7-20020a05600c364700b003b4c00d2329mr55815135wmq.124.1670482493466; 
 Wed, 07 Dec 2022 22:54:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4Laaj5Rzvr60RPZ6eZ0frDVb5kECx+88iFxsuVEiEOiwrRDEYtaizbjbc2w3ZloPhIyQCvaeWaWtk6TRLCyRs=
X-Received: by 2002:a05:600c:3647:b0:3b4:c00d:2329 with SMTP id
 y7-20020a05600c364700b003b4c00d2329mr55815129wmq.124.1670482493204; Wed, 07
 Dec 2022 22:54:53 -0800 (PST)
MIME-Version: 1.0
References: <20221206075747.17352-1-akumar@suse.de>
 <CAEemH2dW2u+tYQUtvresJXMYYfaqiXqtKksdK4rHaGTCG+5L0w@mail.gmail.com>
 <2042676.XiyxxtkoYD@localhost>
In-Reply-To: <2042676.XiyxxtkoYD@localhost>
From: Li Wang <liwang@redhat.com>
Date: Thu, 8 Dec 2022 14:54:41 +0800
Message-ID: <CAEemH2dh-8PfK3c+KbwNHs9PO8QwOu4dpEn4s0WwfHq=8PFKVw@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setresuid04.c: Rewrite the test using new LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Dec 8, 2022 at 2:35 PM Avinesh Kumar <akumar@suse.de> wrote:
>
> Hi Li,
>
> On Thursday, December 8, 2022 9:07:08 AM IST Li Wang wrote:
> > Hi Avinesh,
> >
> > Avinesh Kumar <akumar@suse.de> wrote:
> >
> > > -               /* Test 2: Check a son process cannot open the file
> > > -                *         with RDWR permissions.
> > > -                */
> > > -               pid = FORK_OR_VFORK();
> > > -               if (pid < 0)
> > > -                       tst_brkm(TBROK, NULL, "Fork failed");
> > > -
> > > -               if (pid == 0) {
> > > -                       int tst_fd2;
> > > +       SAFE_SETRESUID(0, ltpuser->pw_uid, 0);
> >
> > There is no reason to modify 'real UID' and 'saved set-user-ID'
> > at this time, we do only care about 'effective UID' made changes
> > successfully or not.
> >
> Yes, Thank you, I realized this while working on setresuid05.c test.
> I think we should leave the 'real UID' and 'saved set-user-ID'
> untouched even when resetting 'effective UID' to root:
>        SAFE_SETRESUID(0, 0, 0); should be
>        SAFE_SETRESUID(-1, 0, -1);

Agree, and with ".needs_root = 1" setting at the beginning
of the test, they are definitely 0 so I didn't correct them
because the test is already done when going there.

But yes, if you'd pursuing perfection I'd help ack your new patch :).

>
> I will send another patch as we also need to add .needs_tmpdir=1
> because we are creating a temp file.

+1

>
>
> > So I tweaked the patch a tiny and merged it:
> >
> > --- a/testcases/kernel/syscalls/setresuid/setresuid04.c
> > +++ b/testcases/kernel/syscalls/setresuid/setresuid04.c
> > @@ -40,7 +40,7 @@ static void run(void)
> >         pid_t pid;
> >         int status;
> >
> > -       SAFE_SETRESUID(0, ltpuser->pw_uid, 0);
> > +       SAFE_SETRESUID(-1, ltpuser->pw_uid, -1);
> >         TST_EXP_FAIL2(open(TEMP_FILE, O_RDWR), EACCES);
> >
> >         pid = SAFE_FORK();
> >
> >
> >
>
> Best regards,
> Avinesh
>
>
>
>


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
