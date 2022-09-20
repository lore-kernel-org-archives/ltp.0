Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE89C54EE9
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 12:44:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 490AC3CAD5A
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 14:44:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D384C3CABD0
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 14:44:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D9AFC1A00A21
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 14:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663677883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RolleQR/tIi3f6Oy9HLm1hzH20L6vSY/uhgr76McPnI=;
 b=TVNLm93I4rrQewCc832ec9vVB6C2ztgzfpo+D9mfGIGkMnk9299e8bv5zLVTDlgojnyeVq
 LtlRuptgJIbalgLqCkQv2BOQ0jT/HJVC3BtLDjqN+HLanKd7Xv0BRtXUFYEiOiQw8i63eD
 MktclkMfNAfl0Psk+Puot6boPyTd2lE=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-325-DKnZqpzSNZuuUTJ89VYTNw-1; Tue, 20 Sep 2022 08:44:41 -0400
X-MC-Unique: DKnZqpzSNZuuUTJ89VYTNw-1
Received: by mail-vs1-f70.google.com with SMTP id
 124-20020a670882000000b00388cd45f433so577897vsi.8
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 05:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=RolleQR/tIi3f6Oy9HLm1hzH20L6vSY/uhgr76McPnI=;
 b=u311tENbaJvTtbbPhAemM3/4Cz0Ixu6+WrY4pj+eUvARmsVOYdR6vtLUAQr0QBnXH0
 So57jEWgGTYVZW3iFdUzac5bqN1QRHJVbfPUtYEgVAs0xAr3Bd6SpUQnhlK9VP3MUEB4
 JFGu//H5x/Up9H2Ki+cl2y04sShUwcZEN63GNtztzO/N1Z/LEA8SSLo9f88VtaAmRb9R
 XOt0O6SWhRfThguenkuz7Yntc0iyFSs8ohbtJS0r4WW9EIRdJe2ebjhvUsqyTnrcKoid
 WVUL8xLF/s1xiOX9Uk4IyCxRJ4D9rCSrKV1RagyH9AopFKzMjFapfVrhG8NqsDLPRyIf
 xeZA==
X-Gm-Message-State: ACrzQf1DbAKmf0JCpwU6dgyJDokOZttcGUgK5yridVuim1r1Fo1O8g8F
 HyRf6PD0rgDhdfABpszyLEiCHpkqQLA072cfGd1wDXRyG5lxx0Mi5xCaIzHZIRrDvD7evzxLbS3
 96v0324u/deK3R54fBxVe5aNO7No=
X-Received: by 2002:a67:d896:0:b0:398:2fa4:2080 with SMTP id
 f22-20020a67d896000000b003982fa42080mr7939149vsj.72.1663677879894; 
 Tue, 20 Sep 2022 05:44:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6UXbShG0niPbSFYp0GbnWrZBXu+jQQcjtIO3vH/77sNOz8cZQgVRbPONT7tlJ6Helk5IhkR52Uh8z0zTzHE84=
X-Received: by 2002:a67:d896:0:b0:398:2fa4:2080 with SMTP id
 f22-20020a67d896000000b003982fa42080mr7939142vsj.72.1663677879593; Tue, 20
 Sep 2022 05:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <6bac7035adc2cfc8ab3800fe1d2d03223ec57ff5.1663662348.git.jstancek@redhat.com>
 <6c5b161bc3bcf753cbda92954ca3f47cb268c68f.1663665637.git.jstancek@redhat.com>
 <6470a099-8b3a-ca9f-f521-181a33b5a28a@suse.com>
In-Reply-To: <6470a099-8b3a-ca9f-f521-181a33b5a28a@suse.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 20 Sep 2022 14:44:24 +0200
Message-ID: <CAASaF6wFc0z+cec6y2T0ygWKY==LwkFv21CT2VG0Waqk+0SSkw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/futex_waitv0[23]: replace
 TST_THREAD_STATE_WAIT with repeated wake
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

