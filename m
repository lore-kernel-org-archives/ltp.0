Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1324ED29FEF
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 11:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768391861; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=/T5F+KLS0QaMMIVKIryAzcjReWmHgZP2byVYrOey98Y=;
 b=b6mQf9MHs6rUpF2B7we1jTolFRJsOHrNJgM6+pwmPDaKwnwOqG9+U0wvKvNvUm+saLfzG
 sAvV5CxnfR44ZCHRXnTUfrBERHzZxl/umbmL8yuvyZC2pNMnCY2bEySVvqzTBANDzKZ7qTf
 unPf8sCW2UQdPW3ftgGS+Ow8TDrxX/Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 863643C9A81
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 12:57:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7C8C3C99D6
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 12:57:15 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5BBD0600269
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 12:57:15 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47d3ffa5f33so39091655e9.2
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 03:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768391835; x=1768996635; darn=lists.linux.it;
 h=in-reply-to:references:subject:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BGiYcHoBbaGQjWloiKFzy7M1+qsj0BksV9PHyfpPUos=;
 b=O4tbtfeGRy2sfOet8ZQnq0OGZfB6MSz5AXLzBX4qHdj1gu6g3wdM/knhGReDkjn5B+
 fdK8wsZ/9u+JsfcNG0p9MoofUggfsyuc2KEt7+jx0ankgJyntgdSEu19Hkt32egHEcsE
 fiRg6W+wiHlHJWKtxTT/fj4eYkne/3pgkiysPN5zg9c0hEduy/vV7UGP7042MGmM8Nvv
 rjXdcS3XuW7iZTZEzrm8ryx/YsewKsXoKVvIsRUGK2xX8W5x8qQubG9dqZBEw3f6T0YN
 505JDyt0CZ7F4MLPTZIq6EMnygRpVMnM+e9Tm6w1yZofl9zLO2/rOaphgIUbjP7QEPBG
 mcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768391835; x=1768996635;
 h=in-reply-to:references:subject:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BGiYcHoBbaGQjWloiKFzy7M1+qsj0BksV9PHyfpPUos=;
 b=FmaqD8byJp4H8a0MroRl9Kt3xHnC6KGbwDj0LINxsPbCpjZrGCDGexiOl8SM+xvNOG
 u74x3XfmrY+oU6YQ+x5bh4LTcTDFaFO3SiOakMXraESKgXI+5F89ZjxTaoURSpIcXPMe
 V9h6V5ovBkU0qvYi0rha/28cURU8KkMlRimSTO1XRPLUjnEyqznlrhG6Xatul5DLmCdp
 lqHhds6C9wI2ZCUFF+noUSHOUFqmPg/iyVCyYKNs8YSWEbL4myqUulcwGGObMThQ/xAp
 V0C7PsATVYQP2aCG+7IUuaDhvleYzJ2mp4lcPJ2YBLMW9GpLJPWS5qGT6unse5BhU6tH
 oRbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuWjiOtFtjCC402EBL5+L9s7Uyu36a5pC0rSqVXw4a1t9EjzGFubUPGCAX2LU7YPP7dto=@lists.linux.it
X-Gm-Message-State: AOJu0Yy5rdqQrLUAar1M+3FIK/7o29odonoE5DrKr7UmTuTgEeBdO6/t
 yfXazDi10GFaoK8gWzC1Gfa86PdZl7LBaQfic56/gFcejddBVVWpl0F5rhd/aznzZ0I=
X-Gm-Gg: AY/fxX6aoec7tlwE/gN8Kushh0ijSWhBC1IqwrxAPb2PuDQ6iRslMiE0pLLn5ir/5PV
 c8LRRvvZf4GkT7HQW4EUFEOeeH18jgPHqr8qyKU6lHejZYKEUmzCVD6UXv1j7NEajSoQfh+Mj76
 7tnrEP6OBhR+JJs6i2Ij1JF39ZGiA2ylByKSPd76HtG4qbinMVMrZh5XIxOx+6Bd9AcNhut0cqz
 E7jjNwIGJY1uMrCzl3hw1BF3T5KsjfNb3vrmDzFiuJOv+oyhcISrWuAH05traqRM44H7dsVA329
 jCzLc9jlQF2XWpIRh/jI8ma5ahm5jCkui9VL6HZhx+CbL1mpjzT52aeeiExtn9NcyHlHP7cVhXd
 saTp/O6go19JWo1cJ5WWzJgB6+e0NA6oLArg3Z6myXkTQjhGRK/Q9MT30l0EndFVyb1knByLp/n
 TbOXkXz9KqFx9l/j7TVDxoAFgUSwR3MAMAh7Clypco9BXTo/EKsf3D74MvHRD3mTlNx1dz8nWJy
 aI1
X-Received: by 2002:a05:600c:1991:b0:477:a02d:397a with SMTP id
 5b1f17b1804b1-47ee3318f31mr24952885e9.2.1768391834654; 
 Wed, 14 Jan 2026 03:57:14 -0800 (PST)
Received: from localhost
 (p200300ff0f0b7b017e458f16f8082810.dip0.t-ipconnect.de.
 [2003:ff:f0b:7b01:7e45:8f16:f808:2810])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee2a5e48asm17602145e9.20.2026.01.14.03.57.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 03:57:14 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 14 Jan 2026 12:57:13 +0100
Message-Id: <DFOAL5AIRA82.3IWRU2HFDI1L@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260114115020.348101-1-pvorel@suse.cz>
In-Reply-To: <20260114115020.348101-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: Use man7.org also for git man pages
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

thanks for fixing it. Feel free to merge.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
