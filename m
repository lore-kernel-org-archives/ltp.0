Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761D0C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 15:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783696534; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=oNvvLUnAEZdgvhGQt5hEPGSyn74tA4xlgCrqCmsl0DE=;
 b=J7bfIXmQ/qYxHb6VZ0pWtE44sCiZ80ypyfk1npLa46ftjVn43SfnisdH/hIClfmlUZf2A
 kYL9ME8bojj0VI6P2LSm/MDJ0VZAoD1bb9uQBucYiqM6GEDgLxE54lF2yooopho5RWZrY2x
 7tFvCSDmsmQ459OW0xnEVUkmEmKiJxk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4B983E5C5C
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 17:15:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F5083E293D
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 17:15:14 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DB956200AF8
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 17:15:13 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493f4638f4aso8038135e9.3
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 08:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783696513; x=1784301313; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ilVIblEASelruSTsGBVGMgv2Gb3RabZ0ToSH2znJQGc=;
 b=MkQ8iRbMz/ROzxTgnx75Z2PdeMmqJw1o2AnX4sjCvEivq0ZKx0tx6cByW47q+obfAK
 JcjxYedqQTDKbBBKMhSGfVFrV6kDH3BR2y2wXVVM3AXSNr98sGIK4c1WS33X3quk5MJp
 UKQorKRqPlZK7odOg0oRASXpD0HFf3/HckZKJib9EzxiL3h9daA+w0kCqNCEiHmC/ryK
 ydF/nCKt1YTS2+ZzcC8hMagL6Ez7QnFsWH+/87NDsMmEJce6S6Vw5optiiuVhXXRgfbN
 fohl7wS2V4JmA6BGpPrmBZhlInT26CbFcja9jWQ5hYleJ9mneDsipnHz8uFSXxYfe8ew
 MLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783696513; x=1784301313;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ilVIblEASelruSTsGBVGMgv2Gb3RabZ0ToSH2znJQGc=;
 b=gc+lTUh3auy9tThaMNcMdlrvtlCSD2ILXMKuDvJYZGwfjYY5J6t0zgwEVdQDJt0ot5
 wrGGVGjdHPeOJ9/5e7B4SUkqYtHXTnfxp/qKttoTCyRcNNrcug3VQy4M/PBoVcm42y4v
 no0ui9U88Ska01n1hWh8uhthAJKkATUtyN3mOvSD6A3YSc96RnfXWy5OBEKQv7uv/DoK
 FPXWBnxZ2yXUR9TXGltvGFtiu1idDULDOkOF7MH0r4jtphRrmSHhJoF/tCGTJ+PLRsOc
 mXn1g4gGYUJ57ccBDH0bN3k4CgO7y+bO3qU1ZuVrVXFW/+mdIVJKGjl7qElLXYPKJkq4
 Jd2w==
X-Forwarded-Encrypted: i=1;
 AHgh+RogUw78d/oXZE4iJJGF1o9By1/gBxTyAEMIby3xzlHHOE+FG7+oCGOEDgqYllgV92cnflg=@lists.linux.it
X-Gm-Message-State: AOJu0YwbOZBcYj0pQCYOZsylnWwpy+HUTehyPJcPPx0YDaUtbn80dJCj
 Mlk6sY34U7yIdDGQxNTIHiUhriogL2lTqdked/m+5FwC+HD4jE2kay5FEoEO2NrhnIs=
X-Gm-Gg: AfdE7clu4e0vHOdMgYUQCf3jMSfMUKlvHycUtRWACR9ZhY1wQVhzZKJ/Rhxn71fowzW
 JDq3AV/Ay6UgGPE3XtpgzrnhfA7PbgzvUMC1YFDoewc6XaOcG85b98aRIxnAyUcnc86kwhh4qqj
 uJ5OY1Cz8HIHrKJOQIdljjk4YduvZN48dLwWdQ5xjno9DYStb7Aa1Dk2s5PV2mhcXcfUYguU+zA
 vq1zKQfFqS0fF5R4jhQI+zE1i3d9NTCpKl8hCyO5tZG3gJWgkudqogz22d0l8CyMJlFX18V1LS9
 yC0MvI0XQlZBNZtZ/Ex2k+n1L/NqZqNBrln+7NkjzD+TuLYEXkboOV7tt6g56dE9GP1wtakUzuu
 TTo7OhwhJRmuY06gyViB3ifZ9SToVV1pLcwPSQBxnuOrsHF+uAhiSAXCaimRI42a5kPfYVeyQBW
 50B9yrFr6HscdAv5ot4YIo9KxwK5vJvNGHSFhi
X-Received: by 2002:a05:600c:6206:b0:493:bc92:ba9a with SMTP id
 5b1f17b1804b1-493e68bee61mr129252755e9.13.1783696513160; 
 Fri, 10 Jul 2026 08:15:13 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f3b85sm236121895e9.2.2026.07.10.08.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 08:15:12 -0700 (PDT)
Message-ID: <6a510c80.fc4d87c3.115da4.55fa@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <alDtz7CMmysJtlAp@rei>
Date: Fri, 10 Jul 2026 15:15:11 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] kill11: Skip pipe-based core dumps per
 signal
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

> Hi!
> > > Well either we do that, or we skip the signals that dump core when we
> > > are dumping into the pipe.
> > 
> > To me it looks good to skip the signals which are not allowing child
> > to be killed after coredump. It's a systemd feature we can't workaround
> > in this case.
> 
> Thinking of it once more, I wonder what exactly fails in the
> systemd-coredump case. I guess that it may delay the test execution a
> bit but the crashed process should eventualy quit and the test wait()
> call should collect it. If that wasn't the case systemd-coredump would
> break one of the fundamentals of UNIX process management.

Let's forget about systemd for a second.

The problem is that by using `pause()` that is not draining the buffer we
never ends the piped user-space helper. The default behaviour for a piped
helper is that kernel collect the coredump until helper drains the pipe.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
