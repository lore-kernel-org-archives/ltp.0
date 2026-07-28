Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500E2C53219
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 13:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785243999; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=ENVLX7EfSKtYoQKCDJT1he78aoL8voupX8iMb51S3XQ=;
 b=BnTk7ndk0QpLoPzqC3hmjnPiQjrxrMy9P5hKIo8YSEwTo4rfqyOphISRP5v5Ml65nxPzR
 91nmO2rTXV9aekEUxP5Rp5cVcVR2q1v92gIeCgoI8ReDPUnbVf/zQHUR30A9RA+q3ldyc3C
 zBemtdU3niViCDM63dg+kEjUacfyd70=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94C463E658A
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 15:06:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C655E3E14C8
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 15:06:18 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3E1BA2009A0
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 15:06:18 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso20068815e9.3
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 06:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785243977; x=1785848777; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=p+tqyxt/L8LpAz4ZQPxe00QNql0SkMcPFSK3DRCnXm0=;
 b=Fpi3g1uCWYvMP5V0KzS/5st6KN6N0htDGwQA0AsrV8Iu29AcAaB0fD5kJywKE5uGQp
 BZXK2O5JSeLMNVDGgr1w7/YXxmwXKRrugvblowCx53uS7Xp8xanSyWXTHAhvXaSqcOEe
 Ob/yRmBCryrvG6/HA3mdK0i/gPArtOXhf1luzvLbmSHBceOE2KhjCwqB1IEDBibMLRyZ
 dX15IQT71rQvjlBGRGYf4vh8Yqmb/XcwEBcxIoWsRjkpzkGc6IHEVORS4orT4E4dtzeC
 x4rgKcFQ8Vm2PAZa+dxuJWv9IMejiEghzG9rJ4E+iWz9/eOagxAfLbP3srL7UUE2Jq2k
 KD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785243977; x=1785848777;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p+tqyxt/L8LpAz4ZQPxe00QNql0SkMcPFSK3DRCnXm0=;
 b=e0TH8nBX0YLfGxS+f3XMOF85zEIQ7ml6PnS65/eHHVATSfBQP0xTx0hj79ehoYJIwm
 k0dkSZC4gBaLk1QTOzaGCSbVYvhTk7m0OAaDc+/4M9qJ+Z9moZk8JvcSPybUIIs8FLaU
 h2T171ll9egodbQODKbtQqLDqaLPWlv6HlqoMRrDej9GYlj+lm2GHayLy7mFHe+spkAo
 VWJIGkdp32yVl0liq1NqUI+HcFBtsPCUXyCoBtLO1UChORMGQzRA7XDnvB8qDdJv+1s1
 EPuCiWtsJ0iwDot5LGvdlqo2tVjvPIWRHzHCnfkLbKbLV5xOR56IrZzxzmGhpZOSzcyG
 0e9g==
X-Gm-Message-State: AOJu0YwoPasguiy+jX5tfAdfdSZ2zX6mDniVV9t/cPq9Gd03L/esmhpw
 mgd+zE2wfLbCjC5TM9sRmNeuY5MZ4uYkxTQoFUktXw76Uj8KzKCA22Mcm6cId/SrpjRfdr+URS/
 P/gZz4yTUNw==
X-Gm-Gg: AR+sD11kZVLTYX5o2kRS0/0X6lPpWarMZOlCNW+0FhKRig3XBi7zfSY4POdc1ub/FqV
 IG5lbHYtXZ2W0o8p9F/wejvq5Aw7AYE7hFpkGgMmFqe+N8pT9QxkXwBqEmoXFgr25Jt8yvuubos
 F7/PQgaup9jFLFa3IHXL3iN7I0ppSxFEamleu04cwcaxrS3plOVQV5UZGluHe4IYrVUlBHVINwb
 UJMYXAQmLaCPL7Ym+QeoJkA45H9LLLHatfX6fr+B4sT8YJ7mM+/Cjw9Yj2b5A1xGThLLi1WG66S
 wfS0nkMl1Th5xAgl1yQICCRbVO9Iehol8ZLBJEeXOO+uxeE6Jy5FFRGOzgo4mGLZkxBj/neZxgt
 mTyFAshJ7tS1Ck95gexbZrFPeYH/XK68OXfUV3hv5XAsJMR46++46IUg6JkD1Ons2hs+vxjtiMl
 jp0lnjIjhRr3DJ6+EE8a8zLQ==
X-Received: by 2002:a05:600c:46cf:b0:495:503f:cf9a with SMTP id
 5b1f17b1804b1-496c6425f1dmr26203565e9.9.1785243977437; 
 Tue, 28 Jul 2026 06:06:17 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c44b84edsm124354525e9.5.2026.07.28.06.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 06:06:16 -0700 (PDT)
Message-ID: <6a68a948.af19844c.435dd.4d07@mx.google.com>
To: "Stephen Bertram via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260721135530.2882066-1-sbertram@redhat.com>
Date: Tue, 28 Jul 2026 13:06:14 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] semctl01: tolerate SEM_STAT races under
 parallel LTP runs
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
Cc: Stephen Bertram <sbertram@redhat.com>, fdarocha@redhat.com,
 ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Stephen,

> +/*
> + * SEM_STAT takes an ipc idr index. Under parallel IPC tests that index can
> + * vanish between IPC_INFO and SEM_STAT (EIDRM/EINVAL). Refresh and retry.
> + */
> +static int do_sem_stat(union semun arg)
> +{
> +	int idx;
> +	unsigned int retries = 5;
> +
> +	do {
> +		int info_id = 0;
> +
> +		idx = SAFE_SEMCTL(info_id, 0, IPC_INFO, (union semun)&ipc_buf);
> +		TEST(semctl(idx, 0, SEM_STAT, arg));
> +		if (TST_RET >= 0)
> +			return TST_RET;
> +		if (TST_ERR != EIDRM && TST_ERR != EINVAL)
> +			tst_brk(TBROK | TERRNO, "semctl(SEM_STAT)");
> +	} while (--retries);
> +
> +	tst_brk(TBROK | TERRNO, "semctl(SEM_STAT) still failing after retries");
> +	return -1;
> +}
> +

In LTP we have TST_RETRY_FUNC/TST_RETRY_FN_EXP_BACKOFF, please use
this one instead.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
