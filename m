Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1DAF8A171
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 13:35:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D490C3C1824
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 15:35:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 139743C1824
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 15:35:31 +0200 (CEST)
Received: from mail-dy1-x1344.google.com (mail-dy1-x1344.google.com
 [IPv6:2607:f8b0:4864:20::1344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C0DD51400BC3
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 15:35:30 +0200 (CEST)
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso10723954eec.1
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 06:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776346529; x=1776951329; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8OvufT7yU4lmk5gJIEHUmIiFb+V4CvXwqQVLMpHhsbQ=;
 b=Eu35b1MJsgoST+Y4lSSQEmwL8BBNIWQzKSSdTtgzguuiswGlwVECthZ35AY75x+vQC
 c4AE7UBx/ZoAByXP9BEgYJ8SHwPv2kXWoOX4azbZJZzrV201mhV4f8aWTBVwJ7H1xhHt
 eYPPlYkBs7lU7JTfDRhLfNyGoMKjRc9BTShSM60DOWU9BdfHmVv7xvDCx2qxb1lfvvtw
 Y2CzOrACNx9pXUSFirhSm5TnsFJMgQtMLEZ30vGqg+illd2apGcvj9itmNiVxELywRH3
 eh89sGYzdBYk3D6sfKsJRHZ76ndf/lM+og2C2Xf6Jvjm4WEuA5JbYFGSsMAkQ9bkyx6Y
 IHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776346529; x=1776951329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8OvufT7yU4lmk5gJIEHUmIiFb+V4CvXwqQVLMpHhsbQ=;
 b=Bl3i2oDdE1IiNWhwbmIy79ULOu1ZnplZhIYNBp4gKERzmyXamw6TXu6M8mP84Hvc1R
 0Ca4bsgh87ZsjbyzY2v8nQYOu7DJLMea6LefbbCFKDFWB/eU9qKx1LCG5Zk7N0ylK15H
 UcVsEBoeUzcjZKdATfrTSkYX9bVsGapGFosa/7FKm9fBRbDddzXfAHuvBbo9twQE9ltG
 35F67SeI1ANAxnzTQ1SsIa03DiEA+qyHXjIxEARKk1mNpYSdqizcOLJGGEO95GZ37pqY
 f+VRi31ZeVZntcatL031VRWzYsQy/op1JN7PgZ4RIbaTxrZv3Ck7eJGTrNuvujHIT6oe
 d5nQ==
X-Gm-Message-State: AOJu0Yz4mYvYCFBEKjFroDlrM82rbsNGWWESe1OvsqlM5lOJBpLZJE35
 d9Ps3Pll7V4GI76VyYPvdfqfNlZGBWU7HsYoOAwdiLc9taHEFGYmYBVJ
X-Gm-Gg: AeBDiesxZtNlQChdo+lIAMLQ9zz3Ycsf7/Qv4kCzJ+CN3f+t+RHvGZBIgsks0FK0NeK
 1+RUJdDokKi8XyRD0GD4V7pTqKiI7a6UhU3VGWiCARqw95KYde+EKLgZBHIffn61wRMbJw71320
 NkFTpnPPCCASRvz1STISh/tE0HteTUgzBizVNPAZu4iwjN99qqms0hOpxHCHihmTZ6XpTtsTDjU
 emVZXARyUjhh/PmIASc6FCNOBTkMESyzj4C2DKY/YTkkMSJTWFMNQjCYqgYnqjI7mxvI87PYHSg
 PHE30Ta+KTbQVXXo1jmYDnrPKXoHGIZpb1C7Ws//qln4h2NFYR5gsqrnB/aG1OZIYR1RPaORzdw
 chAbkqWnkzfgy8Vp71bWRjsN7pxfjxtUwC2R9aGxnJePvYTtW/UTte/AYYFv0wvDuwdXzemUC1t
 zp1M0vtTZGPpbGEgHzZQUNFhHKMlAwXlATNAv3582LHevdYRODWVKWKSZk9TxsLsKk5RkvfpaLb
 CRub5ouqyrh+IrmoHDdb2xbDYFQdMlaRN00ziI=
X-Received: by 2002:a05:7300:b913:b0:2d9:6373:ad24 with SMTP id
 5a478bee46e88-2d96373b29dmr9409296eec.26.1776346528841; 
 Thu, 16 Apr 2026 06:35:28 -0700 (PDT)
Received: from
 runnervm35a4x.5mdysf0siviedfgc1genqfi2hh.dx.internal.cloudapp.net
 ([52.225.73.168]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f65f9bcsm8977422eec.22.2026.04.16.06.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 06:35:28 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sachin Sant <sachinp@linux.ibm.com>
Date: Thu, 16 Apr 2026 13:35:26 +0000
Message-ID: <20260416133527.3891-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416124144.19343-1-sachinp@linux.ibm.com>
References: <20260416124144.19343-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/io_uring: Add fallback definitions for OP_READ(WRITE)
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Sachin,

On Thu, 16 Apr 2026 18:11:44 +0530, Sachin Sant wrote:
> lapi/io_uring: Add fallback definitions for OP_READ(WRITE)

> +#ifndef IORING_OP_READ
> +/* Added in kernel v5.6 */
> +#define IORING_OP_READ		22
> +#endif /* IORING_OP_READ */
> +
> +#ifndef IORING_OP_WRITE
> +/* Added in kernel v5.6 */
> +#define IORING_OP_WRITE		23
> +#endif /* IORING_OP_WRITE */

Looks good.

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/24513031465

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
