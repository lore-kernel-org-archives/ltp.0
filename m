Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158F6C5CFDB
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 11:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786619371; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=WJmaFF8zrGLgWhsJYiDKGEsC56Xt1/bC6xptAhyvhYBvroQQLMi9e6C9ycp3htyyN2+h7
 vl31yi32tz2TTB9Nig8ZXYPAdOUKJP9emKMw2DtrlpAgCXXzq8CwoQp/d/3XM9DQyVWETEf
 wOfl247f7n5ViY0SCjNZivtIXWb2XG8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE7C83E6BFA
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 13:09:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C831A3E249C
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 13:09:10 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2E60A140076E
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 13:09:10 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4954dff6536so14397555e9.0
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 04:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786619349; x=1787224149; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Yoi+mNFl87uMQHRqooMnmIA8aI8oNNCNNGfAwrBaM1JSON4JopGwdVnvKHZdOmBHp+
 yknj2N/Wvz1ZXrLBTBU2MnjGyWlOQIUSKJad6uf56EmZ4ZZ6iMEyWIlZS7WRGqbOjjFZ
 BZizG7rarGDmCk0G+WwE2jrTrGj2zpE2Y/Uv7x37L23QUdg+PLeEat93Zvrijo8Ul3qr
 qQ/bp2MTdhjIAG99SXy4ZL5+9kcRGC1bNpVI2+5pwsSEkXZNwnat+Ue/ecwpjtKAf76J
 YqPrV/MzX9/4ZqNhCKRAM10m4BqML60AGEgj0HmEMDDZXp/CPJTYDqoEO4pyMAZZp7Iq
 Frew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786619349; x=1787224149;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=hewijUdKwkEhJgG7idFucYDr9TXZzX69zbbHTpA1NU7jiwxDoO0x6+ezF22s2bd/fo
 /OqSCPbRH3lbsClghwPNaargOrbkk88JnitAewSSVrLGIVRjD4LpqqojYwvkANDGsTNV
 eglzsMs8PCwmptVRHxbqIl7GBSskqk+X/3uI79TVTC3fSa3J68IpXAWkljN4PlMS7/2O
 JdD/UB02o5e/M6xcbW2GmqT8IGora/wt9S3IB+QlQ9YAPYFid2h172a2Mc0gQsEwPusw
 hrj9BNJujMzne6csFosJ6TVvTcvi6x/QT+8VJdesBJMW15Y9NpOTbom77lH9HXEVnEQs
 cjRQ==
X-Gm-Message-State: AOJu0YzYGvQmpAc19etJ81O0HLR5d1gzchZD7meBIxlk4b1+ylb4eO+s
 NWENTwG5mg0o+j4JTMFRUv0M5fBL8NX7vTqY7rtVxoalDJLB+SKozvOkXjRVBIicKaU3C1+SElE
 7edj6OuE=
X-Gm-Gg: AR+sD101rJP2Lb9fJoxbY4k0MvHRuLBqXI3nuLOQqaaUsuxxo1rOOCEl2g1+cC0mM7j
 DUY2wzLrtLhmQ12BzOv5P8P7FSEiuOGGcRDYkUqD5v/eGKipqSwJlvaJ2/oB16vlGZpe6bQPjZv
 1Z2sMoqMWtNn2FVzK1CwqFDtGSRAQCwkuxvuIsShjIInFr77f/jkL38ZfkOSAh3N/8MCrxmFr3q
 3BERlQbq21llEQBzJePzuaLKYCbGj5peSu68IVJOnjgbmLV2qodIbw+R7a2pgYazwRoRjbF0gm/
 qaU40L+URt+3naUMFhyY2/0J2rtXQ7GZCoObyml+8HDDwnd2T9Z+0IGzATGOghu1AxKBAb+nIrV
 mz9Xf/RY6JFPXSnTX4cqGROg+oUz6wIWi+LBz8X8GBWBTg0kDHsFAaXbcQM7cgK0ddF+3ouDZro
 rfByVqoLQ0pJ5in+CJEb0ZVK4YrtoYUJQldJvTCk+UsB4t187opuv7zikdWszUpMLXfggJqtY=
X-Received: by 2002:a05:600c:a01:b0:499:79b9:e220 with SMTP id
 5b1f17b1804b1-499821ba270mr43985415e9.10.1786619349450; 
 Thu, 13 Aug 2026 04:09:09 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981ded713sm36278205e9.1.2026.08.13.04.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 04:09:09 -0700 (PDT)
Message-ID: <6a7da5d5.fe7f0a4c.7cd5f.34ad@mx.google.com>
To: "Avinesh Kumar" <avinesh.kumar@suse.com>
In-Reply-To: <20260811144854.97821-1-avinesh.kumar@suse.com>
Date: Thu, 13 Aug 2026 11:09:08 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] openposix: Remove timer_*/speculative tests for
 invalid timerid
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
