Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7A7C5DF86
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 10:33:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17F263CD2C7
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 12:33:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C7DD3C9B32
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 12:33:13 +0200 (CEST)
Received: from mail-oo2-x02.google.com (mail-oo2-x02.google.com
 [IPv6:2607:f8b0:4864:31::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8960220017B
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 12:33:13 +0200 (CEST)
Received: by mail-oo2-x02.google.com with SMTP id
 46e09a7af769-7e9feadef81so314467a34.1
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 03:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787135592; x=1787740392; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xT4rz/QlIEMXXDnWO5pniD6r9o0uIrdor5NGLDkiS28=;
 b=NKU+dV413U8pGbw4VOsK7uq6+c9lSoYqCATwJoSlGkofnO95q9qNgcXJwiCVuk6rBI
 CiqxEIKd1NGWM2PrOHITLsTzicp6xxQjxxfKKLQYxxFsohAVSmsFiH4QG3XG0aAu0Ykn
 D1DOy0mf0u/FRCz/HiSrTh8+cELXU0jNI3F2UbdHTy/QUqVQ9yOklDgSLFF9VGO5qBBr
 WiXmScC2yFUzzFB2vxg/D4MQy1SlBIYqQYVAdHtBLPYJWkvZ1bAlxrb5IA823Who1Hcj
 fYWNHcL9CFWNZ/C4rhR26ebk7CHsbXiFSY2D33y8WsLEN9zd7zijslJcr0hGJ7epGB0K
 K3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787135592; x=1787740392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xT4rz/QlIEMXXDnWO5pniD6r9o0uIrdor5NGLDkiS28=;
 b=V82mMSMmVSG7sTPvk5y8OQs+D2eiJ4XHpnRdJYQURCxAqZnGqbYbTNStKsnWWJUpca
 3aLKg7lqL99yIFRQwF7YNU5j8JaBWsvUQIAkosGxJ1wzGD5ZV+2xTFCoM8xfgnp1OtgP
 jhyMRl2dkwEuIbR73rnpGfwM+gB812c9Er1f6auXjrUYQYxL0lcE+w+7ZCXR4PZdIitZ
 BLhyO90p8WSrXg6PFw0j2kq2bJ/AuoTuH8xfymTGXpts9WyFfTCflnNAnpy8fDM7nZ30
 SK8m5vHeLEv/Cnd05EyYTv67dkC8a3gfRBlr73TjMx/nEyEIgke2lHR+due5LLNPKL7o
 c2tw==
X-Gm-Message-State: AOJu0Yx7VmL/Og5t0y1ZlHvq6N0dqqukGWuVzo/a/vNrs+/bj27lxVlY
 mUO4F3jqcUwgRHiBFTsjgF90p7zyrnLP+Hb2CCcCtuScGXnJ8ps+UjdqY83GUFCt
X-Gm-Gg: AR+sD126Q1Do53ZAPURi69SiKTQWm+GSny6gadtyknUxakhDkiPT0zi2g5J+n3vTAjY
 +ok83GkBzapSmvkYu4L3Z9FXiVSd2W8eCgqncMn64On22wuDc/VTD9cnb1H7gMIl14PBV9xdUus
 62I2tYwhN+2JBtLzXlPv0d2AVDPfZQjHwYwTBNvlORMdrt3kTTYNDY/cTUuHPHdhJK8Qy/4BnSu
 x+0HReoS9nlhIQDiGaVy3962PG7AB5HWRhGyov8WPk4CD8UE725zQ8WMeNjq3p1toodlPXzbQb4
 FrFdlGLhSsH7EujQilYLLI0ZVoftm1J16iGpIrZ7rPKPu0Lsp3DW8bDp/ny7z9xOfBDqA9uDOF5
 FKmNX/RxrwfRDCK4qmlsZ7zPX4ogTbsAc9zSD7jEfoj5fRkcm56tl40AyYMN9g/Yr+OBZXLAZ+g
 J9pHpyJmNg1zewUWwBzqpRIHHA7avPudVD2LLrZtQFYXqC1458lPMgra+wzxEoLLGHa3PUNzR16
 KlTnwjLwXsGve/Gl2+wvNueholwzbgLQm3C6Jh+bW+NSf4h/BJLYVmeB4TTGtWySAe0h9CDQhvi
 buR3bgxQf40=
X-Received: by 2002:a05:6830:2b26:b0:7e7:5e4:ee11 with SMTP id
 46e09a7af769-7f43fb5f2b1mr3457271a34.16.1787135592115; 
 Wed, 19 Aug 2026 03:33:12 -0700 (PDT)
Received: from
 runnervmzvulz.v2txsgjvnysubdqtcv1hak3fog.gx.internal.cloudapp.net
 ([20.221.69.183]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f43fea88c9sm1299786a34.7.2026.08.19.03.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 03:33:11 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Wed, 19 Aug 2026 10:33:10 +0000
Message-ID: <20260819103310.39525-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819093210.24342-1-avinesh.kumar@suse.com>
References: <20260819093210.24342-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: timer_*/speculative: Skip untestable optional
 behavior on Linux
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

Hi Avinesh,

On Wed, 19 Aug 2026, Avinesh Kumar wrote:
> openposix: timer_*/speculative: Skip untestable optional behavior on Linux

> +#ifdef __linux__
> +	printf("Linux does not implement this optional behavior\n");
> +	return PTS_UNSUPPORTED;
> +#else

Could these branches be removed from all eleven tests? Linux 7.2 uses
scoped_timer_get_or_fail() to return -EINVAL for invalid timer IDs in
timer_gettime(), timer_getoverrun(), timer_settime(), and timer_delete().
The installed man pages document the same EINVAL result.

More directly, every pre-patch test reports errno == EINVAL and returns
PTS_PASS when built and run on Linux. The platform check therefore replaces
working coverage with PTS_UNSUPPORTED, and the quoted runtime message is not
accurate.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
