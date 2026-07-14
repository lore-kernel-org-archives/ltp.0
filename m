Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A42C43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 08:07:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCBCC3E25A9
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 10:06:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 006493E21F0
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:06:31 +0200 (CEST)
Received: from mail-qk2-x03.google.com (mail-qk2-x03.google.com
 [IPv6:2607:f8b0:4864:34::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 638DA6007AA
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:06:31 +0200 (CEST)
Received: by mail-qk2-x03.google.com with SMTP id
 d75a77b69052e-51cafb11d1fso1232841cf.1
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 01:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784016390; x=1784621190; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5VqGefXlZ0/pLaYF97XfBMQ5EqehIacdQJc9SxqKcno=;
 b=JNNZV3hPIl+eJKE9xaPCA1ViyVVMYJhua/gPSnudgwrQ1qVgYbi/vEpE4fUkziFGiO
 FaIvuI5WNlCPRfXAeba70OrWR4J4YuJTyYwRlhe7pDI93GMwtRO3bHxkwr0Z0n50fxh9
 wRJ52QuEjGrpA/31CLkpK77MPzo6RztXV0Jqp58xM5RTcIZ/JWEq0ZE99oiiYhxLboZA
 09pHHqXXYH2V4sRISSr77RWScb0zlmjK3rDt5UwFhmRvwlTluxq9ypzOqEEuHUoyzFRA
 X/Iv55wLaCGFC8Dqgb67qa7J83Gy3MvQpEq3NHZYeYspch9e3qNSF6f8uk9m5oLMHSps
 QEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784016390; x=1784621190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5VqGefXlZ0/pLaYF97XfBMQ5EqehIacdQJc9SxqKcno=;
 b=oZ7fl+Jl9ziTRrmcSGyYboWFM1sR2LM6i34kPaw6Jza69UqTM3lLp5K5YPzGsviWe6
 UkgyNdA4iDE9zQ7vQlQQdpI5nRv3TA48Wezbqx2UaokZ5vk4vB8STme3nJtzfgbTLkWF
 eAQ9tQoo71JehbU30WnzLSbCQBB3vjaGGvXBwMZsqJ71N8ghKUuoPEazl96QFYA7yxOc
 /5kEtD65/juv8fxUsGWM0Rot//wAro96C1aoEEvm6hilh+rqSpuYBtiBudJ9PdH7DCeZ
 gr/KVOGl5Zc4XDlwPc9gJVrELqEFwdZ2qtstWQawoAeCv9KK3xEKw3PtHIBciJ8KDx9v
 263g==
X-Gm-Message-State: AOJu0Yz02++masMg4+ArapqTsNlE4HGbL+/aFG6VqxtWYKA0vFjI6cmk
 J++mrDOsJkuEDc8whoMIC5xxwKcUcmeXeJFXa0TavTrv3xknf7KtuC8e
X-Gm-Gg: AfdE7cngE1Z+oJlUqmG1MQRhNYToVMbnSyzuf4fFpfEuKd2CqwVzVwYqZpUWIZiArWZ
 4Tr6l7x+irxiGFsLMY1VPdE1OHZwbVTe08jDdBj6dWCIKWHtHOXbFLDNxGWhWs/FnEj87gsLBsu
 rJuGFcxPkR+EaCO+giKzQa/vBt/pZ4fDFWAoqpvpXNlBheFsZRws2tIDSuRwoFQHPlKY1NvtRlZ
 pDutP3ibJynOBYXR9OuEDA4avWphy/ESiH/sRbEhnjl4PXYCaDEzb/NqYTwYhlaSnGId6dLVRrp
 lSAj53OztOSJImaf7q871shVkOvoxrjxDRfahCOkxN6uZ7bvkL/F6h3qLVGkDVwRwvHrkyJI+Uk
 dNky4PcB/7nQMKwJjBRc9xFp7CKJ2zmnQDaDGBrV79BeXSz11TKropmlVsSu0oVJC3pGsrc2cOz
 PuMeZpDmULfZXSSOi+WShYxYXK0C/1tXVFyoOSwV5M3TR0Ckg42LNM7HdOkEAZV9WNa3c9Rckqh
 ywpAfAoyAJ6o0DzBXVu8gHMKkZqUc8=
X-Received: by 2002:ac8:7f89:0:b0:51a:8c99:1f17 with SMTP id
 d75a77b69052e-51cbf27fa24mr122120991cf.70.1784016389995; 
 Tue, 14 Jul 2026 01:06:29 -0700 (PDT)
Received: from
 runnervm5mmn9.pfe21i0rikauph5zkfwnlcew1b.ex.internal.cloudapp.net
 ([135.232.177.181]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd7c1d22bsm159656166d6.32.2026.07.14.01.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 01:06:29 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Runli <mingyu.he@shopee.com>
Date: Tue, 14 Jul 2026 08:06:28 +0000
Message-ID: <20260714080628.4032-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714031545.64932-1-mingyu.he@shopee.com>
References: <20260714031545.64932-1-mingyu.he@shopee.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] pty09: Cap RLIMIT_NOFILE-based slave PTY opens
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

Hi Runli,

On Tue, 14 Jul 2026, Runli wrote:
> pty09: Cap RLIMIT_NOFILE-based slave PTY opens

> +	if (max_pid_num > MAX_SLAVE_OPENS) {
> +		max_pid_num = MAX_SLAVE_OPENS;
> +		tst_res(TINFO, "Number of pids is too large, capped at: %u",
> +			max_pid_num);
> +	}

The value being capped is derived from RLIMIT_NOFILE (open file descriptor
slots), not process IDs.  "Number of pids is too large" describes the wrong
resource.

The commit message itself uses the accurate term ("slave opens").  Suggest
aligning the TINFO message with that:

    tst_res(TINFO, "Number of slave opens is too large, capped at: %u",
            max_pid_num);

Pre-existing issue: the containing function count_avail_pid() and its local
variable max_pid_num carry the same "pid" misnomer for what is really an
open-fd-slot count.  Not introduced by this patch, but worth noting.

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
