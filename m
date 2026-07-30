Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6119AC54FDF
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 06:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785393563; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=vuIuJfsGh9EhkjeRDH3N2fTw3UMxMR0gWROxqJk6gR4=;
 b=TLIBVjdRq+pTq4XZO7pH3YZOlf8OU+L1OyIJ2snORtN8JqG18b4ymTlLYAt0G4z6JNUMk
 DwsXF+GPaAtl+LkdNZAesziX2HABgMitYO+l/wQOnZR+8W7QtPmcjq6w+pjZ0X5PzTmombs
 Fvo3b3In7bj/wpLv796DgU3iHwqIW38=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 074473E49EA
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 08:39:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6BCC3C332C
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 08:39:00 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0E661600351
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 08:39:00 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so16720805e9.2
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 23:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785393539; x=1785998339; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jTNiOsZqz+g4xvsT19TUgBunlMcOXivfxmaxuQBb0ME=;
 b=P0cuCo2XV4amPzpcrkqfiaKtgEpKhQ2LFrmuNQiKgjrf8K3/8ERPJc+SObPwWwdyjs
 TnhpQDChEJWlpU9/Bsc3ocEmPLka/Yn1/Fu0V0gzVaJa6o+nOqW1o3rAYHw1lKM9+QKx
 LkVIu/wa4rGZ6UcV9eK/SYsxl1eAzeIQ3JOmBd3G4HdkIZVUFUAJlqtkGbjxAcQpOYdw
 abzfE0vmkAVGFd5gpS5cabjzpTMLvLb12wmLFFdePRtYvNiHiwhvoLLMoRWFT3tM6qF1
 bvT7bq7WN2Q386DWiJPTsAlL8aLiRwdQznLRpp5gRBrsJh+GuIoZBPw2VKiU8lxl/+Uj
 kSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785393539; x=1785998339;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jTNiOsZqz+g4xvsT19TUgBunlMcOXivfxmaxuQBb0ME=;
 b=kXgcyXUzf57a9Vj5w9t37cXZVAEtx+3SAxxJv4ExRwA163bThmt6l7fNpOhS+9Bk5K
 Aj0M+WLiMtyp4YZZZhnjSH6BzFLrIK18kxOUD0gdooicThMBJqptoZULpVFMFYmfyUee
 HOwt01lsZnj8A/P9EFHGdtHutDyVpCjlggueaFn8J61Ll93UzU/+CaWZgjqE4aMe1Nbt
 8s+3xV4mhCh0JwYLg3ZJ0++Gtf2FaWR93jXMsGOWArdBFkPpOb3k87e49xKFp3CfhOW6
 BZ5A/Qu2tbemSuBEZZpKjEtMcuwKSf3mH5IEnRErWvcXb+vjyuJMa3yjB/y9H+L6ylPO
 lXgQ==
X-Gm-Message-State: AOJu0YyCoM2BYlf94jFRZHTOJcuVwlQwx4j6wQ5PyT5N3Wam8vRjO30h
 gEvnjJ0jX5d8QEzisuE1kc3zXpvl7lYudHp9ZXm5CAX2DHM9xlsR2WDV/O1Hj5SL1zxN6o0ySh2
 Y5YvtlvtFNw==
X-Gm-Gg: AR+sD10RxmJ15s23VyBhU5IEeVodRDC2TcitTrkbwcF2U5kUsrVYHanEynDiBL4kvCD
 nysFs6hrWjEEgJ+P3LhL99j3vmBJwvAjeNwPAr/DOEnhIqm3vCPEXguKCVFuQctz3PEOFJ3yvSs
 oN+/bsZcb4hs8f1sJqaZlTrToci+rjp63Wx+P4r0/9XukOABfhPshRF5duw/jeRLG16+4J+OzdR
 rPKgQ3OKgpPEe/OJLxmaWMfmV23qYCnUO6sEm6mK12N2TDbVxDGhsUQhTWIbNTUdmPGJZY+xjzM
 jVnxNU4v+76VOIIXZ2kNzM9r9D6pbE1v+CjthKJxMyE+lIst9lHSBhdjv0FCcp2cJWwli4hRs5h
 Xwd2dU14fkFe/WN/xyKCtfpSRwXwXG4UJ9Pg0euh22a7ZYgNTIez3/xVS7jqeCq4Y7Fj30koz9d
 hDEGjG8A46m6H3GPX7fLxnTzaFresydTh7dfN5PVrSD0l9U6BzZnM9XzrrKKK8RQqes6Thefsuc
 JmA4OYb+i8OrrxLLbyA3yQuGBNh2G9Vro02DhKE/Mz+KrKwiL28o14rGN1ZGac5BsFI+lI=
X-Received: by 2002:a05:600c:19cc:b0:495:7838:7e25 with SMTP id
 5b1f17b1804b1-49800e9a73cmr14598935e9.15.1785393539339; 
 Wed, 29 Jul 2026 23:38:59 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88d985csm3515526f8f.1.2026.07.29.23.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 23:38:59 -0700 (PDT)
Message-ID: <6a6af183.b2781ae3.74d0c.9671@mx.google.com>
To: "Shaojie Sun" <sunshaojie@kylinos.cn>
In-Reply-To: <20260730032850.775128-3-sunshaojie@kylinos.cn>
Date: Thu, 30 Jul 2026 06:38:58 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] cgroup: add CPU cgroup v2 tests ported from
 kselftest
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

Hi Shaojie,

> + * Copyright (c) 2025 Richard Palethorpe <rpalethorpe@suse.com>

even before starting the review, why Richie is mentioned as the
developer of these tests?

Also, I would be really careful to convert tests from kselftests
to LTP API. We did that in the past and often it might require
more maintenance than we really need while using cgroups tests
from kselftests.

Is there a reason for this?

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
