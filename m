Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E18BCD343B
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 14:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778164882; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Tf++795FDz+4RUlD+8nntBS+0y29gvsR7RQm7YrL8zs=;
 b=JN9dgdSiWqBH2kjS4dQEIrqO5RqgdjgmxSDzmZUiR2sAbbCT/uD3hSA9BjWGVv2NHUhf9
 kTI4clKSEodao9MxuQaxFEiWpcw5aTNvZ9746XLetDng9boQjVzsPL+8qP7WrIou8YepYKD
 Bf00KXnxEJ+bbpJCR6SV8RmANO5syDc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A88B03E5F70
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 16:41:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E01A3CAD2E
 for <ltp@lists.linux.it>; Thu,  7 May 2026 16:40:59 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A6FAA60082D
 for <ltp@lists.linux.it>; Thu,  7 May 2026 16:40:58 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso5968425e9.3
 for <ltp@lists.linux.it>; Thu, 07 May 2026 07:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778164858; x=1778769658; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=4rCTo9KTB5jWA17n4ekY1ff2FZuidxcZYvcNuWC4fws=;
 b=gdrsQ7ESAmr4swyVUaNXF7R34/JTw1K9uJsZDYbK3qAB5Ueqsd9DKW6s4h/GzuM/U8
 JwI2Do+Kjwwf54Lrd1pxOKX+3xCbFDoqkSW/l42A/iUTNJSgkk7zs/+5sIIUhSqPX8pa
 1vmp8kfmQJT4EhU3GvOIO9dilVlLPEQ3R/neFMdfpr+4QRkTBPtqr8cpEQ3Rk4Lr8cqa
 VI/xX6cetriqsuWtKbrdiX8WHEw8Z85sehdn1q8eOL3ltLdeZ2AdSrCT2xSolXuNLrtM
 KdGu1HW7/pnQFOAdM7zn0j64sIMD0K8iDe8QxdUE9VDiL7A/0koJcjPpaa6ESBDrDNOJ
 Q4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778164858; x=1778769658;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rCTo9KTB5jWA17n4ekY1ff2FZuidxcZYvcNuWC4fws=;
 b=FTUnRH0XpPK8XcSVh508pNMat/mThr1xhVMsmUrbk9T5B7dgw5VKdPXZgt/eFzX9/m
 yaZYViF7qkA6dmDxytjv6R0Q8xo1gWsmAbRRladofqb9a94LGyRf9Ij2oQLg+26NODJ0
 mrTDM04Xo/5QRfyFPqGVLALgf95Pj7AIkg3DJlnwZ4nOBZ1xliW2VsFNGzxMmvqZe17h
 GPJHVB2/X0FUmXD92Xl7Aiu78jJN5gUNv9PqWpntUE/jL0zgdMe4DiH0wwmW7aMlFb5v
 0RHCkAVAr2GkzUguxSyy5L30Xb4JMvGm5s8Nxywy7CayRyq+MsWQqxS3FX9TNgoAF6Nt
 k7bA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qrz/A5+FdWzgzy7nMDpdSC+FL7NQ9darfFrOg7JrARVvkocPNL5ZZqBQ8H8akFP7X8Pg=@lists.linux.it
X-Gm-Message-State: AOJu0Yxynlcj6iNN6xr8AcqZTf8pHrBWgb1UY0rxJXYCSHmWCCUTTjLX
 g8JL3mAgMBT9vQmAEv36VW3f4iDeI+8C19E3n8zFYxIo9SReWeOIRxnTcveJ1k4iw3U=
X-Gm-Gg: AeBDiev5Ch/G3A6NCym0SkY6hWdLK1K5Y1ljURL4s+Q8PTqHi8L1mqhv8HYIOT9RQju
 01kxSuF20qkX4U9SvrzlW+pDjn08Ee6W8FTGbCVkiO+b6vpJvaOSG+ShBYS2Wp0Jdg3kmx5cn/P
 S9sil8tKhlZTqADIELMK2HWgaq6q3wD/fO3z5gCELFKjmBko8xxKK2y4lk+jjHHBlsMFHolrLxn
 8aGs2MPY3XpkKYUIt5UU5HF3YIb5065MraUICbnQYbA5IT1KnSXHBGNaUVyVwpPEeUptc19rNzU
 FC0fhcmj03nJVuBRpYs4AAoUaXROlfyM+s5CzxvtqF+9kVG96jtfreQmfjDmt4xm7fv7CoK3Tvt
 Sv9B7Skofa08FnAygISTwuUUYRZUX5vx+qDb9kSAcpJlam/HFmQU3XuRSQ0qmEvOs4zVZwMiQ58
 oVlCsXibgPCb7aLupnXFMsBtDsXNCsHz53sJC7TFgVVT63+HZXY41u5+yoNRcFlg==
X-Received: by 2002:a05:600c:a305:b0:489:2005:b36e with SMTP id
 5b1f17b1804b1-48e51f444e4mr89124245e9.19.1778164857819; 
 Thu, 07 May 2026 07:40:57 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538b26a3sm233623885e9.9.2026.05.07.07.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 07:40:57 -0700 (PDT)
Message-ID: <69fca479.050a0220.143608.4a70@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260507142202.4150-1-linuxtestproject.agent@gmail.com>
Date: Thu, 07 May 2026 14:40:56 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] userfaultfd: Add helper for checking UFFD feature support
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

> > +	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
> > +
> > +	uffdio_api.api = UFFD_API;
> > +	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
> 
> If SAFE_IOCTL calls tst_brk(TBROK) here, the local `uffd` is not
> closed before the test runner takes over; the cleanup functions only
> track the global `uffd`. Close it before the SAFE_IOCTL call, or
> restructure to guarantee SAFE_CLOSE on all exit paths.

This is not necessarily wrong, but since TBROK is called, fd is closed
with the process. We need to instruct the agent because I seen this
logical concept being missed a few times.

> 
> --- [PATCH 2/3] ---
> 
> On Thu, 7 May 2026 14:28:54 +0200, Ricardo Branco wrote:
> > [PATCH 2/3] userfaultfd: Use two-step handshake to probe features
> 
> > Fixes: 1840ee23d172b5ab04cca7c2acfa48755b041911
> 
> This commit is not reachable in the local git history (grafted shallow
> clone). Please verify the Fixes: tag resolves correctly against the
> upstream LTP tree.

Can you please double check this? Maybe we have an another issue
with the agent.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
