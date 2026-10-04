Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9713CA5FF0
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 22:54:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E41803E4EE4
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 00:54:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7F833E4D57
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 00:54:15 +0200 (CEST)
Received: from mail-dy2-x08.google.com (mail-dy2-x08.google.com
 [IPv6:2607:f8b0:4864:36::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9A60E60071C
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 00:54:15 +0200 (CEST)
Received: by mail-dy2-x08.google.com with SMTP id
 5a478bee46e88-33bf2604829so614814eec.0
 for <ltp@lists.linux.it>; Sun, 04 Oct 2026 15:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791154454; x=1791759254; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lA7VPuVi6APR0SsOH/ASX9moKQdovTvFR6gbQ+V0AB0=;
 b=EEdANBr7pGtAq6z8TE5fEkqBeMQ4UeMoFtde2mG3Uq41F9lx7Os1D+eB/Qzg5+zq8y
 3B/xeH4zLctZf4x/j7KPSc3tTnIjFaCA2m7KidsiJFP0nv/yMziy+edKQJ5YqDCbOMsa
 kFxMkZBBa1hT9mAM0YKZwMC/sZUpp1Mae4iZbqzqVuH2RSl5BxfcpV5B21Cv1VKfLkud
 PB5aQyPGEKI5iweSEPsqGuAlprSZF7qgB1lLBN9u/17pK4c8wDY5OsGE3qbRn4mZfcuq
 57nDedN0VbRlneBxMq98Db9hkpTSjB0k3ztIRbOcb+Qx+zsfggIt1/1m2SqiTQw3GkoB
 eQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791154454; x=1791759254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lA7VPuVi6APR0SsOH/ASX9moKQdovTvFR6gbQ+V0AB0=;
 b=pURaiBeey3BfxX0Gj1AGPsrMjBAWH0WzU0pISNIKttJi9rosXVHT1SosFLivJSX+TL
 GH1oyGS8n9r5/1tMCGql1SOMe9m3Lyj+yQ2HO1fCGuvGZiHE/HX+u5CnG39VPfxNR8+Y
 NO76Dy3OrdujBQIiQ1LByzR52Wi6WScgGkefPtj8W49kMaEN5hYzNPAf3AJr8KYxm6zq
 ukQPAdBle5sOzJwTIntTI3bv6uyRQzAM5I1aWtLsDvNeb/k7//abHuTAGV+Kd4bUQVP0
 KtLLXCk/CpOvQCV2LFA/YlRIdIW39rViVtDWO8pnAiDzNtEKIkkPp435lH537NvNRVFb
 8jjA==
X-Gm-Message-State: AFq9FYLEE/6mchpJ/XnmYko9a4kUZ1OLRBvU0UpR21Sx5Wxpxk39snIl
 7XH3tVQPlnld3zH85YiE6q3EESAV3+XfdNDDKAknuFLMEukfYgPPFNY6dASG/4GMYcU=
X-Gm-Gg: AYBFou3yeYBtp3e+zYb+34cG4dTDhC9OaqSrEDto6VD8WyoyYW/Rk386GQnGuQDpL3Y
 nMaKVPnzJwtQlx4KptyUmNvXrvzoUrk34m+Rj84a1Pztt/vX4vQRF689JDJ+QWrd8i772UC5twW
 7C1l2Gbcq2Gqvgx9G1jZnfld5zb4GZhYYy0MR6+vf3iLP0ae+VjmDfIvsEvhXWZDRoV3HvWrEqt
 f2IaW4aQw2L1MHKA1dQkqIFDnnFbsuxLY70T2dCt78c7N1M7/9+0IHniJafDgPAtB2j9wM9dvei
 GMepDvAa5Q8MuTZr4Cil7dT6BsP1ZIc+nLRw3eSv0WWgWzZmxhqgfLEDiephFO0Ttk7x+aNmGHn
 mHkdT6Tkbv/GCk0noeI1OgNnuA7pOHNBGCPV5PXAxHnrLonIYC8RkVpfejtWwEo1ArNW+zjqOAA
 eO5tqTbu74ewFR4ytoX+EAHBsh0PNJseKgCx3cum+pfpfSTe/ad8paW8TqIv4we6swlGAnvKgxx
 Wpcs9bD+UjeKzpVjeGCpDyjJscK3dsVM9Oodu8ChdWmGgyKIMt4PjGNjypnmehnFu0IoZhHEUzV
 73inQaji8g==
X-Received: by 2002:a05:693c:8804:20b0:351:202c:c7a5 with SMTP id
 5a478bee46e88-351202cdc40mr4066313eec.0.1791154453771; 
 Sun, 04 Oct 2026 15:54:13 -0700 (PDT)
Received: from
 runnervm8df0l.ua2h0otvkkhuvjncfmrya3lohb.yx.internal.cloudapp.net
 ([52.161.82.80]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-351277a2fb4sm8202461eec.26.2026.10.04.15.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 15:54:13 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pradeep Susarla <pradeep.susarla@gmail.com>
Date: Sun,  4 Oct 2026 22:54:12 +0000
Message-ID: <20261004225412.10384-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004211535.7307-2-pradeep.susarla@gmail.com>
References: <20261004211535.7307-2-pradeep.susarla@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb: Migrate test library to libs/
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

Hi Pradeep,

On 4 October 2026, Pradeep Susarla wrote:
> [PATCH 1/3] hugetlb: Migrate test library to libs/

Verdict - Reviewed

No issues found in the three-commit series.

Review limitation: NUMA-enabled builds were not verified because numa.h
is missing and dependency installation is blocked in this environment.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
