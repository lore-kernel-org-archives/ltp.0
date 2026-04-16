Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3620F8A146
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 08:41:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FF683E2635
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 10:41:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 597923D87C1
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 10:40:49 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F3DF12002D2
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 10:40:48 +0200 (CEST)
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-50b29c4e554so79227941cf.0
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 01:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776328848; cv=none;
 d=google.com; s=arc-20240605;
 b=U0lVB4hm//cFz03jIRVtYsBJVx57djeAKAS76NZPUq3mc+G/zUkYTJUJmOqBNeejSQ
 IeZiLpdn6RHL4Tmv50Cc4G9B34ASgg1/iyghRSrM9P2H9YjDinpRmKrAVrFCtr4Ua+0r
 RD5gife8Wy1XAzjAh4E4ZQoi0kvGDdRG42g6mLwz/1yn1Mpy0Ig25D0URKIROqiJ9pEa
 zKxirB4YsuOVii+RwtlTrItrFMIycg7R+1TivC5o4OTcNPrLAOgO0r0ehYmZ8BI6BX0r
 S8ezKp1vWX+5M2WvdaMUMsJvnW2dqeSYxfgD5BM++IrmSSZRBNjS+uRXKecYiZ8fee3Y
 a51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4c3RvBiPkdPFC0fmjYbOCnMdf+5YT+BLcXXu5L75KQo=;
 fh=ZJtCY/Flzb2kIi63uVk8Xod53Hn2uNJF3rmZE9hGI7s=;
 b=gp0imiO16P/X2t3sJKazYBu0syEv43XkY6zZI3XbQfu1acBB6PWWL1yrsLxqfNE6hj
 e0ga1SEbmK4BCPr/0KVfZ3zGLWvo3mINhf9lDP+gBDMZCxNbLVdT1QvIzyXL3ts4BoJ+
 6zKD51JtRKxIUONBA6dRsbBllG3MM1ZZBJqVaoNtWinrJsM41xYVwT7/dnrvvANFZ3LB
 wbZJ4kkD/GJje+F5OqNnVOf8osel6M56DtCe7Jna2PTEtUua0nTbEHXNbup9sewtAWdk
 QxHQ4sWuqYmi1xd1xq4SDeT9tSQaAFVfMiKIUJNsE5pTfk4MopgK3M5IKcQAitjU0F9z
 vnMw==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776328848; x=1776933648; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4c3RvBiPkdPFC0fmjYbOCnMdf+5YT+BLcXXu5L75KQo=;
 b=WAYzjZNpg2l9qd6SwCux5da0o6DK2NF2CPhFOAZlEjCIh3ncA7CQ+tqIFfegrxGyeQ
 4o6Fg8oT6j3Ycm6GUDMQhaxrHNUVMVEqjWNrlZPYWTsMe1r7IZPtglwe+515TJaqjhwY
 n2Pawnv6YcAvpD9oLjxiyE1xyXyNAvWGY5JKjKoIvBPraeEQLRNhFSsorMhqlEg1lo04
 N3LXkkMPiu57htZpSofF1SVGi123bEFkzSZg66u9Hyh6ubTlMEU/KMxUgkcjPkiPtVpn
 0ZSzsvmPcV6kXBGCinquvi3n4unn+RYWmehnsAjqZ80SzoH66yp7Ddmh3uU+pn2qXyab
 Zpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776328848; x=1776933648;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4c3RvBiPkdPFC0fmjYbOCnMdf+5YT+BLcXXu5L75KQo=;
 b=Il9EMnbFYeuh+RCCy5y7KM+CygbmUOkrAxFuPtMPPI3RXTon9/ROuWDrcF3s6Tembk
 QONlRsuqPztrNLKtrAUMgfZrQAopQFbwZNyYZlajIQftxS3i0C0dgxA7hsuAg6eLsF7z
 6tL6CTc9F+DqJ8CJcdg7EYDl+NvCxmwbmj32CRRrD4HQ3NjJPw0dPtHV9fE2sPPZSgR3
 qkNVYyOoR5ohWraxUS7l/WRApBNROv/xYyR5jwRtO+hTYz4/LFzmUtv0kvoRaJbjOMs9
 lRqmabwCXlcWLA6u740PMO3VLqMTz13lfRkPYI3AeKQrKLRJgzK9sivxzLJfaMd9ydQM
 9PWA==
