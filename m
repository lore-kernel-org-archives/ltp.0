Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E29C55165
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 13:02:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A2A13E7255
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 15:02:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD77D3CD529
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 15:02:35 +0200 (CEST)
Received: from mail-pz2-x01.google.com (mail-pz2-x01.google.com
 [IPv6:2607:f8b0:4864:3b::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B6EB7600902
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 15:02:33 +0200 (CEST)
Received: by mail-pz2-x01.google.com with SMTP id
 41be03b00d2f7-cab1b0bb489so1669671a12.0
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 06:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785416552; x=1786021352; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9AMGvkDaytixfIRq3MxQqCBiSgXGjHHsw4ajJEBEM/M=;
 b=CPLgQ+4R6cKeCJlLFe+xvAb33ja4uWu68g3dmTwFHaU2QflhKH+fNO17wUrHOmrMCS
 8ay0KCj9owL6rPpwuj+gklmorQ1/+aDAOEumCwVucB667eirO1AbyMLRzdp80t9ajd0a
 H/8rWrIMdbxxf51mkXRm/Fy5N5Q6QUe/osQboVin4uaKS91SC4BDdxQkgXFeqm6TxKVH
 /4RMrAgDpFFAy+lhMPefN6ZU4kU2Nl1po7w1Lhwl8TwHMaFDXP6194bZ8Akfk5ZPQdyh
 FLQDjIWOpCN3su33gt/nbR2CAKR9GWZdyjWAMNTEnRUcUtYMBQ1Y+2AdLAigMvc5iElx
 PICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785416552; x=1786021352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9AMGvkDaytixfIRq3MxQqCBiSgXGjHHsw4ajJEBEM/M=;
 b=PU8Cbqzr4DvknQQbo/ucA8tRHfvPQrVMs2fylHTqBOSpMqWXx10+Mfj8Orkoyc2a4r
 nQTpf1bp4aLrzsSi3Xu6B3d7m1tptxqBv+5taGndmgBX1ttXuinFpymq+boXvgwjwFeL
 rWmRVNrAB2qx2HQiluB0Un0FJfVmtiBn3nia0H7X9SAsxpt/c/fGchwTanZPDihWNdCA
 jNv8X+1/D6IHxrYPb4FDb6xo4/ouMKDCLy7GGAVBOeSLpGfKwXbab56SD8MEUL9Cj+P8
 Yj3i8YXZmkfISLl/d5gT0LhqGE1TXGtgt8BK4QNufcwnFrCxkt6R59IQ70A9n7bHA2b1
 fX3Q==
X-Gm-Message-State: AOJu0Yxht2ttVCtgZH7XLdMr41Gu2QqB+HCQq8zfzICHcOAkI9jQyKMu
 Mg+9xN5EMy2A3hXEoxua0HxhdRW+Knoab3OoA8FkM1dwKX4MRClBEJDc
X-Gm-Gg: AR+sD1336GyY3gTmGZlptFPmhR5Y+ExZYFQGdcr9ipgZg8m1LC+aZvNofKDKJw9cyb1
 BndOMbzQPxsHJ2H87maKJf0QH6o/2ZI5T0yUxT6Gf2lOlWoa6iLVI7AvWMtgTGCRx5eR90kng+L
 83uD/dF+vlHm9aI/GNMMID4ZgO1E44vOaMCympySxjW9rsCh1xA0sUuUhZcE1X5qqpBLPW3kXay
 PkxjwcxHTQnfm956kPTOQshhQnIVC1Arr9+jYaNLaRoWoXMUQh9Im7LJW7U5xsehH4eytbyro3G
 Fyy1OM/RnjQiGDtD2xIWazFJ+bC83Lo10DNs+n21AM2YLo9IEpl+gbhQUN++o0XfO2TiPIidSoK
 OWjbXIqWg2yQIvYHYb2dzoD4w5GSvjLURL4FvUJhO+kkL4cMPSFWRGtFd8xWwsY0nkwMM2WI19p
 lMWpOp0UQ5gFjPWO/xNeJn2SP+9od/1ZEFEihUOrtEL0Kqp5Rlsvw0QfUqIW4xrIIz0FrxyS8gQ
 6sdKFUcWLuzrda3jTa/6bz5QsKgdu/B486KdlO3l/RP8GGZ5YMj4pMR3TxRDQPfGHiflbHtjiU7
X-Received: by 2002:a05:6a00:3491:b0:848:6c4e:59a0 with SMTP id
 d2e1a72fcca58-84ebc4248dfmr2670618b3a.40.1785416551188; 
 Thu, 30 Jul 2026 06:02:31 -0700 (PDT)
Received: from
 runnervmvrwv9.eb4wsyhxqy4u5dpcvlyltl2uzf.dx.internal.cloudapp.net
 ([68.220.59.217]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea03ccc92sm3102379b3a.58.2026.07.30.06.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 06:02:30 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jinseok Kim <always.starving0@gmail.com>
Date: Thu, 30 Jul 2026 13:02:28 +0000
Message-ID: <20260730130228.8904-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729112916.4958-1-always.starving0@gmail.com>
References: <20260729112916.4958-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] power_management: rewrite runpwtests04.sh in C
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

Hi Jinseok,

On Wed, Jul 29, 2026, Jinseok Kim wrote:
> power_management: rewrite runpwtests04.sh in C

> The new implementation preserves the original test semantics while
> removing shell dependencies.

The C version does more than the shell test: it also reads
available_governors and current_governor and adds an invalid-governor
write-rejection check, whereas runpwtests04.sh only read
current_governor_ro and current_driver. Could the commit message be
reworded to reflect the added coverage rather than "preserves the
original test semantics"?

> +++ b/testcases/kernel/power_management/.gitignore
> @@ -1 +1,2 @@
>  high_freq_hwp_cap_cppc
> +cpuidle01

Should the entries stay sorted? Appending cpuidle01 after
high_freq_hwp_cap_cppc leaves the file out of alphabetical order
(c before h). Leaf-directory entries are also normally anchored with a
leading '/' (e.g. /cpuidle01), though the existing entry is unanchored
too.

> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_root = 1,
> +	.save_restore = (const struct tst_path_val[]) {
> +		{ CPUIDLE_PATH "/current_governor", NULL, TST_SR_TCONF },
> +		{}
> +	},
> +};

TST_SR_TCONF expands to TST_SR_TCONF_MISSING | TST_SR_TCONF_RO, so
tst_sys_conf_save() ends the whole test with TCONF at setup when
current_governor is missing or read-only. On a system that exposes only
current_governor_ro, the readable checks for current_governor_ro and
current_driver (which the shell test still ran) would be skipped
entirely. Is gating the full test on current_governor intended, or would
TST_SR_SKIP / a per-file check keep the other checks running?

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
