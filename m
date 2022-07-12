Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BEBC433EF
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 08:00:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69B873CA860
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 10:00:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACFC63CA34D
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 10:00:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6BA6F100096B
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 10:00:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657612819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qCk4yREv+kT9PC3K4D5S56/BphK1xjef88O6mgqtFqE=;
 b=VaxBigrGBhf6+sbF63Y4No6Q8DZOAIPLYPKLIxgda5DbwDk2Pq5b0II8gV4BEUV9DhmsrI
 hpu9sOjTvfbmaz/DX0g9Zup5QynY5ZBQevrSic8vpVIAgnHxuLjrww+XTA30GasnEKkDPH
 oD0T+bOVY5eF+cSTye/RdeEa61EBcVc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-q1xW5aLBOT6E_EBbW5f0Mw-1; Tue, 12 Jul 2022 04:00:16 -0400
X-MC-Unique: q1xW5aLBOT6E_EBbW5f0Mw-1
Received: by mail-lf1-f71.google.com with SMTP id
 br6-20020a056512400600b00482af9d63faso3318242lfb.22
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 01:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qCk4yREv+kT9PC3K4D5S56/BphK1xjef88O6mgqtFqE=;
 b=RZ9m7+eRDn1mXw/IQpczQPXCnjmsjcqqIYvOyo/NKIi1IT0TvQzjDAqIxj4HVz21HV
 F3xuhND+P6nuV688Gknj/CZj2iYd2zvfMearzX0sWI8A0YzsguIuFEI6PoB00lpytc3d
 mstlsKN27xDhlYRxALKl3lPWLgEZ87iqr9boSbzY1jEqXJbVnHEehB4JNQDCMQGz6Uiu
 WpYUkOsIIB94T6yEQozIiNKY2AOIN8btPYv5xLjV3Pv6kQlno9ZxNQg36ue9f0JBh0IR
 M7kkso5VbG+vkBCWWFjaJUBe1pFfZet20tVXYd2pjATGcQVu7rZ1a1xanhKCygD4jwQ0
 OxBA==
X-Gm-Message-State: AJIora/96j/o7SWfbm2ROA5czB1V5TJRvZAYI9HYaCDz/JDrkHAvjOyf
 1BCcm/yIH5Kf7Q0GuQ6XHrNtbLRf2W+c527berCO/okpmNH9Le5AP47tQOSWD0o4ydWqGCfQJpq
 tE9xpSiYxwGqqaThN5ghHF6Hp8VM=
X-Received: by 2002:a05:6512:3f27:b0:47f:a079:eeec with SMTP id
 y39-20020a0565123f2700b0047fa079eeecmr13760300lfa.46.1657612815129; 
 Tue, 12 Jul 2022 01:00:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1st2fJBGyDAKhukhIeKDB4sdOqFIhY+jV0SLZJkxPNi7Lm5/VRVlgpdDprgd1qEQrwRktpok4DStudBBYZMDTs=
X-Received: by 2002:a05:6512:3f27:b0:47f:a079:eeec with SMTP id
 y39-20020a0565123f2700b0047fa079eeecmr13760296lfa.46.1657612814987; Tue, 12
 Jul 2022 01:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <d9cddda87dd121a4c57baa7f2d0e221b7a99bc1c.1657212941.git.jstancek@redhat.com>
 <CAEemH2fe7PKvb08jr-jznrb939+0H7E3Xp6pLC80QKAVGsQ0Zw@mail.gmail.com>
In-Reply-To: <CAEemH2fe7PKvb08jr-jznrb939+0H7E3Xp6pLC80QKAVGsQ0Zw@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 12 Jul 2022 09:59:55 +0200
Message-ID: <CAASaF6x8tiwES5kiFR=bdrc8=h2BraG6fqUHsjdEM-ogkrgHpg@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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

On Mon, Jul 11, 2022 at 9:17 AM Li Wang <liwang@redhat.com> wrote:
>
>
>
> On Fri, Jul 8, 2022 at 12:56 AM Jan Stancek <jstancek@redhat.com> wrote:
>>
>> TST_THREAD_STATE_WAIT isn't reliable to tell that it's safe to call futex_wake().
>> futex_wake() can be called prematurely and return 0, which leaves other thread
>> timing out on futex call:
>>   tst_test.c:1459: TINFO: Timeout per run is 0h 10m 00s
>>   futex_waitv03.c:37: TINFO: Testing variant: syscall with old kernel spec
>>   tst_buffers.c:55: TINFO: Test is using guarded buffers
>>   futex_waitv03.c:106: TBROK: futex_waitv returned: -1: ETIMEDOUT (110)
>>
>> Replace it with repeated futex_wake() until it fails or wakes at least 1 waiter.
>> Also extend timeout to 5 seconds to avoid false positives from systems with
>> high steal time (e.g. overloaded s390x host).
>
>
> Though TST_THREAD_STATE_WAIT is unreliable, I guess that would
> still add more chances if we keep it?
> (I mean go with repeat futex_wake() after checking 'S' state)

We could keep it, though I'm not sure what benefit that has. You
would probably make fewer calls to futex_wake(). Without it,
the window where wake and wait calls are made in parallel
is larger, and it also makes test simpler.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
