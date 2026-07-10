Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21C0C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 14:21:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 453AE3E5CEC
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 16:21:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FB053C8231
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 16:21:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 474421000D28
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 16:21:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2BC79767D6;
 Fri, 10 Jul 2026 14:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783693272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/gOz8ulTFwliESF5kcOs2fEbl2ppBE7V25d/Z4dMQk4=;
 b=XZg/X6D8NZu5ofTH3qNKV89A0wQyt1E2cZXveMC7tgOAUHQyg06kQ0HliIWN67bG4wd0Wk
 GTm+3lqjIlLmCzgqg7oDAVSoUF7JZSXZR3jqqBK9BcPGrBuDLrFlpsn97g6uYMEnVCnfFB
 PZp+lh4JdVZ3PtPmN0M5vIHjmKtaxuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783693272;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/gOz8ulTFwliESF5kcOs2fEbl2ppBE7V25d/Z4dMQk4=;
 b=0mJ9kJFjfFy4Knv9B1WzMORBOTNoFVWexdX+jIw8eTHXSzgkWg1wHbXPTRVPCZXeWZAawz
 t+Cln+iocXTM6rDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XkSISPJy;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OqcBRxvQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783693270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/gOz8ulTFwliESF5kcOs2fEbl2ppBE7V25d/Z4dMQk4=;
 b=XkSISPJyJLHZtm0NvqqIJw+YHN8Pq5IbuU3fcVHMGenEv7+JiSf/f8YqLvtBAkraEbfdYX
 e9lR0tamZcv17MGohexjfHtuesaJ7TzjgwggrX0OFHZqYppzozcdI8OGFMejVzfGyrTyP5
 FTsyPTrTCeZJbeilPHWXEyHwRyKZJJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783693270;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/gOz8ulTFwliESF5kcOs2fEbl2ppBE7V25d/Z4dMQk4=;
 b=OqcBRxvQAZWwlBgcSN51srZcXFp1qeAsEVVTUkpAdTRztu19TjPeKUul9DPxs6kNC9Yl1x
 fjKV41OfIN1CCJAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 149CE779BD;
 Fri, 10 Jul 2026 14:21:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aAMvBNb/UGrjPwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 10 Jul 2026 14:21:10 +0000
Date: Fri, 10 Jul 2026 16:20:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jinseok Kim <always.starving0@gmail.com>
Message-ID: <alD_qLh0SzW-2oJC@rei>
References: <20260707150920.6489-1-always.starving0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260707150920.6489-1-always.starving0@gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2BC79767D6
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[pm_include.sh:url, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, runpwtests04.sh:url, runpwtests03.sh:url,
 suse.cz:email, suse.cz:dkim, runpwtests06.sh:url, linux.it:url, test.sh:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] power_management: rewrite runpwtests04.sh in C
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

