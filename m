Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BDAF506C4
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 12:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773665737; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=/3fXwyOhyABolHocr+34+j0R0BOAPrHuW1xPRGmY3LY=;
 b=DZgccUVlz3t4ZoYAw4piFubfbZ0n1Rc4c/EbTezQFWaYsbuBockjui5CFY/Gy0TMRQVzU
 7yKxK/fmtAwSVg3IYUY/nDRAx5i0tkBXHLeBIT0h7/v2QeGn88x652BzgXo+g8F3W8ZKwJ5
 UM6p5ujn4SiVYADBC3sl/nBiyRFgjMc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5416F3E5664
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 13:55:37 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 624123E4B8B
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 13:55:15 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A132E6008E5
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 13:55:14 +0100 (CET)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4853aec185aso37540315e9.1
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 05:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773665714; x=1774270514; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nsAHmGLdGJv2/5eHnxmgKRaz1X3JEPDecDwHuElv5/U=;
 b=FH0AbBRK+giS362+ShbVd7IyD5UBkxYgFOxy/WdoCOeYpZn9HaEek4tXmFntKxRu3b
 AutChJNxHDlgKcPJLd0DO/bxyOTD25uca6uaPB/WFh457Scc2I5Rx4P2IWPvbwxQp2Oh
 SRDqYblzYhf4mxNGSQoMkmJVgm5vyVWCpBjJ9fm8ga2IbzTZd5DKIqV+YwsYSCgeQW7c
 oJxR/12SKmzML/zzb4lxmO2uMjhkh0/3pBWsKUtKRRyG4l3h29MOeiYDHQ1NsTGFTxSd
 jyJM9OmxHxY5HHDZciR2dk2hR+BR07m9SpJCI1F5oHTYScJZOCDGSDr1pZw5CpJ76YOu
 BxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773665714; x=1774270514;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nsAHmGLdGJv2/5eHnxmgKRaz1X3JEPDecDwHuElv5/U=;
 b=J3SVegGy4xcHYMzqbWWhCMzi0vvPkIYUTbSfwk/Mq6xCiPImQmr99TU9Gw/iyra4ky
 rSYHPUw8xkBYmuFx0kC++ZMJU9TrGGQJynr51+MPDCHpUIhzefntR/gBB1GY5CuV2LnV
 PdGqRVH+ehJtU2/ZZfesiNFEteoRFYrXuMIjVABDtm5xJGsdY/O2GqECTpBNbY/uRc4W
 yNCCuDVi8ZcJlcMcuGFboiYK0vyP81NrbngNdkqe6YnkaP8USLu1O3XFnybLjzCENEhS
 kX1wZGhtcW9TgcQW8BEP8bB2iGJWVtmYtZmXzfyrmm+yHbLz+40DtlTwwwU7BaHBc+NF
 fZlQ==
X-Gm-Message-State: AOJu0Yxss+vMWmj/bB74rch+4FTjBnfOZQj1LwVvCZolJSwlUTF4teW5
 VnOYHRJs1WxttbcVgpvkQekgpbSM6UZAc0Vg8zl2GD/qz8Ej+iUrpwG/i2uz1U1U1tc=
X-Gm-Gg: ATEYQzzZiT8qwv45+53NMWFPvCFOq5GQbDL8QUEFJ1R30JAhVca+4TB6FqK07rAwr9k
 a4REvyXlZVowThdDiHPTM/au//jwHpjIiosBA68gjEDKDjF+TFReTzzlKgMKAIzbh+1e4K9cs8w
 MtHK/LxCy3jA+9cycR0jL5Vy1+mbUn9c0DaQ2/dAnw1wNd0OVuS5FDTvRTGv6LAjG4cSelPlmMe
 3PtvYyiJZvuwlElrKDoi6mGhpvCxmNxPS8DASMhJbMPr6rk8tN//8ZKlJTxANVtYPPFn4/LDiFI
 s7hgMJDahey8dVLDlStj/mUDAj+U3MbpSa5uUaXUAvHJjg6wU2Mur4EdDmbZ5rcvZaz3Tiun5Av
 63Ol9tmTYBZ/OkVj5eaCuerjYbyURuctix6n/u0kwxZ5VY7AWoI6Tz5g6/2q8VSg2gEdFb/iVTv
 5fA80ZOwSgrc7q2hB8kEL+f+vbaJm3ybYEAqoEDsIZV9nYX7LleZ+wmIufd31cSFcH5TZi0yd8f
 9ZaQO8d1a6eNmDURAysX4dmrVapRqoL1o/R10BjCe9/HfOpnagZDT/ikK4Kop5vKU0g8iZtYv2l
 Gg==
