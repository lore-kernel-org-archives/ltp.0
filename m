Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2C0C5CFCF
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 17:10:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B482A3C6EE3
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 19:10:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 913CD3C5E18
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 19:09:47 +0200 (CEST)
Received: from mail-pj2-x0a.google.com (mail-pj2-x0a.google.com
 [IPv6:2607:f8b0:4864:39::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0274C60004F
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 19:09:47 +0200 (CEST)
Received: by mail-pj2-x0a.google.com with SMTP id
 d9443c01a7336-2cf49dc298bso1308165ad.0
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 10:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786640985; x=1787245785; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sa2VzDZJjUSJzY/Oh8LGCcYZQA9CY4WMpsJjQeBjj4Q=;
 b=VFpTGMvA58+jhMUW+Ix/mLofY2fAjCDaqI6b6UbNsIYMON8FfPRNmsUjcAKOZaIRUa
 Dh2hI3htSTKUVELJy/cF0BicAt0SRauC9NWrxayL5CmICvV2rOaUrMi14B62VsXW9nob
 u9DL7KnIY9bLz5WW0N00/2fAzlVXcK1s5CBOUOlRonV6X32L6XjEupKHNsHajiXaYW5X
 WGSBC8NMLiHQ7i0F9OmmWVwq4cokQv8HJkbaUVuRlwtLOzHCxO28dgv+GML4/Ips5SeT
 Piq1NqzBiu17doySjHrCWgYjT+dJtIQ8smQm0z2halvJG/s7OfmihfBsYioNdP2nD7UA
 QXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786640985; x=1787245785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Sa2VzDZJjUSJzY/Oh8LGCcYZQA9CY4WMpsJjQeBjj4Q=;
 b=d6TRhi1bqIocg/+DcshbB6/F5izo6zEAdKlixzMvDyXeJMjAMOXtEoKNZX0rr24j8N
 zXvGt0INNl2SZPJBpIJqgRu8iKK5EQ60tqWjeDAqkI20ZWhBzyLQXzjV8fw6C5yX+873
 XMDVyQIi4WOD7aKZSjqmZQpZAWaHBUQ8SLvraBiTTDplQ3QPqblUhf+dHnuUr8nKMAe2
 a+5wDJUKo9VfaRo+B/OoQ1gTmFJ4tGpz773oqoT/nZKnjOUikJ6np3o7qBat74NGarD7
 V6s1XoLgEsPc6OghE9xmNfqpzO+jywu3tCxoMMGzOhaW9fGExHZIiZlWQLktnShAkxnF
 6vag==
X-Gm-Message-State: AOJu0YziQbrTQix113ucixPRW/LgMmn+GMLwA5QR5Nj+6ndExdDzYnQr
 TzDA6P4x5Gm0r00iCClgxO6F4uQ+7o61OKNDgxnUDYQoGheihbpzhets
X-Gm-Gg: AR+sD11h/mJ/jt9MC0bNWJ2mg/Ct7Aa3M8NNhDI2/lfR3xK3hcTVnadv2o7kgYGqpIi
 QLOf6QVdncNxtSGZwkJREnPoFblvnaBxE1nGvaNhAR2GuAKTHtYavUyAI0h8JiQyDX6/5j8MXvF
 mKReis8xgvRqTiKxAEGpKhP9CUqXeajgY5GwH77m0QXOk9fYSzbn4znhAbwEWFBQOVxldia2j69
 JXqYvUbC9cerL/WeUQcOeYk+iJdTghxF5OLLuO5FDNqxlYWImz0Al0KpSplhLcABUyoo8peY50t
 YncjseGBPu05hpwdFaW7Gh1fFPwMI2rZ4RIe227khOgGKlxNqC6+/RFjbIonWN+0dIy/mBIstE8
 GtFR1Cq4B832KgM3IcHOlDE5wVon3NGlQcQN+6mP7fRwMf3rZ/iDCO2UIJvXuz3QL8wodtc4rW9
 aVPlidPURsPhfIaQRBbCqu6hSVTGv1Upc121dCrT+/pYgQoyMTTGQv95WfxT94uKLjWT+v0WQnE
 mBbfaXYBJJ6i0gCOzKMu0DSriJWbp9NQFiwMS8n36IQGrVRRZX12RB/zMkINOneZ8H6B0jp8j8=
X-Received: by 2002:a05:6a21:4881:b0:3cc:6d6e:288c with SMTP id
 adf61e73a8af0-3cc6d6e3ebemr1001710637.33.1786640985114; 
 Thu, 13 Aug 2026 10:09:45 -0700 (PDT)
Received: from
 runnervmvrwv9.5xxpbm4yekxu3cyamwn05ghzxd.dx.internal.cloudapp.net
 ([52.225.97.23]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ec002e857sm10845198eec.23.2026.08.13.10.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 10:09:44 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Thu, 13 Aug 2026 17:09:42 +0000
Message-ID: <20260813170942.4217-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813162337.3012813-1-pavrampu@linux.ibm.com>
References: <20260813162337.3012813-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcg/memcontrol05: add cgroup v2 task migration charge
 accounting test
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

Hi Pavithra,

On Thu, Aug 13, 2026, Pavithra wrote:
> memcg/memcontrol05: add cgroup v2 task migration charge accounting test

> 	group_a = tst_cg_group_mk(tst_cg, "group_a");
> 	group_b = tst_cg_group_mk(tst_cg, "group_b");
>
> 	SAFE_CG_SCANF(group_b, "memory.current", "%ld", &baseline_b);

Could the test disable swapping for both child cgroups before starting the
worker? Touching the pages only makes them resident at that instant. Under
memory pressure, group_a pages can be swapped between the checkpoint and
the reads, so memory.current drops while the charge remains correctly
associated with group_a in memory.swap.current. The same race affects the
group_b delta after the second allocation and can produce a false failure.

Setting memory.swap.max to 0, or otherwise keeping the pages resident, would
make the memory.current assertions measure migration accounting reliably.

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
