Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7A4CD98E1
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 14:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781621156; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=em6GZ6DH1OgOI4hitsnxQSav7LNZIz3v/Y5yZwn5I4A=;
 b=Md5juxcxGTF4r8ltz8xyoPv6AAXAMdkLAK5w3VeqwJe/8C6IKHoIHjk+eUac3cJKfMdNi
 Bz4NY0q18pa9aL4PFbaSnuJ/B4gFOh3lpLgYIjqFgtUb36nqepdGskWiE4/d8uBo52zjmGV
 Ehf1THa4Nc4VhaRoFG1UwwjpBzim+Qw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7A1E3E5B5A
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 16:45:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 052303E5973
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 16:45:34 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3A0E31000D59
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 16:45:34 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490bc6a7958so44717695e9.1
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 07:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781621133; x=1782225933; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=mUQYyqcSuew9DZiFIlYLl6WJTDaQeANo9W7JNxIzpkM=;
 b=Gdo45fR/GzPn+g22771IZSFrlthxsd2eH0+vH99YOwL1+JYFIaw8/rkid0S900UWCU
 GfeCT57R2PvD9Wtu02BOHKjKH+05k7IL9CbO5azJ09d6xyQFlr2t71QqOKAROtvFXlt8
 i/KRBs6gyro1EVH4Xw5fhQZkIKe+JkAMCZ+B9Bl66rubZYMl18Te5flHafqm1CS9B7VG
 TSGvsb6mHnj9n5WYROqXwhLCkcwpTyHNpxcnvu7ExccvkBVn/0FnoKqRjOXT0siLnnse
 qJEhHv2mqT1Uw5CqX+AqDEAEqbfb2Dn7CR7YiSZ/ybuKQfguR7fQHLWzOnlzy3eKKWPt
 BVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781621133; x=1782225933;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mUQYyqcSuew9DZiFIlYLl6WJTDaQeANo9W7JNxIzpkM=;
 b=b3awLKFabjdUGKp3imgFAhdRKvsrgx4/alUESfd50SeYWxZ19lTDuKZ3zwKRYD9+bG
 Y8YGuWAyPEpFG7+YPop3byrPYbnSnWhRhLHOaDPAjpA+kc8xnOXQLuSIVgczGo8VSxKL
 +qWgOAhQzzfbSo/oNSjidIZLtgqWG7rhGkqu6ZvjAPDt1OoVGJwjcglGGJhOmZtd2JYW
 2LL3RMPzJI84xl1XUKLeba2eHGc62J7JLWVRt215LXYzrzX/Yh8Ibn19ldmb7ZSopif9
 S1f64cNEKzKTyiipolJyjdG2W5/1YaQZrYVPscXZe2npQqQOO9Nw1hsuSaD+fr0JRGhf
 D96A==
X-Gm-Message-State: AOJu0YwBsV5EL9JtBPYjDC3L3FSGf8ajSR5b5H6gjTXw7XatH82+na1W
 WjBHmVTIgj7motwRHthIVT9IIS3lcdPgIfcoSblqjGOpk0MOJ/cT+lUC2AxF4d0hIXY=
X-Gm-Gg: Acq92OGvaOahPFJQPTIk4QRYre+klBiM4pPPff3Q377MZ+LrLZGMN25CNe/sxuZGOn2
 fpDMwHTQjwGZawXz+u+IxCxRSkZ1m513Oa5Yv+2cNtYpZucXi+d/9MfcVGhRihMf9CdF4UIKZUv
 DNpwI0tPn6y9CkrYbD5Xk47l6m7KMnW9ay2ULz5CFxSlGsmikYQwGVWfHG8GJd0c6tlmdnqLfwD
 ku7zoMdk6JNAy16dc4AYLnaAZntAON4kykrdgyPP4tAqo+K28YdVmL3N7D0bvPTKw1S0lbkOOPY
 bcIglOTjmzDSzMTcwNjz5RyESTVsVgvYuSlWfaLHWixIWauKFD8fnmuE0ELiejL93OUet2LED0x
 UElD71tugaOFdccU2ekJABb+APCNWUEXKRU+IBHjoEhGdOgCcVwD1oC7OQsDoMNBJf5lALmaMrh
 /QzEhq5GZ7YSnNZuKfnbtqtLfV9lMSI/iwAopCUYDf1KgN6Ce426ZdYfcHdv/SXJyVc+PI1u2n
