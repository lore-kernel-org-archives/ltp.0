Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E4AC44515
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 15:54:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99EB53E92C7
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 17:54:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7F7C3E9613
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 17:54:11 +0200 (CEST)
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1EE3E2005DA
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 17:54:11 +0200 (CEST)
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-37fb1883fbfso2590872a91.0
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 08:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784562849; x=1785167649; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GI8wKe7VkdM1TKoFc5E0uvPzcUQu/aJV48REnoKEcvY=;
 b=QUyRJ271LsVTsy/nHtFj/Hh5evk8lanqDDmKYfIq3LRyCOjqaefw0fqZjF2bxS98mO
 DP6iKrACbtVGfdn1NeMfHWBpDSZmAoaaiz8+ewn6xORFn/hVZpiUx5Dd2wBLM1N9uwU6
 UXZ++GtnbqW65UA3H5Gyzt3LCbfcEXdjggn7RPF2RoCiMKXT4hxPDxJtCSxAoaB/ipZP
 Db+OmIG2nF8zJfRC/koWaLCMzUIOL7RET+iMSKTBKsEUpQfk4worNLjCKHO3qJLVQgQn
 3atJ7+DdHuWxpBVaKwmnmbgFikgRq+Oh9zb1vtP42uchveTkCiILpYyY8Uauq0arm7bd
 Z3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784562849; x=1785167649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GI8wKe7VkdM1TKoFc5E0uvPzcUQu/aJV48REnoKEcvY=;
 b=ZwYlhwrBZD1duK5I+sASOmfksW+4pEpCaDPl4Irun/kzdMgN9/recEE4cSwg23nCVW
 MWQmIcETPiwivyhzwIoZe1NNQFOHLIvom2WrXhr2uTV1Ql2NCycZgVhTAA6rJ/9FKwBN
 smudBXhfGumnhUKGoUFo4ZrFaMmfwLprJeyQp4d/WEJsamiB2AFcjshXo0pXrFD+4byk
 uAreVDjBPQDKEqJyAXizhlhKzd450JhJ/3b9ouvo7B+xfLJ0p1IodMhrBr4554Dqv2gl
 CGMvnJUUFaNuX8n7XjzsqYUpf0pTLCvirx4it2ti60XAaeQoD5ztcPEucvGE88DtUMYn
 wyQQ==
X-Gm-Message-State: AOJu0Yz4QPm4zNrTECZBDWT/4geOH5jQ29FP/PlyDBNsShmMNQvogkPx
 UBeg+jKjdWYnHSRgLq2r867A436M83FcSxfl36Vm+dtAZfnnUenNqH+N
X-Gm-Gg: AR+sD13NgB5YRMi5xvoTQO/5T72HxAzZD/qV/NPZN/ecRDMrTGhkbxRzW+BAnvMQ0Jq
 /kyqCgXr2YKzkSx+pk88uim0goVckVOvWrSiFiVZuKtFYRGoMBJ3oVxEHZ1YQZHGMXY/JPnAmFU
 4far0ydojg3G6yCgKeoRC4IRkFvwBuUzuVAjCzUJa/CBaGMbk4GnghHCr+uDet2I2lMq7luodrw
 CXlY+dGWVZtXjrTh4/9CC80Zab3iqpCWjPIleCe8pYET+bSeTcMdU5++L/0kwUN/RnArxx73o5T
 r5JPQqbDy4K31FFWDLSzGgtD7RjP3o7tEO0XPwA6f+Qee7cLeSPVPGVCQWCKS2ukfnli0owyybE
 RgsSGYEs2kBmoSAmAHF2aY9kFer3PxrpClDDHAQODSLnTMCyJtkxFkDCJFBD+Sl1iV77yKTo/X7
 ehoKUiSZe4GEnWrmZ7PKmcGWA9zcxFDe0CwhY5IEMb8Esru5CQB0AdG3T/9h+GjslcgoMXdySeS
 qp9eae5u71hvMc4P2Y=
X-Received: by 2002:a17:90b:1f88:b0:38d:f1a4:1116 with SMTP id
 98e67ed59e1d1-38e4b537bedmr12805280a91.33.1784562849234; 
 Mon, 20 Jul 2026 08:54:09 -0700 (PDT)
Received: from
 runnervm3jd5f.4xo3wpb4ugwubdrh1nu51nyeia.phxx.internal.cloudapp.net
 ([20.171.20.58]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2de31a7sm32603053c88.15.2026.07.20.08.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 08:54:08 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 20 Jul 2026 15:54:07 +0000
Message-ID: <20260720155407.3993-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720-fix_cve-2026-46331_enoent-v2-1-395819e74978@suse.com>
References: <20260720-fix_cve-2026-46331_enoent-v2-1-395819e74978@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cve-2026-46331: fix intermittent ENOENT failure
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

On Mon, 20 Jul 2026 15:17:55 +0200, Andrea Cervesato wrote:
> cve-2026-46331: fix intermittent ENOENT failure

> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "899ee91156e5"},
> +		{"CVE", "2026-46331"},
> +		{}
> +	},

The fix commit 899ee91156e5 is not present in kernel 7.2 (the current
latest stable release). Per ground rule 8, the subject line needs a
[STAGING] prefix:

  [STAGING] cve-2026-46331: fix intermittent ENOENT failure

Verdict - Needs revision

Pre-existing issues:

The test entry lives in runtest/cve, but since the fix is not yet in a
released kernel the entry should be in runtest/staging instead. This was
introduced by the original test-addition commit (d6fe8d8e7 "cve: Add
act_pedit page-cache corruption test"), which also lacks the [STAGING]
prefix.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
