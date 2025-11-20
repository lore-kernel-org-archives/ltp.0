Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E94CF887B
	for <ltp@archiver.kernel.org>; Thu, 20 Nov 2025 16:30:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1387E3D00F7
	for <ltp@archiver.kernel.org>; Thu, 20 Nov 2025 17:30:40 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C22293CE4C9
 for <ltp@lists.linux.it>; Thu, 20 Nov 2025 17:30:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DEB671000F43
 for <ltp@lists.linux.it>; Thu, 20 Nov 2025 17:30:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DF7F821273;
 Thu, 20 Nov 2025 16:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763656219;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zdzV/JYX+CBtUHfdsaTFgIhE4eqWa6a+XyUyjZkOBww=;
 b=li1CNPaey4KSgRGoYBY5IZAUr12UuveyXe29MGdE7/g7RGrcxP5C4e8hb5JCoImqdAmPvx
 LYIyW294XaK8NHJVihIt46PoWgEZjdcFKdO2kbnHXRnfDt1ytAwRIVw4woAcbkK2qUFd3o
 exWQ5KzTV2QAmXs/C+g/owQmYbfqLNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763656219;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zdzV/JYX+CBtUHfdsaTFgIhE4eqWa6a+XyUyjZkOBww=;
 b=U8fcAJYqJ75JEK/P71V5rwdoc5cvUhKhPbQP7ErQM/JKyX+c/j+MS9Sg6oof7I6ZMJtomn
 3krUNavnrYG1WZBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tExakk7R;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Tu74/FEP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763656217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zdzV/JYX+CBtUHfdsaTFgIhE4eqWa6a+XyUyjZkOBww=;
 b=tExakk7RYhec0Oiiwi4BzW435BWy6QVKM4h3FBiGjIYm0UU/SWHuq8jdNdgNcCTW8GvU4f
 piI9RxLmrpSnYt09ekn5sTi55uQtzQu/xxx+/b9KyQnNkk2AtZBLrPp1xA6cu/kq4JjCmD
 WfZL9B3fB5vwjvbKcA2hlrzXAo0ywrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763656217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zdzV/JYX+CBtUHfdsaTFgIhE4eqWa6a+XyUyjZkOBww=;
 b=Tu74/FEPJKBDj27fP2w7D1krx3SFHCS/b+8Brnj1Q5uub0j+y7JyjdqkV1ZcgEaXadVM6o
 CYYpV+6N9cMJWlAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB1303EA61;
 Thu, 20 Nov 2025 16:30:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6hViKBlCH2nKPwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 20 Nov 2025 16:30:17 +0000
Date: Thu, 20 Nov 2025 17:30:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Piotr Kubaj <piotr.kubaj@intel.com>
Message-ID: <20251120163016.GA322493@pevik>
References: <20251119114604.285485-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251119114604.285485-2-piotr.kubaj@intel.com>
X-Rspamd-Queue-Id: DF7F821273
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,intel.com:email,intel.com:url];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] thermal: add new test group
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: helena.anna.dubel@intel.com, tomasz.ossowski@intel.com,
 rafael.j.wysocki@intel.com, ltp@lists.linux.it, daniel.niestepski@intel.com
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

> This is a new test for checking thermal interrupt events.
> stress-ng is used because genload doesn't seem to generate enough load.

Thanks for info.  Maybe we should try to fix it later, because we really pr=
efer
to use internal tools instead of external dependencies.

> This version adds min_runtime, switches echo to tst_res TINFO and TDEBUG =
and
> removes usage of bc. It also adds --quiet to stress-ng's arguments.

...
> diff --git a/runtest/thermal b/runtest/thermal
> new file mode 100644
> index 000000000..804ef7d79
> --- /dev/null
> +++ b/runtest/thermal
> @@ -0,0 +1,2 @@
> +#THERMAL
nit: '#THERMAL' does not bring much information value (the same name as the
file). Maybe:
# Thermal driver API
# https://docs.kernel.org/driver-api/thermal/

...
> +++ b/testcases/kernel/thermal/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2025, Intel Corporation. All rights reserved.
> +# Author:Piotr Kubaj <piotr.kubaj@intel.com>
> +
> +top_srcdir             ?=3D ../../..
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +
> +INSTALL_TARGETS                :=3D thermal01.sh
nit: *.sh will help not update makefile in case more tests is added.

> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/thermal/thermal01.sh b/testcases/kernel/the=
rmal/thermal01.sh
> new file mode 100755
> index 000000000..91e4c02c5
> --- /dev/null
> +++ b/testcases/kernel/thermal/thermal01.sh
> @@ -0,0 +1,102 @@
> +#!/usr/bin/env bash

