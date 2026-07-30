Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547C8C55162
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 11:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785410155; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=EjMfR1MGcK1cDWpLBlo7Yhcs/fK585FwY/kxAnKb7U4=;
 b=iD28uduZaVDOJ5PD3LE2jHDUzco7s072/tYRkyn+KAcbnti3mzRjnGzqun8j6d4pVyEcn
 9oFL3Jo5TtX7IbmIdEWGoTxRyTgcBlf+OXeCF6fjJEEq2CXlzvMl6ugMJx7GFGYMPdl9cT0
 B8GF0zg98j2vi2r2Lcn+smH+srVqmi0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E12C03E7226
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 13:15:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 675BC3E49F7
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 13:15:36 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C0B7A14000F0
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 13:15:35 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-47f71156e1aso1049808f8f.3
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 04:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785410135; x=1786014935; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MVKRj3b32vh7BUNVqSv8PS5OK0NLg3/jMehPgw1poaY=;
 b=Mcgu07e5lt9PL7Cfpf5pWL7fa3V9ilt14D4fL9uv2JS8hjHFA/s3+eo3oss9a6l//R
 u7F6T+iS1n4mQ/mPpT8KpbrncQxeenVhLW46+V9PDcgNH71kO5bJXegeyCXyfM3R5L6q
 jlz7c0lYWTwi3jDuZtdZ1dIEcMWWSFXXC9PUOuzm683lAHhmKe9veMGUkN1MK+knfumy
 1B4N5EeUtjhR0wA/PPtDylaPzv9EGAqMKvPktqVM5/kBH+9T0dvvyZlN/ZywTdKUnB2Z
 73hW0o0wDCuUjf07GMZL4OZNUiEjthX2fopXqBnCkE44mV3TWsiPhS2HJQZD5R675E8Q
 PNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785410135; x=1786014935;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MVKRj3b32vh7BUNVqSv8PS5OK0NLg3/jMehPgw1poaY=;
 b=OLa1AY5fmT2ZdAr0mItU6+XBHAbgdnrYRdqeTZFaE4jSbGVSVT7gg2koBFHYzcMmWg
 YZaweQb6ntRYgxOyYtchvFxDqOFg86xyuzFIwXnQ/LNUE74pBedIUvs/aKt5xiiDJ7Vc
 cP7eGpUagUYCX8yHN8v7nL42AXamj/7gAKy1+FUJpRj6H18KkudYIk++FIL2JlzJkHWj
 pdsQJ0V4JIMgXj+3OhwanpXSeNjif92PDBS3U6uk2g+DF/RlCmDyGACwGYWQcDha3c/u
 glXcKjh7ye/7RfN+dAK9iCho539Y+qxJmQsgNENhh6D+WtNJo/E9mYE7ocrKjGMOD3/E
 frlA==
X-Gm-Message-State: AOJu0Yz87UJPrDqPWHzdUS5Ni+jHnUQLIOQE1MY6uvnsnFfaQCZuHCvY
 rmAlyljwSqxmvoYgzeEPEBrMwTD9JLems/b74f2Kyzw8d4qtNCX6Ltma0LIyvE4vyPMSFWN1iiZ
 OlqpzIIgPuQ==
X-Gm-Gg: AR+sD10v6U7m1BmpA0yGrM/aCNulpTmf8INOwVUv9B6YRa/P2pzrsaYGMLS7+2Czg1C
 JzCgFO/7YmQ6ACqJOnrWM8IGMSCgpF4uzLOjWNjSVh7uLafKqND7TFO9NM4UQHFQyuJQ0ZIDH83
 j5fR7Fh57wV/1izCthlcvI6maHiuX0EkzBcf0upm1nqxqSUEEWIQ602nSwo9Bdo+nUYF0+V8ms5
 Z7QE/jC7P1c7IPUlwcyKGlwmqO4blXC9PxJayhb5ieQIRBj3Tj+DhFveLkwM1ITrmyHzjCmlx/P
 5sLhn1lFmchVdT5qgEzlPQFOxq5juCKPaAdUddy1Ce9m7n0ZROGPLczi18T7Ng9n9XoyyAHH+/G
 SXjbZYdRlOj+bfKR7t+5qrLAd6d5lRwv0Wl7mCCHYdEuNax10XwK1U5IPy9/XqC5JRaxd26Sv1P
 BMOFdXKXN/Ian4tD5gOC1aNd3fZ8dwpRLpvoP23qVuIg1Y76+wn4rdVnQsMpF3he9LEfUonnakO
 sKU4PSfsbMQ4Acry5cxbpuQW2Cvn+x+ru4AsA==
X-Received: by 2002:a05:6000:220b:b0:472:7dce:d8c7 with SMTP id
 ffacd0b85a97d-47fc81f36eamr2813014f8f.36.1785410134936; 
 Thu, 30 Jul 2026 04:15:34 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc893fe58sm8790449f8f.31.2026.07.30.04.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 04:15:34 -0700 (PDT)
Message-ID: <6a6b3256.9325fd96.a3326.fd87@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260715123612.1684984-5-chrubis@suse.cz>
Date: Thu, 30 Jul 2026 11:15:34 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/5] syscalls: Add epoll_wait15
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

> +	if (epoll_wait(efd, &ev, 1, 2000) == 1)
> +		tst_atomic_add_return(1, woken);

Maybe here we can track errors via TWARN just in case?

Otherwise:

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
