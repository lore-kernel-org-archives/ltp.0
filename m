Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B914C5AD55
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 03:56:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 162093CB43A
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 05:56:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D419C3CB270
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 05:56:04 +0200 (CEST)
Received: from mail-qk2-x04.google.com (mail-qk2-x04.google.com
 [IPv6:2607:f8b0:4864:34::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8510D2000F3
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 05:56:04 +0200 (CEST)
Received: by mail-qk2-x04.google.com with SMTP id
 d75a77b69052e-51ca62d6836so459271cf.0
 for <ltp@lists.linux.it>; Sun, 09 Aug 2026 20:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786334163; x=1786938963; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A/rS9snYzICILKENeU0/slTJt3ug5U4TcuORMRF5Ymg=;
 b=ravyU3TZ9Fi3Qi8kRCYvL59DoIS6Xk8Ia3puc1ggkLYzdqhR+TTDVHC1hjqsh/gomr
 +1UKcwBZZ9ATlijmnK7gLFJMgLcWcymiHV4ZLlPfvX6lEFHTEsPy/Gr2lcqohIyVMzGW
 tUFUFJhyVjDLQsFZgA0tJpt++ZXm+CMMiPzuR0hCavuDTWzKPcPsgVEEDTt6UllijBbs
 Xxic8DUBcj1mpQ2fhz6WsXz8jdvHTg/A5D0KLIWylUuga6q4Gwv+TrVRasR5C8Jl/inj
 RROCs6Dhu1AIlJ5h+EOV36cuVRqfXmLF5dQ/GoRg+qzSkV8LZ1TIbV2xcQpdZI0ocz9c
 zExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786334163; x=1786938963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A/rS9snYzICILKENeU0/slTJt3ug5U4TcuORMRF5Ymg=;
 b=fvF+8jetMbsvnmewsK+igReCdpsl1UOPAExXSEM85qlHx2Sf/4tK/anXLJQ3dzxnhy
 vpfYY9Vm8ltQqZOQLJClTZ3xyuVgok3xr/Ec1u3x3DbkkYTFv3c+3xHPxvNEGaAl2wXk
 tE4cj2oJqLttxs7GZ0q7eA79krpF6GmYYQqeCBKR1nRU0r6IZyGLrA9MmrO6tTvqEDw6
 1ZYegq83/Cfvpa/DOsPMUORac8svAlezrE98L9en7J+pNMAVHWMhOgBENO9TrE5Q8ZUM
 p/XK4hH8j6huRx9VMtOBtvz/ZSNsBt/QG9DesTus0boqok0kTT0Sb7Ho4+lg7Mv4kAQh
 bl3A==
X-Gm-Message-State: AOJu0YydRqGOk7hHDl6FgvieLYkPR3yctqYWZHkFk2pctyGdAIxUOeca
 v8Y328T1XCngLhg5qJrE69CyJ/+gU8CMpJTIWttwxixoy3ZmY+8vpQSG
X-Gm-Gg: AR+sD13g51fMAEKZbaU57859m9lcmYUnLDwuaspsrFpnNbWY0v0cqSEe4is47Fl89Fu
 Y0hvhZ+h/doIHj0NSbYtBj406tq/z2955/ErrR1rXKNBX69gxsQRfvtBpGzYuKI3IiIJV0DQ8Hb
 buHz+B8ioVYGo0zgPRY06gzRzLzEMueZLvvmvqFG/GteVRs2S5GV6wOYFDKU8rBKckkUDIas6Jp
 wutx88Gf2n6c3prDOXFSrXmsBtmTl2F5VEy8voV2o4udsbTor3MhUevgL2eysjZTIZkIiMIMBj0
 R27cjMPW63V0/xg1itw+uhZ7RjCOg70bBa3SU9pTE2/T8eB0KXwnGoMIzUMJByTvVh053A8cRpl
 VoXvUbwOf1jqNoe4Q4PLWeCneKhwYACOeY1+cU5E+aoGAE10tRIy+msj0wwdq/qZeYOH7M7uDUl
 SFNm2l5nKJIqXedhcmnGHAEWbrq+qvR6hpd+CkBbQ7/ix+fzPB472F20gaT+LP3SGxTnJ6N/KI8
 u4DHPEjZimuMKuH3U1Gnydh7vW4TywMyEc+iz7gkkmD2iZEWqvx5hn3OKMeS71trp3rMVLNbA==
X-Received: by 2002:a05:622a:480c:b0:51b:ef78:4062 with SMTP id
 d75a77b69052e-52d236c05c1mr165957371cf.10.1786334163205; 
 Sun, 09 Aug 2026 20:56:03 -0700 (PDT)
Received: from
 runnervmvrwv9.s45qwjd1e1xuhpuiv1334zs2ob.bx.internal.cloudapp.net
 ([20.51.199.6]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d16337589sm62996781cf.6.2026.08.09.20.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 20:56:02 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Mon, 10 Aug 2026 03:56:01 +0000
Message-ID: <20260810035601.7637-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810025817.1665141-2-wakel@google.com>
References: <20260810025817.1665141-2-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Fix overflow in backoff polling and timeout
 multiplication
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

Hi Wake,

On Mon, 10 Aug 2026, Wake Liu wrote:
> lib: Fix overflow in backoff polling and timeout multiplication

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