Please, don't use env, don't expect bash.
#!/bin/sh

Please, test at least on the system where dash is /bin/sh

https://linux-test-project.readthedocs.io/en/latest/developers/writing_test=
s.html#shell-coding-style
(Doc does not mention busybox sh, but ideally it should be tested also on b=
usybox sh.)

> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2025 Intel - http://www.intel.com/
> +#
> +# ---
> +# doc
> +# Tests the CPU package thermal sensor interface for Intel platforms.
> +#
> +# It works by checking the initial count of thermal interrupts. Then it
> +# decreases the threshold for sending a thermal interrupt to just above
> +# the current temperature and runs a workload on the CPU. Finally, it re=
stores
> +# the original thermal threshold and checks whether the number of thermal
> +# interrupts increased.
> +# ---
> +#
> +# ---
> +# env
> +# {
> +#  "needs_root": true,
> +#  "supported_archs": ["x86", "x86_64"],
> +#  "needs_cmds": ["stress-ng"],
> +#  "min_runtime": 180
> +# }
> +# ---
> +
> +. tst_loader.sh
> +
> +thermal_zone_numbers=3D""
> +temp=3D""
> +temp_high=3D""
> +status=3D0

These variables do not need to be global, because you use them only in a si=
ngle
function.  Could you please move them to tst_test()? And please use local?

tst_test()
{
	local thermal_zone_numbers temp temp_high
	local status=3D0

> +tst_test()
> +{
> +	line=3D$(grep "Thermal event interrupts" /proc/interrupts)
Actually any variable should use local.

> +	if [ $? -eq 0 ]; then
> +		interrupt_array_init=3D$(echo "$line" | tr -d "a-zA-Z:" | awk '{$1=3D$=
1;print}')
> +		tst_res TDEBUG "Initial values of thermal interrupt counters: $interru=
pt_array_init"
> +		num=3D$(nproc)

Could you please use: tst_getconf _NPROCESSORS_ONLN
Again, we try to avoid external dependencies (tst_getconf is LTP minimal ge=
tconf implementation).

> +		tst_res TDEBUG "Number of logical cores: $num"
> +	else
> +		tst_brk TCONF "Thermal event interrupts is not found."
nit: unneeded dot at the end.
> +	fi
> +
> +	# Below we check for the thermal_zone which uses x86_pkg_temp driver
> +	thermal_zone_numbers=3D$(grep -l x86_pkg_temp /sys/class/thermal/therma=
l_zone*/type | sed 's/[^0-9]//g' | tr -t '\n' ' ')

This will not work on busybox tr implementation:

tr: unrecognized option: t
BusyBox v1.36.1 (2023-11-07 18:53:09 UTC) multi-call binary.

Usage: tr [-cds] STRING1 [STRING2]

Yes, the time and pain trying to write portable shell is why I asked first =
to
rewrite into C which is more portable and reliable. (The other is to allow =
test
working without coreutils/busybox tools as external dependencies.) And using
more shell pipes increases the risk the code will fail.

First, "tr -t '\n' ' '" part is not needed at all, it will work without it:
thermal_zone_numbers=3D$(grep -l x86_pkg_temp /sys/class/thermal/thermal_zo=
ne*/type | sed 's/[^0-9]//g')

Do we need really to know the number? Can't we just store whole file and la=
ter
use dirname to get directory?

setup()
{
	...
	THERMAL_ZONE_NUMBERS=3D"$(grep -l x86_pkg_temp /sys/class/thermal/thermal_=
zone*/type)"
}

tst_test()
{
	local i file tmp

	for i in $THERMAL_ZONE_NUMBERS; do
		file=3D"$(dirname $i)/temp"
		temp=3D$(cat "$file")
	...
}

I checked on 2 x86_64 machines, with 8 and 2 thermal_zone files. Both had o=
nly
one x86_pkg_temp type, always the highest number. I wonder if we need loop =
at
all.

FYI C API has .save_restore and tst_run_shell.c supports it (see
testcases/kernel/mem/vma/vma05_vdso.c). Unfortunately we cannot use it, bec=
ause
we are searching for one particular file from possible several.

NOTE: We usually try to do any preparation in test setup function (declared=
 in
TST_SETUP=3D...  see testcases/lib/tests/shell_loader_setup_cleanup.sh) and=
 do
cleanup in a a test cleanup function (TST_CLEANUP=3D...). Why? At least cle=
anup is
useful to have separated in case test quit during failure (e.g. tst_brk qui=
ts
testing earlier).

TST_SETUP=3D"setup"
TST_CLEANUP=3D"cleanup"

setup()
{
	local line

	line=3D$(grep "Thermal event interrupts" /proc/interrupts)

	if [ $? -ne 0 ]; then
		tst_brk TCONF "Thermal event interrupts is not found."
	fi

	tst_res TDEBUG "Number of logical cores: $(tst_getconf _NPROCESSORS_ONLN)"
	THERMAL_ZONE_NUMBERS=3D"$(grep -l x86_pkg_temp /sys/class/thermal/thermal_=
zone*/type)"
}

