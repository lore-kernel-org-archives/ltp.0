Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96AAC5DF9D
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 08:37:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38FA33D0660
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 10:37:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B17613C2603
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 10:36:56 +0200 (CEST)
Received: from mail-pz2-x0b.google.com (mail-pz2-x0b.google.com
 [IPv6:2607:f8b0:4864:3b::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 37BEE14001EB
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 10:36:56 +0200 (CEST)
Received: by mail-pz2-x0b.google.com with SMTP id
 41be03b00d2f7-cc1cb94b583so422806a12.0
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 01:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787819814; x=1788424614; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rb4hhIzLvpT6f2Zu5wky96BhtIDileFFqPPYbrJOrrk=;
 b=Tg4hFPYYYx+dFspysRfvX5LjFfEpPeeaB4DOk94JVo99uq4NttmBsttZcUxlAHvEkY
 y7gluyh2E28KksRtq6JoSQyqXUcYdkAtdx8UpzZ3NC3T+SKJBB7J8806E2ABYgL21wbD
 EZcBUUzVEoCB5j+wQqM7ymvVmJq0Qry9DGtMpCmtghDucO5F9pjA8PxWNhme9Y24l3hg
 4AfH3xHnTQ4jDaT6uDvAerwBzcMo0rLYcubY5oygOqvV3YGw5qRBhU3/hKsxdvLy1z5/
 ilfFlOWIp3G13nGLWx35g/mTpjYATSVJwxPQyjkVc1mKycAmsadj+3OGT9Jz4usyKnPD
 bC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787819814; x=1788424614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Rb4hhIzLvpT6f2Zu5wky96BhtIDileFFqPPYbrJOrrk=;
 b=kv553MFb5eG08+EnesWmq1Lx+BJEpBzH3yC7SzkHk9QyepFBtDw9ZqXJ05x0905YZH
 CKh9llIafyc86vIMUCEnJQcC02UUA1UyUM7MQqWY4rIWtRpBH7TWzRo4Ti+m8BDkgiXU
 pmTrdnMVjLdWQd6YrzUjo2X1MtfFqCFbC/hAnC0aLn85mKel/CLjXqDZUtKNd4sh2SP8
 sHe2PqASZCAUHchHXYpDW6KtNME04qrkM3u5JFJzv79ZqFFSFomzY+92Nd4NmXKnHbxW
 mFpG864bOBDG2cOy7XFt/lHKVq0HigbKGdDgJh5Cno/rf6mHJvDAH82QygHazF0kF8EW
 8bxw==
X-Gm-Message-State: AFuF++lpd6JV755UUNa5KG4u5+GRmOg0ocWk95tXdYWipeLiu6Jgc2Mu
 pbdu9/T1FWBzx+X7P1nqvvCkozqm5QSW7MvPPMo3Bt6e4tACkim6b3AntvMeT4U+
X-Gm-Gg: AR+sD12R62lKZNHNxZKAvbQ842enI72qmKyVqRid8U/W4qCDMSq3Dhi3nkClY/UgGx5
 QOeOm2tE4BQVB5AXbYxVMt7nGdCMniY8kxf1BFLlUIYxdj2e16UqjhFBLoYMrehckWwXsBHZNXR
 HNSZg+ggKFBreG6fYVawkQvN9F/8JH/NJhD/qNbolZG+KEiLsjxGcmWoRmD6HstKx+KhllFR9Ph
 GUtWERrwvXhG6f8YphHEzTBaWCsNFJW7vb7OckTWgV25eClVjcWs9Fb/6mDAlrUSmimKZiBkxBb
 deDcdDqSuDyD1vLupiBA8ShU0y5fY+QRyGRHbstO/Kr7/VnuELX0e3D8Kc/CFzuT+7V4YdwwBnG
 213trcRS0G33vamrTCuJvz2mKOiv7khRpcHdK7PABuYE1B+htcz8CZKo0mMKUd4MTp+HTxTOUV1
 iuiT6Tm8XelbLWsQ6r546WeSRdfAc7ZhLD6o1P/ffJ95UdvI7sc4KDOcszzF7ziMk3ol5Te2Mzt
 JO5wVl1molUrOdAc2BQMKRroyFwP7UGZs8IsQM4T6gMQcSqLyfoTVe5T36wlaDYzNU+r/eOy6q2
 myiQyToRkapgLg==
X-Received: by 2002:a05:6a21:497:b0:3cc:eea9:f757 with SMTP id
 adf61e73a8af0-3cf8445b305mr29145303637.16.1787819814390; 
 Thu, 27 Aug 2026 01:36:54 -0700 (PDT)
Received: from
 runnervmgx7h7.kgil3twzltkufo2gekkesmjjke.dx.internal.cloudapp.net
 ([172.184.209.113]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d884ca8sm17329660eec.15.2026.08.27.01.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 01:36:52 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 27 Aug 2026 08:36:35 +0000
Message-ID: <20260827083636.8672-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826-cve-ghostlock-v4-1-52ec94d6635f@suse.com>
References: <20260826-cve-ghostlock-v4-1-52ec94d6635f@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/prctl: add more fallback definitions
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

Hi Andrea,

On Aug 26, 2026, Andrea Cervesato wrote:
> lapi/prctl: add more fallback definitions

--- [PATCH 1/2] ---

> +#ifndef PR_SET_MM_MAP
> +# define PR_SET_MM_MAP	14
> +#endif
> +#ifndef PR_SET_MM_MAP_SIZE
> +# define PR_SET_MM_MAP_SIZE	15
> +#endif
> +
> +#if !(HAVE_STRUCT_PRCTL_MM_MAP) && !defined(PR_SET_MM_MAP)
> +struct prctl_mm_map {

Could the struct guard depend only on HAVE_STRUCT_PRCTL_MM_MAP? Since
PR_SET_MM_MAP is defined immediately above, !defined(PR_SET_MM_MAP) is always
false here. On systems missing struct prctl_mm_map, the fallback is therefore
not emitted and ghostlock.c fails to compile.

--- [PATCH 2/2] ---

> +	map.start_code = map.start_data = map.end_data =
> +	map.start_brk = map.brk = map.start_stack = map.arg_start =
> +	map.arg_end = map.env_start = map.env_end = (uint64_t)(uintptr_t)&sz;
> +	map.end_code = map.start_code + 0x1000;

Could this probe use the real process map values, as waiter_fn() does? A
successful PR_SET_MM_MAP call writes these values into current->mm. In
particular, start_brk and brk remain set to setup()'s local stack address
after setup() returns. A later brk() allocation below that address is rejected
as being below mm->start_brk, so pthread creation or another allocation can
fail for a reason unrelated to the CVE.

> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.runtime = 180,

Could this declare .min_kver = "3.18", or otherwise treat EINVAL from
PR_SET_MM_MAP_SIZE as an unavailable prerequisite? PR_SET_MM_MAP was added in
Linux 3.18, while the CVE affects older kernels. On such a kernel,
SAFE_PRCTL() currently reports TBROK rather than TCONF.

>  cve-2014-0196 cve-2016-7117 cve-2017-2671 cve-2017-17052 cve-2017-17053 refluxfs:  CFLAGS += -pthread
> +cve-2014-0196 cve-2016-7117 cve-2017-2671 cve-2017-17052 cve-2017-17053 ghostlock:  CFLAGS += -pthread

Could ghostlock be added to the existing assignment instead? The new line
passes -pthread twice to every pre-existing target listed there.

>  refluxfs
>  sctphantom
> +ghostlock

Could ghostlock be inserted in sorted order?

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
