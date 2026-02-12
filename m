Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED9DEB48F0
	for <ltp@archiver.kernel.org>; Thu, 12 Feb 2026 09:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770889874; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=De7e8wL3pAhpwvkdKAmJfi+KYOXkA2u7l8E2+bfZyWc=;
 b=owGhY+HeeAi5V72+tU/nybYlMcHwc14cOKbCPNm5EZD5WTKzmw0xQO3jcHCJfgsknxbQ1
 wcOaAjAHGLYGscRg6UPxvB4l7NjGVhoFInzsy7sreutl/I65LXzqWYbmm/11MvGGeuIsw7O
 8Q8pM57j9quLjtV5f6KkuYGTBXSY7/k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 420593CF26C
	for <ltp@archiver.kernel.org>; Thu, 12 Feb 2026 10:51:14 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27F883CE9C1
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 10:50:49 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 96B4910009F3
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 10:50:48 +0100 (CET)
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso17845015e9.1
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 01:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1770889848; x=1771494648; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jTdquhsh6dB4VzGavcAcA6sSdhv4gwMI5MEJIPTHmvE=;
 b=TY2JR3sga4knvJEfDmZuFRUes5slJfd/wwXb0AdMOVzxmwv5DCdUWqDxDxkvZyM9K0
 pqnfw8+d9wv8GCziT2XvfVfVEUsPXDZoqSVZiNcoE6K8sDLnmJ6SVD9cs+ghep2kkBjv
 U6/B5ar1S93fj495jQuyfyRtlO5QKabNm0pem42gg+hqnFhMNnmIJciXECuVlbD8cUsi
 rDpBqGm5OzpF0og/6wFYVCOmm+i7CdL7TinkXcWl7d87Om8JZAl3ZbNejeRHdVXkl0bo
 KtY4gZRyK5DkT7Quna5lt3HRgY1f+ntr0Hd3So2hZQaZbpokCJtsyCRijlY+XCbozHln
 aJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770889848; x=1771494648;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jTdquhsh6dB4VzGavcAcA6sSdhv4gwMI5MEJIPTHmvE=;
 b=Kw8twRPPBD2WTYm4ydLDhQPFtFZ6gbIbsOdEKA6MrhRHbAA3u3IQLpO1IiDPkLDfTX
 19O4aBQQFHCT6thltB0ZurHVD/1DmRScAfPSauELrDb4FOyNioJ0O7vH4fqRoUB2nVBA
 pppqQDLRIQK911aYL9W63awWJxzu0XysYOwDwWcYsSZM5GUnOJe+Tv1CDf1AwjEIpsMU
 sI7pl1XAdvEEoDAEf7QeyIeKDk5HoGfpIbUSFPo6qDm7n+N34HSe+f+kaGeBRfNhy51z
 O65GZEfck4RuDUGv3DlJJIYhQF1lufe/UEUktrEwGxrZBMxK2R8rM138Y+QYOg23rX6K
 rjoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7uuNOgOs1RhhmEjAunPJS+HuGKinYmkz8StojomHZfnswb+ZPmQn4zjPrpkVWGupeZg0=@lists.linux.it
X-Gm-Message-State: AOJu0Yw0+LnYXH1cdoSLRxK04kVfA6BLL9DaZd99MvUt5fLZ+xnuVseg
 dn6gC6uqBAM1S7lElXrDjfFzsBcHRzNyEOwp/EgrWo/ZiHDb5MYFn7VmRQBY9tiSnEr1efcex0Z
 to8Y1wOu5nXqX
X-Gm-Gg: AZuq6aKg6cChRd4JSB2pG4ag1y0jCqS98oyebOxyOXaTXxS6g0ncuBKTH71PMGIA455
 BTFwfxGMpmiKd6XtKD9HwGL2fX6qiLHGYPmG4ZQy96xe2w49B70QP2BhN3Z5s6Kk8HACkO33LXF
 nsFuSYf/GIGoHSj0nnIoytU9yZ9eD98VHfeNUOZXWKiQPXpPlDo4PXfaCZkLtE+kxucT2VI34A+
 /2aceCY0/KRc2eelXC1hTPBj4z3c2hYPc3zBDodjx63n2LCw4pe9ABji+SVNdUolmYCCVqRtSkJ
 1NddoYKN8yqVFB35uCCsWiCAMLGxAiF4O8EeWhSkgxKL/xE+O2n+SoRJmI495YddiOC9vjcFkx0
 UcdjAZsTi1rh3xz+UAUgcdJ7T0nnvKj5EXyDaGHpu9NyobicSg1ENdrM0M7YNfr2V2GsOvuBywD
 9+Ql0BJ19mOIm0cNQAJBPSObuUh7Wjt3Y=
X-Received: by 2002:a05:600c:8010:b0:483:14ec:5925 with SMTP id
 5b1f17b1804b1-48365febeaemr25452855e9.2.1770889847835; 
 Thu, 12 Feb 2026 01:50:47 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5e11f5sm174637195e9.4.2026.02.12.01.50.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 01:50:47 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 12 Feb 2026 10:50:46 +0100
Message-Id: <DGCW24NO41YF.34RVLSFL2026H@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>
X-Mailer: aerc 0.18.2
References: <20260211-fix_doc_build-v1-1-42897785e0c7@suse.com>
 <aYyrcqnGWKhsIUej@yuki.lan> <20260212084804.GA5659@pevik>
 <DGCV06VWH5W4.2S96MUIO5X4ZL@suse.com> <20260212093257.GA8902@pevik>
In-Reply-To: <20260212093257.GA8902@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: fix documentation build with latest
 setuptools
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> It is a workaround in a sense because new linuxdoc master thanks to my fix [1]

Now it's more clear, thanks for fixing it!

> will not need setuptools any more (which I explained in my patch). Normally we
> would update, but upstream does not have time to release.
>
> Also, new release will use hatch, we'll need to use pyproject.toml instead of
> requirements.txt.

Isn't pyproject.toml used specifically for python projects? I'm not sure
about our LTP documentation setup which is just a sphinx configuration.


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
