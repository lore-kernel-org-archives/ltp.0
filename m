Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFA7CA601E
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 17:28:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DB2F3C198F
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 19:28:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F10A3C198F
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 19:27:54 +0200 (CEST)
Received: from mail-dy2-x08.google.com (mail-dy2-x08.google.com
 [IPv6:2607:f8b0:4864:36::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E88BE1000527
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 19:27:53 +0200 (CEST)
Received: by mail-dy2-x08.google.com with SMTP id
 5a478bee46e88-34cbc588a31so2346264eec.1
 for <ltp@lists.linux.it>; Fri, 09 Oct 2026 10:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791566872; x=1792171672; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kMDEiA0bNxpVqcbdXV2fcY+DcIpXRkhCroFUsCyPtiQ=;
 b=C3cAOz67xyyt07wmUFDxNg73Mn4abawbfPFTdr2yg+3OlcZrBSS+7RFt4WEWLQ+VGk
 xCRiJhK13sokeZT8LSmabajE9BKHA61DZE3V51JcRA6vHZxLVx9Sm25KJOyo1hAwUkU/
 QK44juPG9/OYHGlenYaxuT3x4FKX5ILnmQUbqrLgbz1xC/ha9UZZfyfsQAsV6tHWEmDY
 9+niuENzyofoQbujBHBCEoYUVUWNaxDNXITy9/hoKs4FLgPAEqrWrbT+5U/jQueLGs/U
 elNnEBSzxpE6nA0Z1nazfFwbbfWBEd3Zh+7WRRjxIEKN8XuvDWxLvaHeigrIZnrevCsR
 cuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791566872; x=1792171672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kMDEiA0bNxpVqcbdXV2fcY+DcIpXRkhCroFUsCyPtiQ=;
 b=LiRG2Z6GN1jOz7GYeCzljRgdbcPXe6duECSb9yyCQI2Yc5qYmrjqXOPzDfS6shzoob
 E9zjwtJK/77JaYUpCyvf7ssJQWPusyHe21LScLOHGd1GEI7NJO5s4GyB51BwCIWCJ4KL
 2XpdjeoIfhJjZuDkkJrPTrPaAfN/rnvsFKl6BuVVtyVq2qSKkczGiWLPMW4/6zuxOSaI
 pVwZnY8laN6ZOLJ0n8a4e2vTCT9haYPyoHqAyFNDiWF/XMY7E0cuc4aqn7Q3SkuKL6ON
 KTmRjFd+s3r84DVEHstNrJzvUwySK0FnWsUI7M9sh9ELqT8tUoFl9VA2wOyiiCINeEEm
 xmPg==
X-Gm-Message-State: AFq9FYIqljVpAhF830M1Vl/K6BF6mcHJF6yqqyLDd1Ht7+eN/rGDq1lm
 Sc6cE0OTovtgsUlQmFnNdI6AY1lYRYCHiXeulKltGfDw3G5OFueSlItz
X-Gm-Gg: AYBFou0ICcfwVhUijyWvXmlMN8CdmXFoVrRusIwHJNf6Jil/k0lYHO3Wp8LZYpJ8gg+
 mQgiz26bujA3okcgQXvHLs56QFu7g963Q0LcYmUHu/bL6j+1HUB49R1R/rk9IigMgVMSiF6eTh3
 Dsf2vfWj04Nk3MUNEU/lb5QxUY4UQhC2belsbfF6SbIpaUW9YiHw9SnRu7wofyJGh7waCAAAtBz
 PGs4UkVFmNWYReLX0o2UyJ7yzp8YM4GO7HJRc346+FGR2IJSZ+RIpOHz7/W6F9rGdw9i2OVrtUN
 dj3IUJg8d/qT++kstqJTgLoiypxxRipR0VhsMKBNygZKSA4QufacQFuMtx2UdZJ+S1LqYdVL6fS
 dJA2EIw3SQCOipkQU2eCLVF8rra3vQGfDVPufllW7hyDupXbx8J+ua1VfMRgYBLYXAnAWgK1PzK
 F3Pl0LqwLTSfRtHciYQYOa8G7+Ngepu42yAzhJR0wW7pI1YeknzS4AU8U/rBdtevSQvPhxUo1CW
 rWXrl7NNu/DphNp5Ldu4xyOC+0a9mAUNoZyIQFV3Wl3Y+yzcrGLGSan3ac/xu9tmGZmoFcVp4CA
 It9HLYy4cDMs
X-Received: by 2002:a05:7301:4d0b:b0:34c:7e54:65e6 with SMTP id
 5a478bee46e88-3537ddf9214mr3141912eec.5.1791566871967; 
 Fri, 09 Oct 2026 10:27:51 -0700 (PDT)
Received: from
 runnervmmprz5.an4jhpycccwujg5lrz0tsrezdc.phxx.internal.cloudapp.net
 ([4.242.195.196]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca1ba7esm7341366eec.7.2026.10.09.10.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 10:27:51 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: dm.chestnykh@gmail.com
Date: Fri,  9 Oct 2026 17:27:49 +0000
Message-ID: <20261009172749.9075-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009155224.9042-1-dm.chestnykh@gmail.com>
References: <20261009155224.9042-1-dm.chestnykh@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] arch_prctl: add ARCH_GET_FS, ARCH_GET_GS tests
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

Hi Dmitry,

On Fri Oct 9 18:52:24 2026 +0300, Dmitry Chestnykh wrote:
> arch_prctl: add ARCH_GET_FS, ARCH_GET_GS tests

> +++ b/testcases/kernel/syscalls/arch_prctl/arch_prctl02.c
> +	unsigned long gs = READ_GS_BASE();
> +		TST_EXP_EQ_LU(gs_prctl, gs);

The default GS base is zero in ordinary runs, so an always-zero getter
passes; replacing ARCH_GET_GS with a successful zero write reproduced this.
Also exercise a known nonzero 64-bit GS base and restore the original
afterward, without changing the libc-owned FS base.

> +	TST_EXP_PASS_SILENT(arch_prctl_get(ARCH_GET_FS, &fs_prctl));
> +	if (TST_PASS)
> +		TST_EXP_EQ_LU(fs_prctl, fs);
> +	else
> +		tst_res(TFAIL, "got wrong fs register value");

TST_EXP_PASS_SILENT() already reports syscall failures; injecting EINVAL
for both getters produces four failures for two calls. Remove both else
branches: they duplicate the failures and claim value mismatches without
comparing either value.

> +static void run(unsigned int index)
> +{
> +	(void)index;
> +	.test = run,
> +	.tcnt = 1,

Represent FS and GS as two tcases entries and use
.tcnt = ARRAY_SIZE(tcases), with the index selecting the opcode and
corresponding register read instead of duplicating both cases in run(0).

> +    unsigned long v = 0;
> +	unsigned long long __res;                          \

Use a tab for v's indentation; checkpatch reports a warning here.
Rename __res to a non-reserved identifier in both register-reading macros.

> +/*\
> + *  Simple test on arch_prctl to get FS_BASE and GS_BASE
> + */

Use the :manpage:`arch_prctl(2)` role and describe the actual assertion:
``ARCH_GET_FS`` and ``ARCH_GET_GS`` return the bases read independently
by RDFSBASE and RDGSBASE.

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
