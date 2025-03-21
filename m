Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD461C36000
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 10:18:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 081163CAF00
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 11:18:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A33C3CADEA
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 11:18:37 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4EF341400C74
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 11:18:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D17071FBA7;
 Fri, 21 Mar 2025 10:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742552316;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c6pHptrOhwjUfTYKFK8iRTKnlO4FUxqpnSVLvGdEl34=;
 b=pbivnB7LBPmpiIPhXlOismlHddTMUJfaNaXj6Un7mcokkkPRliNm4NdOdlC2x7o0tg5GbB
 h8bKUgYGoFUdgMDh51iNX7xGIOKyoDklWl/NXZWVYeJIrqrDOaB5DeSw07AznzqQkaFlxk
 gB6rzAngBh4yKK7XsIniM9X5DTUdyhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742552316;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c6pHptrOhwjUfTYKFK8iRTKnlO4FUxqpnSVLvGdEl34=;
 b=FdFYOb9k4e9LrI5BAMOEn4NeFddOJU1iNHeNqMmz72FJkiz8Sxwk3QDsCdTmLQNtjecd3n
 O1M/h8diAGBhGoAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742552315;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c6pHptrOhwjUfTYKFK8iRTKnlO4FUxqpnSVLvGdEl34=;
 b=KDtQlyxO5iH6lLGm7nV35B40VZuJ5Ph1uybS+V0bjL8/diWXfDiezPuWzkH/2MZs+LDMjv
 P9xGp3Cu2FqncNg/bwMoHBsADnwpwKNxPpCI9fH85nuvGC0lJCA9f7xRiER0bqGxkvcFum
 xNB/UjNR6covLPSuWFjzLBc2BQI6TLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742552315;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c6pHptrOhwjUfTYKFK8iRTKnlO4FUxqpnSVLvGdEl34=;
 b=hk8UIExUIuLEsMKUyCKlDpCX6kelvQCliE9E38M+v5HBKQL7R2QBCOi4tNaZjCORNgSYv7
 3mKihvqPO5gFiSAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B951613A2C;
 Fri, 21 Mar 2025 10:18:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id j2s9LPs83WdtKwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 21 Mar 2025 10:18:35 +0000
Date: Fri, 21 Mar 2025 11:18:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250321101830.GA163226@pevik>
References: <20250321075234.1829966-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250321075234.1829966-1-liwang@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_test: Add TCONF when no required filesystems
 are available
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

Hi Li,

> Currently, when no required filesystems (filesystem[i].type) are available,
> the test silently does nothing, leading to a misleading test summary.

> This patch adds a check to issue TCONF when no valid filesystems are found,
> ensuring clearer test results.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

Thanks!

Kind regards,
Petr

>   # ./ioctl_ficlone03
>   tst_buffers.c:57: TINFO: Test is using guarded buffers
>   tst_tmpdir.c:317: TINFO: Using /tmp/LTP_iocSKLS9l as tmpdir (tmpfs filesystem)
>   tst_device.c:99: TINFO: Found free device 0 '/dev/loop0'
>   tst_test.c:1900: TINFO: LTP version: 20250130-166-g17960d952
>   tst_test.c:1904: TINFO: Tested kernel: 4.5.0-00002-g22bd332f11d4 #162 SMP Thu Mar 20 18:00:10 CET 2025 x86_64
>   tst_kconfig.c:88: TINFO: Parsing kernel config '/.config'
>   tst_test.c:1724: TINFO: Overall timeout per run is 0h 00m 31s
>   tst_supported_fs_types.c:97: TINFO: Kernel supports ext2
>   tst_supported_fs_types.c:62: TINFO: mkfs.ext2 does exist
>   tst_supported_fs_types.c:97: TINFO: Kernel supports ext3
>   tst_supported_fs_types.c:62: TINFO: mkfs.ext3 does exist
>   tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
>   tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
>   tst_supported_fs_types.c:105: TINFO: Skipping bcachefs because of FUSE blacklist
>   tst_supported_fs_types.c:97: TINFO: Kernel supports vfat
>   tst_supported_fs_types.c:62: TINFO: mkfs.vfat does exist
>   tst_supported_fs_types.c:97: TINFO: Kernel supports tmpfs
>   tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs

>   Summary:
>   passed   0
>   failed   0
>   broken   0
>   skipped  0
>   warnings 0

> Reported-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  lib/tst_test.c | 5 +++++
>  1 file changed, 5 insertions(+)

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 3823ea109..9a23cd4a0 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1855,6 +1855,7 @@ static int run_tcases_per_fs(void)
>  {
>  	int ret = 0;
>  	unsigned int i;
> +	bool found_valid_fs = false;
nit: I would chose slightly shorter variable name (e.g. tested), but that's not
important.

Thanks for sending a patch!

Kind regards,
Petr

>  	const char *const *filesystems = tst_get_supported_fs_types(tst_test->skip_filesystems);

>  	if (!filesystems[0])
> @@ -1866,6 +1867,7 @@ static int run_tcases_per_fs(void)
>  		if (!fs)
>  			continue;

> +		found_valid_fs = true;
>  		ret = run_tcase_on_fs(fs, filesystems[i]);

>  		if (ret == TCONF)
> @@ -1877,6 +1879,9 @@ static int run_tcases_per_fs(void)
>  		do_exit(ret);
>  	}

> +	if (!found_valid_fs)
> +		tst_brk(TCONF, "No required filesystems are available");
> +
>  	return ret;
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
