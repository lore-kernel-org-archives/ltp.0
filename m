Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CE6C04FFE
	for <ltp@archiver.kernel.org>; Mon, 20 May 2024 15:11:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA6953CFEBC
	for <ltp@archiver.kernel.org>; Mon, 20 May 2024 17:11:54 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B99943CFC16
 for <ltp@lists.linux.it>; Mon, 20 May 2024 17:11:36 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4A9D01A003D9
 for <ltp@lists.linux.it>; Mon, 20 May 2024 17:11:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5EDDC20E07;
 Mon, 20 May 2024 15:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716217895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I9m2CxgHZQUlSqvbUaFH3ui/Fo3K4sF2s/nVCezTl2E=;
 b=q9JyJNjaKoBLgq5MqYa1wjfoKI15JEhoOzmUskXgBUzF5yq2D/0OkCiEHU30HpFbCbfxG6
 BiHHWnt9hxOv2398a+6XcHc4qpfDwEyIgd6T0JKyI8DFeRz0aXtpgik71tqVjt77Fy9TzM
 NRBT76r0BdeSzYlOoxRK9/LArhJUtsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716217895;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I9m2CxgHZQUlSqvbUaFH3ui/Fo3K4sF2s/nVCezTl2E=;
 b=iQnhJj6aqAuep60Fu0yd3b1CAhmksXnPDKoSnAg72BpAMmYJzEJDSX6Qh/Tjf7A6PTUHf8
 0A23v46b83ZQkJCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716217895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I9m2CxgHZQUlSqvbUaFH3ui/Fo3K4sF2s/nVCezTl2E=;
 b=q9JyJNjaKoBLgq5MqYa1wjfoKI15JEhoOzmUskXgBUzF5yq2D/0OkCiEHU30HpFbCbfxG6
 BiHHWnt9hxOv2398a+6XcHc4qpfDwEyIgd6T0JKyI8DFeRz0aXtpgik71tqVjt77Fy9TzM
 NRBT76r0BdeSzYlOoxRK9/LArhJUtsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716217895;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I9m2CxgHZQUlSqvbUaFH3ui/Fo3K4sF2s/nVCezTl2E=;
 b=iQnhJj6aqAuep60Fu0yd3b1CAhmksXnPDKoSnAg72BpAMmYJzEJDSX6Qh/Tjf7A6PTUHf8
 0A23v46b83ZQkJCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5008013A21;
 Mon, 20 May 2024 15:11:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id e+6EEidoS2YHZwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 20 May 2024 15:11:35 +0000
Date: Mon, 20 May 2024 17:10:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zktn8mMhzM_Eomkb@yuki>
References: <20240520124005.57978-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240520124005.57978-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] libswap: Fix tst_max_swapfiles() for SLE12-SP5
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
> SLE12-SP4 backported 5042db43cc26. It's now EOL, but SLE12-SP5 is still
> supported, thus fix tst_max_swapfiles() detection.
> 
> While at it, fix whitespace.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> NOTE: this should get merged before release.
> 
> I can split whitelist change into a separate commit.

Yes please.

>  libs/libltpswap/libswap.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
> index eb066df71..6c21ac8af 100644
> --- a/libs/libltpswap/libswap.c
> +++ b/libs/libltpswap/libswap.c
> @@ -243,24 +243,31 @@ bool is_swap_supported(const char *filename)
>   */
>  int tst_max_swapfiles(void)
>  {
> -	unsigned int swp_migration_num = 0, swp_hwpoison_num = 0, swp_device_num = 0, swp_pte_marker_num = 0;
> +	unsigned int swp_migration_num = 0, swp_hwpoison_num = 0,
> +				 swp_device_num = 0, swp_pte_marker_num = 0;
>  	struct tst_kconfig_var migration = TST_KCONFIG_INIT("CONFIG_MIGRATION");
>  	struct tst_kconfig_var memory = TST_KCONFIG_INIT("CONFIG_MEMORY_FAILURE");
>  	struct tst_kconfig_var device = TST_KCONFIG_INIT("CONFIG_DEVICE_PRIVATE");
>  	struct tst_kconfig_var marker = TST_KCONFIG_INIT("CONFIG_PTE_MARKER");
> -	struct tst_kern_exv kvers[] = {
> +	struct tst_kern_exv kvers_marker_migration[] = {
>  		/* RHEL9 kernel has patch 6c287605f and 679d10331 since 5.14.0-179 */
>  		{ "RHEL9", "5.14.0-179" },
>  		{ NULL, NULL},
>  	};
>  
> +	struct tst_kern_exv kvers_device[] = {
> +		/* SLES12-SP4 has patch 5042db43cc26 since 4.12.14-5.5 */
> +		{ "SLES", "4.12.14-5.5" },
> +		{ NULL, NULL},
> +	};
> +
>  	tst_kconfig_read(&migration, 1);
>  	tst_kconfig_read(&memory, 1);
>  	tst_kconfig_read(&device, 1);
>  	tst_kconfig_read(&marker, 1);
>  
>  	if (migration.choice == 'y') {
> -		if (tst_kvercmp2(5, 19, 0, kvers) < 0)
> +		if (tst_kvercmp2(5, 19, 0, kvers_marker_migration) < 0)
>  			swp_migration_num = 2;
>  		else
>  			swp_migration_num = 3;
> @@ -270,18 +277,19 @@ int tst_max_swapfiles(void)
>  		swp_hwpoison_num = 1;
>  
>  	if (device.choice == 'y') {
> -		if (tst_kvercmp(4, 14, 0) >= 0)
> +		if (tst_kvercmp2(4, 14, 0, kvers_device) >= 0)
>  			swp_device_num = 2;
>  		if (tst_kvercmp(5, 14, 0) >= 0)
>  			swp_device_num = 4;
>  	}
>  
> -	if ((marker.choice == 'y' && tst_kvercmp2(5, 19, 0, kvers) >= 0) ||
> -		tst_kvercmp(6, 2, 0) >= 0) {
> +	if ((marker.choice == 'y' && tst_kvercmp(6, 2, 0) >= 0) ||
> +	    tst_kvercmp2(5, 19, 0, kvers_marker_migration) >= 0) {

The 5.19 and 6.2 seems to be swapped after the patch, that does not look
right.

>  		swp_pte_marker_num = 1;
>  	}
>  
> -	return DEFAULT_MAX_SWAPFILE - swp_migration_num - swp_hwpoison_num - swp_device_num - swp_pte_marker_num;
> +	return DEFAULT_MAX_SWAPFILE - swp_migration_num - swp_hwpoison_num
> +		- swp_device_num - swp_pte_marker_num;
>  }
>  
>  /*
> -- 
> 2.43.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
