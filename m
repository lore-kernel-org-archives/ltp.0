Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE37C61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 21:10:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6DA43E9A70
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 23:10:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2B253E18A9
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 23:10:41 +0200 (CEST)
Received: from mail-oa2-x0b.google.com (mail-oa2-x0b.google.com
 [IPv6:2607:f8b0:4864:30::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 598361000610
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 23:10:41 +0200 (CEST)
Received: by mail-oa2-x0b.google.com with SMTP id
 586e51a60fabf-467e2b5b74eso667185fac.0
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 14:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787951440; x=1788556240; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sPTjZP0IYT4PpktgmNkgqIOESjQxm9uwqXHydyv3bKU=;
 b=RiKY+4eaN0cd/Q4APItVje54JXrQNGkVTUQDJ3uaevpYFsA9Z6Xx5lrZOY56qnkheQ
 WyxY1XkBdTIp2xin7K6AkkoBwoMoHpKeADo+iVngB8xGMxvhzupXYHeBRU/g5R90UBzo
 ovXcBdcg12dItQXcteE82PL+uheXZYEWtMMCZlsTAoTMVN94NIxEdHZfMYd0Zn9EcO8U
 UaqK8tIAqBXH35BgLQhm0A3mP9AlJN3lz5SK++CEUcnzkt1hUw/gm0Yb8m7pwdr2FP2z
 U8yBZyY27EA92Gn37wcuHuHV7OBzuym/KrjR0vu627om6l5pQgasf4nRUJVopZSpLxIK
 z1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787951440; x=1788556240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sPTjZP0IYT4PpktgmNkgqIOESjQxm9uwqXHydyv3bKU=;
 b=TCLMdFjy2JagJJt2xLr4c0Eg4uCSLX9CRo5BwB1WaSaEoc4vF+/eO746sx+qn0S8Jq
 5efzN5nYeVZm/P/T0RFQwj0dvpqf+VTEmRIUGrbsBvVfPGpGVCLkX8iZdHyb0Wezi6z4
 dY1Lci1Ipx8j7Kn9kiQC7cmnseA6QAI+ZHDDzCErAW0H+prd2Kcka3B42zSF+qZCAkUx
 a7f8xU2sU4pkT6Lxl3tgWacPZCy6AlVfvtZ0yxKcZtSJZSK44D25knKLoaP6eiHuUzFJ
 mpbQEWafvrqAOePzXopdzuqieJZuped/JB2dR07EckLkwuu2SVf1nz1AHof8/fJnr+a+
 y8nQ==
X-Gm-Message-State: AFuF++kkYVu1dEOZR013U/r6jP3hrgtcJq7kgbslKv8RpJeYygwxfxFW
 aDmPqykB6W9jN/sc4aXMlCgRLGf11wMmff6/DygkTID3td6OIktf60xn
X-Gm-Gg: AR+sD11DFrjqC7ne7zz3U7myjgAxoAqL42/bPkg2AUz4sDYK2YSEf7ssm74swgWHc7Z
 lTilO10ucYDkCSLyB5fvrRa7Nv0vXori66Xu3DS5FDJ0S4N+X9Y9i5Q24irhBUeBLCuoAhy7urg
 vzNNVeHhqhg+/fkRnJUFxk14DJmtdN02kOz0yrbGSjndJm2TdQF++49z7sNXXIuMWL1ARhF9Efw
 +tPc7UT47n8T//uT11YJ0gb8jv89TvRLHfKHDKoakMjgBGLgdl+4aIq5jCAD/W6VCv0sM18n0Bw
 +R5nTcAmA8wKysZb+Nyg0jMpMY1dSfYZp2lTpajGIR25IbA3JQ6pUG6aIOhYfXkz/PnthDSAa6W
 PN5UsObXReWlRk6uLsuTBKR7Bt8qgYI1E5wzy1bVIcvSP2qszOwvpwvYP2Ej4z92mYtOnjQWGqN
 mMksJ+S4NcThhWGUdsxOS/76aLlr0pncQNI5fTzhSUwZy2Mtb0iGpejkOa+bPNabeDxYRlIvZnY
 Gkd1oFxv/LoXoh/IgcbH+k+G+7ztyoptouuZghZNJToiN4Z/rEH5GSDPt05Zw2AtZFfr9Zqtplz
 hKE=
X-Received: by 2002:a05:6820:83d2:20b0:6aa:db9f:6b89 with SMTP id
 006d021491bc7-6b1c668456cmr7702173eaf.21.1787951439730; 
 Fri, 28 Aug 2026 14:10:39 -0700 (PDT)
Received: from
 runnervmgx7h7.sawxw5je4hoe3cq21bmrzr3s4f.gx.internal.cloudapp.net
 ([128.203.189.252]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b1ce160533sm2583685eaf.8.2026.08.28.14.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 14:10:39 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Aug 2026 21:10:38 +0000
Message-ID: <20260828211038.8829-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828-mmap_32bit_coverage-v1-1-7f0b8b589773@suse.com>
References: <20260828-mmap_32bit_coverage-v1-1-7f0b8b589773@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/mmap: add MAP_32BIT fallback
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

On Aug 28, 2026, Andrea Cervesato wrote:
> lapi/mmap: add MAP_32BIT fallback

--- [PATCH 3/3] ---

>  * - Verify that memory in each chunk is readable and writable
> [...]
> 		((char *)addr)[0] = 'a';
> 		((char *)addr)[CHUNK_SZ - 1] = 'z';

The algorithm says that each chunk is verified to be both readable and
writable, but these statements only write to the mapping. Could the test
read and compare the stored bytes, or should the readability claim be
removed?

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