X-Received: by 2002:a05:600c:810b:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-4922fac1214mr60890345e9.6.1781621133311; 
 Tue, 16 Jun 2026 07:45:33 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a58becsm63954055e9.7.2026.06.16.07.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 07:45:32 -0700 (PDT)
Message-ID: <6a31618c.7f42fb59.24bb2.63c5@mx.google.com>
To: "Piotr Kubaj" <piotr.kubaj@intel.com>
In-Reply-To: <20260616114204.5636-2-piotr.kubaj@intel.com>
Date: Tue, 16 Jun 2026 14:45:32 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] rfim: add new test for verifying RFIM sysfs
 interface
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

Hi Piotr,

> diff --git a/runtest/power_management_tests b/runtest/power_management_tests
> index 4da57ee72..8ebbcff84 100644
> --- a/runtest/power_management_tests
> +++ b/runtest/power_management_tests
> @@ -1,5 +1,6 @@
>  #POWER_MANAGEMENT
>  high_freq_hwp_cap_cppc high_freq_hwp_cap_cppc
> +rfim rfim

Use rfim01 instead. We might want to add more tests in the future.

>  runpwtests03 runpwtests03.sh
>  runpwtests04 runpwtests04.sh
>  runpwtests06 runpwtests06.sh
> diff --git a/testcases/kernel/power_management/.gitignore b/testcases/kernel/power_management/.gitignore
> index 03f0c83e4..ecc2931fa 100644
> --- a/testcases/kernel/power_management/.gitignore
> +++ b/testcases/kernel/power_management/.gitignore
> @@ -1 +1,2 @@
>  high_freq_hwp_cap_cppc
> +rfim
> diff --git a/testcases/kernel/power_management/rfim.c b/testcases/kernel/power_management/rfim.c
> new file mode 100644
> index 000000000..06bc144a2
> --- /dev/null
> +++ b/testcases/kernel/power_management/rfim.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 Piotr Kubaj <piotr.kubaj@intel.com>
> + */
> +
> +/*\
> + * Validate presence and permissions of RFIM attributes.
> + * The test checks first validity of general RFIM attributes,
> + * and then checks either DLVR or FIVR, depending on hardware.
> + */
> +
> +#include "tst_test.h"
> +
> +#define RFIM_ROOT "/sys/bus/pci/devices/0000:00:04.0"
> +
> +enum rfim_variant {
> +	RFIM_FIVR,
> +	RFIM_DLVR,
> +};
> +
> +static enum rfim_variant variant;
> +
> +static void setup(void)
> +{
> +	struct stat stats;
> +
> +	if (!stat(RFIM_ROOT"/dlvr", &stats)) {
> +		if (S_ISDIR(stats.st_mode))
> +			variant = RFIM_DLVR;
> +		else
> +			tst_brk(TBROK, "%s exists but is not a directory", RFIM_ROOT"/dlvr");
> +	} else if (!stat(RFIM_ROOT"/fivr", &stats)) {
> +		if (S_ISDIR(stats.st_mode))
> +			variant = RFIM_FIVR;
> +		else
> +			tst_brk(TBROK, "%s exists but is not a directory", RFIM_ROOT"/fivr");
> +	} else
> +		tst_brk(TCONF, "Neither %s nor %s exists", RFIM_ROOT"/dlvr", RFIM_ROOT"/fivr");

Avoid too many nesting. Use if() -> TBROK or TCONF, instead of having else
everywhere. First, handle the error, then proceed with the test.

> +}
> +
> +static void check_read_only(const char *path)
> +{
> +	tst_res(TDEBUG, "Checking whether %s is read-only", path);
> +
> +	if (access(path, F_OK)) {
> +		tst_res(TFAIL | TERRNO, "%s does not exist", path);
> +		return;
> +	}
> +
> +	int fd = open(path, O_RDONLY);
> +
> +	if (fd == -1) {
> +		tst_res(TFAIL | TERRNO, "%s can't be read", path);
> +		return;
> +	}
> +	close(fd);
> +
> +	fd = open(path, O_WRONLY);
> +	if (fd != -1) {
> +		close(fd);
> +		tst_res(TFAIL, "%s is writable", path);
> +		return;
> +	}
> +
> +	tst_res(TPASS, "%s is read-only", path);
> +}

