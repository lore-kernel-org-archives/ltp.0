Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F90ECAAA1
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 06:40:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E0CC3CAC28
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 08:40:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36F703CAA07
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 08:40:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ED89914011A2
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 08:40:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663224014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bJJX8mqPhoH6vgFxCmPIbr373w4Bp6eL8VdHNFyVuPE=;
 b=eml1HiyYHStJu3EAIkIlDXRsy/4zXCm1/vzDuJQA0H1Lw8qBqr4zyDZYM7BIKYOrwhepyk
 LEQg2HVKcHbP743fWBpt79hzpE2jGcqSq4QSomLko+9lZzfpQ2U/teXriFeVIj1AbEueEK
 ywywAG6UNOZaHPrEi6c9J7KySm5RLsg=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-184--SHygg0TOUCZOTgkzpa-qg-1; Thu, 15 Sep 2022 02:40:11 -0400
X-MC-Unique: -SHygg0TOUCZOTgkzpa-qg-1
Received: by mail-ua1-f71.google.com with SMTP id
 o43-20020ab0596e000000b0038421e4c7deso4804901uad.19
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 23:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=bJJX8mqPhoH6vgFxCmPIbr373w4Bp6eL8VdHNFyVuPE=;
 b=h/JQnVFmWlQEf6OtOhY/Fc6mzLSgch7PoXzAg1ZBQsNvaCl35XNw9e6F18wBUN5AoQ
 IeHTV2jVjEP6OBX15Bh4XENtsXCr+Q/veuZvGPgRpIMhh/rfQdpDbw38+NExTRQTKrb+
 90O4jxBFNtRZgW5MtsftH0P8/H7iUXImFX2vNW6LJc6sDAr/Kleo0ByjELmvmj7PvobP
 b9RJ8bNLQolg6gkuvoAcvmypkuFrGy+7nMNsvh1jV39O6rz6CN+7/y+RuhPwYNeO5NB4
 peri0Q7zIRmqIEsgilYOWAY8PYkyKZqL4falwZy4NRXJJ99ooZ5i3ATCqwszbe37KwKm
 K7Gg==
X-Gm-Message-State: ACgBeo2qVyqK4rroONomCUXAC46DemS/FKE1PDiV19e7SU+1+bh75IRz
 Bqi7hSXd0kex+j+DujrQ9pThg+JuS5KBP4LzJO87Co2lTkTUolBy44B1v/eK1eJYnqIyOnwv8Fm
 MsOUaCqc91bLZ1N9QzllmB/ehXzw=
X-Received: by 2002:ac5:c90c:0:b0:39e:b77e:e6fc with SMTP id
 t12-20020ac5c90c000000b0039eb77ee6fcmr13193170vkl.8.1663224010872; 
 Wed, 14 Sep 2022 23:40:10 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5SyEMBJxGnHT3wZK8tk4HKsc5+or/esUWV4NM9nVD81Pqpm6MIoEjXk8Oz9W4HODqSuLfzn0zioEeKZBBx4/w=
X-Received: by 2002:ac5:c90c:0:b0:39e:b77e:e6fc with SMTP id
 t12-20020ac5c90c000000b0039eb77ee6fcmr13193163vkl.8.1663224010545; Wed, 14
 Sep 2022 23:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <19d19a5d6bbf5b19940a936b62db6dfdd29a085f.1658313770.git.jstancek@redhat.com>
 <YtftUlDCvP5uchp9@rei> <YyI+gHa7zCBIyjcg@pevik>
In-Reply-To: <YyI+gHa7zCBIyjcg@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 15 Sep 2022 08:39:53 +0200
Message-ID: <CAASaF6xX=gBBjOVEnp6U4HpjfuzBVpbkyD1i0keW+iVjSCJZWg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fsync02: restore runtime to 5m
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

On Wed, Sep 14, 2022 at 10:50 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Jan, Cyril,
>
> > Hi!
> > > Test allows up to 240 seconds for PASS result (depending if its VM or not),
> > > but on slower systems library now kills it after a minute. Restore
> > > runtime to 5 minutes.
>
> > Looking at the test itself it's a bit messed up too.
>
> > The test uses rand(); to initialize the buffer size but without
> > initializing the seed which is not random at all. It also uses number of
> > available disk blocks as a upper limit, which makes the test runtime
> > completely unpredictable.
>
> > I guess that it would make sense to randomize the buffer sizes but in
> > certain bounds to make the test more predictable and print the numbers
> > we are going to use too. Maybe run the test with a few different sizes
> > and time limits. Maybe the size of the buffers can be function of the
> > test runtime.
>
> > All in all I think that we should really rething what we are doing here
> > since the current code does not make that much sense to me.
>
> Jan, do you plan to do anything with the test before the release?

I put it at todo list, but haven't dived into it yet. For release, I'd
go with timelimit
extension as that can't cause any regressions.

>
> Kind regards,
> Petr
>
> > > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > > ---
> > >  testcases/kernel/syscalls/fsync/fsync02.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
>
> > > diff --git a/testcases/kernel/syscalls/fsync/fsync02.c b/testcases/kernel/syscalls/fsync/fsync02.c
> > > index e13ba89f1b63..55c7a71c1d65 100644
> > > --- a/testcases/kernel/syscalls/fsync/fsync02.c
> > > +++ b/testcases/kernel/syscalls/fsync/fsync02.c
> > > @@ -114,5 +114,6 @@ static struct tst_test test = {
> > >     .test_all = run,
> > >     .setup = setup,
> > >     .cleanup = cleanup,
> > > -   .needs_tmpdir = 1
> > > +   .needs_tmpdir = 1,
> > > +   .max_runtime = 300,
> > >  };
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
