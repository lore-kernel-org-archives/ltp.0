Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802F1C624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 08:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788512274; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=nD70yKRMjC1dJYUL08T5Xr7Q6qrbs/pPrIlLTRkXT2zqzjMNyYbx6bWNOQSBTsr0PW6Ti
 KAhnYJ/Z5PhrTpO9Ga8MNwXnK7h9tWpzJcKK8j7HfLYS5jFUC0zgQYx/uK4hf/xEPZeYpR4
 YPMaOk7yjJ8Mnm4sGVEnXBoa4CS6cYI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29ABD3E939E
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 10:57:54 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC43C3E937E
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 10:57:08 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 221AC1A0117A
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 10:57:08 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-485850cbac3so473050f8f.3
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 01:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788512227; x=1789117027; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=D0dnc/wM+Gc4ZKNYKmiyKedn1YGZWIhoP8eb1mYTbja5LitS96TnlEnlVOJtIvdMvh
 Y831aqdfyjv8BrxRtDwDJ5h1pluUFBdReoY4s2eV+/a+7JAl1mjBhXjC4Y/k8aYbPfoP
 d5GOXGQ8OnKc2z0afcpiLN/mhwWftplf3Q0CZz+V5X+Tg2jYj+jDvHtOMppoYdmQoQ5+
 IwhjU+pJ9GM/jJPvGqPmalViPE6qZsgIFlqaOouOkamzMkEXOFJ1xfYJYojcyt+zSVju
 TsFbe7HnhqPyIU++Wl+c62b3DTFEnPFqm7y5L17RX2IndKqdMx/IW+g0oUSinMgT3mcl
 mOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788512227; x=1789117027;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=sHCxnhaOpkP4Rzr/btMdFQuSY2Ugmc3KDgb9gBHM9wE4+qtrcA/qtzJJ5e2MMw6+cY
 +w0rt2ECmgpj8+MQGxlBtpNSs+D1W+SPzmmxDRMvl16RhCXdI23ZNrad4WnLIrp2LR08
 tuBBM5JV68U4ZnIS5YX9SdJKuVOdD/je/0GLoCT93B2l7sQ19AStbTocYg1EGxoBg09V
 9waYIC5uPI+HongJ9f+UMUaJictwSXxSsmOcOL2j5h1BNmfuJpOctgKfH431AfVtRYRb
 XlxzyscLThVrnGhBJMCF1/4DpbS2coDPyKHphRfb1CudeF+PmRZckGlNd41vhpXYGVYX
 bBMQ==
X-Gm-Message-State: AFuF++nrhglTOXSiCC8ELg0Ns49p+VEpCAEqnR3wHqGrsBQlmuxwQM7J
 vMVfqcZMa7WAET5gM4jpqNki/3MT2w7wAJn1DHDYVL0zHHB5lj4IEuYnWYA6w0dgfZlXsqiNQPR
 SSNHbVmHhbA==
X-Gm-Gg: AYBFou3eYBSFtmocL1q2dGjTGgidGW6SEqw/i4eCiXbznk8zD9HxoTKxFgxXwc1DEvM
 k3I5nF4/Dyvz0oHBmlczpDfbBQV8pKBC33Rl9Pk2X7m5+jixzMKsBjzdRXWh5W4STLlBLiMDX2n
 vyk6UHcby5pk+RPfXMjUTKULCqQnsuOX7UIywR76V5JXez1NBnPZfV28yZJrTl+lDz4Xztie4Wz
 qBV9gjUe5VTbQeG0vWg0ldlCZwm1ePnkMA7/tpSAnVU2GsMgsXUjwD3saWGHuhO0pjeke2E6zWs
 dzT+ZOF4b2RC0bP/ST0MWxH+Z8RG1Hry0yKb+EKhtcxQqg/TqV0iCAUtMlezU8JB70ongK+DIHe
 K2K5quyjAMUPTHQRMstBeSDR7SQmc7dwn70Kz1Pbo/VoW8cfN2aZ1qVraulymBY0mvUDt3uygd/
 L2XndQKx94cNVlaz06mWusPlkM3qTISqBflUkS9qJ35FEUASY1AYQ7WBNeGjQv0XGEeykSZgSdq
 EG+XE+1h7ccPa/jSUC6A2BP
X-Received: by 2002:a05:6000:4694:b0:482:ee81:f0ca with SMTP id
 ffacd0b85a97d-485872a56e6mr6242540f8f.12.1788512227502; 
 Fri, 04 Sep 2026 01:57:07 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885be01bsm4485565f8f.31.2026.09.04.01.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 01:57:07 -0700 (PDT)
Message-ID: <6a9a87e3.c69142e7.327fff.2ded@mx.google.com>
To: "Wake Liu" <wakel@google.com>
In-Reply-To: <20260901224512.1180203-1-wakel@google.com>
Date: Fri, 04 Sep 2026 08:57:06 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/sched: Fix sched_getattr/setattr fallback
 definitions
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