X-Forwarded-Encrypted: i=1;
 AFNElJ97JsIktC/xp0DHSJs25wxHYkt1tLrE1pc1+fQpaTHuPgMeQHmZq8+weMQqElj7R2lq0/g=@lists.linux.it
X-Gm-Message-State: AOJu0Yyq50C4XK+D4W2cXLRM+DDlBwHt5enRcozklgukmwElFmqt4c9N
 lAOg44vJDitdfTm0YqDea4yuI5qeG4DtivI2PUPpI+Ipx9I24+LL0WaZcYTXoMe/X4WllZyQCpt
 Stpi4i3apBUIzWRGoXttT0BZrJ9GSHg==
X-Gm-Gg: AeBDietlhDzz2QmdPSl2FO0xQTwQ1Wbjr7uR6uDEjH+IOPePzx2udbC5iZ6cyRs/rZG
 8AEIQGaMhhVBP7wAfB4TKoNYRf3qg8rV8XBed2II/psW/eKr68Wp2clnZ39PPClN6D8OM7XeQEK
 M3i3/eAYhalbwcXt5PfKvWPRtoXdlme1EHMdm54YgkL5XJ+B3KKqXocwzayz6pSleV0HAMBlCws
 Z8UQ1JJyyDC5wOcz6fPKdNuRYBytwyEkL/lcviGyjemtbCsZyGO1g+lM2WMh2z1WyT9PNI+bqGZ
 2c9yNqHRrKrjvuO5uw/RYqVasWk=
X-Received: by 2002:a05:622a:610c:b0:509:2b02:c1bd with SMTP id
 d75a77b69052e-50dd5b18f23mr364610521cf.12.1776328847748; Thu, 16 Apr 2026
 01:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <53f26493-09fc-4f8b-9751-24d2c2e80697@linux.ibm.com>
 <ad5jSSYZJS0FdZva@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CANgNiRyTovPjVq01n7sCNhbNdYNp6nSvWcpVV_8aC3+kBX0edg@mail.gmail.com>
 <ad-sqJXCYZpBAKM0@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CANDhNCoAc4ktPUzqgam_oO7aAc4yp3nCqkcwQDvWs0zV15ZCaw@mail.gmail.com>
 <CANgNiRz7c7mJ3E2QQwHCHb4=DCk-S6vXe3Xkge05xfYe2LYTEQ@mail.gmail.com>
 <CANgNiRxV5Kd1Y3hHjM4mXaE2sdjhCQdp4Ff85YdqxL_DOSZdgw@mail.gmail.com>
 <17da2ea7-b1f8-49ab-95ed-30083592e7fa@linux.ibm.com>
In-Reply-To: <17da2ea7-b1f8-49ab-95ed-30083592e7fa@linux.ibm.com>
From: Li Wang <wangli.ahau@gmail.com>
Date: Thu, 16 Apr 2026 16:40:36 +0800
X-Gm-Features: AQROBzAojD5Xc9fz-lpyxpA3HAJsugbDGfdZwkIsbylVgqkkN8UTmny4wbtOByo
Message-ID: <CANgNiRx+Yww_+UE-DsUbpH_yAsM1VbeJTwX6aJkfFnDwMN1-ig@mail.gmail.com>
To: Soma Das <somadas1@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched_football: fix false failures on many-CPU
 systems
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
Cc: John Stultz <jstultz@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Soma Das <somadas1@linux.ibm.com> wrote:

> Based on the feedback, here is what I plan to incorporate in v2:
>
>   * Pin only defense threads (one per CPU), leave offense unpinned
>
>   * Replace |get_numcpus()| with |tst_ncpus_available()| to handle
>     offline CPUs
>
>   * Drop the RT throttle disabling entirely - unnecessary once defense
>     is pinned per CPU
>
>   * Remove the |usleep()| / |tst_check_preempt_rt()| block after kickoff
>
>   * Add |join_threads()| before |pthread_barrier_destroy()| for clean
>     |-i N| reruns (thanks Jan for catching this)
>
>   * Split into separate patches - at minimum fixes #3 and #4 will be
>     separate
>
>   * Update commit message to clarify the test now verifies per-CPU
>     SCHED_FIFO priority ordering

Generally that's my expected revision, but I would suggest you wait for
John's reply to see if he has other suggestions.
(John is an expert in schedulers :)

But you can test the v2 on your side and feedback here firstly.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
