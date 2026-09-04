Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992A3C624D3
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 10:42:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CE053E9753
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:42:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56EE23E9750
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 12:41:49 +0200 (CEST)
Received: from mail-oi2-x06.google.com (mail-oi2-x06.google.com
 [IPv6:2607:f8b0:4864:32::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 806A320077F
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 12:41:48 +0200 (CEST)
Received: by mail-oi2-x06.google.com with SMTP id
 5614622812f47-4b3759b7ff0so328095b6e.1
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 03:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788518507; x=1789123307; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wda+7FavooHdwJcQKgI3gYF1zKUOExGc618SLa4t37Y=;
 b=biEc9FP3wE++aTFL2E8qdQbFr3AC0OkU9a+fUGkVR423P4tery1U85C/JoUKwp/96s
 NliUQMOm6Mq7Frc7SKa0z86Pw+YXJBSylja3MPuscNXSXfVHmDapo28PO30J35Ustuns
 pZmworR+1nEmnU4mUFq5gOp6dn/3r52LSfY+n8zEPWysEdLRsiExPSUefwOPRb8w6saJ
 vbWkcG7wvogLQYwRl8B3+vsxasS5duI+Zs7JVRkieJng2wciRpIyW/vhslawc0MesQpL
 tIl5vE/9sxMtepP7wyeG2Nkr4YsumbZ7r+UFywZMkiosGj/MbiaTSgdNmDtZuSrb/Ad3
 J/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788518507; x=1789123307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wda+7FavooHdwJcQKgI3gYF1zKUOExGc618SLa4t37Y=;
 b=OCt3Q3VT0RslMqt1Zv9dCf15oewFm9n3dNGOpxSFz5C/y/IK19WkW9RKRZvE1jSr0G
 VSUhV74gvSOsfgLcEDY3VcAwbkQBIATCi7/MslXGSkYS6jho7t4uEcV2uBVWPZPnjpxv
 5o7KcIsLGlT430BL4nXE/LIzlBiaZxS65knmfdpw4QxfFc2f/nWvr3hWHFgEG3x2JUu5
 kAWOEhZH8Vs0/7I/G+ufYuC7ytAtUzTs9e2ni5XJ+k/AGWKIfhEgzdT12aUtBkgLLrbG
 K5Rp79iwqGfFdKmR01rhTX0bjKElbgfTrvUjQ4TgP5cxzavWpIJd1wQ6KJ/khqwU6tQ+
 jeMQ==
X-Gm-Message-State: AFuF++n2CRo5LbY1TWJzIMB/R/4WBBP6JGstbfYZ9WAiGKaC12CEpw79
 AbBeHhJGd4a5rSQlj1Yp85TClhJEozk+2jne1imbH1FVN++fWq/TduzZ
X-Gm-Gg: AYBFou2cZvJ0RMqGoonHXb1KeDxJODBR8rqnImS0X2xEcvPS7k7rnr0cBeoIucpC/+2
 UUSsbNZUi4X2c11HgPvwDs7ckvCfReNd/5XqXc4JWR8jYNTmoPv6RqUQpKta8LBzDV12gR08fSO
 TmnGNqjaIwYZgCyH63AR0g4BUC4uJebtmN4yK4gsd7XX51sDZT82JsUwHcH4pHXQJwOc8m468XK
 c+0yzlUsd6qSyZ2LOFPPyc4XJIKDKm5o4NBivPAMyNnXVoNP9UsboXaR76hzM9HT2II0BEnvFFU
 nBXm1b7PN9SNycq+mdDj9MMDGwi6DUYm8dSrU8aoDYP8zNPMbWSkaJktWhF9Zny8dcff9bt7Qf7
 ouFSfXc6WQUVdLYHB3yXvT845pQ+u3xgGzchN1oUpreCQtpx8KffWE4BL9S53GiOQNeDgVgP3Xa
 KOn6KNShjV2j20xPEcCQZQrut77xoCFLglBCl9Dt04uaib7gQDX0DIr4yw0CDnDOqI6SOcYQ3Zq
 y08+WuBcRY53h/yoBMeyXPCRQDx10iimDgyqX6Dbl2oVy5nUaBiTiisBBCMwRBBfvLg44ooyg==
X-Received: by 2002:a05:6808:4f25:b0:4b3:1a95:4160 with SMTP id
 5614622812f47-4b963ab8d32mr4268370b6e.18.1788518507023; 
 Fri, 04 Sep 2026 03:41:47 -0700 (PDT)
Received: from
 runnervmejwal.d42dy02qlyzefb0mhnu3tfa5hb.gx.internal.cloudapp.net
 ([20.29.53.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b971c98e07sm1739168b6e.18.2026.09.04.03.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 03:41:46 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri,  4 Sep 2026 10:41:44 +0000
Message-ID: <20260904104144.7749-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904-min_kernel-v2-1-9991d3fb3c18@suse.com>
References: <20260904-min_kernel-v2-1-9991d3fb3c18@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Check minimal supported kernel version
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

On Fri, 4 Sep 2026, Andrea Cervesato wrote:
> lib: Check minimal supported kernel version

> +	if (tst_kvercmp(v1, v2, v3) < 0)
> +		tst_brk(TWARN, "Kernel is older than minimal supported %s", TST_MIN_KVER);

This exits with TWARN, contrary to the commit message's stated TCONF
behavior. Use tst_brk(TCONF, ...) so unsupported kernels are reported as
skipped configurations.

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
