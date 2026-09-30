Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E92CA5FB1
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 08:11:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3A883E5645
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 10:11:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D69D3E55AE
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 10:11:18 +0200 (CEST)
Received: from mail-oa2-x0a.google.com (mail-oa2-x0a.google.com
 [IPv6:2607:f8b0:4864:30::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A965760022B
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 10:11:17 +0200 (CEST)
Received: by mail-oa2-x0a.google.com with SMTP id
 586e51a60fabf-494859024f0so1553714fac.0
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 01:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790755876; x=1791360676; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UcntnRqa3E6YdVrvVTftUT0JScGWgeZFtWHUijGjfPQ=;
 b=nQgrZVt2SHNnzi3QQwCJvDQfmAXMnSch3wg4orffrPaVFhDLUwWmPuu0tpByMVy2iX
 hE93Ulmfpkxln5bdgaJGUU4xfD1e8bK4btP/Kzl5nP454SlxPI+pQt+Lv+AQjENIxCMX
 iP+l4vvC/Hz0Fe8k1EzmPO08JzxGIxaPLNF7NquWqNHe8mFYEdbO+vzoEjl8rN8keOnT
 gKuLASeob4dmC6RtxgA5SlNyO98vv/HV/R/rB9fCtWDqKMO7hh6YvLxc5exCFNJrSE4r
 kDvVgXyBS4MQbF0wHpc/FBBBuoZ9kPp8d9p9dWjomNqVKuttDbIzh/TT2hrrlCJqxBuF
 Pb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790755876; x=1791360676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UcntnRqa3E6YdVrvVTftUT0JScGWgeZFtWHUijGjfPQ=;
 b=dE/IBjBkrcghOno9XFBfLqYXd/bwJK0DRlpXhu0YhMM5H+I4CH3Ln2vYoBvAJwUvX5
 Ouvj/OLHdfx85TzxYFB/6gFoGcIYNg1Z9/Ri51HqN86SPZUYFl2X0bFoZuCjp08DtPOt
 VXDIEJelE2bCmagBAHxJ88BABueN3z3yGQAFghEivyMbIZCivAqrZFH4hr+yH6tAEDgJ
 b/IENefJQt+jpQ+5/+PH1bE0dsDhY4TFtAyhKLs2zD3dXMm0DDZJv/lTVFxfzgjLlQj9
 B6z7lIfGCpl73j+gn86MxIzxdOi7rgUm9tqNMTyfHEweAx6F8tLl6hp9lTZGuSc5lsBl
 ndfg==
X-Gm-Message-State: AFuF++nzPNF9wjTcoG2D/9iiMvuBFLbV0zY5283yu/SHmihMeqtb3Wvl
 E+VwAxIJaD6GE0q0vVw0qS5BKejiGWfmbL4b8t41Y8ylJcCtC8NnWO0q
X-Gm-Gg: AYBFou00TCDry16UKDorVdVJ0W55C7r/VUrvH6PZKb+aHNOl1byNM9eNqy/Fupc7HiL
 Mr9mNOW4hE0pKPugSJaLfnNSb8qZ6V1Kuqc3X3zsArV3Q3IEqiiu2pIiQ0Rl08m1aIE5UNLcpUw
 tX7L3tihO9dgaS1kJQL306vmKEddbzY6bsrkX0ougjdfOpF9Qs3bOVspwxATZl2R6NCa+75k6fk
 BiC9IPT5EFzcCxyVFXLt4Oaz7oQqmvQ/OFrilw020YlB5ovUVI6E6RRZQwp5Ha3d4H0hYbkqvwc
 hS/IOUAuRQ7j3go3Pl/6sP9bjWR8O9bQ0b3WTz55agImx8lCwtmpehDL9ZrMn9jSjAuvBix/BoK
 RON7dxV66f76THD0+fKIGcGLJDDcEaJTld723j737WPWCfcrJlT7H4iL0EHIT0CRhV/bVYwTNqo
 KYwVgrwJBoEjYu6fu9h1vgZaKMaATpoEYLV2Bz5J8nR5D6WpETZXSFO8phEtKGezezL9e1BcJYo
 UKRMM77zXTomt342YmxrIZ90bT3ampU8nmo2u4IJuq84WkGkb5CAJuCI2pm71LCkYTCnysQut+H
 joqBiGuVEdbzLRhxsLRD1A==
X-Received: by 2002:a05:6820:4cc1:b0:6d9:4c33:64fa with SMTP id
 006d021491bc7-6dcf573613amr532548eaf.37.1790755876176; 
 Wed, 30 Sep 2026 01:11:16 -0700 (PDT)
Received: from
 runnervmtr4k5.oq3xicayfjpu1o1gnuwmpwcacd.gx.internal.cloudapp.net
 ([135.119.86.99]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6dccde2b4b8sm974064eaf.3.2026.09.30.01.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:11:15 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Wed, 30 Sep 2026 08:11:14 +0000
Message-ID: <20260930081114.8885-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930035332.3360-2-wegao@suse.com>
References: <20260930035332.3360-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcontrol: Add bind_to_current_cpu() helper
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

Hi Wei,

On Wed Sep 30 03:53:14 2026 +0000, Wei Gao via ltp wrote:
> memcontrol: Add bind_to_current_cpu() helper

--- [PATCH 1/2] ---

> Add bind_to_current_cpu() to memcontrol_common.h to allow memcg tests
> to bind the test process to a single CPU.

The commit message only restates what changed. Explain why memcg tests
need to bind to a single CPU (e.g. to prevent multi-CPU per-CPU memcg stock
charge accumulation from causing reclaim variance in hierarchical tests).

> +static inline void bind_to_current_cpu(void)
> +{
> +	int cpu = sched_getcpu();
> +	size_t mask_size;
> +	cpu_set_t *mask;

Include <sched.h> in memcontrol_common.h. The function uses sched_getcpu(),
cpu_set_t, CPU_ALLOC(), and sched_setaffinity(), but currently relies on
indirect inclusion via tst_test.h.

Verdict - Needs revision

Pre-existing issues:
- memcontrol03.c:209: sleep(1) is used in a polling loop. Polling loops
  should use exponential backoff or checkpoint synchronization.
- memcontrol03.c:241, memcontrol04.c:240: fd validity is checked with
  fd > -1 instead of the LTP convention fd != -1.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
