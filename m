Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016D6CEE343
	for <ltp@archiver.kernel.org>; Tue, 18 Nov 2025 18:17:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 784E23CF735
	for <ltp@archiver.kernel.org>; Tue, 18 Nov 2025 19:17:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C7E43CF597
 for <ltp@lists.linux.it>; Tue, 18 Nov 2025 19:17:31 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E44122009AB
 for <ltp@lists.linux.it>; Tue, 18 Nov 2025 19:17:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2A4BC2000B;
 Tue, 18 Nov 2025 18:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763489848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yFmwXsnZa5TX9VwbmeS0to14ndNeinsdPyWbpHwP9hc=;
 b=KqO40xnubMihSL38pNpi7mOpeqJUYy3fG71Qjr4dYi+CGoOnSv6dB4AGpnl9xtR4k8rAWU
 wRkXACL8eFEfPn3FVKFj7OdkT+Tv6cuRo7wMIqiTlGD06gCvK3MUvtJIAyu75sx+4FGBYj
 PxLc/SXrN3VSFlEhkgt3rf3xByqHazs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763489848;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yFmwXsnZa5TX9VwbmeS0to14ndNeinsdPyWbpHwP9hc=;
 b=tIDalpxYPco1Yo7/l5zwaQHCiugeW66kKZ9Hx2SnQ51Of/74tQV9/iVuRoqujNfZP0FcYR
 eaDJFotHU3K2cnCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763489848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yFmwXsnZa5TX9VwbmeS0to14ndNeinsdPyWbpHwP9hc=;
 b=KqO40xnubMihSL38pNpi7mOpeqJUYy3fG71Qjr4dYi+CGoOnSv6dB4AGpnl9xtR4k8rAWU
 wRkXACL8eFEfPn3FVKFj7OdkT+Tv6cuRo7wMIqiTlGD06gCvK3MUvtJIAyu75sx+4FGBYj
 PxLc/SXrN3VSFlEhkgt3rf3xByqHazs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763489848;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yFmwXsnZa5TX9VwbmeS0to14ndNeinsdPyWbpHwP9hc=;
 b=tIDalpxYPco1Yo7/l5zwaQHCiugeW66kKZ9Hx2SnQ51Of/74tQV9/iVuRoqujNfZP0FcYR
 eaDJFotHU3K2cnCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0ABAB3EA61;
 Tue, 18 Nov 2025 18:17:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id T4lJADi4HGk/XgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 18 Nov 2025 18:17:28 +0000
Date: Tue, 18 Nov 2025 19:18:14 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Piotr Kubaj <piotr.kubaj@intel.com>
Message-ID: <aRy4Zhle9JJANzuW@yuki.lan>
References: <20251114180157.1207278-1-piotr.kubaj@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251114180157.1207278-1-piotr.kubaj@intel.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 URIBL_BLOCKED(0.00)[thermal01.sh:url,imap1.dmz-prg2.suse.org:helo,intel.com:email,intel.com:url,linux.it:url,tst_run.sh:url,suse.cz:email,yuki.lan:mid,tst_loader.sh:url];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:url,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] thermal: add new test group
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>
> ---
>  runtest/thermal                       |   2 +
>  scenario_groups/default               |   1 +
>  testcases/kernel/Makefile             |   1 +
>  testcases/kernel/thermal/Makefile     |  11 +++
>  testcases/kernel/thermal/thermal01.sh | 101 ++++++++++++++++++++++++++
>  5 files changed, 116 insertions(+)
>  create mode 100644 runtest/thermal
>  create mode 100644 testcases/kernel/thermal/Makefile
>  create mode 100755 testcases/kernel/thermal/thermal01.sh
> =

> diff --git a/runtest/thermal b/runtest/thermal
> new file mode 100644
> index 000000000..804ef7d79
> --- /dev/null
> +++ b/runtest/thermal
> @@ -0,0 +1,2 @@
> +#THERMAL
> +thermal_interrupt_events thermal01.sh
> diff --git a/scenario_groups/default b/scenario_groups/default
> index 0e76b2bee..ffdd7ff25 100644
> --- a/scenario_groups/default
> +++ b/scenario_groups/default
> @@ -26,3 +26,4 @@ crypto
>  kernel_misc
>  uevent
>  watchqueue
> +thermal
> diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
> index 98fd45a9d..ac816e4e8 100644
> --- a/testcases/kernel/Makefile
> +++ b/testcases/kernel/Makefile
> @@ -36,6 +36,7 @@ SUBDIRS			+=3D connectors \
>  			   sched \
>  			   security \
>  			   sound \
> +			   thermal \
>  			   tracing \
>  			   uevents \
>  			   watchqueue \
> diff --git a/testcases/kernel/thermal/Makefile b/testcases/kernel/thermal=
/Makefile
> new file mode 100644
> index 000000000..789db430d
> --- /dev/null
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
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/thermal/thermal01.sh b/testcases/kernel/the=
rmal/thermal01.sh
> new file mode 100755
> index 000000000..138c30ee7
> --- /dev/null
> +++ b/testcases/kernel/thermal/thermal01.sh
> @@ -0,0 +1,101 @@
> +#!/usr/bin/env bash
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
> +#  "needs_cmds": ["stress-ng"]
> +# }
> +# ---
> +
> +export LTP_TIMEOUT_MUL=3D6

