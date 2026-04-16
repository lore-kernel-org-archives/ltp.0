Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C417CF8A171
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 13:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776346283; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=8jHf/UfUuyPNYnAOPKk0pwvMbiqcqmnsQjJ9KnmFKxU=;
 b=qFb9iKgQafcWM40Yge87w4mll5f1kPoPoT3rgYMqQhFAbm//H6iBRx1L9afrgMv1qEx0B
 mTq+qIBSSIrfxs2gn+iiT8JUqZHI4krzDT7DeOSAbuDOqz+yV9Cr+exIx9kERu8f5OEWHvK
 4v7A5W3qgQuTB+n3+kwFiLahTGnRITs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 662013E2DED
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 15:31:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F20DE3C6AF9
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 15:30:59 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 792831400C78
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 15:30:58 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488ba840146so79271615e9.1
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 06:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776346258; x=1776951058; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=tmw1LrVp7sSUZCqE3zjVbGPzYV6mTWM9cmEgDhTftic=;
 b=U3q7a5F6XeUP1sC/SCMVP2SKYJXU6o8bc8kRRlErkvAYqRbK7mJYU36tIyDcvqsy/e
 u8bYIKaGPyHwNZXdZvyZ3di7eKssImdHn1mh7gzjCummFKOcbw/YgQv4oP9RGmlwbYCR
 bjSNdQ52O6fh22H2lNZ7GCSL3pVCL5NGzAVrCjh/mHPgLMdD8njFPXTy6bz5Txc8yIfy
 JipE8ckRrothTfCmswx7i9FKG2zerzd1o7rHKQzz6xhFgvYHMqDNBmR7ZNCgxb2hS4af
 3QBy7Ujp7zkyyshWjjGkLN1AOcTmlX7XLWInj2FtzBRUbja6nu7WEZvdSsts+hwC1Stv
 XEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776346258; x=1776951058;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tmw1LrVp7sSUZCqE3zjVbGPzYV6mTWM9cmEgDhTftic=;
 b=FRSS/F5LBDvlRCtQW3rLla7EGHEd+eQqEqHFMiN3mej6kxpBS1QvGF/VotXGUfPx0F
 Arz1/aAhAr3xCUM1OqKLu0cxF3byP3KT6FfNdcKyxDeE2IWOaB4DaiduBUQx6ol9mAhR
 pTk7GtjE+J/lLyei8LhwXRgMs/7joUboTw5SlxfCA3EAiT4mLJrvieIld9UPcEuEENUi
 yDo9rmXIyEFvXm9WSCL/2JMAq7el+bBvI9cc9gzAy+pu6UKWj2gvNHd0XzLiQ37ggROo
 +ooxUIck+1VO2Hkcb4ywqJxwq1+PCXqpwmNQJB+719SpkwLam1mNve8iCeK8qqPzb2KP
 zWiw==
X-Gm-Message-State: AOJu0Ywuz6rLG79DMMhh0lfPW43RIQE0oT/XSjvAjjBBYJwYHaH9zhO/
 mr3bij3VaGFLOR6gJrLzOMCNFJry3bem9e8b5NNY1CO5xmSC6wGyq/lBLA/azxDUCzX+ZBY0spM
 B/drymIaTcg==
X-Gm-Gg: AeBDieto3GYRgAKC0D3Si9aHZqGE0XTKojjNSRlbmhMMdSU/YhJTI58ECcejMKcztwz
 CKYMzBdp0Xgdoy38qB9uCQBKV6NGlUh0iCNdK2pj+bJt/JHFlVjSxNA49qoNLqVwnJLHPRiFuMg
 VZponzRmU9kEn7WHSzrt7v16hi6rUpqy79N8Xhm69g1GPw7hqk3R5LXO8uOITZHRl/sXRmKQLO6
 vnZ8sueafAmfh7j/O/Bwtu8U9B08XSV1yR+jRSetNha4y3ibnaHtAzwzbrDyY6fwkIQPMPCnipY
 rlPFFMemdhmIGpNR3dUX9OhFLwishgKrj0C5ow+P2zFefXEUPcfNd9cQUMwdXzJRYoZwEJSzMYY
 EKtrUY8UmX2v7OTzlXIVnLstycDrjnKhFA7umrPsoiDw3ibPhRgj711si6W56TEnLqvT3jwBhwO
 RPJyJcZUR3AgpQH2xqUqBGKZulcWm0Pc/Z2seEBW1E
X-Received: by 2002:a05:600d:d:b0:488:9e43:9690 with SMTP id
 5b1f17b1804b1-488d67dbf4amr280297485e9.10.1776346257756; 
 Thu, 16 Apr 2026 06:30:57 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5813954sm49099115e9.3.2026.04.16.06.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 06:30:57 -0700 (PDT)
Message-ID: <69e0e491.050a0220.362816.1c38@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260416132400.3046-1-always.starving0@gmail.com>
Date: Thu, 16 Apr 2026 13:30:56 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] read: verify read size and data correctness
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

Hi Jinseok,

> Hi,
> 
> Thanks for the review.
> 
> While looking into this further, I realized that strengthening read01.c
> in this way would make it overlap with read04.c.
> Would you prefer me to:
> 
> - keep read01.c as a minimal success test, or
> - update read01.c and drop read04.c as redundant?
> 
> The main distinction seems to be full read vs short read at EOF,
> so I wanted to confirm your preference before sending the
> next revision.
> 
> Thanks,
> Jinseok.

I'm sorry, indeed I didn't notice that this test was overlapping
I would keep the test minimal then, because we don't want to have
two tests haveing the same purpose.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
