Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66F0C433F5
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 11:19:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AB623C73DA
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 12:19:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32A1A3C078E
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 12:19:27 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B99C1600662
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 12:19:26 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 09DFC21106;
 Thu,  6 Jan 2022 11:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641467966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L0jaV3Q43YtgPFoYzzpbmK3RLjAw3aTqG8rX4exDcq0=;
 b=wnOmvD69CTeufH6gb8OwjTLlSfrERWI7PijX5Ld4n/y/DUcC5MhK5D8P9zudMPftKAdS/S
 pHjuUlmHD//1sBYtVLnh+AbS41GJmmZXqj4jo342FhWqFO+C+OtUe/9PD2un2dZhpQWn86
 MazcZfUYPry8fsVl+Xw/h7hjgkrn3jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641467966;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L0jaV3Q43YtgPFoYzzpbmK3RLjAw3aTqG8rX4exDcq0=;
 b=La4AdvpGTpB0/Lwxha8VfzireBYX4GjR7xHWAc5f41tkgvtW3y+z6D90YcEWLiOaGwW7h9
 M9DPIzhOwBqOEPBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAE0113C0D;
 Thu,  6 Jan 2022 11:19:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TGVPOD3Q1mHIFwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 06 Jan 2022 11:19:25 +0000
Date: Thu, 6 Jan 2022 12:20:57 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YdbQmTJK73804UYT@yuki>
References: <YdWsZpTjnBLszubC@pevik>
 <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641461121-2212-4-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1641461121-2212-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/4] sysctl/sysctl02.sh: Use kconfig shell api
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

Hi!
> @@ -20,15 +20,14 @@ TST_CLEANUP=cleanup
>  TST_CNT=4
>  TST_NEEDS_ROOT=1
>  TST_NEEDS_CMDS="sysctl"
> +TST_NEEDS_KCONFIGS="CONFIG_SYSCTL=y, CONFIG_PROC_FS=y"

Is there a good reason to check for PROC_FS? I doubt that modern system
without CONFIG_PROC_FS will even boot.

>  sys_name="fs.file-max"
>  sys_file="/proc/sys/fs/file-max"
> -syms_file="/proc/kallsyms"
>  
>  . tst_test.sh
>  
>  setup()
>  {
> -	[ ! -f "$sys_file" ] && tst_brk TCONF "$sys_file not enabled"
>  	orig_value=$(cat "$sys_file")
>  }
>  
> @@ -61,17 +60,15 @@ sysctl_test_overflow()
>  
>  sysctl_test_zero()
>  {
> -	[ ! -f "$syms_file" ] && tst_brk TCONF "$syms_file not enabled"
> +	tst_check_kconfigs "CONFIG_KALLSYMS=y" "CONFIG_KALLSYMS_ALL=y" "CONFIG_KASAN=y" \
> +		|| tst_brk TCONF "kconfig doesn't meet test's requirement!"
> +
>  	ROD sysctl -w -q $sys_name=0
>  
> -	if grep -q kasan_report $syms_file; then
> -		if dmesg | grep -q "KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax"; then
> -			tst_res TFAIL "$sys_file is set 0 and trigger a KASAN error"
> -		else
> -			tst_res TPASS "$sys_file is set 0 and doesn't trigger a KASAN error"
> -		fi
> +	if dmesg | grep -q "KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax"; then
> +		tst_res TFAIL "$sys_file is set 0 and trigger a KASAN error"
>  	else
> -		tst_res TCONF "kernel doesn't support KASAN"
> +		tst_res TPASS "$sys_file is set 0 and doesn't trigger a KASAN error"
>  	fi
>  }
>  
> -- 
> 2.23.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