cleanup()
{
	local i

	for i in $THERMAL_ZONE_NUMBERS; do
		file=3D"$(dirname $i)/trip_point_1_temp"
		temp=3D$(cat "$file")
		echo "..." > $file
		=3D> but here we would need to reuse values previously stored in setup().
		Maybe not worth to complicate with setup+cleanup unless we test only
		single sysfs file.
	...
}

> +	tst_res TINFO "x86_pkg_temp thermal zones: $thermal_zone_numbers"
> +
> +	if [ -z $thermal_zone_numbers ]; then
> +		tst_brk TCONF "No x86_pkg_temp thermal zones found"
> +	fi
> +	for i in $thermal_zone_numbers; do
> +		tst_res TINFO "Currently testing x86_pkg_temp thermal_zone$i"
> +		TEMP=3D/sys/class/thermal/thermal_zone$i/temp
> +		temp=3D$(cat "$TEMP")
> +		tst_res TDEBUG "thermal_zone$i current temperature is $temp"
> +		case $temp in

> +		[0-9]*) ;;
> +		*)
> +			tst_brk TBROK "Unexpected zone temperature value $temp";;
> +		esac
> +		trip=3D$(cat /sys/class/thermal/thermal_zone$i/trip_point_1_temp)
> +		# Setting trip_point_1_temp for termal_zone$i to $temp + 10 (0.001=B0C)
> +		temp_high=3D$(( temp + 10 ))
> +		echo $temp_high > /sys/class/thermal/thermal_zone$i/trip_point_1_temp
> +		run_time=3D30
> +		sleep_time=3D10
> +		while [ $sleep_time -gt 0 ]; do
> +			stress-ng --matrix 0 --timeout $run_time --quiet

You happily ignore stress-ng exit code. IMHO it should be checked.

I sent a patch which adds ROD() and other functions
https://lore.kernel.org/ltp/20251120161957.331580-1-pvorel@suse.cz/

ROD stress-ng --matrix 0 --timeout $run_time --quiet

> +			temp_cur=3D$(cat "$TEMP")
> +			tst_res TDEBUG "temp_cur: $temp_cur"
> +			[ $temp_cur -gt $temp_high ] && break
> +			sleep $sleep_time
We have tst_sleep binary, please use it.

> +			run_time=3D$(( run_time - 3 ))
> +			sleep_time=3D$(( sleep_time - 1 ))
> +		done
> +		[ $temp_cur -gt $temp_high ] || tst_res TFAIL "Zone temperature is not=
 rising as expected"
> +
> +		# Restore the original trip_point_1_temp value
> +		echo $trip > /sys/class/thermal/thermal_zone$i/trip_point_1_temp
nit: quoting echo is always safe

echo "$trip" > ...

In my case echo fails.

thermal01.sh:53: TINFO: Currently testing x86_pkg_temp thermal_zone8
/opt/ltp/testcases/bin/thermal01.sh: line 80: echo: write error: Invalid ar=
gument

> +
> +		# Check whether thermal interrupts count actually increased
> +		interrupt_array_later=3D$(grep "Thermal event interrupts" /proc/interr=
upts | \
> +			tr -d "a-zA-Z:" | awk '{$1=3D$1;print}')
Maybe, when we need to use awk, avoid tr? advantage: remove one pipe,
disadvantage: awk code less readable.

		interrupt_array_later=3D$(grep "Thermal event interrupts" /proc/interrupt=
s | \
			awk '{ gsub(/[A-Za-z:]/, ""); $1 =3D $1 }1'

The rest LGTM.

Kind regards,
Petr

> +		tst_res TDEBUG "Current values of thermal interrupt counters: $interru=
pt_array_later"
> +		for j in $(seq 1 "$num"); do
> +			interrupt_later=3D$(echo "$interrupt_array_later" | cut -d " " -f  "$=
j")
> +			interrupt_init=3D$(echo "$interrupt_array_init" | cut -d " " -f  "$j")
> +			if [ $interrupt_later -le $interrupt_init ]; then
> +				status=3D1
> +			fi
> +		done
> +	done
> +
> +	if [ $status -eq 0 ]; then
> +		tst_res TPASS "x86 package thermal interrupt triggered"
> +	else
> +		tst_res TFAIL "x86 package thermal interrupt did not trigger"
> +	fi
> +}
> +
> +. tst_run.sh

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
