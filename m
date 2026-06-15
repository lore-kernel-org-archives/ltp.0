Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E29CD98DA
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 11:33:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B82853E5BE2
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 13:33:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E01873E16F2
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 13:33:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F120B1A003D6
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 13:33:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ECBD275EDC;
 Mon, 15 Jun 2026 11:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781523184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EVSdwybA4R/hbjfMYT32X2AvXy7zzvCVFhUj2Z7sxeo=;
 b=qhg5f/CQex5y8XI8UL7MR7BC3d0Is3zcKn+YDZb27rSior/Crsi6m5ZX5y+YgkPJRXMTiE
 Kd8W7q3IZUoboFYSSB6h2b2CqZ+WUF+IT9mtAA/SiKqUrpVdQoBFu3T5aYuwTr7XOMfLPn
 LjQCscylHag38u9Um9XTSAGNGyJK9w4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781523184;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EVSdwybA4R/hbjfMYT32X2AvXy7zzvCVFhUj2Z7sxeo=;
 b=gTOyiaq+N3XGYs447fGhSoUngKodDjFk5t4w7KYo80wyP60v7FtAeqdR6L5hnihHkFaDOM
 u6ybLNZu3/lN0IAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="FsuKi2/F";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="GX/7mUJs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781523183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EVSdwybA4R/hbjfMYT32X2AvXy7zzvCVFhUj2Z7sxeo=;
 b=FsuKi2/FdXGmneT2F6YBEDKY1p04zvWWKPuMn8VRLKoPvSdL3Oooo4wuJD8CKeg52+zzQH
 tCvEN1OqxSJWlyqMFeFsISPPW0/6rHp4YXtcSn+Hu7eVX7OMfzQWTE6BKGvtGZpiV+C/fa
 AeICO1gjWfpn88dHxDHqR0bqioaKcu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781523183;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EVSdwybA4R/hbjfMYT32X2AvXy7zzvCVFhUj2Z7sxeo=;
 b=GX/7mUJswBTRgG6CNBsp0hH2hCMUbwb0ow6kyb+ZOuxySWMFjf8ULDFs+57Jt/hibn8wah
 AsoR3y4uYCXAx+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC8EA779A7;
 Mon, 15 Jun 2026 11:33:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ln/3NO/iL2r6OwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 15 Jun 2026 11:33:03 +0000
Date: Mon, 15 Jun 2026 13:33:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ai_i7H1Vfoy5H4oP@yuki.lan>
References: <20260611-fw_load-v6-0-c2aec79a7ed7@suse.com>
 <20260611-fw_load-v6-2-c2aec79a7ed7@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260611-fw_load-v6-2-c2aec79a7ed7@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: ECBD275EDC
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/4] fw_load: rewrite test using new LTP API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +static void run(void)
>  {
> -	setup(argc, argv);
> +	struct fw_data *fw;
> +	int result = 0;
> +	int fail, offset;
>  
> -	test_run();
> +	SAFE_FILE_PRINTF(DEV_FWNUM, "%d", fw_count);
> +	SAFE_FILE_SCANF(DEV_RESULT, "%d", &result);
>  
> -	cleanup();
> +	for (int i = 0; i < fw_count; i++) {
> +		fw = &firmware[i];
>  
> -	tst_exit();
> -}
> +		fail = (result & (1 << i)) == 0 && !fw->fake;
> +		offset = fw->dir[0] ? strlen(fw->dir) : 0;
>  
> -static void help(void)
> -{
> -	printf("  -n x    Write x bytes to firmware file, default is %d\n",
> -		fw_size);
> -	printf("  -s      Skip cleanup\n");
> -	printf("  -v      Verbose\n");
> +		if (fw->fake) {
> +			tst_res(result & (1 << i) ? TFAIL : TPASS,
> +				"Firmware '%s' correctly not loaded",
> +				fw->file + offset);
> +		} else {
> +			tst_res(fail ? TFAIL : TPASS,
> +				"Firmware '%s' loaded",
> +				fw->file + offset);
> +		}

If you are splitting the tst_res() by the fw->fake then do it right. We
should drop the && !fw->fake from the fail above and use a variable
only to get the right bit from the result:

int pass = result && (1<<i);

if (fw->fake)
	tst_res(pass ? TFAIL : TPASS, ...)
else
	tst_res(pass ? TPASS : TFAIL, ...)


> +	}
>  }
>  
> -void setup(int argc, char *argv[])
> +static void setup(void)
>  {
> -	if (tst_lockdown_enabled() > 0 || tst_secureboot_enabled() > 0)
> -		tst_brkm(TCONF, NULL, "Cannot load unsigned modules in Lockdown/Secure Boot");

I assume that we dropped this because we have
tst_requires_module_signature_disabled() later in the setup() right?


The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
