Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF92C05027
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 06:16:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFE6E3CC0D3
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 07:16:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9750B3CB107
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 07:15:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 56F301A00156
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 07:15:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675923354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G713lsGy7MYVwWVNGIyvB6dV129CRxXZhkuLXbEMPMo=;
 b=ETRf/oXchy5KJZmq0PgwHplRi7BLv2BjhUhjdLfrbp9uhQW1wpL+qsNT61VUsAF6Vxj8S8
 zAlaAMPUDjzZKfAeFCkcGSEPg6wnDXBcPFT0IH4arR4gPmBZhhDC/1h+flPJ8xEqEy0xPH
 bEUFkxY6YSJgjkllDCadgGeQFygnWeU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-373-aBu0HYrzMnKKZuao6PfVrQ-1; Thu, 09 Feb 2023 01:15:52 -0500
X-MC-Unique: aBu0HYrzMnKKZuao6PfVrQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 h9-20020a05600c350900b003e000facbb1so2299460wmq.9
 for <ltp@lists.linux.it>; Wed, 08 Feb 2023 22:15:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G713lsGy7MYVwWVNGIyvB6dV129CRxXZhkuLXbEMPMo=;
 b=kEmi0dHXy6xTCXoRws9jIh8QCr4Q+s+TI2AQAbBhxOpN/V7S2xWxMUUeIAF0MA6I06
 o67KYmJszEVrXi1fqMlfHkgtbRJfZS+HKZDljlCtB2wwGzkQ76JQq9C01cjASfrbKMMC
 +18Ztshhvx5lneBvC4Ye5ly31xuLt27VNSnRt5GqFCl6T+jgPv8t162BA0AYVMa0AbGN
 x9RX2X1Aq2mLNlagOecyHkdxhfzVWnlJIPLNNR8dMWL5LNi1SFql6gv2Ig0bK0C0CIds
 b6qglSoJswgJY+TbAkPGB+5rxM+guLCcF5rpHInhG5ut9wrI2wO/tUywNIfU2vYqw7rx
 /0gA==
X-Gm-Message-State: AO0yUKVkMqpeVI8EtVsufyQ8koi9+k/zYuqjRoFczC73qinyjjqcZgd4
 4GN2ROScDYkQRTxk7wxpaHMDgMe+CV9IJSbHMgy22Rv0Xu4NS2Rzt32a4yAa+CAkKnLfdFKCwTq
 mja9Ahuc9k9wwYGxflnETiLdt2V8=
X-Received: by 2002:a5d:5949:0:b0:2c3:36d4:edea with SMTP id
 e9-20020a5d5949000000b002c336d4edeamr455127wri.528.1675923351572; 
 Wed, 08 Feb 2023 22:15:51 -0800 (PST)
X-Google-Smtp-Source: AK7set/JDDmBasGCsB8fxFVpGk0Skq8C+NH0U2fxL1IiiESxO2Zdb0jCKCA6KiA9JkRzMA8AdGAtFwRFyRtQEyKdMPs=
X-Received: by 2002:a5d:5949:0:b0:2c3:36d4:edea with SMTP id
 e9-20020a5d5949000000b002c336d4edeamr455126wri.528.1675923351361; Wed, 08 Feb
 2023 22:15:51 -0800 (PST)
MIME-Version: 1.0
References: <20230207131714.2500-1-pvorel@suse.cz>
 <20230207131714.2500-2-pvorel@suse.cz>
 <CAEemH2chcTe263-zqpSF2Gc2CVc8NC+G-KZsFMbwoxEKyjA01w@mail.gmail.com>
 <20230208135404.GB31469@pevik>
In-Reply-To: <20230208135404.GB31469@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Feb 2023 14:15:40 +0800
Message-ID: <CAEemH2cg_ATrf35WwFOoA0oqVN6GTZgT4jaRzkNjae8D6SBLZw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/3] ioctl01: Add default tty device
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

On Wed, Feb 8, 2023 at 9:54 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> > > +#define        DEFAULT_TTY_DEVICE      "/dev/tty0"
>
> > Hidden the device path parameter is a good idea.
>
> > But maybe can we add a function to find available char devices instead
> > of using the tty0 as default? In that function, we do the S_ISCHR() check
> > and return the valid path of it. Then the rest test (e.g. ioctl02) can
> make
> > use of it but not set the specified device as well. WDYT?
>
> FYI I'm using S_ISCHR() in other patches, which check if device can be
> used.
> Implementing search looks like a good idea. Are useful files any /dev/tty*
> (including /dev/tty, /dev/ttyACM0, /dev/ttyS0) or should I avoid any file
> or include other paths?
>

It seems not all char devices can be used here.
The /dev/tty*Num* should be the first choice.

I tried some of them and only /dev/tty0-N works well,
maybe we can just make use of them to avoid no tty0
file failure should be enough. Because my only concern
about the hard coding is that "/dev/tty0" is non-exist.



>
> Kind regards,
> Petr
>
>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