>  runtest/power_management_tests                |  2 +-
>  testcases/kernel/power_management/.gitignore  |  1 +
>  testcases/kernel/power_management/cpuidle01.c | 90 +++++++++++++++++++
>  .../kernel/power_management/runpwtests04.sh   | 58 ------------
>  4 files changed, 92 insertions(+), 59 deletions(-)
>  create mode 100644 testcases/kernel/power_management/cpuidle01.c
>  delete mode 100755 testcases/kernel/power_management/runpwtests04.sh
> 
> diff --git a/runtest/power_management_tests b/runtest/power_management_tests
> index 4da57ee72..0f2656b52 100644
> --- a/runtest/power_management_tests
> +++ b/runtest/power_management_tests
> @@ -1,5 +1,5 @@
>  #POWER_MANAGEMENT
>  high_freq_hwp_cap_cppc high_freq_hwp_cap_cppc
> +cpuidle01 cpuidle01
>  runpwtests03 runpwtests03.sh
> -runpwtests04 runpwtests04.sh
>  runpwtests06 runpwtests06.sh
> diff --git a/testcases/kernel/power_management/.gitignore b/testcases/kernel/power_management/.gitignore
> index 03f0c83e4..e237df1c8 100644
> --- a/testcases/kernel/power_management/.gitignore
> +++ b/testcases/kernel/power_management/.gitignore
> @@ -1 +1,2 @@
>  high_freq_hwp_cap_cppc
> +cpuidle01
> diff --git a/testcases/kernel/power_management/cpuidle01.c b/testcases/kernel/power_management/cpuidle01.c
> new file mode 100644
> index 000000000..919dd2b7c
> --- /dev/null
> +++ b/testcases/kernel/power_management/cpuidle01.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
> + */
> +
> +/*\
> + * Basic cpuidle sysfs smoke test.
> + *
> + * Verify that selected cpuidle sysfs files are readable.
> + */
> +
> +#include <fcntl.h>
> +#include <unistd.h>
> +
> +#include "tst_test.h"
> +
> +#define CPUIDLE_PATH "/sys/devices/system/cpu/cpuidle"
> +
> +static struct tcase {
> +	const char *name;
> +	bool is_writable;
> +} tcases[] = {
> +	{ "available_governors", false },
> +	{ "current_driver", false },
> +	{ "current_governor", true },
> +	{ "current_governor_ro", false },
> +};
> +
> +static int fd = -1;
> +
> +static void verify_cpuidle(unsigned int i)
> +{
> +	int ret;
> +	char path[PATH_MAX];
> +	char buf[32];
> +
> +	snprintf(path, sizeof(path), "%s/%s", CPUIDLE_PATH, tcases[i].name);
> +
> +	if (tcases[i].is_writable)
> +		fd = open(path, O_RDWR);
> +	else
> +		fd = open(path, O_RDONLY);
> +
> +	if (fd < 0) {
> +		if (errno == ENOENT)
> +			tst_res(TCONF, "%s not available", path);
> +		else
> +			tst_res(TFAIL | TERRNO, "open(%s) failed", path);
> +		return;
> +	}
> +
> +	ret = read(fd, buf, sizeof(buf));
> +
> +	if (ret < 0)
> +		tst_res(TFAIL | TERRNO, "%s read() failed", path);
> +	else if (ret == 0)
> +		tst_res(TFAIL, "%s read() returned 0", path);
> +	else
> +		tst_res(TPASS, "%s read() successfully", path);

When we actually bother writing tests maybe we should not do it with the
array style, but rather add a function per sysfs file that would
actually check that the data are correct.

E.g. we could write a function that would read and parse
available_governors and then check that current_governor is in the set
of the available_governors.

> +	if (tcases[i].is_writable) {
> +		if (write(fd, "invalid_governor", 16) < 0) {
> +			if (errno == EINVAL)
> +				tst_res(TPASS, "%s rejected invalid input with EINVAL", path);
> +			else
> +				tst_res(TFAIL | TERRNO, "%s rejected invalid input with unexpected errno", path);
> +		} else {
> +			tst_res(TFAIL, "%s accepted invalid input successfully", path);
> +		}

	This can be just TST_EXP_FAIL2();

> +	}
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd != -1)
> +		SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_cpuidle,
> +	.save_restore = (const struct tst_path_val[]) {
> +		{ CPUIDLE_PATH "/current_governor", NULL, TST_SR_TCONF },
> +		{}
> +	},
> +};
> diff --git a/testcases/kernel/power_management/runpwtests04.sh b/testcases/kernel/power_management/runpwtests04.sh
> deleted file mode 100755
> index 6565320d2..000000000
> --- a/testcases/kernel/power_management/runpwtests04.sh
> +++ /dev/null
> @@ -1,58 +0,0 @@
> -#! /bin/sh
> -#
> -# Copyright (c) International Business Machines  Corp., 2001
> -# Author: Nageswara R Sastry <nasastry@in.ibm.com>
> -#
> -# This program is free software;  you can redistribute it and#or modify
> -# it under the terms of the GNU General Public License as published by
> -# the Free Software Foundation; either version 2 of the License, or
> -# (at your option) any later version.
> -#
> -# This program is distributed in the hope that it will be useful, but
> -# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> -# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> -# for more details.
> -#
> -# You should have received a copy of the GNU General Public License
> -# along with this program;  if not, write to the Free Software Foundation,
> -# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> -#
> -
> -export TCID="Power_Management04"
> -export TST_TOTAL=1
> -
> -. test.sh
> -. pm_include.sh
> -
> -check_cpuidle_sysfs_files() {
> -	RC=0
> -	if [ -d /sys/devices/system/cpu/cpuidle ] ; then
> -		for files in current_governor_ro current_driver
> -		do
> -			cat /sys/devices/system/cpu/cpuidle/${files} \
> -				>/dev/null 2>&1
> -			if [ $? -ne 0 ] ; then
> -				echo "${0}: FAIL: cat ${files}"
> -				RC=1
> -			fi
> -		done
> -	fi
> -	if [ ${RC} -eq 0 ] ; then
> -		echo "${0}: PASS: Checking cpu idle sysfs files"
> -	else
> -		echo "${0}: FAIL: Checking cpu idle sysfs files"
> -	fi
> -	return $RC
> -}
> -
> -# Checking test environment
> -check_arch
> -
> -# Checking cpuidle sysfs interface files
> -if check_cpuidle_sysfs_files ; then
> -	tst_resm TPASS "CPUIDLE sysfs tests passed"
> -else
> -    tst_resm TFAIL "CPUIDLE sysfs tests failed"
> -fi
> -
> -tst_exit
> --
> 2.43.0
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
