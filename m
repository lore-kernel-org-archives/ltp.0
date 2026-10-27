Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29357606A31D
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mYK9wIc/
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFB8A3C57EB
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 20:04:06 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF0A43C57EB
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 20:03:50 +0100 (CET)
Received: from mail-dl2-x0a.google.com (mail-dl2-x0a.google.com
 [IPv6:2607:f8b0:4864:38::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 117401400BEE
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 20:03:50 +0100 (CET)
Received: by mail-dl2-x0a.google.com with SMTP id
 a92af1059eb24-17c2de6994cso16889c88.0
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 12:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793127828; x=1793732628; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KAh689EpMMgMOyFLHCxWN8qVMsCKjl3sVK9Fx9FEjMU=;
 b=mYK9wIc/tNhdJxO+jk8oOWkoWc7gfs0mLpFM2NVYwFUw+8rsb5gPbbcgxIULAg7oC5
 ckdVOTD+YnBqGsGcDODBZEHvQmjb+wORdVdTHIAKklDs373Tns+PtWki8BalNi+jhJaW
 2AK7pIHH9eb0M2RoXoRHrKedOBPccshQ4UUzb4UX0nykAJKfmKYvGMZ6yn6c4u4qjsjc
 CaKYFQeLcI1zezY857KxErhW3dJCiNhOAoR76UjfxMge7M1rUTJWqbX/sXCbIiwei8ei
 Rz4noFCm7j66N+nwFmOyIZercPbjzPee/UsgCqGJLOQs/+ut3Kneqdh/RLUfvgrON1Br
 eUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127828; x=1793732628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KAh689EpMMgMOyFLHCxWN8qVMsCKjl3sVK9Fx9FEjMU=;
 b=HDq1z4iEzB3PTiev53nBCO6P1APQ2xCMaJC7ff8XH2Y+4AVwUNLlXIamzMHviMz4A2
 ffYeaMAaiM6UKK85QBKfyKwsrNJEyAwaE3tiho1qupE3wirlmgoVVChjZ1Icd4r47MH7
 Uk9/GKGuw+DWy8tbigttkbSlv0SXSGPKIAkiHU41nxL6RggE21YbqC3hY2luVIjtV7kr
 DudtIQMXGNwJQdxryXcrK6HHnEWhCupFGkdHS0Ligm4eyyeqKeih6Y5433sQaeXeMbiR
 2v6FVQnR3ubfFQGX8HoiFD8RBiAEogOh6dIb+V7K6uORgoyTHY5A/0CCgOr8mfxX6uMn
 bPRw==
X-Gm-Message-State: AFq9FYK14Rk8GqnRdT2V3zZJKEkOd9qxLZmei+XrBKIz7G+DCntj2lXK
 jY5fWVRyKMT6+Cixy3QMId+bEel2rumBT4TOriVx4322oVtQiEwoykZ+
X-Gm-Gg: AYBFou3vyiaX+qREWctnfXslfuu2s7gSSjkyEJxj3kZjgjQn7VYtKmpWE/7tc6TCJsd
 ZuxGtBu/dQhASS0bnGWq0wUqGCn/k8HoacvzmJ7EXKncEWjcZkwzm0iZYf8ZUhVR/NMln9WcI+5
 8UOlCCVccDyO3XNzbzZ4nEAPixAOaERUbQt+OV79iSRxxkm6NsE1geQxeCa8Azgx3ZtWcds8I7g
 jrMjFj4kiGYe2cZLe4S8LK19WmrBUFBnh5+TfrPj7NwNi0BdQaIFjTHD1DjP+YO85+SfxNi4jip
 y/o9yvEpOxQVHVEYuMK6aGkCaVvtcF5kheqCrQ6T+O90tdOWnlYYy5335YlMgzgRPWW/+i4TrQA
 ePtuTGywuNYLuopphVz0Hi2BG6FAvb3HtWE7Yg4/I2K0NJUCMTef9pAP43dGsU0fvlfkdz7g0+S
 4MmhDl1fX+mR0ttsjQmJyXbjUVXdrrSEhWHxSBZg5CIXu/sP1UjpkZ8TpbkHPuc+TzQupmBrrxQ
 GDFsyUAOWF0V3FPLr1s/5SGDcQIGYVub8US+EhoPx9UynGF1zxri3J2TwitQVbQCP6kQgNZBe90
 UKGM/9pFzQnH1eXp+pZCX/yam1NUGRLayBaDxyz4TJXWo6lT5xdv2eqdMOiIVcdR70bw6MBiT/f
 B6H9sXGVouPb+ZN7hsBC5fMj7sRw5WDetLEXOBBo=
X-Received: by 2002:a05:7022:ed07:b0:1a5:1c15:9ea3 with SMTP id
 a92af1059eb24-1a6cc7238d3mr195852c88.17.1793127827686; 
 Tue, 27 Oct 2026 12:03:47 -0700 (PDT)
Received: from
 runnervmtai0g.vxwubsvclilezgs3f1xfxeaexc.yx.internal.cloudapp.net
 ([52.161.51.68]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a6d98c93d7sm180865c88.13.2026.10.27.12.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 12:03:46 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Tue, 27 Oct 2026 19:03:45 +0000
Message-ID: <20261027190345.4005-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027130351.26537-1-sebastianchlad@gmail.com>
References: <20261027130351.26537-1-sebastianchlad@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: Fix aio_suspend/1-1 completion race
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

On Tue Oct 27 14:03:51 2026 +0100, Andrea Cervesato <andrea.cervesato@linux.dev> wrote:
> openposix: Fix aio_suspend/1-1 completion race

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
