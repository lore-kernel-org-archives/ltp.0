Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7E6CD342C
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 02:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778122756; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=yCAZ31/+4A01KD4EEtunTTRRMu7N7MgarjpOH1y1qzg=;
 b=g02oGRm7eEINkQnEoKwyrBTaXDiiBdW1mqR5ghmtAN6dNTuWWwlFESVIrZAhJMNmOjtbl
 9OpDzZOW7yeM4rhKQm0+I5BI4K4fdfgxyCC/Q5NyVROXkmxV/xUkfAgKRrUilPO6yJIAgm1
 j3F/dJJgdUy4siOZizwhz6VNrzjAihU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0D093C0367
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 04:59:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F0043C0367
 for <ltp@lists.linux.it>; Thu,  7 May 2026 04:58:51 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1A79610005E4
 for <ltp@lists.linux.it>; Thu,  7 May 2026 04:58:49 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso2683545e9.3
 for <ltp@lists.linux.it>; Wed, 06 May 2026 19:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778122728; x=1778727528; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uSXxHKrgbDz8xdX5SyP1JAQE0LsvwmzaYYu1YxtsS6k=;
 b=DqMYmtjbGsVUbumWRJX26d02nVx7qdI0PSLVqIbRGFnqhAgSjr1U12ZyDbI/Nfc5bQ
 z9uAtYLLRut7503vV6zlWOw4AJJjCj/uJSEdPGCGykJNt3u09+3dybRJw73kTAsWyVqe
 zbVgd0o7mcczIT0xTp6FgLhsMWPu+j6XFrtCJ/WcR8kFFDbossY+J9HTVPgDfzKEvGvb
 e/RpQmicYjCQZLAfGNEhzBBgJXUS1esgJkfK5xJiGRABvHqvWVGISVP63oIh1jY6nNUZ
 DkxyTymNvJGlGCoUhiP6wuMNKFvuSuWz06VPuJKg4HMsWOVTXrbJ07nSyp2GyHvxO0KI
 umfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778122728; x=1778727528;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uSXxHKrgbDz8xdX5SyP1JAQE0LsvwmzaYYu1YxtsS6k=;
 b=JX5onpF9ErzkljIglu/wpXXLGRNlZa2AcDR72yPPOTwyd6CYKRLuCsAuQ8qcAwHrfk
 f6UqN8kRyevx2krrkx5BOkGTNzcMfMWOjTFhrsS4ykytGNa04idwmFvRyBw+m2koi2Jb
 618XDVSVEL/INRo4ooX4nrZEddW4b4TDvsX+dw40PVCf+krcAn6T1pVvENoPsJjQzzew
 6cCl7auBKKRf5KtzdyxZ7d50d27io5SCJIPMXwUbaBsiJA3ys7Jty/IKboMYvTfZjTCp
 hHEEP+QiKCH/hBy05yv6cv3/RZdjmGOFS88WXptuNID8T15pi9F7w7iUQat1U1yPkv/5
 K8KA==
X-Gm-Message-State: AOJu0YzmuQ81ncAPurOv6yxoINqZhFFVjvsVCoRLFiMzE+3eEystiFS7
 IZcOJm+0GDxBA2zwhyC+la6QbIfc1/kVUh1PmOjK/cmag5GCN3NjgCnjpCwD6tojMQ==
X-Gm-Gg: AeBDievwjW6JkkRSWGoTVpWJUZCm9dDYgl2mG/fRqRefoG0/wHKmslDnuIZVu7FEfy0
 aQ1hUszoZ9iTEh7ZU4h5z5cvb4dr/WsWxhqnbxR/Ji4POZlE+QHxv6lqMn+HVkNJg1VwZ0QQFQH
 oSdrux9/ZQfZZxiph4CYQhawXOEMTM4iuO0yRz6AutrVdzQVnX8HAIx4udAwh9lUSMjkse0/YgO
 5bEDrFBZSzr1YAWHou9sciMn5bunDSIL5iDfizjwn+FtKDrzC7TqzJgtNUpxFnLcT+BUzStuHqL
 bMRYedKui5ZqneQuF7PQY1LzgeSbVl4T3pfygF9icmDoFPPCV7s5p/I7Y8OstDfucbX6FijBZLP
 D+JL6wQgMPmKNfeQA4brrl96whyEnkbzw9KVT2rMGP8xYZhamHydI4UjmMdDJ6dlrnrNUs8Pri4
 y5KOaBstIqY5dnA7hCmBdJNJRXEvWaKUAiGrmQG0wI3ibccJnqjuE=
X-Received: by 2002:a05:600c:8011:b0:488:904b:f31 with SMTP id
 5b1f17b1804b1-48e51f3bbabmr91701855e9.22.1778122728563; 
 Wed, 06 May 2026 19:58:48 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505238e174sm17243820f8f.1.2026.05.06.19.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:58:47 -0700 (PDT)
Date: Thu, 7 May 2026 02:58:46 +0000
To: linuxtestproject.agent@gmail.com
Message-ID: <afv_5kw2BGj6G6br@autotest-wegao.qe.prg2.suse.org>
References: <20260331111857.10995-1-wegao@suse.com>
 <20260429145132.4008-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260429145132.4008-1-linuxtestproject.agent@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fanotify22.c: handle multiple asynchronous error events
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Apr 29, 2026 at 02:51:32PM +0000, linuxtestproject.agent@gmail.com wrote:
> Hi Wei,
> 
> On 2026-03-31, Wei Gao <wegao@suse.com> wrote:
> > fanotify22.c: handle multiple asynchronous error events
> 
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202602042124.87bd00e3-lkp@intel.com
> > Signed-off-by: Wei Gao <wegao@suse.com>
> 
> This fixes a known sporadic failure; please add a Fixes: tag referencing
> the LTP commit that introduced fanotify22.
LTP test was technically correct for the kernel behavior at the time it was written,
so no need add Fixes tag.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
