Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330DDC6FD1D
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 12:47:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 310BF3CD4CF
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 13:47:49 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BFAA3C0162
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 13:47:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 45ACF1400FA2
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 13:47:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678884456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vnkFJrDhlGV7Ns4MLOn+pXfYFNRF8MFpT8X0NI9dIuo=;
 b=ZNIZ5KZ+uqSXcAUOVDIHGnFgdXBmlhJdihY48w+jpE+5HZzn56+IzY/1T9td5yZEB8uqyU
 a8wGnxwVmpOKQVchdunPih0DOWY7NQ02hFhan2BiRQx3kzTAebTK1HbbwoKGxZEqTzC4lB
 Qm1S554trMfwPWS0bJfEWia7y63sFGw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-SQavueceOAutl0bAEBlsEA-1; Wed, 15 Mar 2023 08:47:32 -0400
X-MC-Unique: SQavueceOAutl0bAEBlsEA-1
Received: by mail-wm1-f72.google.com with SMTP id
 n38-20020a05600c3ba600b003ed29a0b729so2992281wms.9
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 05:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678884451;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vnkFJrDhlGV7Ns4MLOn+pXfYFNRF8MFpT8X0NI9dIuo=;
 b=3m+2gbv1tfGNbXi+HUSUvxaiYYhRciL+dLd+Lq2YuwgIsAuv+IVItN+t9bCIhNvNm5
 VNKx7yW7UbZmFjBuA05khe1ig6dXYAJ6Q8eX01xNZ+LplyipgsPENYk6pzQ1jGtOhtX+
 YuYl2cXEuwEHNe2Z+QiCDCoWpi99uSwiHNnkal9/mPO47chcT+vKC+u6YtHdPjlj63g2
 AhVv0UkcoYIm36YQxgQnlMhngNQa6OY+z0ZC1tir5cu7BmV6ptgwMP3tg7tASVHQn+Kg
 gHdGzn35EzsuuLzzMPuDwTZuV/toRGHoctERPcPazY3U3aFI13Q0ovZtGB4513elArfB
 QW2g==
X-Gm-Message-State: AO0yUKV2FgkkO3fQNQOWnRdNE0PLpLrWvGlzoyMeBwba9IoXoRz7ptb2
 AxTVhE7BUaq3ms0CEFB/AHNF4S/KH8JOw+UQYcFt1TVWGa+B5szsUMsFvHW+ffyCZQJdGzrFwCb
 TY30dUJRQMnIw0HfqWxvSMylJTHc=
X-Received: by 2002:a05:600c:a399:b0:3ed:253b:1034 with SMTP id
 hn25-20020a05600ca39900b003ed253b1034mr2736965wmb.8.1678884451732; 
 Wed, 15 Mar 2023 05:47:31 -0700 (PDT)
X-Google-Smtp-Source: AK7set9Kljq7K2euxMYEvb8SBBJgCQyAM8etC6DORBaqTWC1XN0W4seQSdMhzhguqJL68MO7Po4GNTyL/1yc5o5WNg0=
X-Received: by 2002:a05:600c:a399:b0:3ed:253b:1034 with SMTP id
 hn25-20020a05600ca39900b003ed253b1034mr2736960wmb.8.1678884451507; Wed, 15
 Mar 2023 05:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230313095049.53761-1-gehao@kylinos.cn>
 <20230315080041.128271-1-gehao@kylinos.cn>
In-Reply-To: <20230315080041.128271-1-gehao@kylinos.cn>
From: Li Wang <liwang@redhat.com>
Date: Wed, 15 Mar 2023 20:47:20 +0800
Message-ID: <CAEemH2ekKdtQ2Qa2=Egf8Fy_731gyopAteNG=V06CEYsHVA3vg@mail.gmail.com>
To: Hao Ge <gehao@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4] memcg_stress_test.sh: Fix reserved mem
 calculate
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

Hi Hao,

I adjust some syntax and expressions then pushed. Thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
