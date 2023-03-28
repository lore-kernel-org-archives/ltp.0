Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7087CC76195
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 03:14:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C0A93CBC5F
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 05:14:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA3263C8934
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 05:14:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ECA6F2001A2
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 05:14:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679973266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qR9fCW/bQJeJ4qYWhnjiTWuHcy4GdIM7YeFfRiTeL+M=;
 b=g7DMXMDWbSF3diVetoVwmEBdVYObdA0rsj2x/Txybi4Ojz1AjwWgQbeardBPFyH116XMf9
 mGJkfuD2F1V2EQd7GKS+l8ybo0ZHTs35fj8H5u2yAf7+vCvGOUy8ZT9ktCopw2aThHuixR
 sc/jc6Q0aUtoYPfi63H/cRba2JWLHeU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-4AyXXLHhPrm6F7Edo9ZcPw-1; Mon, 27 Mar 2023 23:14:24 -0400
X-MC-Unique: 4AyXXLHhPrm6F7Edo9ZcPw-1
Received: by mail-wm1-f71.google.com with SMTP id
 bi5-20020a05600c3d8500b003edda1368d7so5701017wmb.8
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 20:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679973263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qR9fCW/bQJeJ4qYWhnjiTWuHcy4GdIM7YeFfRiTeL+M=;
 b=VqGZeBN7s6I3tSfYsAtWJvr6UGDNZ0SBdkthBwXdeYLhKdSRUT0M7159itZelx28T2
 8nJrjNvvCjlwJSHgVCTKOSBxKCuJV2YodTjFxqv8YZMVijwC/V2qGTujol+bkKHJMgA5
 y/B7m/NeyqFdU34tkaRtB9iwsaubagw4Qgo/sj4LWBXWPdjcft/ppz0x1LSB+ZqwRi8S
 6BKtJaneOM3bAWioeqduPIjzFTO8zEzvYH0MyApsM9vzO5IEa+P46Sj21zTapUNPjEzM
 /2A9eCFcjPY8t/9Wyufy6v7ubin/i2bJf0PDTG5YcNUyI01af8wYG3iXv18yN/l0j23K
 cCjg==
X-Gm-Message-State: AAQBX9dfMTgwwIasqmGst6dGnP2h/yrVf+Cz3TkvsGm1LGq7wrc4sFuL
 FkcAzrUzBt7BCVBh92qTOE+dnyeb/7cu4Cj75Pane/feUx47zTiV+cZPIGRRYBuUjWJWQf1cLWD
 KxwDT0gLZGKA7OxYQO3tWep5rkwA=
X-Received: by 2002:a5d:59a6:0:b0:2cf:eff8:48a1 with SMTP id
 p6-20020a5d59a6000000b002cfeff848a1mr6237089wrr.2.1679973263361; 
 Mon, 27 Mar 2023 20:14:23 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yacu82+OH0oFwTCDQXwKQlO/F1oJgNGqwrTv9toVpKUMtSS3/h1H9GXlYN5kH7B+ZoGfurTaI9WNOmn1KLHeo=
X-Received: by 2002:a5d:59a6:0:b0:2cf:eff8:48a1 with SMTP id
 p6-20020a5d59a6000000b002cfeff848a1mr6237085wrr.2.1679973263110; Mon, 27 Mar
 2023 20:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230323121330.92244-1-paulson@zilogic.com>
 <20230324103334.GA557284@pevik>
 <CA+O3cCRGPfMP2EVigECgJ8c0Uo-yd7JUm64wSgvvgxoRqe7-Jw@mail.gmail.com>
In-Reply-To: <CA+O3cCRGPfMP2EVigECgJ8c0Uo-yd7JUm64wSgvvgxoRqe7-Jw@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 28 Mar 2023 11:14:12 +0800
Message-ID: <CAEemH2e69a5DOq9eqJVau8YCENZchm8miOH3upQY_Pi6SUFyng@mail.gmail.com>
To: Paulson Raja L <lpaulsonraja@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Added test for mmap() with MAP_SHARED_VALIDATE.
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

Hi Paulson, Petr,

Paulson Raja L <lpaulsonraja@gmail.com> wrote:

> Hi Petr Vorel,
>   Thanks for the comments, I have just started contributing to LTP, and
> this is my first patch. I agree to merge it as is.

Good to see a new case for MAP_SHARED_VALIDATE.

As this is the first test to cover the new flags argument, so I'm
wondering can we add the functional verification to check if
this works correctly for mapping a valid shared memory which
equal to the behavior of MAP_SHARED?
(or do this in a separate patch)

But anyway, I'd suggest you send a patch V2 for achieving all
requested changes.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
