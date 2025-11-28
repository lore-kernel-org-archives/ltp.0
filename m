Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632E6CFD376
	for <ltp@archiver.kernel.org>; Fri, 28 Nov 2025 11:02:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9BF23CE1F9
	for <ltp@archiver.kernel.org>; Fri, 28 Nov 2025 12:02:43 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83F783C8232
 for <ltp@lists.linux.it>; Fri, 28 Nov 2025 12:02:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 97F541000DAA
 for <ltp@lists.linux.it>; Fri, 28 Nov 2025 12:02:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B2F21336FD;
 Fri, 28 Nov 2025 11:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764327738;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WTqTBVqBNc9ww0sWUCKp08oxD6KFrgBMnyA7FeNw2sE=;
 b=HU7t5AofTktEbI7z82f0/dRAskfN/ZGKc1byeSILdPmLIpZe+djdoltgvyEk5+KkGaXbJc
 ENbJ0r71vjshAyQzVow0qPker5HLtqOdXduasTxhWYXEouHbJBwxaXYww/Y0Uz/ufbkv6P
 0toFScLiQZge+5uzx9ed5lwtUcGlE9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764327738;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WTqTBVqBNc9ww0sWUCKp08oxD6KFrgBMnyA7FeNw2sE=;
 b=xMQ//5xZUNIQS+uZwfH1zNK/oJETKxAjKm9ow9VjcwTTE15LBC4lf152huua7XApgyEJha
 SOvnhsrLELOPLBDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764327733;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WTqTBVqBNc9ww0sWUCKp08oxD6KFrgBMnyA7FeNw2sE=;
 b=kZvfMSzGRDjMn3b5RPZXiUDfqaQWiI35MOEvwupom69rdX+U9PNxe0zvX/oxN+lTries1y
 NuwnDvy5rc0hkvEvihNg1GWvxnXF9ZnYXKbL3wuedob9b0qObxNGoq9QP1hxoNBwzKlfxy
 zdo2o+CRtzbd9RpysyTIDZGVJzdiZrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764327733;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WTqTBVqBNc9ww0sWUCKp08oxD6KFrgBMnyA7FeNw2sE=;
 b=MZhFttbKyzr9L3PT7z0zJoxR2n3RdvhYM+lCPG4qvLQz+WNwQbkqySAPuwomMsRtEWIe8g
 a7LrgXU9OOA4PwDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 800393EA63;
 Fri, 28 Nov 2025 11:02:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mC1bHjWBKWnsGAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 28 Nov 2025 11:02:13 +0000
Date: Fri, 28 Nov 2025 12:02:12 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Piotr Kubaj <piotr.kubaj@intel.com>
Message-ID: <20251128110212.GA261918@pevik>
References: <20251124105123.151772-1-piotr.kubaj@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251124105123.151772-1-piotr.kubaj@intel.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RSPAMD_URIBL_FAIL(0.00)[thermal01.sh:query timed
 out,thermal_interrupt_events.sh:query timed out]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo,tst_run.sh:url,thermal_interrupt_events.sh:url,tst_loader.sh:url];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] thermal: add new test group
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

> This is a new test for checking thermal interrupt events.
> stress-ng is used because genload doesn't seem to generate enough load.

> In particular, this version replaces use of tr and cut where awk is
> already used.

> --- /dev/null
> +++ b/runtest/thermal
> @@ -0,0 +1,3 @@
> +# Thermal driver API
> +# https://docs.kernel.org/driver-api/thermal/
> +thermal_interrupt_events thermal01.sh

I would not mind if the test itself was named thermal_interrupt_events.sh (=
more
descriptive), but that's a minor detail (which can be ignored or changed be=
fore
merge).