Instead of this the test needs to set up runtime in the environment
properly. I will send a patch for the tst_run_shell.c that adds support
for runtime to the JSON env tomorrow.

> +. tst_loader.sh
> +
> +thermal_zone_numbers=3D""
> +temp=3D""
> +temp_high=3D""
> +status=3D0
> +
> +tst_test()
> +{
> +	line=3D$(grep "Thermal event interrupts" /proc/interrupts)
> +	if [ $? -eq 0 ]; then
> +		interrupt_array_init=3D$(echo "$line" | tr -d "a-zA-Z:" | awk '{$1=3D$=
1;print}')
> +		echo "Initial values of thermal interrupt counters: $interrupt_array_i=
nit"

All these echo should be tst_res TINFO "..." or tst_res TDEBUG "..."
(not shown by default) messages instead, so that the test verbosity can
be properly controlled.

> +		num=3D$(nproc)
> +		echo "Number of logical cores: $num"
> +
> +	else
> +		tst_brk TCONF "Thermal event interrupts is not found."
> +	fi
> +
> +	# Below we check for the thermal_zone which uses x86_pkg_temp driver
> +	thermal_zone_numbers=3D$(grep -l x86_pkg_temp /sys/class/thermal/therma=
l_zone*/type | sed 's/[^0-9]//g' | tr -t '\n' ' ')
> +	echo "x86_pkg_temp thermal zones: $thermal_zone_numbers"
> +
> +	if [ -z $thermal_zone_numbers ]; then
> +		tst_brk TCONF "No x86_pkg_temp thermal zones found"
> +	fi
> +	for i in $thermal_zone_numbers; do
> +		echo "Currently testing x86_pkg_temp thermal_zone$i"
> +		TEMP=3D/sys/class/thermal/thermal_zone$i/temp
> +		temp=3D$(cat "$TEMP")
> +		echo "thermal_zone$i current temperature is $temp"
> +		if [ "$(echo "$temp <=3D 0" | bc)" -eq 1 ]; then

bc package is not installed by default on certain systems, so we either
need to request it explicitly or not use it.

What about:

		case "$TEMP" in
		[0-9]*) ;;
		*)
			tst_brk TBROK "Unexpected zone temperature value $temp";;
		esac

> +			tst_brk TBROK "Unexpected zone temperature value $temp"
> +		fi
> +		trip=3D$(cat /sys/class/thermal/thermal_zone$i/trip_point_1_temp)
> +		# Setting trip_point_1_temp for termal_zone$i to $temp + 10 (0.001=B0C)
> +		temp_high=3D$(( temp + 10 ))
> +		echo $temp_high > /sys/class/thermal/thermal_zone$i/trip_point_1_temp
> +		run_time=3D30
> +		sleep_time=3D10
> +		while [ $sleep_time -gt 0 ]; do
> +			stress-ng --matrix 0 --timeout $run_time
> +			temp_cur=3D$(cat "$TEMP")
> +			echo "temp_cur: $temp_cur"
> +			[ $temp_cur -gt $temp_high ] && break
> +			sleep $sleep_time
> +			run_time=3D$(( run_time - 3 ))
> +			sleep_time=3D$(( sleep_time - 1 ))
> +		done
> +		[ $temp_cur -gt $temp_high ] || tst_res TFAIL "Zone temperature is not=
 rising as expected"
> +
> +		# Restore the original trip_point_1_temp value
> +		echo $trip > /sys/class/thermal/thermal_zone$i/trip_point_1_temp
> +
> +		# Check whether thermal interrupts count actually increased
> +		interrupt_array_later=3D$(grep "Thermal event interrupts" /proc/interr=
upts | \
> +			tr -d "a-zA-Z:" | awk '{$1=3D$1;print}')
> +		echo "Current values of thermal interrupt counters: $interrupt_array_l=
ater"
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
> -- =

> 2.47.3
> =

> ---------------------------------------------------------------------
> Intel Technology Poland sp. z o.o.
> ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wy=
dzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-=
316 | Kapital zakladowy 200.000 PLN.
> Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu us=
tawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w tra=
nsakcjach handlowych.
> =

> Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresa=
ta i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej =
wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jaki=
ekolwiek przegladanie lub rozpowszechnianie jest zabronione.
> This e-mail and any attachments may contain confidential material for the=
 sole use of the intended recipient(s). If you are not the intended recipie=
nt, please contact the sender and delete all copies; any review or distribu=
tion by others is strictly prohibited.
> =

> -- =

> Mailing list info: https://lists.linux.it/listinfo/ltp

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
