Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A67AC43334
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 09:10:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC3AF3C964E
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 11:10:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 987143C7FCC
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 11:10:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1044B1A01E42
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 11:10:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658221799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H917e4F1Od3qnmtdckLki5FqHmGAeN7k4tAM0gnUH1g=;
 b=VB6sChNkQzroxDGjNLtpLvsT9IvH5fk5cGdh6Wd8Ef+htlNp21nrP3w1VEOqek3trwn4kP
 +bgtpVRavJpu9RZs+Qpv6YkYo+Ae8oucN5PilVVZzSpRF2RsYLe9ALSD7i0kZVbzHSW4G0
 FG2e2ua6ra/w3hs37Xtf9bxmCeHSpYA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-3hRhg8qOPe-_Fa6s8HOV_g-1; Tue, 19 Jul 2022 05:09:57 -0400
X-MC-Unique: 3hRhg8qOPe-_Fa6s8HOV_g-1
Received: by mail-lf1-f71.google.com with SMTP id
 g29-20020a0565123b9d00b0048a3f1e00abso1992101lfv.9
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 02:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H917e4F1Od3qnmtdckLki5FqHmGAeN7k4tAM0gnUH1g=;
 b=NtusxSB56fm8OQtL0mR4zT+DbPLOxmtKD0u7mtLaa7sRAjVMHYxyxk9XgYJHYO1UOQ
 SmcT0EnWtJ/ry0Cr/VFufiDjEa3XWkpZGz1vfRg6k0YR44wlFBzvY2c+2NWH41Zc82U0
 T7SCDRKCOiEw2FBPMl99AVNJbQGm2uz8G8aG+3iyBgEclQiaBbCExD8liTOGUUp+XahP
 gMfvNhnCfvnHqnhf4Om3/KmMGi1w9qAHBUdyC0DXvim3s35pacp94GbV7f9qXRmqNy/a
 7Otm1QW+1L6OVOwatnTdmJDLXZNH7aVfrOqZ6cK+sha9/o4TAf/YjUUeujhFo54U54i/
 s5hQ==
X-Gm-Message-State: AJIora9Pe1Xtfrhf7gO+9SxkbSYPRcs+C5QRlzX/HdVxAuNC2Ramj2w1
 sLWzo9q5KRsK9DJfXhrMcOT5TQhueGptzmGLyGtzix8doWTosFHU3jdDr2zc3IB/Hbp2D/41QUM
 48TaPZg9wwBoq4eO8MuDdCqn4S9M=
X-Received: by 2002:a2e:b538:0:b0:25d:881d:a10f with SMTP id
 z24-20020a2eb538000000b0025d881da10fmr13250456ljm.65.1658221796465; 
 Tue, 19 Jul 2022 02:09:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tkR506sBgTjfFch2/iA6ey1NVAILkSCnrVKzngamdJiEyW7/bYwDfDt/Q9iVlrtAKS6uvTuei363wVXbsKy0A=
X-Received: by 2002:a2e:b538:0:b0:25d:881d:a10f with SMTP id
 z24-20020a2eb538000000b0025d881da10fmr13250448ljm.65.1658221796300; Tue, 19
 Jul 2022 02:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <d9cddda87dd121a4c57baa7f2d0e221b7a99bc1c.1657212941.git.jstancek@redhat.com>
 <CAEemH2fe7PKvb08jr-jznrb939+0H7E3Xp6pLC80QKAVGsQ0Zw@mail.gmail.com>
 <CAASaF6x8tiwES5kiFR=bdrc8=h2BraG6fqUHsjdEM-ogkrgHpg@mail.gmail.com>
 <CAEemH2dTgx26P5f=oXSVa0T4B5seE1r6wbdb_-0255PDundgcg@mail.gmail.com>
In-Reply-To: <CAEemH2dTgx26P5f=oXSVa0T4B5seE1r6wbdb_-0255PDundgcg@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 19 Jul 2022 11:09:39 +0200
Message-ID: <CAASaF6yWy3c9GV5TGpMEdauaom7LABQ73N17ysPAH3tHEzUT7A@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/futex_waitv03: replace
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jul 12, 2022 at 10:33 AM Li Wang <liwang@redhat.com> wrote:
>
>
>
> On Tue, Jul 12, 2022 at 4:00 PM Jan Stancek <jstancek@redhat.com> wrote:
>>
>> On Mon, Jul 11, 2022 at 9:17 AM Li Wang <liwang@redhat.com> wrote:
>> >
>> >
>> >
>> > On Fri, Jul 8, 2022 at 12:56 AM Jan Stancek <jstancek@redhat.com> wrote:
>> >>
>> >> TST_THREAD_STATE_WAIT isn't reliable to tell that it's safe to call futex_wake().
>> >> futex_wake() can be called prematurely and return 0, which leaves other thread
>> >> timing out on futex call:
>> >>   tst_test.c:1459: TINFO: Timeout per run is 0h 10m 00s
>> >>   futex_waitv03.c:37: TINFO: Testing variant: syscall with old kernel spec
>> >>   tst_buffers.c:55: TINFO: Test is using guarded buffers
>> >>   futex_waitv03.c:106: TBROK: futex_waitv returned: -1: ETIMEDOUT (110)
>> >>
>> >> Replace it with repeated futex_wake() until it fails or wakes at least 1 waiter.
>> >> Also extend timeout to 5 seconds to avoid false positives from systems with
>> >> high steal time (e.g. overloaded s390x host).
>> >
>> >
>> > Though TST_THREAD_STATE_WAIT is unreliable, I guess that would
>> > still add more chances if we keep it?
>> > (I mean go with repeat futex_wake() after checking 'S' state)
>>
>> We could keep it, though I'm not sure what benefit that has. You
>> would probably make fewer calls to futex_wake(). Without it,
>> the window where wake and wait calls are made in parallel
>> is larger, and it also makes test simpler.
>
>
> Yes, that helps reduce the tries of futex_wake() to make the test faster.
> But not benefit a lot compared with removing.
>
> So feel free to merge it as you wish, I think it's OK with both.
>
> Reviewed-by: Li Wang <liwang@redhat.com>

Pushed.

>
>
> --
> Regards,
> Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
