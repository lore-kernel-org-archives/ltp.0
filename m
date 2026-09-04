Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2BDC624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 15:18:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D37B3E978C
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 17:18:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBB703E56C2
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 17:18:34 +0200 (CEST)
Received: from mail-qv2-x0b.google.com (mail-qv2-x0b.google.com
 [IPv6:2607:f8b0:4864:33::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 714BE1A0117F
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 17:18:34 +0200 (CEST)
Received: by mail-qv2-x0b.google.com with SMTP id
 6a1803df08f44-90cdfc57039so3130646d6.0
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788535113; x=1789139913; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rhh4DL7GoxS0YjQVXVnrN4cKSI4qfb0UE60AndE9/MA=;
 b=C6btwwOZJSDjdMWif373bNFslzUwjO4T5CGmPppeUny1ilazIxqniSYjEKL41c/7qX
 QptaSJD1ub/94zuvA1VcztTzdMcxOvS5oUkZj0NqK6VwJqkpuKi5xtFvvO6OMlE8+H1H
 wnGuVpjSWFTxFr498d5SGM+yJpKDwqD6Y2TWadANT22lMX1cZO4kwu/9IwfQ3ofjvvG4
 kAAxgxqB/czUEJDy5rA+QWKUAR+7ni+Ke7CJJQBklwUjcuk4j33WWtkMypW21UYMQzfN
 PmJGNQNkfQH47ylw5EHbMHCsjZ9pgo70K7vUz/ygAenyaDU8XJHJlH45+doTIYg77sKR
 d/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788535113; x=1789139913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Rhh4DL7GoxS0YjQVXVnrN4cKSI4qfb0UE60AndE9/MA=;
 b=gFVryFsX0WhYBVHb7NDcSvXeoR+bNxBz01Fap6kqlmDJD+JeSzb/EyPPE0xSuXYMWB
 oO/pDQYQg+Rc/ZNUFnR/wC/rui/PS++yHLeA4m/+nDx0XXgZa2i6f0KbTj7PxZ2SzFry
 m4jFtdCYmZ0533BGHG/gGaFzPyQnC1G9YUqaE8D+bUHYg2bg9ZhGOn9JALdkdMk5J272
 8TpASDV+mo2q0ILBHTnJ4xomEwHLLDNT3yNjyCkPJtg5rWaNx8vlbMo4C2mBxmffOWUv
 +7nwl1ZIEzccNtBvIi7Z4P0YaaEYeBnT6m/3cdMhgwjMPltKA7Gcexdg03aJmSdbHfN/
 DW3A==
X-Gm-Message-State: AFuF++lCqQ9tFRIFn1OIgo+WqKMV8iIfQn5yrc2BPPnTzocbKyg6QgPj
 HOuqCctc1ENNvsuZd3DSz9/+ZAnqbNGLTsZATHrQ5gKTFkYxSNBhyAnW
X-Gm-Gg: AYBFou3s/GG+ZMYoNYiIGJY5yEbEiJMLU8++0BP14JNHGMbgw86MxAzmPpn3SrGI2N9
 cgUqn40hAeYYe3M92ZfRU51pHGCfmZk9/UaPMMuzCl5TCsK7jGsutddRlX7bcs7UVJo6jVW/6Fs
 aouIjAhp+0IO9qybQK71GD33tmeKLq9FNSUikV4UAKjw3pdKc6Tbt6QqXYr54l5HEmjLGMuAqxZ
 u8bLfSFaW/KFjOdekkhN/Yn7/hxeWGU+b3lNI1YQIoYlMLcKRRqz/8CPU3iMAsZ+QDlUhN5Zi6f
 m5mvCT9XQv9eJbDJHL1fFJttW7ekPunIr+ZThRVSP9YwOyDZ4uCbvWVfAg455A2n9hfRwWMI4Us
 5iShXrsIvRvMpu3bLx8i/jojlsMphXMh+EDq7LMzIEjeIDEBaiTjzj25wF0dty/+LFLspZ8MCaa
 NIseToNbML3dLJ76RdARWts+08pKuObsIi91ogj2wnvtmXXhpzBvdMNERvX9NelKArwKWtmgSVm
 4nWMFn1mio39BXXCyMVyiee90pUV2L/149iIPPQO+8pw14/lgvVWDgGI3+C9r4VuohTTeja/hY=
X-Received: by 2002:a05:620a:649c:b0:937:1b8d:e3da with SMTP id
 af79cd13be357-9398053955bmr724361085a.42.1788535112905; 
 Fri, 04 Sep 2026 08:18:32 -0700 (PDT)
Received: from
 runnervmejwal.nh2apy4m4v0ufgemucnyvc4yzg.cx.internal.cloudapp.net
 ([48.214.54.51]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397fb70fbdsm230078985a.32.2026.09.04.08.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 08:18:32 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri,  4 Sep 2026 15:18:31 +0000
Message-ID: <20260904151831.5154-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904-keyctl_coverage-v2-1-43b78b15ef9f@suse.com>
References: <20260904-keyctl_coverage-v2-1-43b78b15ef9f@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/keyctl.h: Add fallback definitions for extended ops
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

On 2026-09-04, Andrea Cervesato wrote:
> lapi/keyctl.h: Add fallback definitions for extended ops

--- [PATCH 15/33] ---

> +	/* Probe if asymmetric key type is supported */
> +	TEST(keyctl(KEYCTL_RESTRICT_KEYRING, ring_builtin,
> +		    (unsigned long)"asymmetric", (unsigned long)"bogus", 0));
> +	asym_supported = (TST_RET != -1 || TST_ERR != ENODEV);

KEYCTL_RESTRICT_KEYRING returns ENOKEY, not ENODEV, when the asymmetric
key type is absent: keyring_restrict() propagates the raw -ENOKEY from
key_type_lookup(), unlike add_key() which remaps it to ENODEV. On a
kernel without CONFIG_ASYMMETRIC_KEY_TYPE this probe therefore sets
asym_supported to true, so run() proceeds and the builtin_trusted
restriction returns ENOKEY, which is not handled as TCONF and reports
TFAIL. Use asym_supported = !(TST_RET == -1 && TST_ERR == ENOKEY);

--- [PATCH 16/33] ---

> +	TEST(keyctl(KEYCTL_RESTRICT_KEYRING, probe_ring,
> +		    (unsigned long)"asymmetric", (unsigned long)"bogus", 0));
> +	asym_supported = (TST_RET != -1 || TST_ERR != ENODEV);

Same probe defect: the absent-type errno is ENOKEY, not ENODEV, so
asym_supported is true without CONFIG_ASYMMETRIC_KEY_TYPE and the
needs_asym tcases are not skipped as intended. Use asym_supported =
!(TST_RET == -1 && TST_ERR == ENOKEY);

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
