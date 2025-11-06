Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B774CCFA05
	for <ltp@archiver.kernel.org>; Thu,  6 Nov 2025 12:45:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DBAD3CEB77
	for <ltp@archiver.kernel.org>; Thu,  6 Nov 2025 13:45:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B61D93C5705
 for <ltp@lists.linux.it>; Thu,  6 Nov 2025 13:45:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DB3A7200AD5
 for <ltp@lists.linux.it>; Thu,  6 Nov 2025 13:45:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 408DB1F78C;
 Thu,  6 Nov 2025 12:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762433136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1vEhq40+a3VNwGayUf7ULXG2EZwmixMfH3DV85B8JkM=;
 b=cxN1RIdgHV2A0oZ7Rfym5CAkBiZoo7/meylATk+zOJEHBcEsydOZol7+OH5Ul9Z6qiuzQf
 C3TLvNAN98bf8extrPcjCeykakwAj8qHcDQczLpChe7Z4FKsrxM2Bep6LZJuyvCzG5lWmL
 pKrYjqBHiBMG3c3K4hLT0D+YLijFktI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762433136;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1vEhq40+a3VNwGayUf7ULXG2EZwmixMfH3DV85B8JkM=;
 b=5bNovIX8F2fOx/0TIj8htK52gfkxhrIfhEb67FoMwiBGd/sz9ikkpGBkUVLMRrt99xOzJk
 /AtLrHFAFQEY7MCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762433135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1vEhq40+a3VNwGayUf7ULXG2EZwmixMfH3DV85B8JkM=;
 b=cLblr/8nDdxMp7m/7S+LBjp6C2X1ovIsASW/ZGkacNJjM4u01Oj1wZj8vGnK1QE5dSsT46
 DuTv65B9bUpXRdv7srSqv5Pgp+ohfKP9VR6/rcHPR7dMeUnpytzrUnWwmAkE75WiEu+g5S
 gs2nzGuUZGHEaz+LAtJEv+zQBl0bGiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762433135;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1vEhq40+a3VNwGayUf7ULXG2EZwmixMfH3DV85B8JkM=;
 b=YvImmQS3+Rs24SQ0ETNscaxsCa5u9QzpJ+QF7bsL1NXHFMLTuxJA9cGZacbVVmGcYUVgjV
 6i+BLefY/WiAaCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28FB313A31;
 Thu,  6 Nov 2025 12:45:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4msMCG+YDGlrXAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 06 Nov 2025 12:45:35 +0000
Date: Thu, 6 Nov 2025 13:46:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Piotr Kubaj <piotr.kubaj@intel.com>
Message-ID: <aQyYnbgewc4AptZJ@yuki.lan>
References: <20251106114337.550054-1-piotr.kubaj@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251106114337.550054-1-piotr.kubaj@intel.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] thermal: add new test group
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
First of all, the tst_test.sh test library is in maitenance mode and new
shell tests should use the tst_loader.sh instead. Have a look at the
testcases/kernel/mem/vma/vma05.sh test on how does it look like.

> diff --git a/testcases/kernel/thermal/thermal01.sh b/testcases/kernel/the=
rmal/thermal01.sh
> new file mode 100755
> index 000000000..723591d94
> --- /dev/null
> +++ b/testcases/kernel/thermal/thermal01.sh
> @@ -0,0 +1,92 @@
> +#!/usr/bin/env bash
> +########################################################################=
#######
> +# Copyright (C) 2025 Intel - http://www.intel.com/
> +#
> +# GNU General Public License for more details.
> +########################################################################=
#######
> +# Contributors:
> +#   Piotr Kubaj <piotr.kubaj@intel.com> (Intel)
> +#     -Initial draft.
> +# Check the CPU package thermal sensor interface for Intel platforms.
> +# It works by checking the initial count of thermal interrupts. Then it
> +# decreases the threshold for sending a thermal interrupt to just above
> +# the current temperature and runs a workload on the CPU. Finally, it re=
stores
> +# the original thermal threshold and checks whether the number of thermal
> +# interrupts increased.

