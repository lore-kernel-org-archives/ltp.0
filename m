Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A44CA5FC1
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 08:10:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9EC03E5618
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 10:10:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B9E0A3C6BD3
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 10:10:13 +0200 (CEST)
Received: from mail-oo2-x0a.google.com (mail-oo2-x0a.google.com
 [IPv6:2607:f8b0:4864:31::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A4296600CFC
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 10:10:12 +0200 (CEST)
Received: by mail-oo2-x0a.google.com with SMTP id
 46e09a7af769-81a9c3f4f03so1608890a34.1
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 01:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790755811; x=1791360611; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fCl1wtJKM2STvQKcnx4U7ghAR1t4pmBFSS+9pOMgjVE=;
 b=V3nE+Xo29fBQ6FkivtSSbC9rEq8aH0MvQrN2H7CBdxJB2eTWffqwbvXBQpM0a7YqYU
 uLhG1PE9Anxse2CSQfflw7pr8eAOoqmlr2DI5ZCtzGSUCslu+PVEWTck8fyyAwBPUCHY
 x59WTIbKZgFlLidIOK9HkU1lGdkH7eraBLBkj4vR0AmpmdAIec/awiFOrSrf3010/uk6
 gcwIv3p6S+vklS6e0HBzydV3l5Wq7w5avc3bK9h3LxUizIiM+nT/Vr1YCcqW3nuOxaAp
 7p5BGQ2CHiTSww7wlAdqFkdIyJjCWvzo+uw3VcBEvwbO6q0KNNp3s11/2pgpA0SXGy2w
 FNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790755811; x=1791360611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fCl1wtJKM2STvQKcnx4U7ghAR1t4pmBFSS+9pOMgjVE=;
 b=E3go4siMSsKWopJkGU8n/Jnbo1YKIjQfyIi8ZBtFpuWn/M+Ig2LNXZCShDnwVDDIJt
 YwfMtiOGtbqprbNFRFr/CqgOJNIIwfS3a80f9bsEfN1BAhLIuwiE8dgbY/iLwt1EsnQY
 Eg1nAlYLVevbUnu50kytLBjaIfKSibw/+uQ1trEU3i9HCAJYe99vajFHHwALX1SJKZJC
 CaS5o3JQFhWvvXBUjy6hb9PTDwLhVq8SOZjRmS8THnKwD1ijwSuaEm+Ag4EALFfOaG/7
 M++mxLAvomtiMJKjEGCIlYMGajfJSY6BABye6EOIJ0RJjOBimitA3oYABSfXqGTRlQ7b
 rb6g==
X-Gm-Message-State: AFuF++kSBW1AbeCJymSxCheXc/C04OHmator8AGZwIdsvPVPCGWguqLs
 GFyHlBgZyXINs7geSWLdL8BIMlP1igdrWPt14QJOlKZ+/wBDzS9OMezA
X-Gm-Gg: AYBFou2BGt8/BuvY/pqhqefrTUeA7zthcmN0vjhZ5wBXFbjb5dVqHk2kE3WcfGwQOvb
 gR8rtxvjcxTmakB8p5HVaGWf3RlCr5Hu2ygZLnBbRFeBfpHxTDdHr+ED7SiSRtq+jyW36gY/Sf1
 HJ2Yjptg/ft0St2C2TdLwAqfRSV4O/Zwytm1uMWO8klGLgxiB5/B43s03BDmaRYLhokplm/jHv0
 A6ZGtIbseiEpW8eNesebTMN09sxuA8Dz7Tzeq81/6qC2Gs1GYVMVInSakPui2KLhUz1ZBU/K94P
 VTzrKV0FHsuCl6sWYgCGWUxO1ghB8J8NAF5fhWXv85MkimrDYtoqRP1Q3maOF3vgyeFzUdEIslU
 AK6BcHzZ4uOXlRB5RqBSL/pgph+1x6kYpFyHhzK2NdcYyQlLws4Tt57sb1Mt6h3UGCv8WMT4jku
 xCUvjZobwYeb1VT5BrsXwofxKkQ5V1KGIobSccb8aVKZ8eBKJcUgFEOHPvW3OBAcHwId50UteO6
 B5FYiVGsXSrKMCbLx4hSW+eDulqpLjynsOLpyypx1Ek1qU7qVNMoJM2yqZaAiDltTeLCzbVgcB6
 Np7V/vUV
X-Received: by 2002:a05:6830:2303:b0:81b:c6da:c351 with SMTP id
 46e09a7af769-82049cfb380mr850047a34.17.1790755811181; 
 Wed, 30 Sep 2026 01:10:11 -0700 (PDT)
Received: from
 runnervmtr4k5.bg3g3sriuwxe5nkesjmafbtdva.gx.internal.cloudapp.net
 ([52.165.59.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-82063cdfdeasm441800a34.26.2026.09.30.01.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:10:10 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 30 Sep 2026 08:10:09 +0000
Message-ID: <20260930081009.9235-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930-fix_epoll_bpf-v2-1-c1ac22e73b8c@suse.com>
References: <20260930-fix_epoll_bpf-v2-1-c1ac22e73b8c@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] epoll_ctl06: Fix BPF map on old kernels
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

On Wed Sep 30 09:23:19 2026 +0200, Andrea Cervesato wrote:
> epoll_ctl06: Fix BPF map on old kernels

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
