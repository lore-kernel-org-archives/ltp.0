Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4883DCD98F2
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 13:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781704585; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=ZBSOpBcSPULItt1H/YxbrxRbJ+/DknQqrwapc8mvsqs=;
 b=mkz8iNKGVxBx3OiNNALS/m5EjjnRj2UhPHng+0QjVxMVwfeW0h6looo2i/etEdSs7Z2c8
 LpbJ5gKGvLgQaq/rsNcFlZdz7iEg/IGj9Hery9bg2K1VARizntfM/ghN14PxzU0p5kbkqhB
 Nf5XH5KKupm5KIytR03vlYf2pjeW2to=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 662653E5939
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 15:56:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96C743E4E33
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 15:56:03 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1E1891A00666
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 15:56:02 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so40557385e9.1
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 06:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781704562; x=1782309362; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=xgZs+pNH4t6uAhcOK06IJaVCeMqEIx0Z3B8RCf81JNU=;
 b=PXFutuEGD/avYjuBkBnJbCqpRoeah9512+Z3/e5PTyX+2JsUQ8D6pdIXoGit37Vfvk
 0Tn2l2br+pV2Ff5/XBGc2UENFquRvz0dN/zhLlK/qh6U3xxJu1jqtWguBe6hMD0lwIHa
 23+zqLXXo7TRsR4Kb7uMYZz+ODM23km4BwU4yekShUVsitQa7GUV7f9WfL5rhBpjcZL/
 G9d+0MOQN0d6EvzLb2aB2Z1R6Ks/vZZbn8VGLHv+FhfMpZ6E0oGqnoYmRI/X9QYyp+yH
 qf/1PAc5paBSEzJ5sBmAU/rS6dHuQgLW4BGd4N0rlpAs3VHav48HYvLFeIzBUMVfzuaO
 YQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781704562; x=1782309362;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xgZs+pNH4t6uAhcOK06IJaVCeMqEIx0Z3B8RCf81JNU=;
 b=O2emNog/fHdiuPVnzh8YZ/YfQ5Tmu+XJEGgK2E7UFZl6068aRlKUsaup5WVbIMELdX
 nrEy5Gk2uzhT6DqHUe8UD9KhT0Mrt8uDRCpNIp6eNd11xQwEfd8bxzrZcfIYLugZOZaO
 0jdvzdVgz23/NwUR2ZliLBTjJZiPLkhmOUH7EPp6WcNWUCGTOZUDRjjIAEE39HVda6wm
 JplfnPvatPYUFYF9odlcDgW7COe9SOQK72h75rWZvDIC1mfDACAJbiZQZTA1PWbbx8yu
 GMjqWglai4gVHsvQb4HpqujAcus3iiie05nX+wg+LW8KyTjLpP2EEklffiBzkpfsdFVa
 pBpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9SG/Lr3x6bjMv1V6DtrS/ZN7rqPoQEaqKQdvGlS0Lf4a1xxCx6B94aCfJ9zgNu9Fc2aPA=@lists.linux.it
X-Gm-Message-State: AOJu0Yyzu6eiciZHIVXpvFnnhjeSb67Df01JqqedprxJ2zNPrx86hG6t
 pHe1ZMIDxYezCa1QHwFTAxHPzBeJjHUjfcre7YI1YRMP1LZ+dY3sKvQ+xSgWucC9FN3sA07X9ov
 kiSWhtvw=
X-Gm-Gg: Acq92OHZ0INO00vIaMHcx+yMnb7et6tuXdOAs7Uag/OWwWVhnJhll6VuKHf3ijufXtX
 L+E+v5Cv+GjKHwEE3oZuB1Axc2vMedN/wW5e4WlqxzS5+bDDoubWcUxEwQiSqxsc7wL93xb0ilE
 Ew9vsP6/omBb86UpACdfSR3W59c6W5MuoPO7UGq0WhW+gzJhCfBOWwVFNIQFjk3gSdCcUBndv/G
 YhuPCqMk0s48yn1JVJOj7QiXJvJxLN39GCu31fAghNX3pScYicRlgcMfWJJmd+jCgFWxOUj4WQ1
 SuYK+NMjCg5OSP/mk5wDE+WTAqeFOAas3R7lo15G5ei69old3Jq3sG2McdhxQbr+eact2256xfZ
 P870mZaycMM161BDtOn8fWSbVen+prW1qvqg6fJ/HUmUiZWNp5UwlNrPXzYaKESoePCDzkv2i04
 q0OZOLj199c5mJxmLx0Kr81OntIa0ccyN+rAUgt130nY6QZtEXXMr/V3qTA/8haw==
X-Received: by 2002:a05:600d:103:b0:492:10e8:3f92 with SMTP id
 5b1f17b1804b1-492333c94f6mr47501445e9.17.1781704562261; 
 Wed, 17 Jun 2026 06:56:02 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a8ec56sm145734345e9.9.2026.06.17.06.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 06:56:01 -0700 (PDT)
Message-ID: <6a32a771.5e46ca1c.2772d7.360b@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <aivMbUk008_2cMSU@yuki.lan>
Date: Wed, 17 Jun 2026 13:56:01 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] swap: Add exfat to filesystems requiring
 tst_fill_file
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

Hi Cyril,

> > maybe I reproduced it, but it would be nice to have the test output
> > as well. Also Kernel 7.1 is still in RC stage, so this patch must
> > wait kernel release before being considered valid.
> 
> If it's reproducible only in 7.1 isn't it a kernel regression?

Had time to go back looking at the results. Error was caused by an
another issue on my side. I also can't reprouce the issue on kernel
7.1.0 after the release. I ran swapon01, but it runs fine.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
