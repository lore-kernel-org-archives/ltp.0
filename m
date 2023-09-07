Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473C8CCF9F4
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 11:13:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 210383CE9B4
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 13:13:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89FE13CB579
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 13:13:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CEA76602F7F
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 13:13:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C12DA1F8A6;
 Thu,  7 Sep 2023 11:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694085182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jKVjRo+Y58svIMa+VqWzYZiU1f0fI9xZJJtzz7HfPVk=;
 b=bDsYVj2JpqKA182NvQlOzZQwE3bh3Wg8H7yvXX6q1KPl0a1yFI1kDGN0T/xo6sB3atCPLP
 cfUW40vu47b9szAuUiN+hNtLoow0S+SkYqfRLvJAFTw0Ho8UOJcQrvXpB9vZk27h2t+DHb
 ljJCaisvmWOTfcuXT0jyHx9OU8Rv9ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694085182;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jKVjRo+Y58svIMa+VqWzYZiU1f0fI9xZJJtzz7HfPVk=;
 b=x3aF+43mm2x884niRcEc09M+Oyep5GlpdCZqvux5jFwKbGV8Cm+M3Ie615ULKEYfa875Sf
 SLUDjFZXa3kR7CAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B16B1138FA;
 Thu,  7 Sep 2023 11:13:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tdNAKj6w+WT4cAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 07 Sep 2023 11:13:02 +0000
Message-ID: <cc1cf898-ff65-29bb-1157-772d8f319eec@suse.cz>
Date: Thu, 7 Sep 2023 13:13:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: R Nageswara Sastry <rnsastry@linux.ibm.com>, ltp@lists.linux.it
References: <20230907044011.4812-1-rnsastry@linux.ibm.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230907044011.4812-1-rnsastry@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] lib/tst_lockdown.c: Add PPC64 architecture
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
Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 07. 09. 23 6:40, R Nageswara Sastry wrote:
> From: Nageswara R Sastry <rnsastry@linux.ibm.com>
> 
> Add PPC64 architecture support to the lockdown library.
> 
> Signed-off-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
> ---
> v3:
>   - Revert back the kernel config checking to v1 (Martin Doucha)
> v2:
>   - Group all the constant definitions together (Cyril Hrubis)
>   - Reduce the number of variables (Martin Doucha)
> ---
>   lib/tst_lockdown.c | 31 +++++++++++++++++++++----------
>   1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/tst_lockdown.c b/lib/tst_lockdown.c
> index 9086eba36..3ccf73092 100644
> --- a/lib/tst_lockdown.c
> +++ b/lib/tst_lockdown.c
> @@ -14,33 +14,37 @@
>   #include "tst_lockdown.h"
>   #include "tst_private.h"
>   
> -#define EFIVAR_SECUREBOOT "/sys/firmware/efi/efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c"
> -
> +#if defined(__powerpc64__) || defined(__ppc64__)
> +# define SECUREBOOT_VAR "/proc/device-tree/ibm,secure-boot"
> +# define VAR_DATA_SIZE 4
> +#else
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
> +	tst_res(TINFO, "SecureBoot: %s", data[VAR_DATA_SIZE - 1] ? "on" : "off");
> +	return data[VAR_DATA_SIZE - 1];
>   }
>   
>   int tst_lockdown_enabled(void)
> @@ -51,9 +55,16 @@ int tst_lockdown_enabled(void)
>   
>   	if (access(PATH_LOCKDOWN, F_OK) != 0) {
>   		char flag;
> +
>   		/* SecureBoot enabled could mean integrity lockdown (non-mainline version) */
> +#if defined(__powerpc64__) || defined(__ppc64__)
> +		flag = tst_kconfig_get("CONFIG_SECURITY_LOCKDOWN_LSM") == 'y';
> +		flag |= tst_kconfig_get("CONFIG_SECURITY_LOCKDOWN_LSM_EARLY") == 'y';
> +#else
>   		flag = tst_kconfig_get("CONFIG_EFI_SECURE_BOOT_LOCK_DOWN") == 'y';
>   		flag |= tst_kconfig_get("CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT") == 'y';
> +#endif
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
