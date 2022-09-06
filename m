Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC7FC38145
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 05:09:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B4323CA6BC
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 07:09:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41E193C0475
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 07:08:57 +0200 (CEST)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3EB7F2009CD
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 07:08:57 +0200 (CEST)
Received: by mail-ua1-x935.google.com with SMTP id r17so3934063uat.8
 for <ltp@lists.linux.it>; Mon, 05 Sep 2022 22:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=hZE6dPNIv3Bz9tB9DzF1wGJT23MeHGlBkIOWu2/Itsw=;
 b=mA2qY38z4HfpQDdmHuRFpJWZYbu0wc3GJOnKQa23Q3mVZESW5nu4fSlOiociTtiLvX
 pUgoqahNjGY2kQ1YU/WKzmXpzgTUHM8euqzhr5etfQeNjSzZ5vNwj6Mw0QS1el65X5al
 3GH/w/rlxaD2wIHCnoGhZlpYD9QKLexWx05PiErmCy204R6DospgoA6CmFxjjMCTRqKY
 1YQS6kBex4kE+5UpO0fnEA7G0oNvsS024TfQATX9uGEA8wLu+4c5DkzMnQJONnrp3gYy
 lXHDnFk9FFzUh6EcCxyzqBId74pbOgW3L1CZtTTTxrwHVkklY5QP7wJpYr0idxcCkRQb
 sTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=hZE6dPNIv3Bz9tB9DzF1wGJT23MeHGlBkIOWu2/Itsw=;
 b=fdG+1zLogb8oxrRZBkArMiVrYkMuWi1idT4Kg1yfWDgYEesJGT/YvD3SIoTGFjlddG
 F8cSozwLMbtiBcUEtpx6VDHFEYoyWcY7q0wRaAB52q938OAcrkyqIIj2jcmfrJQjBRZm
 dGVIu3ByZ8L4eNDr6EGuLN2EQgnj7p+wTIYZWtkSauxPLb4WVGcKIvvyKDIXVahjShCN
 0szKvaSjGomgG/ugDBCxL/zz7+W9FWeK4RM1QLeqPyWdNI12ACs+1s7dDXzFPeO7NJzA
 knGB8oyP3AY52a5iGyKNExx2b7e+JgASk+qOR+qE05VD/gl8RD7A3eb4R7dQMp/0wW7B
 t3lA==
X-Gm-Message-State: ACgBeo03PsxKQJ3l/sEHpIm+M+UAoVdVv9dH9XA6+tl5OzzYucXJ82RO
 IC+3N+IzIYZ9mlc7JqeLDfE4epP/IxJhD7dL9Uc=
X-Google-Smtp-Source: AA6agR5XKsMwEF8/Y8vj62yqVFO3zlxjz3VYBLHaJP2ZNOAM19uFWuLpdUJNaPxbS8OvlsDsLI/dIe+QoXvB7UCMZ3Y=
X-Received: by 2002:a05:6130:1021:b0:3a0:d2d8:a6fd with SMTP id
 bs33-20020a056130102100b003a0d2d8a6fdmr4680953uab.9.1662440934569; Mon, 05
 Sep 2022 22:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220905154239.2652169-1-amir73il@gmail.com>
 <20220905154239.2652169-2-amir73il@gmail.com>
 <YxYeGclGHpSay6ZN@pevik>
In-Reply-To: <YxYeGclGHpSay6ZN@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Sep 2022 08:08:43 +0300
Message-ID: <CAOQ4uxjNt-1Gqu6D8rGJmAFkS=GX99dQXvVO5n8spaQ_eVgdBg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/9] syscalls/fanotify09: Add test cases for
 FAN_MARK_IGNORE
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Sep 5, 2022 at 7:04 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Amir,
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> ...
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
> > index 0eb83e2f8..e40916c08 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify09.c
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
> > @@ -73,12 +73,14 @@ static char event_buf[EVENT_BUF_LEN];
> >  static int mount_created;
>
> >  static int fan_report_dfid_unsupported;
> > +static int ignore_mark_unsupported;
>
> >  static struct tcase {
> >       const char *tname;
> >       struct fanotify_mark_type mark;
> >       unsigned int ondir;
> >       unsigned int ignore;
> > +     unsigned int ignore_flags;
> >       unsigned int report_name;
> >       const char *close_nowrite;
> >       int nevents;
> > @@ -88,7 +90,7 @@ static struct tcase {
> >               "Events on non-dir child with both parent and mount marks",
> >               INIT_FANOTIFY_MARK_TYPE(MOUNT),
> >               0,
> > -             0,
> > +             0, 0,
> >               0,
> >               DIR_NAME,
> >               1, 0,
>
> nit: as number of struct grow, it'd help readability to omit members with 0:
>                 .tname = "Events on non-dir child with both parent and mount marks",
>                 .mark = INIT_FANOTIFY_MARK_TYPE(MOUNT),
>                 .close_nowrite = DIR_NAME,
>                 .nevents = 1,
>

You are absolutely right.
The readability of use cases is quite tough at this point.

> This is obviously non-blocker of this patch, if you agree it can be done any
> time later.

Certainly.
I think that growing the struct is a good place to stop and
do this cleanup, we have got plenty of time until v6.0 and I expect to
get more comments on this series, so I will probably do this cleanup
already for v2.

>
> Also I fixed make check warnings some time ago (i.e. checkpatch.pl), but they

Cool. I didn't know.

> got back. I might find a time to fix them (we appreciate you look after the
> test, thus don't want to bother you with these tiny details).
>

This is the only new check warning I see:

fanotify10.c:378: ERROR: Bad function definition - void drop_caches()
should probably be void drop_caches(void)
make: [../../../../include/mk/rules.mk:56: check-fanotify10] Error 1 (ignored)
fanotify10.c:378:25: warning: non-ANSI function declaration of
function 'drop_caches'

I will fix it.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
