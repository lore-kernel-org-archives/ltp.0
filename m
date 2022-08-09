Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5886EC19F2D
	for <ltp@archiver.kernel.org>; Tue,  9 Aug 2022 05:29:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DE343C94FD
	for <ltp@archiver.kernel.org>; Tue,  9 Aug 2022 07:29:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADA4F3C0646
 for <ltp@lists.linux.it>; Tue,  9 Aug 2022 07:29:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3D3F7200924
 for <ltp@lists.linux.it>; Tue,  9 Aug 2022 07:29:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8301633E97;
 Tue,  9 Aug 2022 05:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660022980;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6tNB+tdOfAhqw1pTEzJmQVp1ZbSYCPmTUCtiOt+QimU=;
 b=NmnBTkGC7mnlYUS7hIaEi5HpNlWHX/Fcy+xkIKnuissKOftxa0tlpKyIg4ZOuNtDLopEph
 +9xxtT199XuIUHpwwbzSWjjC5NaD47jKep53ScdjaFtK2jPd4kxubD0LTIp0Ri615nI4FN
 3odkrmCNeZgdSuCUPMADCFLm0g5iFj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660022980;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6tNB+tdOfAhqw1pTEzJmQVp1ZbSYCPmTUCtiOt+QimU=;
 b=9YkTLRr64v2rGZFZ+elVDoLfuO68BkzJE8ecoq4xoBkmnon68CLtIkcB/pAVs7qyNJlY7+
 Nuj8sF8oE7rYtkCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54D211333E;
 Tue,  9 Aug 2022 05:29:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 04w6E8Tw8WKnSAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 09 Aug 2022 05:29:40 +0000
Date: Tue, 9 Aug 2022 07:29:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Message-ID: <YvHwwsjr52lZXtVA@pevik>
References: <20220804073805.196537-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220804073805.196537-1-zhaogongyi@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cpuhotplug*.sh: Check return value of
 online_cpu/offline_cpu
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Zhao,

> We need to check the return value of online_cpu() and offline_cpu()
> although it is always success.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Looks reasonable.

Kind regards,
Petr

> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  .../hotplug/cpu_hotplug/functional/cpuhotplug02.sh   | 10 ++++++++--
>  .../hotplug/cpu_hotplug/functional/cpuhotplug05.sh   |  9 +++++++--
>  .../hotplug/cpu_hotplug/functional/cpuhotplug06.sh   |  5 ++++-
>  .../hotplug/cpu_hotplug/functional/cpuhotplug07.sh   | 12 ++++++------
>  4 files changed, 25 insertions(+), 11 deletions(-)

> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
> index f12aabc72..ba274db01 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
> @@ -90,7 +90,10 @@ until [ $LOOP_COUNT -gt $HOTPLUG02_LOOPS ]; do
>  	set_affinity ${SPIN_LOOP_PID} ${CPU_TO_TEST}

>  	# Verify the process migrated to the CPU we intended it to go to
> -	offline_cpu ${CPU_TO_TEST}
> +	if ! offline_cpu ${CPU_TO_TEST}; then
> +		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be offlined"
> +	fi
> +
>  	NEW_CPU=`ps --pid=${SPIN_LOOP_PID} -o psr --no-headers`
>  	if [ -z "${NEW_CPU}" ]; then
>  		tst_brkm TBROK "PID ${SPIN_LOOP_PID} no longer running"
> @@ -101,7 +104,10 @@ until [ $LOOP_COUNT -gt $HOTPLUG02_LOOPS ]; do
>  	fi

>  	# Turn the CPU back online just to see what happens.
> -	online_cpu ${CPU_TO_TEST}
> +	if ! online_cpu ${CPU_TO_TEST}; then
> +		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
> +	fi
> +
>  	LOOP_COUNT=$((LOOP_COUNT+1))
>  done

> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> index 2feb8d9ff..1eb204f4e 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> @@ -36,7 +36,9 @@ EOF
>  do_clean()
>  {
>  	pid_is_valid ${SAR_PID} && kill_pid ${SAR_PID}
> -	online_cpu "$CPU_TO_TEST"
> +	if ! online_cpu ${CPU_TO_TEST}; then
> +		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
> +	fi
>  }

>  get_field()
> @@ -149,7 +151,10 @@ until [ $LOOP_COUNT -gt $HOTPLUG05_LOOPS ]; do
>  		tst_exit
>  	fi

> -	offline_cpu ${CPU_TO_TEST}
> +	if ! offline_cpu ${CPU_TO_TEST}; then
> +		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be offlined"
> +	fi
> +
>  	kill_pid ${SAR_PID}

>  	LOOP_COUNT=$((LOOP_COUNT+1))
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
> index 319c66537..b9c1889d3 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
> @@ -99,7 +99,10 @@ until [ $LOOP_COUNT -gt $HOTPLUG06_LOOPS ]; do
>  		tst_exit
>  	fi

> -	online_cpu ${CPU_TO_TEST}
> +	if ! online_cpu ${CPU_TO_TEST}; then
> +		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
> +	fi
> +
>  	kill_pid ${TOP_PID}

>  	LOOP_COUNT=$((LOOP_COUNT+1))
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
> index 0d2dec7fe..af170f1cc 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
> @@ -100,9 +100,9 @@ until [ $LOOP_COUNT -gt $HOTPLUG07_LOOPS ]; do
>  	# Move spin_loop.sh to the CPU to offline.
>  	set_affinity ${KCOMPILE_LOOP_PID} ${CPU_TO_TEST}

> -	offline_cpu ${CPU_TO_TEST}
> -	RC=$?
> -	echo "Offlining cpu${CPU_TO_TEST}: Return Code = ${RC}"
> +	if ! offline_cpu ${CPU_TO_TEST}; then
> +		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be offlined"
> +	fi

>  	NEW_CPU=`ps --pid=${KCOMPILE_LOOP_PID} -o psr --no-headers`
>  	if [ -z "${NEW_CPU}" ]; then
> @@ -113,9 +113,9 @@ until [ $LOOP_COUNT -gt $HOTPLUG07_LOOPS ]; do
>  		tst_exit
>  	fi

> -	online_cpu ${CPU_TO_TEST}
> -	RC=$?
> -	echo "Onlining cpu${CPU_TO_TEST}: Return Code = ${RC}"
> +	if ! online_cpu ${CPU_TO_TEST}; then
> +		tst_brkm TBROK "CPU${CPU_TO_TEST} cannot be onlined"
> +	fi

>  	LOOP_COUNT=$((LOOP_COUNT+1))

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