On Tue, Sep 20, 2022 at 11:55 AM Andrea Cervesato
<andrea.cervesato@suse.com> wrote:
>
> Hi!
>
> On 9/20/22 11:21, Jan Stancek wrote:
> > TST_THREAD_STATE_WAIT isn't reliable to tell that it's safe to
> > call futex_wake(). futex_wake() can be called prematurely and
> > return 0, which leaves other thread timing out.
> >
> > Replace it with repeated futex_wake() until it fails or wakes at least 1 waiter.
> > Also extend timeout to 5 seconds to avoid false positives from systems with
> > high steal time (e.g. overloaded s390x host).
> >
> > For futex_waitv03 this replaces while loop with TST_RETRY_FUNC.
> >
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >   .../kernel/syscalls/futex/futex_waitv02.c     | 21 ++++++-------------
> >   .../kernel/syscalls/futex/futex_waitv03.c     | 12 +++--------
> >   testcases/kernel/syscalls/futex/futextest.h   | 15 +++++++++++++
> >   3 files changed, 24 insertions(+), 24 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/futex/futex_waitv02.c b/testcases/kernel/syscalls/futex/futex_waitv02.c
> > index 0a0e2b62075c..ccea5eb5e745 100644
> > --- a/testcases/kernel/syscalls/futex/futex_waitv02.c
> > +++ b/testcases/kernel/syscalls/futex/futex_waitv02.c
> > @@ -50,19 +50,13 @@ static void setup(void)
> >       }
> >   }
> >
> > -static void *threaded(void *arg)
> > +static void *threaded(LTP_ATTRIBUTE_UNUSED void *arg)
> >   {
> >       struct futex_test_variants tv = futex_variant();
> > -     int tid = *(int *)arg;
> >
> > -     TST_THREAD_STATE_WAIT(tid, 'S', 0);
> > -
> > -     TEST(futex_wake(tv.fntype, (void *)(uintptr_t)waitv[numfutex - 1].uaddr,
> > -                     1, FUTEX_PRIVATE_FLAG));
> > -     if (TST_RET < 0) {
> > -             tst_brk(TBROK | TTERRNO,
> > -                     "futex_wake private returned: %ld", TST_RET);
> > -     }
> > +     TST_RETRY_FUNC(futex_wake(tv.fntype,
> > +             (void *)(uintptr_t)waitv[numfutex - 1].uaddr,
> > +             1, FUTEX_PRIVATE_FLAG), futex_waked_someone);
>
> Correct way of using TST_RETRY_FUNC is the following:
>
>      ret = TST_RETRY_FUNC(futex_wake(tv.fntype, (void
> *)(uintptr_t)waitv[numfutex - 1].uaddr, 1, FUTEX_PRIVATE_FLAG),
> TST_RETVAL_GE0);
>
>      if (ret < 0)
>          tst_brk(TBROK | TTERRNO, "futex_wake private returned: %ld", ret);

This has couple problems:
TST_RETVAL_GE0 aborts retry on futex_wake returning 0.
It won't report a failure (-1), followed by successful call later.
And if the failure (-1) is persistent, it would waste time retrying.

>
> >
> >       return NULL;
> >   }
> > @@ -70,16 +64,13 @@ static void *threaded(void *arg)
> >   static void run(void)
> >   {
> >       struct timespec to;
> > -     int tid;
> >       pthread_t t;
> >
> > -     tid = tst_syscall(__NR_gettid);
> > -
> > -     SAFE_PTHREAD_CREATE(&t, NULL, threaded, (void *)&tid);
> > +     SAFE_PTHREAD_CREATE(&t, NULL, threaded, NULL);
> >
> >       /* setting absolute timeout for futex2 */
> >       SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, &to);
> > -     to.tv_sec++;
> > +     to.tv_sec += 5;
> >
> >       TEST(futex_waitv(waitv, numfutex, 0, &to, CLOCK_MONOTONIC));
> >       if (TST_RET < 0) {
> > diff --git a/testcases/kernel/syscalls/futex/futex_waitv03.c b/testcases/kernel/syscalls/futex/futex_waitv03.c
> > index ee79728474ee..c674f52d8d4c 100644
> > --- a/testcases/kernel/syscalls/futex/futex_waitv03.c
> > +++ b/testcases/kernel/syscalls/futex/futex_waitv03.c
> > @@ -74,15 +74,9 @@ static void *threaded(LTP_ATTRIBUTE_UNUSED void *arg)
> >   {
> >       struct futex_test_variants tv = futex_variant();
> >
> > -     do {
> > -             TEST(futex_wake(tv.fntype, (void *)(uintptr_t)waitv[numfutex - 1].uaddr,
> > -                     1, 0));
> > -             if (TST_RET < 0) {
> > -                     tst_brk(TBROK | TTERRNO,
> > -                             "futex_wake private returned: %ld", TST_RET);
> > -             }
> > -             usleep(1000);
> > -     } while (TST_RET < 1);
> > +     TST_RETRY_FUNC(futex_wake(tv.fntype,
> > +             (void *)(uintptr_t)waitv[numfutex - 1].uaddr,
> > +             1, 0), futex_waked_someone);
> >
> >       return NULL;
> >   }
> > diff --git a/testcases/kernel/syscalls/futex/futextest.h b/testcases/kernel/syscalls/futex/futextest.h
> > index fd10885f3205..515b5102d4fc 100644
> > --- a/testcases/kernel/syscalls/futex/futextest.h
> > +++ b/testcases/kernel/syscalls/futex/futextest.h
> > @@ -277,4 +277,19 @@ futex_set(futex_t *uaddr, u_int32_t newval)
> >       return newval;
> >   }
> >
> > +/**
> > + * futex_waked_someone() - ECHCK func for TST_RETRY_FUNC
> > + * @ret:     return value of futex_wake
> > + *
> > + * Return value drives TST_RETRY_FUNC macro.
> > + */
> > +static inline int
> > +futex_waked_someone(int ret)
> > +{
> > +     if (ret < 0)
> > +             tst_brk(TBROK | TERRNO, "futex_wake returned: %d", ret);
> > +
> > +     return ret;
> > +}
> > +
> >   #endif /* _FUTEXTEST_H */
>
> --
>
> Regards,
> Andrea Cervesato
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
