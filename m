Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58377C83F3E
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 09:23:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 380943CDEFC
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 11:23:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 353B43CB78F
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 11:23:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 724A2100047A
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 11:23:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CAE59210DD;
 Tue,  5 Sep 2023 09:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693905791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BzPnC4ryBhIYRm4BIwsvdvOw4pYPFlfoRE0WoeqGw1Y=;
 b=iEtOj1/oHrxCq5uVnVXZ8/Pbml1vNpQ2EiLTYYxq3ZhPb9nqVfRvr/0/KlAiVLBqX0nXgQ
 rQHw3pZ0xuUct5aa6XsWVXBzexel8gA+4WaYDE9j4vyN8Ogh+Qgpur0Szch7IWUTQSW+9A
 ByBc8cUSbGR+ODPvCL14hji0vpXbW5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693905791;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BzPnC4ryBhIYRm4BIwsvdvOw4pYPFlfoRE0WoeqGw1Y=;
 b=D7VvEAiX40NOXMTGqfeE3utSbfQ21PT2glcHFXAMOSs5oLxxOW2eFyHdap7Tzghxt3AK0D
 nlF751WynIx127Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8A6513911;
 Tue,  5 Sep 2023 09:23:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NsP0K3/z9mSNLAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 05 Sep 2023 09:23:11 +0000
Message-ID: <62549924-8590-c85f-5693-129168bdb9f5@suse.cz>
Date: Tue, 5 Sep 2023 11:23:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: Nageswara R Sastry <rnsastry@linux.ibm.com>, ltp@lists.linux.it
References: <20230905060410.45560-1-rnsastry@linux.ibm.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230905060410.45560-1-rnsastry@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH V2] lib/tst_lockdown.c: Add PPC64 architecture
 support
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 05. 09. 23 8:04, Nageswara R Sastry wrote:
> Add PPC64 architecture support to the lockdown library.
> 
> Signed-off-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
> ---
> v2:
>   - Group all the constant definitions together (Cyril Hrubis)
>   - Reduce the number of variables (Martin Doucha)
> ---
>   lib/tst_lockdown.c | 35 +++++++++++++++++++++++------------
>   1 file changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/lib/tst_lockdown.c b/lib/tst_lockdown.c
> index 9086eba36..ea71f6753 100644
> --- a/lib/tst_lockdown.c
> +++ b/lib/tst_lockdown.c
> @@ -14,33 +14,42 @@
>   #include "tst_lockdown.h"
>   #include "tst_private.h"
>   
> -#define EFIVAR_SECUREBOOT "/sys/firmware/efi/efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c"
> -
> +#if defined(__powerpc64__) || defined(__ppc64__)
> +# define KERNEL_CONFIG1 "CONFIG_SECURITY_LOCKDOWN_LSM"
> +# define KERNEL_CONFIG2 "CONFIG_SECURITY_LOCKDOWN_LSM_EARLY"
> +# define SECUREBOOT_VAR "/proc/device-tree/ibm,secure-boot"
> +# define VAR_DATA_SIZE 4
> +#else
> +# define KERNEL_CONFIG1 "CONFIG_EFI_SECURE_BOOT_LOCK_DOWN"
> +# define KERNEL_CONFIG2 "CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT"
> +# define SECUREBOOT_VAR "/sys/firmware/efi/efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c"
> +# define VAR_DATA_SIZE 5
> +#endif
>   int tst_secureboot_enabled(void)
>   {
>   	int fd;
>   	char data[5];
>   
> -	if (access(EFIVAR_SECUREBOOT, F_OK)) {
> -		tst_res(TINFO, "Efivar FS not available");
> +	if (access(SECUREBOOT_VAR, F_OK)) {
> +		tst_res(TINFO, "SecureBoot sysfs file not available");
>   		return -1;
>   	}
>   
> -	fd = open(EFIVAR_SECUREBOOT, O_RDONLY);
> +	fd = open(SECUREBOOT_VAR, O_RDONLY);
>   
>   	if (fd == -1) {
>   		tst_res(TINFO | TERRNO,
> -			"Cannot open SecureBoot Efivar sysfile");
> +			"Cannot open SecureBoot file");
>   		return -1;
>   	} else if (fd < 0) {
>   		tst_brk(TBROK | TERRNO, "Invalid open() return value %d", fd);
>   		return -1;
>   	}
> -
> -	SAFE_READ(1, fd, data, 5);
> +	SAFE_READ(1, fd, data, VAR_DATA_SIZE);
>   	SAFE_CLOSE(fd);
> -	tst_res(TINFO, "SecureBoot: %s", data[4] ? "on" : "off");
> -	return data[4];
> +
> +	tst_res(TINFO, "SecureBoot: %s", data[VAR_DATA_SIZE - 1] ? "on" : "off");
> +	return data[VAR_DATA_SIZE - 1];
>   }
>   
>   int tst_lockdown_enabled(void)
> @@ -51,9 +60,11 @@ int tst_lockdown_enabled(void)
>   
>   	if (access(PATH_LOCKDOWN, F_OK) != 0) {
>   		char flag;
> +
>   		/* SecureBoot enabled could mean integrity lockdown (non-mainline version) */
> -		flag = tst_kconfig_get("CONFIG_EFI_SECURE_BOOT_LOCK_DOWN") == 'y';
> -		flag |= tst_kconfig_get("CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT") == 'y';
> +		flag = tst_kconfig_get(KERNEL_CONFIG1) == 'y';
> +		flag |= tst_kconfig_get(KERNEL_CONFIG2) == 'y';

I don't think that defining two constant macros for the kernel config 
options makes sense here. It's just a coincidence that both PPC and x86 
currently have two possible config keys. When we add special support for 
a third arch that has only one (or e.g. a third option for x86), this 
code will need to be reworked back to what was in v1. Or you could check 
all 4 option regardless of arch, the worst thing that'll happen is that 
the test setup will be slightly slower.

> +
>   		if (flag && tst_secureboot_enabled() > 0)
>   			return 1;
>   

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