...
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/thermal/thermal01.sh b/testcases/kernel/the=
rmal/thermal01.sh
> new file mode 100755
> index 000000000..95adaf04b
> --- /dev/null
> +++ b/testcases/kernel/thermal/thermal01.sh
> @@ -0,0 +1,100 @@
> +#!/bin/sh
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
> +tst_test()
> +{
> +	local thermal_zone_numbers=3D""
> +	local temp
> +	local temp_high=3D""

This could be just:
local thermal_zone_numbers temp temp_high

(empty shell variable is the same as =3D"").

> +	local status=3D0
> +
> +	local interrupt_array_init=3D$(awk -F'[^0-9]*' '/Thermal event interrup=
ts/ {$1=3D$1;print}' /proc/interrupts)
> +	if [ $? -eq 0 ]; then
> +		tst_res TDEBUG "Initial values of thermal interrupt counters: $interru=
pt_array_init"
> +		local num=3D$(tst_getconf _NPROCESSORS_ONLN)
> +		tst_res TDEBUG "Number of logical cores: $num"
> +	else
> +		tst_brk TCONF "Thermal event interrupts is not found"
> +	fi
> +
> +	# Below we check for the thermal_zone which uses x86_pkg_temp driver
> +	local thermal_zone_numbers=3D$(grep -l x86_pkg_temp /sys/class/thermal/=
thermal_zone*/type | xargs dirname)
> +	tst_res TINFO "x86_pkg_temp thermal zones: $thermal_zone_numbers"
> +
> +	if [ -z $thermal_zone_numbers ]; then
> +		tst_brk TCONF "No x86_pkg_temp thermal zones found"
> +	fi
> +	for i in $thermal_zone_numbers; do
> +		tst_res TINFO "Currently testing x86_pkg_temp $i"
> +		local TEMP=3D"$i/temp"
> +		local temp=3D$(cat "$TEMP")
> +		tst_res TDEBUG "$i's current temperature is $temp"
> +		case $temp in
> +		[0-9]*) ;;
> +		*)
> +			tst_brk TBROK "Unexpected zone temperature value $temp";;
> +		esac
> +		local trip=3D$(cat $i/trip_point_1_temp)
> +		# Setting trip_point_1_temp for $i to $temp + 10 (0.001=B0C)
> +		local temp_high=3D$(( temp + 10 ))
> +		echo "$temp_high" > $i/trip_point_1_temp
> +		local run_time=3D30
> +		local sleep_time=3D10
> +		while [ $sleep_time -gt 0 ]; do
> +			ROD stress-ng --matrix 0 --timeout $run_time --quiet
> +			local temp_cur=3D$(cat "$TEMP")
> +			tst_res TDEBUG "temp_cur: $temp_cur"
> +			[ $temp_cur -gt $temp_high ] && break
> +			tst_sleep $sleep_time
> +			run_time=3D$(( run_time - 3 ))
> +			sleep_time=3D$(( sleep_time - 1 ))
> +		done
> +		[ $temp_cur -gt $temp_high ] || tst_res TFAIL "Zone temperature is not=
 rising as expected"
> +
> +		# Restore the original trip_point_1_temp value
> +		echo "$trip" > $i/trip_point_1_temp

FYI this is in /sys, otherwise for creating temporary file we would need in=
 the
env.

#  "needs_tmpdir": true,

Thanks for your patch. I'm still not happy we introduce shell tests (sooner=
 or
later somebody will invest his or his company time to rewrite that into C),=
 but
I don't want to block this.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

NOTE: this needs to wait till my patch which adds ROD() is merged.

https://lore.kernel.org/ltp/20251120161957.331580-1-pvorel@suse.cz/

Kind regards,
Petr

> +
> +		# Check whether thermal interrupts count actually increased
> +		local interrupt_array_later=3D$(awk -F'[^0-9]*' '/Thermal event interr=
upts/ {$1=3D$1;print}' /proc/interrupts)
> +		tst_res TDEBUG "Current values of thermal interrupt counters: $interru=
pt_array_later"
> +		for j in $(seq 1 "$num"); do
> +			local interrupt_later=3D$(echo "$interrupt_array_later" | awk -v j=3D=
$j '{print $j}')
> +			local interrupt_init=3D$(echo "$interrupt_array_init" | awk -v j=3D$j=
 '{print $j}')
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
