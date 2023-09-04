Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BF1C71153
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 09:53:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 881853CB894
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 11:53:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0F043CB834
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 11:53:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 834581401268
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 11:53:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7778A1F38C;
 Mon,  4 Sep 2023 09:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693821213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fBIqMyNNgm4pK9sIFgEsU86gxXdCWHuM89TLgiACQvg=;
 b=Qj+kEj86WlBoe+MylDGkqGaVIWKf2pfM76AxsLnK1S+CLRoSL3JwpvB9IXpBPdLshY3l7Q
 6Z26k9XuVTrD6Nhlb05pkzanNhrRK/aS4mAwx2NGVToEu72Vh7+KMPjEbXJF5xzeP01y/q
 P249D/FH1tA7HjFCYivpQOc5WUX5AlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693821213;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fBIqMyNNgm4pK9sIFgEsU86gxXdCWHuM89TLgiACQvg=;
 b=rh1/u2nT+V8c/v8e210eLVdZO/5BzqixdvV4PSTFAoK1I6UXsDRtFtUcAhVBA0lnM8ZnGD
 7E+Nc77Fe2EIXxDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D0C713425;
 Mon,  4 Sep 2023 09:53:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MZruFR2p9WQiDQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 04 Sep 2023 09:53:33 +0000
Date: Mon, 4 Sep 2023 11:54:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Nageswara R Sastry <rnsastry@linux.ibm.com>
Message-ID: <ZPWpRFy4-T0vVzWv@yuki>
References: <20230904065643.32590-1-rnsastry@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230904065643.32590-1-rnsastry@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tst_lockdown.c: Add PPC64 architecture support
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
> +#if defined(__powerpc64__) || defined(__ppc64__)
> +#define SECUREBOOT_VAR "/proc/device-tree/ibm,secure-boot"
> +#else
> +#define SECUREBOOT_VAR "/sys/firmware/efi/efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c"
> +#endif

This is not properly indented, for preprocessor directives the # has to
always be first character in the line, then inner blocks are indented by
spaces between # and the rest such as:

#if foo
# if bar
#  define BAZ
# endif
#endif

>  int tst_secureboot_enabled(void)
>  {
>  	int fd;
>  	char data[5];
>  
> -	if (access(EFIVAR_SECUREBOOT, F_OK)) {
> -		tst_res(TINFO, "Efivar FS not available");
> +	if (access(SECUREBOOT_VAR, F_OK)) {
> +		tst_res(TINFO, "SecureBoot sysfs file not available");
>  		return -1;
>  	}
>  
> -	fd = open(EFIVAR_SECUREBOOT, O_RDONLY);
> +	fd = open(SECUREBOOT_VAR, O_RDONLY);
>  
>  	if (fd == -1) {
>  		tst_res(TINFO | TERRNO,
> -			"Cannot open SecureBoot Efivar sysfile");
> +			"Cannot open SecureBoot file");
>  		return -1;
>  	} else if (fd < 0) {
>  		tst_brk(TBROK | TERRNO, "Invalid open() return value %d", fd);
>  		return -1;
>  	}
> -
> +	#if defined(__powerpc64__) || defined(__ppc64__)
> +	SAFE_READ(1, fd, data, 4);
> +	#else
>  	SAFE_READ(1, fd, data, 5);
> +	#endif

Here as well, the ifdefs has to start at first character in the line:

#if ...
	SAFE_READ(...);
#else
	SAFE_READ(...);
#endif

>  	SAFE_CLOSE(fd);
> +
> +	#if defined(__powerpc64__) || defined(__ppc64__)
> +	tst_res(TINFO, "SecureBoot: %s", data[3] ? "on" : "off");
> +	return data[3];
> +	#else
>  	tst_res(TINFO, "SecureBoot: %s", data[4] ? "on" : "off");
>  	return data[4];
> +	#endif
>
>  }
>  
>  int tst_lockdown_enabled(void)
> @@ -51,9 +64,16 @@ int tst_lockdown_enabled(void)
>  
>  	if (access(PATH_LOCKDOWN, F_OK) != 0) {
>  		char flag;
> +
>  		/* SecureBoot enabled could mean integrity lockdown (non-mainline version) */
> +		#if defined(__powerpc64__) || defined(__ppc64__)
> +		flag = tst_kconfig_get("CONFIG_SECURITY_LOCKDOWN_LSM") == 'y';
> +		flag |= tst_kconfig_get("CONFIG_SECURITY_LOCKDOWN_LSM_EARLY") == 'y';
> +		#else
>  		flag = tst_kconfig_get("CONFIG_EFI_SECURE_BOOT_LOCK_DOWN") == 'y';
>  		flag |= tst_kconfig_get("CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT") == 'y';
> +		#endif

However all of these cases we can just define a few constants instead of
cluttering the code with ifdefs.

#ifdef ppc
# define VAR_DATA_SIZE 5
# define VAR_DATA_OFF 4
# define KERNEL_KCONFIG1 "CONFIG_SECURITY_LOCKDOWN_LSM"
# define KERNEL_KCONFIG2 "CONFIG_SECURITY_LOCKDOWN_LSM_EARLY"
...
#else
# define VAR_DATA_SIZE 4
# define VAR_DATA_OFF 3
...
#endif


>  		if (flag && tst_secureboot_enabled() > 0)
>  			return 1;
>  
> -- 
> 2.37.1 (Apple Git-137.1)
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
