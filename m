Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1932C624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 09:21:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C4953E9374
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 11:21:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42A7E3E15C1
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 11:20:49 +0200 (CEST)
Received: from mail-qk2-x07.google.com (mail-qk2-x07.google.com
 [IPv6:2607:f8b0:4864:34::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E4FBF2010FC
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 11:20:48 +0200 (CEST)
Received: by mail-qk2-x07.google.com with SMTP id
 af79cd13be357-938c17645ccso57399185a.1
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 02:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788513648; x=1789118448; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HxY9lcox0UO/1YUJM7DnbzsYaRW+Ao3x/sJ6kkjYKsk=;
 b=g9xUh7O3j/TcXrk1+qbMr5Jg2jC1Qxkwv9g6fiJw1F0RNgENfX5/B+9jbF1JYmCO1J
 ER4N5jqnyaAvAotWxOEmZUL8nZ8RT/GbdKyk0AfAU7uBmpUyP8Xr6R0ETfPkiQ4PN+PQ
 kAu7CPClGH+jmJ2/N3i+4w/lM7uWmLW2E6K9szopGa8DDK69LlH1d8oYliGnTczoaEuL
 /tMG2YWl/Iku9+3FUH8kmVFBey3Ft/fVyQSfu6ClFSunNqJ2ygn3T/PLdVvB3jzCzKol
 dPwQPE2eeTs45oKZ0X30nNXW/zvMfHpQko4UoqKYaqbJOIKIgRp7j3UsVkoOUupmbPEy
 twWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788513648; x=1789118448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HxY9lcox0UO/1YUJM7DnbzsYaRW+Ao3x/sJ6kkjYKsk=;
 b=FZTzO4gUX6Jmyh6c+JJ0HIVlP1NzH2cmQLNJnpHiSNkU7ReRp13UShk0RnnL3qSZlf
 WPH8h6si71U+dUWtBFyMSYFXZie6gZbtkka3o8SU58AGLBPI870pp9dXJeI2l51CNyCj
 fqWjQsxNi4sgtjEXWVGE+F+P+/rfatzCqlh4rbpkCIJZQ02+3ZMI/lfr/LwfpCYLLcfl
 P1bVkfBfYiABjx2tXgEj9cJuNprmXxU5r5VePjg7PguKuMJWIpd7ZXRGaDnegYjq4ZpN
 8dSq8Ijhmrg0OrITssj8fD0jlf+SMN3IrJGT5IZcHiOKr88rn0xlo0XbyBofq3uApkHi
 3BMw==
X-Gm-Message-State: AFuF++kGs7EVqrXz2NQxTNH9kXOARTkp1M240i83WeCfQgg6OClvai0e
 v3DSixwZ9H+/eCSEIqNPZ23T2JPRCHQ9uE3/hLEUgSIuGs6AD5tc2+3g
X-Gm-Gg: AYBFou2rHuFQ5ZppTL46Pj3Oy/1krtXmq3MwUqrfNNDxSKRxAD8pu4mLEuoJYuoaMAL
 wRkMOUcheys+gU3r/RU9rr0uOhvSPTEkido9D/ds7XeV67Rq2r3CmfQlS0dTpO06kjivIFVgfdX
 4c3GboZzr7xujcAV3XlA6Ku2va42nAkUUkzUqWgNj/pCgTpyZPfNNEMl0e3IHBpGiZUfjEDIwEu
 5/3RYAYniY/3vfoD4/q18NVVrxm+ukFkogxKaG7iU+hvAvKc0XQHUm8vcMXaqgv/vLBe1mVFNH6
 oIgBkEMc6/+XZxJChVc3W+u5kHW/yznbBRAieZjaUdBT3u12I1SF7E80PqLGurBMuy0c9maGBOw
 e4TBF2Lpfco7ukoJdHfX6ISJeaz8npi0HmgrQSJjp8zc+vMcuOYjDnlZ2XpmlJGgR9kySX9mWR3
 GXM2FjhOGKMxlMzXZitDYlEKszoPFJMTLUs7kydmWNtkKSRy+kG9x93Ob5diBQ9dUaQfMvSizAr
 74LHJw1YlF+Zl3dE3h4EM3XduSyVHLY6IWKCEdaaoD/+jfnlqhAGWHAoLxL+YQq9MUd5NVfzBd7
 3g==
X-Received: by 2002:a05:620a:d95:b0:936:bc40:cae2 with SMTP id
 af79cd13be357-9398072a8c0mr448426185a.39.1788513647777; 
 Fri, 04 Sep 2026 02:20:47 -0700 (PDT)
Received: from
 runnervmgx7h7.gvdpdkbpqlwevgifsipgujp5cd.bx.internal.cloudapp.net
 ([172.174.190.71]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-910406b0f51sm15748366d6.42.2026.09.04.02.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 02:20:47 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri,  4 Sep 2026 09:20:46 +0000
Message-ID: <20260904092047.8942-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904-min_kernel-v1-1-47b556550780@suse.com>
References: <20260904-min_kernel-v1-1-47b556550780@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Check minimal supported kernel version
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

On September 4, 2026, Andrea Cervesato wrote:
> lib: Check minimal supported kernel version

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
