Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78140CD8CA8
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 12:28:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 107163E1CF6
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 14:28:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA93A3E1CF6
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 14:27:57 +0200 (CEST)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 53B311400C70
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 14:27:57 +0200 (CEST)
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-9157f7c1c0eso90727185a.1
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 05:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781267276; x=1781872076; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c3M/ImDCukUvb0XumFKZvhfP9jUHjMKjqhTZPGgSHH4=;
 b=FyX0y7relboiND2s/ymNbVht1QtvQUgzYhEluTWVdcjSGPvkzpyjKunX43eoMtTWfn
 dbEHastj7MKUD8S3XkKnQWoV3unu/3zNe6+2kIrAdQaNL1IRfsBSip+i1tYXBiF4iJpU
 Kh63wK5tZdzl+DmvHm2daceMfgnn3hjae1HK0m/4aO+/cX2DGBwc27R6HwKNyAd3By1r
 gB+RgrxWXW9K+LdVrUCWLAma6Rr3+0875CQqvWOvMk1H2X5NdHBEkwklG7ODvrMX65RO
 nl1e8xn4KV5z+naQ9Ydz8frvhq+REeRWWEUa/NO/6Lvx9TanSg3NeP1slCwG5iKpYn3E
 +R/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781267276; x=1781872076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c3M/ImDCukUvb0XumFKZvhfP9jUHjMKjqhTZPGgSHH4=;
 b=VcJwtuJTFCglSt+Hr2Zj8EmV+xHGkpvLjwKcRxyNG6Yjyj0t9/RakbWablz6LygoFS
 YsPUFNCmowr1rDMReO26rKM/dN9plRu00ZZwr4WpWb8ADPPCs8j71mOQtM6dO1Tjjblf
 wTxzNpy0EHQzChVrMd2vwOUHbkZGinPJDr97BEI2941eF68Y0a45nCG/jqtR6gvzFOcf
 DxTMuXDW2LfRjuA5aQHBFvENb3h+GH74e84XzlIirbUD8CszCwGSyJeff42RD1Oa1NNH
 dTxvazzSH21HDFS1pyFyy6SFX+yTNIufuCHPNim4YBkQ/Qok37wicCZXhd4TRQCSotwW
 toFA==
X-Gm-Message-State: AOJu0YwLKK/iY+Caj00PdskqZrrGVcVnULqEyFyp/BPVm8PA95UKDSCx
 2s5oalb/HVzEXiLlITwdPYQwoT4vd2U7KYSVM04Fe3USEgGo2NEl4dQm
X-Gm-Gg: Acq92OEdlDaXGTM49ejkd/o1RSYVaLarUoq69s3lYwDHFuj3dXQIJyTqRngwFc7XDlq
 QmhHj3qQq5mq46SqyPoB4CRJDYwXiQH8hbEKKxrvKDSlfnI3Ii0tCb4nqQdgKPDsS1kBMi1RpkN
 w4aHB825TUobcYlwQZuiyLI+ASIxjQM7ZV7K5Hfq6aF/1a1efkW5NcC1JDIuhw8sL5G1cpFlHWw
 Ev5I9YMv3ciE2DOatTWz6uIGuLiamCEeAs+db+fdUoW4TG5FLpRjSjhRt+lWNA1qSnrY7kf1tlh
 kx9qUKqxohG+9uzE0/yggZqlTLMkWCFbC49gkIhNptW8VaAaK6crpx9tDFx/s0I1dGMM6UBgJN+
 yaNzlqyTaTg7UtV1SSDUVJZp3l72ID+5q/ywa4q50HteXIf4AWnTBMgZOLQ2ETdHK3yXWDwp9qF
 /bAdYp+oEUWPTL/zpJ+Bj+9m+eT97ZsrjoM7kKO8h/COT/br+HRYuddHRValhL3FKZz/rQCiZTH
 PkoH2uMIT5IDtDO1F32u5i+6bQYtx2f7IyBYq2F
X-Received: by 2002:a05:620a:17a8:b0:914:7b4f:cf5b with SMTP id
 af79cd13be357-9161bae5cc7mr313092385a.16.1781267276090; 
 Fri, 12 Jun 2026 05:27:56 -0700 (PDT)
Received: from
 runnervm1li68.f3mlxvf3wtgejkn5nkkey3hymg.ex.internal.cloudapp.net
 ([64.236.141.179]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9161a03bd31sm191144085a.34.2026.06.12.05.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 05:27:55 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sachin Sant <sachinp@linux.ibm.com>
Date: Fri, 12 Jun 2026 12:27:54 +0000
Message-ID: <20260612122754.4205-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612102502.24071-2-sachinp@linux.ibm.com>
References: <20260612102502.24071-2-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fs/acl: Add ACL_USER_OBJ permission test
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

Hi Sachin,

On Fri, 12 Jun 2026 15:54:55 +0530, Sachin Sant wrote:
> fs/acl: Add ACL_USER_OBJ permission test

--- [PATCH 1/8] ---

> +	SAFE_SETGROUPS(0, NULL);
> +
> +	if (setresgid(gid, gid, gid) < 0)
> +		tst_brk(TBROK | TERRNO, "setresgid(%u) failed",
> +			(unsigned int)gid);
> +
> +	if (setresuid(uid, uid, uid) < 0)
> +		tst_brk(TBROK | TERRNO, "setresuid(%u) failed",
> +			(unsigned int)uid);

SAFE_SETRESGID() and SAFE_SETRESUID() exist in
include/tst_safe_macros.h. Since SAFE_SETGROUPS() is already
used on the line above, could these be switched to the SAFE_
variants as well?

> +		if (exp_errno) {
> +			TST_EXP_FAIL(open(TESTFILE, O_CREAT | O_WRONLY, mode),
> +				     exp_errno, "open(%s)", TESTFILE);

open() returns a positive file descriptor on success, not 0.
TST_EXP_FAIL2 should be used here instead of TST_EXP_FAIL.

With TST_EXP_FAIL the PASS_COND is TST_RET == 0, so if open()
unexpectedly succeeds with e.g. fd 5, the macro falls through
to the "invalid retval" branch instead of reporting "succeeded".

Verdict: Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