X-Received: by 2002:a05:600c:c8f:b0:485:4bd1:4c64 with SMTP id
 5b1f17b1804b1-485567102dbmr204622935e9.31.1773665713845; 
 Mon, 16 Mar 2026 05:55:13 -0700 (PDT)
Received: from p200300ef2f4fc90053e282780f88a5bb.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b65fd3dsm403533295e9.10.2026.03.16.05.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 05:55:13 -0700 (PDT)
Message-ID: <69b7fdb1.050a0220.48979.cc0e@mx.google.com>
To: "Piotr Kubaj" <piotr.kubaj@intel.com>
In-Reply-To: <20260313125408.480770-2-piotr.kubaj@intel.com>
Date: Mon, 16 Mar 2026 12:55:12 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] high_freq_hwp_cap_cppc.c: new test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

> Verify for all online logical CPUs that their highest performance value are
> the same for HWP Capability MSR 0x771 and CPPC sysfs file.
> ---
>  testcases/kernel/power_management/.gitignore  |  1 +
>  .../power_management/high_freq_hwp_cap_cppc.c | 57 +++++++++++++++++++
>  2 files changed, 58 insertions(+)
>  create mode 100644 testcases/kernel/power_management/high_freq_hwp_cap_cppc.c
> 
> diff --git a/testcases/kernel/power_management/.gitignore b/testcases/kernel/power_management/.gitignore
> index 0c2a3ed4b..c13bca1c4 100644
> --- a/testcases/kernel/power_management/.gitignore
> +++ b/testcases/kernel/power_management/.gitignore
> @@ -1 +1,2 @@
> +high_freq_hwp_cap_cppc
>  pm_get_sched_values
> diff --git a/testcases/kernel/power_management/high_freq_hwp_cap_cppc.c b/testcases/kernel/power_management/high_freq_hwp_cap_cppc.c
> new file mode 100644
> index 000000000..4cbb81f0b
> --- /dev/null
> +++ b/testcases/kernel/power_management/high_freq_hwp_cap_cppc.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * Copyright (C) 2025-2026 Intel - http://www.intel.com/
> + */

Remove space
> +
> +/*\
> + * Verify for all online logical CPUs  that their highest performance value are

Double space before "that"

> + * the same for HWP Capability MSR 0x771 and CPPC sysfs file.
> + */
> +
> +#include "tst_test.h"
> +
> +static int nproc;
> +
> +static void setup(void)
> +{
> +	nproc = tst_ncpus();
> +}
> +
> +static void run(void)
> +{
> +	for (int i = 0; i < nproc; i++) {
> +		char path[PATH_MAX];
> +		unsigned long long msr_highest_perf = 0, sysfs_highest_perf = 0;
> +
> +		snprintf(path, PATH_MAX, "/sys/devices/system/cpu/cpu%d/acpi_cppc/highest_perf", i);

snprintf(path, sizeof(path), ..) is better.

> +		SAFE_FILE_SCANF(path, "%llu", &sysfs_highest_perf);
> +		tst_res(TDEBUG, "%s: %llu", path, sysfs_highest_perf);
> +
> +		snprintf(path, PATH_MAX, "/dev/cpu/%d/msr", i);
> +		int fd = SAFE_OPEN(path, O_RDONLY);
> +
> +		if (pread(fd, &msr_highest_perf, sizeof(msr_highest_perf), 0x771) < 0) {
> +			SAFE_CLOSE(fd);
> +			tst_brk(TBROK | TERRNO, "MSR read error");
> +		}

Simply use SAFE_PREAD(). fd will be closed when test ends.

> +		SAFE_CLOSE(fd);
> +		msr_highest_perf &= (1ULL << 8) - 1;
> +		tst_res(TDEBUG, "%s: %llu", path, msr_highest_perf);
> +
> +		if (msr_highest_perf != sysfs_highest_perf)
> +			tst_brk(TFAIL, "CPU %d: highest performance values differ between sysfs and MSR", i);

Why tst_brk() ? It's supposed to be tst_res(TFAIL, ..).

> +	}
> +
> +	tst_res(TPASS, "Test pass");
> +}
> +
> +static struct tst_test test = {
> +	.needs_kconfigs = (const char *const []) {
> +		"CONFIG_X86_MSR",

The CPPC sysfs interface also requires CONFIG_ACPI_CPPC_LIB to be built.

> +		NULL
> +	},
> +	.needs_root = 1,
> +	.setup = setup,
> +	.test_all = run
> +};
> -- 
> 2.47.3
> 
> ---------------------------------------------------------------------
> Intel Technology Poland sp. z o.o.
> ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
> Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.
> 
> Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
> This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

There's also no runtest entry for this test, so it can't be run in the testing
suites by kirk.

Kind regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
