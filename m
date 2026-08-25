Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87323C61DBD
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 17:35:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDB793C71FD
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 19:34:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E2B03C2CE3
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 19:34:42 +0200 (CEST)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 71988600714
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 19:34:42 +0200 (CEST)
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7e9f1f24cbcso98685a34.0
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 10:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787679281; x=1788284081; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W1uuChJIFRzoxj45BtJbypp8EDKxCfJ+DocZ8gWG/Tg=;
 b=XUzn7P5ttdbebt3sJ2NukivFcmoangJNsVSdUa0TWrVL5NpejH9nUL82g+GGxJCKz7
 CO8LLy5HM+Kw81PhTJ+pbbhPGAAfcuQDWYqMDLzIen+5DOpU1UeKXieoVXhv0vtLlqmB
 t0yzv2n0wvK2b/bInrTKlhulS/RZAZrEB+SMNzHMP56/STOJqMpWXDgiIbRr0kFEiu2J
 mU7a533D2SS0fCdV7PT6feXTqLD5xzzvGGoHIpMcXjCGOA3U8nNswVcjJYxZmPu5bq+D
 MMiR8RFoPF1FjgcCvSEO80NntoO5/C7WhA9NuMf01ldMGs6L8cbr3jZf33Ek7RfEBbyj
 5EvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787679281; x=1788284081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=W1uuChJIFRzoxj45BtJbypp8EDKxCfJ+DocZ8gWG/Tg=;
 b=mG/u6wnuEUI8Jh0AXJ72XaATh61plzgclVrhSh3UWKCVDCLi4OndtvCmJchr1T/Yf9
 h6jy2MyDPkeZbB/gmyhsGqC+NlqM4Q17BVGBSNi0JUtNoM/VZLcP5q+VzXXro2rp7ogo
 yMP4STChmelVt1p8bpjVeagCeDT4jDML9l0t5pQMfXSINed/GTLOYoiV4W1foRBZSaPj
 eDl/38hdmJZSNmQ060+Uv1MByDK/XxX+jfDXclPvDPSKGjsUsxK/oSfBQzv9YhD8ReMf
 qHIit/8qTKcBJAFvQx20ak2u4u4oNjg/c/m7K4KW2FZXabQE9rQLc/GS+SZseUUQhlxb
 SsBA==
X-Gm-Message-State: AFuF++mmgECEmlNBw0gN8hexZXqHtaH9B5pKyeAR1wAoeGzaA1gSVRDW
 nqU0QQGk6DIiVKH0DHSEu04RmfPFxucLnmm2uHT8C1noRIs9aTGoACSm
X-Gm-Gg: AR+sD10VqnEDsCKx8xs71l82+r3Zi2iJbZrYZ9Eu9j9raZ9CbSdrQ2Fy2cgHWDc9Xgv
 M9WbdGfcem3Bz1+IuOK0fHeadoYC1ZPg/zZQ/mS9+pwvZKTL6+pLOEABr1jqmcrzR/FFy2ZnbWk
 vkz+I00dB0KntBT8Kg1wrqwQi3GauKFPxNqmCpJ7C9Hlh62GD6UZLd3HnGPzRsDSIcqaVbZYZou
 yzHsdG3bq0aOMmMOGXHF7vF4Ipu0+uEKwfV3XyoPFFIy7wIVx0+HwMLwsrkArUsqJyVxWKPWa0n
 u4ZO9GBbD48oCIhFRl4RXJr8bo5Hnbh23H3eQ2C6gYcSG7CdvjD3epEYD18bJdj2IcgjPKFKE3b
 yqOqYdM9zBR5xXLjPE2JK3nyJGVifqCvNewX1P673DDzwboKt6jzBS1GLOavp4aoiX+npnrds72
 96p6jvxFqltl/MX9E7XTRxGZQqKZWDXGpz/+kE6xW5Vz6mMY09cQr1fM+VG2QQGa6RVCxogTux+
 2yucc3x6IG6EnVA/K4beLigxhdAeAeRk7PyNwsVES1N8fjZ5bkx60fSaJ3n8wBn1T9ItLzOUHgG
 AeV6pbWbOg==
X-Received: by 2002:a9d:6659:0:b0:7ed:ce16:7d72 with SMTP id
 46e09a7af769-7f4aec4808dmr5204184a34.5.1787679280991; 
 Tue, 25 Aug 2026 10:34:40 -0700 (PDT)
Received: from
 runnervm76f27.ugd2vj5l4uoe1ofxiuw3zjeule.gx.internal.cloudapp.net
 ([13.89.124.29]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4c44dedfbsm117896a34.26.2026.08.25.10.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 10:34:40 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Nirmoy Das <nirmoyd@nvidia.com>
Date: Tue, 25 Aug 2026 17:34:39 +0000
Message-ID: <20260825173439.3829-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825152544.1675541-1-nirmoyd@nvidia.com>
References: <20260825152544.1675541-1-nirmoyd@nvidia.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] getrusage03: account for percpu RSS counter batching
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

Hi Nirmoy,

On Aug 25, 2026, Nirmoy Das wrote:
> getrusage03: account for percpu RSS counter batching

> +	long batch = MAX(32L, tst_ncpus() * 2);
> +	long delta = MAXRSS_BATCHES * batch * SAFE_SYSCONF(_SC_PAGESIZE) / 1024;

Could this allowance also scale by the number of online CPUs? An mm's
anonymous RSS counter can retain up to batch - 1 pages on every CPU visited
by the child, and task migration does not flush the previous CPU's local
counter. Linux's own error bound in __percpu_counter_compare() is
batch * num_online_cpus().

For example, with 64 online CPUs and 4 KiB pages, the batch is 128 pages.
This code computes 1 MiB and therefore retains the old 20 MiB floor, while
partial batches on 41 CPUs can already omit more than 20 MiB. The failure
this patch intends to address therefore remains possible.

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
