Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA78CA6002
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 16:19:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D95E13E9C8D
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 18:19:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DA623E2D4C
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 18:19:15 +0200 (CEST)
Received: from mail-oo2-x00.google.com (mail-oo2-x00.google.com
 [IPv6:2607:f8b0:4864:31::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B12136006EC
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 18:19:14 +0200 (CEST)
Received: by mail-oo2-x00.google.com with SMTP id
 006d021491bc7-6a3900cb2b5so2471754eaf.0
 for <ltp@lists.linux.it>; Wed, 07 Oct 2026 09:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791389953; x=1791994753; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Ciq+uunUC0HaACC7Qlq8skaC+q+wBEUAxGsi+MqCOQ=;
 b=RY22YIZpT2VrhtKOKd0cNtAfNaP7arXViGkW2IjcvrCPFf/plqSSQGrqZm4l1cCf4h
 4cRtL7ZShvPiCwvi7Y2lcBegrqFId/cp/QMLcpMNa2l/Bw43LH8ElaTjQgkPouctBzAh
 dYjhl8DkM8l1y5aqhE6p0dd6xCgq3bAem0z6Tekb5kQoBihp+YJZyNDw6vd7Ii+514Lj
 CpXwEqnKx926pJBuYHUvIYqvqj2719dbnWvSh8jY5IseW10SWZyGz7rDYXmRNGN03sQu
 dMAIErEhBBlcCpFRCIenwkUfbX+k9DA3GufCVHt92BOH98FoIFhOwWKsg/08DY85u4BH
 ULdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791389953; x=1791994753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0Ciq+uunUC0HaACC7Qlq8skaC+q+wBEUAxGsi+MqCOQ=;
 b=tuqrC+cdbyt1j3ub4msgWlVOGEXww7vENA3gT3hk/HbzhhcuSdjFYeJQuRbEM01hdd
 iSQnfpTKeRLIpIcVGpLScTPAXlMJLNeY2WyuCa699gazJKAA5LbiTbpSrx0842ynqDRa
 JPVtYmEsfgCeRHxWSyl7VEV0kVNIxgLQZHi75tZpo1UjPGbPa92wPuvHOQ5/byW+hDQ2
 7gVNDkRLk9Ul7c9KnSM10LyMNGW3AnmPVOvxbcKuVFyqdKncCSG23RHdHjwTgpVHfUZR
 ZGt3ONYPTWgdVJM+7QefJfjB1Mo5FBbgeJ9SF1p1x1XcC6w9n7CiTUKT6ClFZOut00yc
 da6A==
X-Gm-Message-State: AFuF++lIn45fRWvB5MiuJdSIGnaAtywQ0STDuiL4eVfyxJHcoYp3QGfg
 p3m3XR4aLEp2ednA+NxYULqQZ9CiGP2SDGlJQt0aoY7XWYsxQZlQTT0w
X-Gm-Gg: AYBFou0bv0OLugWKbUn+pXdaO49tiBOlF/S2kX1F/wHyr4WqSwzwRoCWsbF7nG5feGJ
 JtM1sNRcP3c92AJ77xSvtTLhL6TLh/2k+n86ZJMeNockqPqkBZBg5IuZQB80BdCvTHZSUI/OKk6
 bcx//QbtYw+/DcpgTLbrDfyKVsYjtpGdxS6d/i1ZnEVIcb1pE2O+ikOfO1etJDcUDB5DYuw0CeU
 Mvh/jGCGQjB6K+BT9MDdQVePdu3smqsDC9C2tL5WmFkxjaeYf09ogsjNGtf1lj7j3z0IFPJyMTI
 B//23oatYMYN8dTTvGMwEx0Mqgwh6CqBr66oiTVpVJvrvukW7uXdq55JBB1tNKyiMCqWSg3vBU5
 Dt7Zw9PVZT9XS9/nOzB1vIklWZEGHZQfVu1PM0/+luGuJ/BXtCjmSNRaR5TZyLOvCQ//PuHItf8
 zOL37qGonED9qaRENQWWCy62+QfQ9SMG/tjW9ZfOThWBelBn8P4bFuNApWFPdTLZzdWsrRshLhX
 M8xrVvBUBMchf4fbM7LuFbMdkhS6CWEm2A5BVkkWRdRglFpPbxDRkDCwSsZAsh24dlC/XR2CPfE
 3WFLzdqQlyE=
X-Received: by 2002:a05:6820:7095:20b0:6b7:8415:d792 with SMTP id
 006d021491bc7-6e7a749a5damr1981846eaf.61.1791389953211; 
 Wed, 07 Oct 2026 09:19:13 -0700 (PDT)
Received: from
 runnervm8df0l.xp2z4hqevwpupjssoemgtobmze.gx.internal.cloudapp.net
 ([52.176.19.201]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-82adc70e262sm3111690a34.18.2026.10.07.09.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 09:19:12 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed,  7 Oct 2026 16:19:11 +0000
Message-ID: <20261007161911.9439-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007-fix_leftovers-v1-1-63a1e7acd0e6@suse.com>
References: <20261007-fix_leftovers-v1-1-63a1e7acd0e6@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ltp-aiodio: Remove unused common_sparse.h
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

On 7 October 2026, Andrea Cervesato wrote:
> ltp-aiodio: Remove unused common_sparse.h

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
