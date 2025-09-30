Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2D7CCA468
	for <ltp@archiver.kernel.org>; Tue, 30 Sep 2025 13:13:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C02843CE2CF
	for <ltp@archiver.kernel.org>; Tue, 30 Sep 2025 15:13:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29AC93CDEE4
 for <ltp@lists.linux.it>; Tue, 30 Sep 2025 15:12:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B39B360086B
 for <ltp@lists.linux.it>; Tue, 30 Sep 2025 15:12:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CA4141F7D0;
 Tue, 30 Sep 2025 13:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759237976;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7X7085EsmeCXDxk/kln5Zpo8J+Hga8PO8fMXe1rnMws=;
 b=gUTY9gO421l1vaY1Xl1CzqfyyaJIBHeK7cPziobmX3KkKDMdja4QI1ExP4BrrG78HqVQLM
 vqL7d/eFxD/6npN2MmGcBXTufz/3QP7QIwUtA7lo1wUszUx1aY9dlEuOJ3XdEK+a8/RaUg
 HuZJW+bKbiEPXawh2yjF+lGidgU23gM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759237976;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7X7085EsmeCXDxk/kln5Zpo8J+Hga8PO8fMXe1rnMws=;
 b=Xeb3+rRfQzVvNe/8MSShp76qyeC5kg68xhRS7GcNWpPsNV7adER0XGWnuPIMSRhaTL2XHL
 tIiOMnTR7N2D8pAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759237976;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7X7085EsmeCXDxk/kln5Zpo8J+Hga8PO8fMXe1rnMws=;
 b=gUTY9gO421l1vaY1Xl1CzqfyyaJIBHeK7cPziobmX3KkKDMdja4QI1ExP4BrrG78HqVQLM
 vqL7d/eFxD/6npN2MmGcBXTufz/3QP7QIwUtA7lo1wUszUx1aY9dlEuOJ3XdEK+a8/RaUg
 HuZJW+bKbiEPXawh2yjF+lGidgU23gM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759237976;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7X7085EsmeCXDxk/kln5Zpo8J+Hga8PO8fMXe1rnMws=;
 b=Xeb3+rRfQzVvNe/8MSShp76qyeC5kg68xhRS7GcNWpPsNV7adER0XGWnuPIMSRhaTL2XHL
 tIiOMnTR7N2D8pAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5423A13A3F;
 Tue, 30 Sep 2025 13:12:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bBrsEVjX22jiPgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 30 Sep 2025 13:12:56 +0000
Date: Tue, 30 Sep 2025 15:12:50 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250930131250.GA238065@pevik>
References: <20250926085021.22141-1-wegao@suse.com>
 <20250928232708.24007-1-wegao@suse.com>
 <20250928232708.24007-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250928232708.24007-3-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] ioctl_loop01.c: Update to new .needs_cmds
 struct
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

Hi Wei,

...
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> @@ -97,9 +97,10 @@ static void verify_ioctl_loop(void)

Patch does not apply, thus CI fail. Please always rebase before sending.

>  static void setup(void)
>  {
> -	int ret;
> +	parted_sup = tst_cmd_present("parted");
> +
>  	const char *const cmd_parted[] = {"parted", "-s", "test.img", "mklabel", "msdos", "mkpart",
> -	                                  "primary", "ext4", "1M", "10M", NULL};
> +					"primary", "ext4", "1M", "10M", NULL};

This change just changes whitespace. I would avoid it.

>  	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
>  	if (dev_num < 0)
> @@ -107,18 +108,8 @@ static void setup(void)

>  	tst_fill_file("test.img", 0, 1024 * 1024, 10);

> -	ret = tst_cmd(cmd_parted, NULL, NULL, TST_CMD_PASS_RETVAL);
> -	switch (ret) {
> -	case 0:
> -		parted_sup = 1;
> -	break;
> -	case 255:
> -		tst_res(TCONF, "parted binary not installed or failed");
> -	break;
> -	default:
> -		tst_res(TCONF, "parted exited with %i", ret);
> -	break;
> -	}
> +	if (parted_sup)
> +		SAFE_CMD(cmd_parted, NULL, NULL);

>  	sprintf(partscan_path, "/sys/block/loop%d/loop/partscan", dev_num);
>  	sprintf(autoclear_path, "/sys/block/loop%d/loop/autoclear", dev_num);
> @@ -152,5 +143,9 @@ static struct tst_test test = {
>  		{"linux-git", "6ac92fb5cdff"},
>  		{}
>  	},
> +	.needs_cmds = (struct tst_cmd[]) {
> +		{.cmd = "parted", .optional = 1},
> +		{}
> +	},

Otherwise LGTM.

With above fixed:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