This should be a doc comment instead, the doc comments are parsed and
exported into the LTP documentation:

# ---
# doc
# Tests the CPU package thermal sensor interface for Intel platforms.
#
# It works by checking the initial count of thermal interrupts. Then it
# decreases the threshold for sending a thermal interrupt to just above
# the current temperature and runs a workload on the CPU. Finally, it resto=
res
# the original thermal threshold and checks whether the number of thermal
# interrupts increased.
# ---

Also the tst_loader.sh supports for various metadata, since this test is
supported only on x86 platforms and I guess needs root we can specify
that in the environment as:

# ---
# env
# {
#  "needs_root": true,
#  "supported_archs": ["x86", "x86_64"]
# }
# ---

> +########################################################################=
#######
> +
> +export TST_TESTFUNC=3Dtest_interrupt_events
> +export TCID=3D"thermal_interrupt_events"
> +
> +pkg_thermal=3D""
> +thermal_zone_numbers=3D""
> +temp=3D""
> +temp_high=3D""
> +
> +test_interrupt_events() {
> +	line=3D$(grep "Thermal event interrupts" /proc/interrupts)
> +	if [ $? -eq 0 ]; then
> +		interrupt_array_init=3D$(echo "$line" | tr -d "a-zA-Z:" | awk '{$1=3D$=
1;print}')
> +		echo "Initial values of thermal interrupt counters: $interrupt_array_i=
nit"
> +		num=3D$(nproc)
> +		echo "Number of logical cores: $num"
> +	else
> +		tst_brk TBROK "Thermal event interrupts is not found."

This should be TCONF which means "test cannot run on this machine"
rather than TBROK which means "test is broken".

> +	fi
> +
> +	# Below we check for the thermal_zone which uses x86_pkg_temp driver
> +	thermal_zone_numbers=3D$(grep -l x86_pkg_temp /sys/class/thermal/therma=
l_zone*/type | sed 's/[^0-9]//g' | tr -t '\n' ' ')
> +	echo "x86_pkg_temp thermal zones: $thermal_zone_numbers"
> +
> +	if [ -z $thermal_zone_numbers ]; then
> +		tst_res TFAIL "No x86_pkg_temp thermal zones found"
> +	fi

This should possibly be TCONF as well. Also this should be tst_brk
instead, since we will otherwise print the TPASS at the end of the
script.

> +	for i in $thermal_zone_numbers; do
> +		echo "Currently testing x86_pkg_temp thermal_zone$i"
> +		TEMP=3D/sys/class/thermal/thermal_zone$i/temp
> +		temp=3D$(cat "$TEMP")
> +		echo "thermal_zone$i current temperature is $temp"
> +		if [ "$(echo "$temp <=3D 0" | bc)" -eq 1 ]; then
> +			tst_brk TBROK "Unexpected zone temperature value $temp"
> +		fi
> +		trip=3D$(cat /sys/class/thermal/thermal_zone$i/trip_point_1_temp)
> +		# Setting trip_point_1_temp for termal_zone$i to $temp + 10 (0.001=B0C)
> +		temp_high=3D$(( temp + 10 ))
> +		echo $temp_high > /sys/class/thermal/thermal_zone$i/trip_point_1_temp
> +		run_time=3D30
> +		sleep_time=3D10
> +		while [ $sleep_time -gt 0 ]; do
> +			which -s stress-ng
> +			[ $? -eq 0 ] ||  tst_brk TBROK "stress-ng is missing"
> +			stress-ng --matrix 0 -t $run_time

We try to avoid dependencies on tools that are not installed by default
if possible. Looking around we do have genload tool in LTP already:

			genload --cpu $(getconf _NPROCESSORS_ONLN) -t $run_time

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
> +				tst_res TFAIL "x86 package thermal interrupt did not trigger"
> +			else
> +				break
> +			fi
> +		done
> +	done
> +	tst_res TPASS "x86 package thermal interrupt triggered"
> +}
> +
> +. tst_test.sh
> +tst_run

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
