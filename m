Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725FFC43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 01:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783905967; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=eBl8rkkz6JC6lTgR5QiL67Ijzp2TgccQJB/no+C0q6c=;
 b=CBt1v1Z9hySfi8T++MMcmTXIlCap3PO1DXEjgiN1n/DtduXqzcM4PqFpO8I765MnChTrc
 aHYom1iRdv3U6LNFUzpAyGfs0DHinBPM4LKxHJFzPGw6QvIxdtuFJ/RDOoLybMTrsd3D+Uy
 cw3bitt44IbokLGXlEqJcK497y28sxY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE50D3E2E0B
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 03:26:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0CF03CC91F
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 03:25:45 +0200 (CEST)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com
 [IPv6:2607:f8b0:4864:20::1049])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E496E6002A1
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 03:25:44 +0200 (CEST)
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-38827cee19eso2624763a91.3
 for <ltp@lists.linux.it>; Sun, 12 Jul 2026 18:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783905943; x=1784510743; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0iXCaOofPXuGXgOn6EqUcrgrno0A7NofZSqsXPCJdWU=;
 b=Bvsmk/2O0pV0Yf0sH5rOjOn3WasM8Uis11R05cNb/RT0y2/Li5/pUb/uLwlcIGP32T
 XcpFRGsGl+5XG2Lsnzf4vOtNMwuv9C6VJz/Yazg1ZzFPJKZoidXFYRHi3vrm/iedZjU1
 wGnnxdOomEPxJrNfiVfnu9dFYO4/99Aqnfyo01CXJg5K69Z4I0vrWIGQAV8aZwXvg8f9
 94WG8jWX7hkBhFLKo8eObP0ikvdf74Mx4aemhcX5gXYwQtqOsS/0rp3IO8LJIK9EarKN
 Z4dPznaNdtryai4gdEVlrds30cRBqThmN26WiVKaPM6vfIJ3p+qfWYiIJdXH2S5ugsAW
 CWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783905943; x=1784510743;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0iXCaOofPXuGXgOn6EqUcrgrno0A7NofZSqsXPCJdWU=;
 b=faITd4+TOioZ5K/bt2qsrpnTEYxZJVuWavG6F8cnpgaFbgxYnbhpdANmxv8SabrDfo
 4oGReEaF3SeFlMSpdvKlbSVyFEf5WgXSKfniaen9p0ZPmqzIAwS1P27hb+5rahNo5S9w
 J2onqdMe9IDMoOp8rEKl3Qiq2q1PUUe1quhAiE2Z3nVjTZe4PLlZeRpyAb1YgfJPOjoJ
 2UisBUN9GSArnDo5EPq4kHqqd0FYdeUqrADLmVf3b2+ULdnNkXVR2Rmo23DaEmdd3IBT
 IS7N4WaVTJXHlYPMvYwqDvwQ2iN1uhSyD1elqS4yvVaJkj3IwgtHksIRG+0PlBDkWITs
 xItg==
X-Gm-Message-State: AOJu0YxRcfWMpjHluwSFLWxOW4e63BjoXCOULoMCWpCfacEtW3MrU9X7
 URjHCIGW1TvFdX228xfSF2eStggmXrBnmBuwys1+LFO4VXroJo/Eyi0O4WcvG6iK/S9GgEJxONi
 MEml9weA60FLLQVIOndCdTDVZxHHUlwvc39Frx8NP7w5+aJ0kseLbW+6rw/1Tb/LlG3jREE5IlG
 7WF9Z9WjF68Ms0EWo7sUlN6AIDbg==
X-Received: from pjbcu17.prod.google.com ([2002:a17:90a:fa91:b0:38e:f0:e6b8])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1a8b:b0:387:e0cb:c8e1
 with SMTP id 98e67ed59e1d1-38dc77c3378mr6659131a91.42.1783905942975; Sun, 12
 Jul 2026 18:25:42 -0700 (PDT)
Date: Mon, 13 Jul 2026 01:25:40 +0000
In-Reply-To: <20260710021502.1798161-1-wakel@google.com>
Mime-Version: 1.0
References: <20260710021502.1798161-1-wakel@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260713012540.3875317-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ltp: syscalls/madvise09: Reset cgroup memory
 limits before test retries
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Ack. Apologies for the non-standard commit message. I will correct the commit message according to the guidelines and send v3. 
Thanks for the feedback and the link to the ltp-agent repository, they are useful.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