This function can be easily replaced by access().

TST_EXP_PASS(access(path, R_OK));
TST_EXP_FAIL(access(path, W_OK), ..);

> +
> +static void check_read_write(const char *path)
> +{
> +	tst_res(TDEBUG, "Checking whether %s is read-write", path);
> +
> +	if (access(path, F_OK)) {
> +		tst_res(TFAIL | TERRNO, "%s does not exist", path);

TERRNO already show the message. Either you use TERRNO or you specify
a message error by hand, not both. This is valid in general for all
other messages as well.

> +		return;
> +	}
> +
> +	int fd = open(path, O_RDWR);
> +
> +	if (fd != -1) {
> +		close(fd);
> +		tst_res(TPASS, "%s is read-write", path);
> +	} else
> +		tst_res(TFAIL | TERRNO, "%s is not read-write", path);
> +}

This one as well can be replaced with access().

> +
> +static void run(void)
> +{
> +	const char * const fivr_nodes[] = {
> +		RFIM_ROOT"/fivr/vco_ref_code_lo",
> +		RFIM_ROOT"/fivr/vco_ref_code_hi",
> +		RFIM_ROOT"/fivr/spread_spectrum_pct",
> +		RFIM_ROOT"/fivr/spread_spectrum_clk_enable",
> +		RFIM_ROOT"/fivr/rfi_vco_ref_code",
> +		RFIM_ROOT"/fivr/fivr_fffc_rev",
> +		NULL
> +	};
> +
> +	const char * const ro_general_nodes[] = {
> +		RFIM_ROOT"/dvfs/ddr_data_rate_point_0",
> +		RFIM_ROOT"/dvfs/ddr_data_rate_point_1",
> +		RFIM_ROOT"/dvfs/ddr_data_rate_point_2",
> +		RFIM_ROOT"/dvfs/ddr_data_rate_point_3",
> +		NULL
> +	};
> +
> +	const char * const ro_dlvr_nodes[] = {
> +		RFIM_ROOT"/dlvr/dlvr_hardware_rev",
> +		RFIM_ROOT"/dlvr/dlvr_freq_mhz",
> +		RFIM_ROOT"/dlvr/dlvr_pll_busy",
> +		NULL
> +	};
> +
> +	const char * const rw_dlvr_nodes[] = {
> +		RFIM_ROOT"/dlvr/dlvr_freq_select",
> +		RFIM_ROOT"/dlvr/dlvr_rfim_enable",
> +		RFIM_ROOT"/dlvr/dlvr_spread_spectrum_pct",
> +		RFIM_ROOT"/dlvr/dlvr_control_mode",
> +		RFIM_ROOT"/dlvr/dlvr_control_lock",
> +		NULL
> +	};
> +
> +	const char * const rw_general_nodes[] = {
> +		RFIM_ROOT"/dvfs/rfi_restriction_run_busy",
> +		RFIM_ROOT"/dvfs/rfi_restriction_err_code",
> +		RFIM_ROOT"/dvfs/rfi_restriction_data_rate_base",
> +		RFIM_ROOT"/dvfs/rfi_restriction_data_rate",
> +		NULL
> +	};

Please define them out as static arrays.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
