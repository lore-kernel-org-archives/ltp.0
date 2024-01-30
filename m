Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00274C47DDF
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 11:30:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72BC83CF96B
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 12:30:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FE463C81D8
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 12:29:57 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2C8151A00CAB
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 12:29:56 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3727121CDB;
 Tue, 30 Jan 2024 11:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706614196;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DcXbieeBamuOkYvyEEcdwWxqDtAwHaRyag4EyR3RzM8=;
 b=rc+mKr+ZOyQzDEDPT6wCMRAa2OqhmnX9QW4DYuAQP8tUv09v5EAZVcjQ+wZepLcMS3qAca
 Ixc1NLCderWgz5go8FDbJrfUha83OgLWw5ZgaS+nVugtoylj2/pG7Kbf+CAb6tZ3By4WGL
 ljU2QOmNyDk/ykysONaEyxCMnhIfO7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706614196;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DcXbieeBamuOkYvyEEcdwWxqDtAwHaRyag4EyR3RzM8=;
 b=3TUmGbHYMS0jfk37yOdfl3w+X/efJjONt+BzCNQqb6WLVf/kWdAzPOCkX0AOy3a3zSS56o
 YnpfEKtGqKcSg/Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706614195;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DcXbieeBamuOkYvyEEcdwWxqDtAwHaRyag4EyR3RzM8=;
 b=vlgUokRfCHCKehAIvn3sS0KRaASJGSdOQxwXQvMQtWXylmdqWexk1/tzGAUueASnVE1ygu
 TA0OKeYe+yKz94YnCaPHR5ogbv30L0z7vEIIDo4ouZmY+QIP6bHCtbfUsxquS1Kt6Gc/yU
 3L/7NuTEoHSPkoc08vGlnoUxeLc8ySg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706614195;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DcXbieeBamuOkYvyEEcdwWxqDtAwHaRyag4EyR3RzM8=;
 b=K4U/hH4qcIIen/pYqIuMe8ZVG7+f8MctdCxj0AYBLFq/WWAYpENrV4q96aZh37TQr1LqXs
 a1nj+PapMq67IKBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B28113462;
 Tue, 30 Jan 2024 11:29:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id yZ+BBbPduGWiDgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jan 2024 11:29:55 +0000
Date: Tue, 30 Jan 2024 12:29:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240130112953.GB753541@pevik>
References: <20240117173006.31521-1-mdoucha@suse.cz>
 <20240117173006.31521-2-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240117173006.31521-2-mdoucha@suse.cz>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vlgUokRf;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="K4U/hH4q"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.21 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.00)[35.81%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 3727121CDB
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] Add test for ASLRn't bug
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

Very nice work.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +++ b/runtest/kernel_misc
> @@ -15,3 +15,4 @@ zram01 zram01.sh
>  zram02 zram02.sh
>  zram03 zram03
>  umip_basic_test umip_basic_test
> +aslr01 aslr01

I wonder, don't we want to run also with strict mode?
Do you want to avoid failure:
aslr01.c:241: TFAIL: Large lib base address has less than 28 random bits

> +static void find_large_lib(void)
> +{
> +	size_t hpsize, libsize = 0;
> +
> +	read_shared_libraries(find_large_lib_callback, &libsize);
> +
> +	if (!libsize) {
> +		tst_brk(TCONF,
> +			"No dynamic libraries loaded, please use LD_PRELOAD");
> +	}
> +
> +	hpsize = tst_get_hugepage_size();
> +	tst_res(TINFO, "Largest loaded library: %s (%zu bytes)", lib_path,
> +		libsize);
> +
> +	if (!hpsize) {
> +		tst_res(TCONF, "Hugepage support appears to be missing");
> +	} else if (libsize < hpsize) {
> +		tst_res(TCONF, "The largest dynamic library is smaller than "
> +			"hugepage size");

very nit: I would not split the string (better for grep).

> +		tst_res(TCONF, "Please use LD_PRELOAD to add larger library");
> +	}
> +}

...
> +	if (strict_check) {
> +		if (compat) {
> +			kconf_minbits = aslr_kconfigs[ASLR_COMPAT_MINBITS].val;
> +			minbits_path = "/proc/sys/vm/mmap_rnd_compat_bits";
> +		} else {
> +			kconf_minbits = aslr_kconfigs[ASLR_MINBITS].val;
> +			minbits_path = "/proc/sys/vm/mmap_rnd_bits";
> +		}
> +
> +		/*
> +		 * Reading mmap_rnd_bits usually requires root privileges.
> +		 * Fall back to kernel config values if unprivileged.
> +		 */
+1. So this require either only root or working kconfig.

> +		if (!access(minbits_path, R_OK))
> +			SAFE_FILE_SCANF(minbits_path, "%d", &minbits);
> +		else if (!kconf_minbits)
> +			tst_brk(TBROK, "Cannot determine kernel ASLR min bits");
> +		else if (tst_parse_int(kconf_minbits, &minbits, 1, 64))
> +			tst_brk(TBROK, "Invalid kernel ASLR min bits value");
> +	}
> +
> +	find_large_lib();
> +}

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
