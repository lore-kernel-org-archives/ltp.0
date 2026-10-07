Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAE5CA5FF1
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 14:18:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A3AA3E96B1
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 16:18:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D21393E7429
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 16:18:02 +0200 (CEST)
Received: from mail-qk2-x03.google.com (mail-qk2-x03.google.com
 [IPv6:2607:f8b0:4864:34::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 995821000286
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 16:18:01 +0200 (CEST)
Received: by mail-qk2-x03.google.com with SMTP id
 d75a77b69052e-53391df636aso10757491cf.0
 for <ltp@lists.linux.it>; Wed, 07 Oct 2026 07:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791382680; x=1791987480; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tE0aVFYQ2r9XxHRNCt9+XVKaibDi4uZ8jCjYnBfvsIM=;
 b=iY4UpaWfpxZEksY1gmqocq8n2WgGnClSwoLvgd2biPrOhXP/VaEpbDp0L+0vKv/mmU
 aOdIBczPbSSBK7mhD265kSqpYA59+2nKcA+Yxx3sq/yZPjawTqz81/1vbM1BczZvzEjo
 ykjWyv7c+jQSTAT2MPiVYFJaiJikWFk0HBWIjuzW1tVf4h7Hq9ohs03wcy3A2pCN8Det
 X2sOx8ZYCFLtFguQyCFGwX8qPcsSaGSMeevG1FWchoOlIZyX0hhfszpThcSeBkrWifDB
 5P6iMlq+RwrR41dql7fte65877WGfu/rtHKXThhgwSOiPNIj4iTD3dln4uub4oNYk05/
 +clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791382680; x=1791987480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tE0aVFYQ2r9XxHRNCt9+XVKaibDi4uZ8jCjYnBfvsIM=;
 b=aBLc0MEqae6S3uMhUnseWxso8yVvQbyfU8h0PB9zE5jZHOYy4fsCaFnP/IANAVSZWO
 HYyh9TnukVrTSk8kTNV1/LQkh0Uy6RsA3R8WAkd7uuue4KX6l4ENWQDrOOzx+uQ16kdL
 URU9ZB/2RemT+W9qMW8o2WkTglV4AtXCd4jNlewkEwVew0bRmfbX5gIY6NTa1Olpvi8B
 LVzPyoav2wbrmRNwaDBNXiix0jY91CL5IlCnc2rNqLzPlcLY7IukxIyBrjpCm8rLA3Z/
 khalqVhOJKDtel5SpRMyavSz0fLHgbS5mZrToPTI9O8hyfoUnm3ROEsAlG5xjzTbYTAA
 G4HQ==
X-Gm-Message-State: AFuF++nUI3w+tr7tTy4lwEN3RBafKV/AvZi3S2cYgmVpQ1YyRPZ7OAUu
 uXBb3GGyVCM9ZW9ipFcLZ/35baQ+q3jtidC/XEJiSVS2nTxd7/o4L9eJ
X-Gm-Gg: AYBFou0efITbH71k+6x5osumBrGk6hAHH2D0If15YI/q2/g3oUv8pvXC63SHPwbPca1
 f0FuoPtTvi96kl3JnDMshhRb6FBVrYl6dthYiQ2HfHm8ecwC2VuiBUGXuFddrdK6oCLOawyDPeR
 hmDszTmnlvZVmJ/StM6r7iCnYIty6kvlgsHIXnAM3r42xFz5NGfYmh+YQsLKpzgpuqMlHgRWELI
 f4Kai7a297Dy3CR+YaA0tIGj9bGTbAFxJi406QiOc4l6/reLuWx69qc0u/6q5Rv583kT6rhi9eJ
 Bl1JYTI9bjYDPjY9S9J4q4q5/JPRcM6H2zKzDZvwxii1MgHKWOtLpjRlpla3HJkWtuTEm8rAXBF
 +JUwdV0QhGcgmUWxY4OsTBY7T39Dv2fm8P+4R2WGLaabHOsCxu08muWSf3xLXrLNVOQL4uSiksg
 /2NUUeBalFKsgNc7U4mL5IOEH6hmt8F0bDqYixG1BH41BPWkXQaEtd8XbNr2YzF/1+1FhTUwTma
 NF+cYQLailyxpD1w7kZvFo+IsQmppFhpfod1o+3vDxfBxFuhXsXPqF7zg2m2SmLM2O1aveIGn0q
 3ekiYSpJJxFXIA==
X-Received: by 2002:a05:622a:1a81:b0:535:70b4:9d9b with SMTP id
 d75a77b69052e-5357564cd27mr41170811cf.77.1791382680000; 
 Wed, 07 Oct 2026 07:18:00 -0700 (PDT)
Received: from
 runnervmmprz5.tornivwsjy1exiwt0otn1hacmb.cx.internal.cloudapp.net
 ([135.237.130.154]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5357219c0ecsm20854401cf.24.2026.10.07.07.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 07:17:59 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Li Wang <li.wang@linux.dev>
Date: Wed,  7 Oct 2026 14:17:58 +0000
Message-ID: <20261007141758.9828-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007105730.94492-2-li.wang@linux.dev>
References: <20261007105730.94492-2-li.wang@linux.dev>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_kconfig: load and unload kernel modules for CONFIG_*=m
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

Hi Li,

On Wed, 7 Oct 2026, Li Wang wrote:
> tst_kconfig: load and unload kernel modules for CONFIG_*=m

--- [PATCH 1/3] ---

> diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> +	if (loaded_module_count < MAX_LOADED_MODULES)
> +		loaded_modules[loaded_module_count++] = mod;

High: This records config matches, not modules newly loaded by the test,
so cleanup can remove an unused module that was already loaded beforehand.
A read-only tst_kconfig_read() during a callback also adds unload targets
without loading them. Separate config discovery from ownership tracking
and unload only modules successfully added by this test.

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> +	tst_kconfig_module_unload_all();

High: Loading happens once in the library parent, but this cleanup runs
in each test child. Setup aborts and killed children leak modules, later
variants can lose modules removed by the first child, and cve-2026-46331
cannot unload after dropping initial-user-namespace privileges. Move
unloading to parent do_cleanup(), after all variants and resource teardown.

> diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> +		tst_modprobe(loaded_modules[i], NULL);
> +		const char *const argv[] = { "rmmod", loaded_modules[i - 1], NULL };

Medium: modprobe also inserts dependencies that this list never records;
with both initially absent, loading can-raw inserts can, but cleanup only
removes can-raw and leaves can loaded. Track newly inserted dependencies
relative to the initial module state and remove owned modules in
dependency order.

> diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
> +/*
> + * tst_kconfig_module_load() - Load kernel modules for CONFIG_*=m entries.

Low: Both new public API comments use /* rather than /** and are omitted
from the generated kernel-doc reference. Use kernel-doc comment openers
for both declarations.

--- [PATCH 2/3] ---

> Map CONFIG_VSOCKETS and CONFIG_VSOCKETS_LOOPBACK to their kernel
> modules (vsock, vsock_loopback).

Low: The body only restates the mappings and does not explain the new
config and privilege gates in cve-2025-21756. Explain the missing-loopback
bind failure and why the test now requires root.

> diff --git a/testcases/cve/cve-2025-21756.c b/testcases/cve/cve-2025-21756.c
> +	.needs_root = 1,

Low: Document this new root requirement in the test's high-level
description, identifying module loading as the privileged operation.

--- [PATCH 3/3] ---

> diff --git a/testcases/kernel/syscalls/keyctl/keyctl29.c b/testcases/kernel/syscalls/keyctl/keyctl29.c
> -	tst_modprobe("x509_key_parser", NULL);
> diff --git a/testcases/kernel/syscalls/keyctl/keyctl30.c b/testcases/kernel/syscalls/keyctl/keyctl30.c
> -	tst_modprobe("pkcs8_key_parser", NULL);

Medium: With KCONFIG_SKIP_CHECK=1, tst_kconfig_check() returns before
recording modules, leaving these removed loads without a replacement.
When parser modules are installed but unloaded, keyctl29/keyctl30 now
skip with EBADMSG instead of executing their checks. Preserve module
setup independently of config validation, or retain the explicit loads.

Verdict - Needs revision

Pre-existing issue (not introduced by this series):

Medium: sctphantom saves its SCTP sysctls in the test child's private
tst_sys_conf list, but only the library parent calls tst_sys_conf_restore()
and cannot see those saved values. Use parent-side .save_restore after
module loading, or explicitly restore them in the test child's cleanup.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
