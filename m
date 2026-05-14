Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48795CD4F39
	for <ltp@archiver.kernel.org>; Thu, 14 May 2026 11:58:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB8E83E2841
	for <ltp@archiver.kernel.org>; Thu, 14 May 2026 13:58:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA31D3C1DA7
 for <ltp@lists.linux.it>; Thu, 14 May 2026 13:58:37 +0200 (CEST)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9F8FD1A00912
 for <ltp@lists.linux.it>; Thu, 14 May 2026 13:58:36 +0200 (CEST)
Received: by mail-qv1-xf41.google.com with SMTP id
 6a1803df08f44-8c9166b26b4so9269856d6.0
 for <ltp@lists.linux.it>; Thu, 14 May 2026 04:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778759915; x=1779364715; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tlhUcwjYBNEHG7d3kgo6iHPoLa21UJ+hYYnp/GLJq+M=;
 b=WuSVy2hQxCqFH4JLguNDty3lIp1gaHaPD9o57mtHMqYzgUedd0NDW9M4rnVShIep3Q
 iRGv+6WPGXfwpl/D8UXDU++ToEnNeDX4wb68T28xFFuO6NI4GA+++R1m0pryxiLdbO4E
 WqaL4UcWOVxLcS0/gYwHiODRTRAfip/4ch4oeBLlafZS25vaYGTU524XhwAx0OsFFEHg
 i76kzM0i5eJ8iY5nrT+0JVLoHS1OI/SKQe2juVa3Z9Je4jTCDLYBus4OItK/gcpAj1MY
 pTusGWrGswG8QTii5zNk98VjLqmvEytUehNVoDMeEhagIN5X2i3nuUjW5ePSN4TLkEze
 ql/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778759915; x=1779364715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tlhUcwjYBNEHG7d3kgo6iHPoLa21UJ+hYYnp/GLJq+M=;
 b=pvZ8O82YD5XilXjJ7e+9bwonJLpYdJBofJwIjUNBGDPpQqDrlNS2Agf8iHuyn5aAci
 reUxkMtPf2pU1YN06Ix5yOuwpTC0di7r1tQ2lVe3gUTDrL6Vx+RsQDkxhIdcbIQHyYHN
 1aOTKcniJKbxTOv0wfKiSmDQq5+aeHY03LkaVFYdwMUwTE8YYgaThY6UCl7D+B475p7h
 6Nyt4BAqYnJqnSYE2Yp4loXeZg6jVTB90DXPGP+OZv5hK1W1WCD11baUO1fpS6dN9VF1
 TcOZYisJu7kSqReuvmcWwVU+XC9SamavQ1JFtrzfXlRtmOQo5CSS5QkIsKSHBIg74DZU
 FytQ==
X-Gm-Message-State: AOJu0YyD/ZRAkuq1C2DsrRT1eLjigfyiaDB4zUHZQKHbbQdECiOfqVZZ
 zyPDCC89/CCjLr8Kl6yfPXD4h36EcW3UP8uZdOW2Ef7tPDgBqBD7+iSb
X-Gm-Gg: Acq92OH/JemOSrfa2kezO8jvEFIVtvM4wLNLtdCJ7+mAiqZITbFOYMaU3s0Rx3slLhZ
 8n/lBEy5LgObHYMLhuFeqlFrV4Nmr2tsqeCgr/r2pkUAr2WvcBoHZIxw5RY0gYE4GERK+6mZx70
 CQQH66TjzOZuQ5m1SOYIGU02nouvO9FVUoXFmjWa6m/FyF/T73vODUbFIfUwAmwekeBTTMs64Lo
 4wS7tjYJvCrc4Vbxu0GzwVnbKY907x3W64AdC0IjNbzXgpZwsqify7ULjbK/ys4YUKBN6CaMgoP
 KpyIzUj9jPJjk2M0ouA+tyZC2tCyiBhllBDYakMPB0KQv5FlNfzDL/WMEMf19NDSeyZWYzmbOic
 N9HVGe8OnhOFjGGVgVjmOTfKMPhOxkZLPJWqYPD+8dQ3Zg784NUOks7yQtJTHjW7cJmf92YHJ6G
 rgHr6lzfnuRZ43/+vQEfBGFlE7W0N0pS+Sy7vTLd7nbQe/j7pL4NYdh/mGkQAu2DSKlE4Vc0myI
 Y9K8/aV9Scn0SzBEzgRR0AMNY/PNMM8xaSJhQ==
X-Received: by 2002:a05:6214:5c8e:b0:8be:7ed5:477b with SMTP id
 6a1803df08f44-8c7dde9b6c0mr110692726d6.22.1778759915399; 
 Thu, 14 May 2026 04:58:35 -0700 (PDT)
Received: from
 runnervmeorf1.bbvfuim50bhurirfaguag3kcgf.bx.internal.cloudapp.net
 ([20.83.174.53]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c90c164b19sm21178246d6.38.2026.05.14.04.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 04:58:34 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Thu, 14 May 2026 11:58:33 +0000
Message-ID: <20260514115833.3969-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514093559.125070-2-piotr.kubaj@intel.com>
References: <20260514093559.125070-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] high_freq_hwp_cap_cppc.c: new test
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

On Thu, 14 May 2026, Piotr Kubaj wrote:
> high_freq_hwp_cap_cppc.c: new test

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
