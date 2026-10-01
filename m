Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97288CA5FD2
	for <ltp@archiver.kernel.org>; Thu,  1 Oct 2026 14:18:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8DFB3E5CA8
	for <ltp@archiver.kernel.org>; Thu,  1 Oct 2026 16:18:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA9A83E1894
 for <ltp@lists.linux.it>; Thu,  1 Oct 2026 16:18:11 +0200 (CEST)
Received: from mail-oi2-x0b.google.com (mail-oi2-x0b.google.com
 [IPv6:2607:f8b0:4864:32::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5074F6002C9
 for <ltp@lists.linux.it>; Thu,  1 Oct 2026 16:18:11 +0200 (CEST)
Received: by mail-oi2-x0b.google.com with SMTP id
 5614622812f47-4bfec71901fso2544773b6e.1
 for <ltp@lists.linux.it>; Thu, 01 Oct 2026 07:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790864290; x=1791469090; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kQGu9B9y47n5moVsl1RsK3m/v6eDbK+hyektecGe0zE=;
 b=bdgi5GYMuFzd7TmzxS8cF7JxlZdLcW1snJJNIkpTtCZ08ImGWF38CfCyrDdgDkWYa+
 uEG9Osjav8zK/Jrm0493p8Gl5fQQOh7YAbLUc2MJXrkRBx/WG2XUCnoPLpcCaLolpse3
 S6OeTcD40U9BtwRTFjtWkuNgNpwvNiLUZOIK/QaVgwtUh0BAwEhoRo4hOCAvXc4s5WIY
 QYqCL/y987Ok+zPcg2aQBTmTxT/vzJSFmM5RNLpHDAfKiumLChFoQdiQNwqRsqqm8VaP
 h8UaaR6sm/PEg6zbrxvoaaZStz3FoVMS4Obs6sMsBrBymcUB9a7kFRnit9QEm4t9RXHu
 uMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790864290; x=1791469090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kQGu9B9y47n5moVsl1RsK3m/v6eDbK+hyektecGe0zE=;
 b=tPf2OnwYRErI9MS+r99ZxSS5KlASVaZ0ApsuRPE1pe0ehUin+CYP94cu0Rz6sPRWfi
 E3e6ZR22P+Qvrpbg+PrV2b6D9TpBLYDnBIlCWuwxeryjcgeLpt979jLc9PLzK4kODTL/
 L5dNo9f+yO8xHtzZxbumCoIf44KrBA0mZUVhB5gI7kld4E7jSWLl2QkbMSBUNq3K/Qxx
 kkcIYJlADDCOmOarf/ttKCZwFgqyYJxZfPcdzaaGbtIQpey5QjExa+MEt3/PCx2vLbA8
 0HFm4LdqO3tRtmZvNQHChcxYzFHW166A+/JCn/GUITTTEcV7VpQxeEt+pzu40rJBoPHz
 oPRQ==
X-Gm-Message-State: AFuF++kTAWChwgskBkIa8+sSE0Sk7dVICl/65rKRbbIuhrXBYvN8hYDo
 xfy1/8qteduPymULYLH1lfy1hqEv2eHovlfQnpyZUhvL5j/nGNukkj8G
X-Gm-Gg: AYBFou17HUQTU+XpRFqGtlJ1/MIhM50rWuwphTXLKYZvvBT9/hi6V/vfYL13Rkrzqku
 dWrknM+ZkNw3jNiZIHnnan/GOMldQtmMEsGyNAPhDcKp4x+/X9r/L2nfank1XtnZ5jybMBwV3FZ
 CzJ9yApptXyDdSfvS95ML85lcpkAXg+vN5w/b6paO7jrreYLQG/fSXh574D9R2PgAuWqi8iBE+K
 jtoaV8f2ZeZT52tOdAEr5XYF5lxLXR+gpwXK/MpYTQw2oWTA3ug5OMfEgq0EzgTYSdTIuwhn2tf
 HuqB+j3FusrLaKw+9ajHOMzvHVvCpMP5hC5BJrFYaEVmv7/cdn8dvJT7CJD1lQnPvwgliH/tYID
 f8lWsO6GXhqyiWDnuL2q2F5PO5sKcqWrUd6/uDqDsKI3ZlSAmud5lfga+F/0k82Tx6pqES/Y5/0
 kZ1RGmEXn000Dyqp5V/m0Clvh0PUahwwHgUGe3nI0fX9NoH7wBEsH6Cg0MqeydahRCz9ECZv0DS
 A9+RQR5slK2+eKT76XHUEs7PcXsRIWiMb43BCXK7sNNqr6RjbbtYKYgfVElJF0gZ86ofUBy5SwT
 23ckFoMjpuYSIi0=
X-Received: by 2002:a05:6808:309a:b0:4f1:6c9c:78c8 with SMTP id
 5614622812f47-4f1badcb238mr5781688b6e.59.1790864289612; 
 Thu, 01 Oct 2026 07:18:09 -0700 (PDT)
Received: from
 runnervmtr4k5.l1h5scrcalruddgw10wsm1k3yb.ex.internal.cloudapp.net
 ([172.214.155.180]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4f34bbb2227sm2478182b6e.11.2026.10.01.07.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 07:18:09 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sushmitha <sushmita@linux.ibm.com>
Date: Thu,  1 Oct 2026 14:18:08 +0000
Message-ID: <20261001141808.3976-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001110953.32332-1-sushmita@linux.ibm.com>
References: <20261001110953.32332-1-sushmita@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cgroup_core02: modernize test using LTP cgroup API
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

Hi Sushmitha,

On Thu, 1 Oct 2026 16:39:53 +0530, Sushmitha wrote:
> cgroup_core02: modernize test using LTP cgroup API

> diff --git a/cgroup_core02.c b/cgroup_core02.c
> new file mode 100644
> --- /dev/null
> +++ b/cgroup_core02.c

This adds an unbuilt root-level copy; normal builds and the existing
runtest entries still use the unchanged original test. Apply the changes
to testcases/kernel/controllers/cgroup/cgroup_core02.c instead and remove
the root-level copy.

> +		if (pid < 0)
> +			tst_brk(TBROK, "clone failed");

In a forked child, tst_brk(TBROK) kills the main test process with SIGKILL,
skipping cleanup(). If clone fails with EAGAIN, child_a and child_b remain,
and tst_cg_cleanup() cannot remove their parent because it does not remove
these descendants. Propagate the error to the main process and report
TBROK there so cleanup() runs.

> +			TST_EXP_FAIL(write(targ.fds[i], "0", 1), ENOENT,
> +				     "write to cgroup.procs from different namespace");

Use TST_EXP_FAIL2() here: write() returns a byte count on success, not zero.
TST_EXP_FAIL() diagnoses a successful one-byte write as "invalid retval 1"
instead of an unexpectedly successful migration.

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
