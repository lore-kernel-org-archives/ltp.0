Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A427C4451C
	for <ltp@archiver.kernel.org>; Sat, 18 Jul 2026 07:55:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC0343E24C0
	for <ltp@archiver.kernel.org>; Sat, 18 Jul 2026 09:55:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F9EE3E1B2A
 for <ltp@lists.linux.it>; Sat, 18 Jul 2026 09:54:58 +0200 (CEST)
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BC9321400262
 for <ltp@lists.linux.it>; Sat, 18 Jul 2026 09:54:57 +0200 (CEST)
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-37fb1883f59so2886362a91.1
 for <ltp@lists.linux.it>; Sat, 18 Jul 2026 00:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784361296; x=1784966096; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7jfY//iVcxHmEjgOr90F6uSnEN/al+9b0SRzThAVO3Q=;
 b=kyKZ/RaE1vYWHgt3WBO4Tuqj8zzKtMvYdao8PCFgZqQsrrAwNbOuKkepBbWY2D8PEW
 oMFNmFWn05GVLVvtbs7RO1Gzir9uyizdfR97HGymI27W0JMJuq6Mn9odI70j5zJjBHX2
 hROtQl026K4Yt8ONSC8QFY0i1KR7zXBhv9xe3maD6zJ/Z22/58atjKYGptwJwDFmdG7E
 ZciT3v27RHJWhdWxqa5Huib1KQH4XhlICwe89gflHrdxJujhNQ9nQW13g80co6231GGI
 68PanzlMSZ7v88u0M27MHy/N0eRCVL3UaZEWa+qjv6gC2cLx5uUJAWHZqy1wa32TmFQ1
 yVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784361296; x=1784966096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7jfY//iVcxHmEjgOr90F6uSnEN/al+9b0SRzThAVO3Q=;
 b=tOQc2KGIalnlbpIJl0IsdrTvr5Vwf9oodP9rKHBhYtYha7izhI+h1FGljm6hxKEdIP
 vGR0HmufUvNjmvcANg1VhVp9rZM9jPmzCuw+SX79uweC+c4wJOh4tfSZ+dHKGWbXHW6X
 g/SX2QBQOkSZCnQjEph5/E3t3byGPKCURm6p/cD0SYCAOGmGdIRiaPN6TALmviOxG0H8
 5rf7GBE1aFZkIR37sFlLZ09QbomfxBx4Dgfg/LIU31FP+Yk+QTcToNmrjqH275t5L0e7
 8pSpFyF9AigiMzIZGKdJjKFIYqUCu0u9FNBhfauXZ1x4SqYqJNcSZUHYx2IuDRwVwu2t
 ao2g==
X-Gm-Message-State: AOJu0YwYlkRZZvK72snqivg+m9Lb3plvojzgdjt5V40rsdp1E6z9TQPp
 h6zRtcoRBV1Wshtp30ScQgMJk8SXR0Z+534UBWDprOgkyrLYoqmIzS/B
X-Gm-Gg: AfdE7cnHNC4gN9/aivybmzOBbboImk669OlhIJLZ9EIXYbpyDr4/N6KnBESPCJ+qfZK
 2mYedUGv2uei+fVsiFaCVWRaSMDB7QIC1miYEg6JAQpC8aJADIF14DDNIX80dRrPwpaYxL1Og4S
 Yxd3jTiU16o8ZhmJijcK+i0wMz0IMVr1/++CAZDO9vUd3yN5cU7qJTFYHm7Lae5Zn9sfNnNViWR
 SePhj6ehKQo7DBRDTpO1BoOXYQQ0k9w60jdR8wwokJJyneaCDkQJqV6ubqvkxrIShwSBB5Mwj2K
 OGjYVuCox3jlWpodBI0v6K9AGBdLBI6eAwiJZqmPOvY3Zp1AnbfxlHj3fp9COIzWJjnEh1MXRgl
 32sP5k+wrL77wOLcUqsr9lgHATA5FVuebwrEtPqTSgjhjndgpWTBE8jvjgf5OnM04vaw8/pq2bO
 +hhavy0bdpvZTKe22sL5u3fnVzwrHs9Y8LTl2QgXdC776j2ZYuKI45HWhLqWHnRkLM2GcUoREBB
 oCJL81zD8obg443
X-Received: by 2002:a05:6300:2284:b0:3c0:9c19:65a1 with SMTP id
 adf61e73a8af0-3c3ada952cfmr6040830637.73.1784361296061; 
 Sat, 18 Jul 2026 00:54:56 -0700 (PDT)
Received: from
 runnervm3jd5f.iocqbfkwkbwutl5mx142enzt2e.dx.internal.cloudapp.net
 ([52.234.42.32]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9d444sm17173216eec.6.2026.07.18.00.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 00:54:55 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Sat, 18 Jul 2026 07:54:54 +0000
Message-ID: <20260718075454.4123-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260718063815.1260992-1-pavrampu@linux.ibm.com>
References: <20260718063815.1260992-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap/hugemmap38: migrate libhugetlbfs test
 truncate_reserve_wraparound.c
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

Hi Pavithra,

On Sat, 18 Jul 2026 12:08:15 +0530, Pavithra wrote:
> hugemmap/hugemmap38: migrate libhugetlbfs test truncate_reserve_wraparound.c

> It ensures that reserved hugepages are properly tracked through the
> complete lifecycle

The sentence ends without a period and "the complete lifecycle" is left
unspecified. The doc comment inside the file describes the sequence as:
mmap (reserves page), touch (instantiates page), truncate (releases page),
and attempted access (triggers SIGBUS). Should the commit body spell that
out as well?

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
