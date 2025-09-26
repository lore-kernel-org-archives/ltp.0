Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7800DCAC5B9
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 09:31:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD8303CE0A6
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 11:31:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B37DD3CD066
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 11:31:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E500C1400745
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 11:31:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 092FC8D5A2;
 Fri, 26 Sep 2025 09:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758879098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tdv+atBgM8Be3UgoK/6pp5gmcJ1kWCXp55ifOwEmyFE=;
 b=ppD4/mwSGjDc1QzL2ZH9BpcbfTqxDzszjiWkG5EgGWH2/LrrHUH0GeAgvPCSguOB9ji//e
 O81OfG1mmEevYrcqw3o5izRIgEJD0+Me3YakTSNQQvM1L9BORXMCSi12PnNOD7F+boQyb0
 FJXzfYGQzENLRYj9DhItsyyn74dthVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758879098;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tdv+atBgM8Be3UgoK/6pp5gmcJ1kWCXp55ifOwEmyFE=;
 b=JCuSziAwilWC3NhRSMD0gUgn8+9i+EJCPfYkguJLUnBLLzjlEFrY72xwq5kyAd9yk+7sFW
 ryfJxGSAT2kZ5+Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758879098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tdv+atBgM8Be3UgoK/6pp5gmcJ1kWCXp55ifOwEmyFE=;
 b=ppD4/mwSGjDc1QzL2ZH9BpcbfTqxDzszjiWkG5EgGWH2/LrrHUH0GeAgvPCSguOB9ji//e
 O81OfG1mmEevYrcqw3o5izRIgEJD0+Me3YakTSNQQvM1L9BORXMCSi12PnNOD7F+boQyb0
 FJXzfYGQzENLRYj9DhItsyyn74dthVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758879098;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tdv+atBgM8Be3UgoK/6pp5gmcJ1kWCXp55ifOwEmyFE=;
 b=JCuSziAwilWC3NhRSMD0gUgn8+9i+EJCPfYkguJLUnBLLzjlEFrY72xwq5kyAd9yk+7sFW
 ryfJxGSAT2kZ5+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6D871373E;
 Fri, 26 Sep 2025 09:31:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SI6CN3ld1mhXCwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 26 Sep 2025 09:31:37 +0000
Date: Fri, 26 Sep 2025 11:32:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aNZdoyUXnbGocpqR@yuki.lan>
References: <20250926085021.22141-1-wegao@suse.com>
 <20250926085021.22141-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250926085021.22141-3-wegao@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/2] ioctl_loop01.c: Update to new .needs_cmds
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Sep 26, 2025 at 08:50:12AM +0000, Wei Gao wrote:
> NOTE:This patchset is draft for review not final one.
> Since not include update .needs_cmds for all related testcases.
> 
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  .../kernel/syscalls/ioctl/ioctl_loop01.c      | 23 ++++++++-----------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> index c9137bf1e..a3f0857e3 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> @@ -97,9 +97,10 @@ static void verify_ioctl_loop(void)
>  
>  static void setup(void)
>  {
> -	int ret;
> +	parted_sup = tst_cmd_present(test.needs_cmds, "parted");
> +
>  	const char *const cmd_parted[] = {"parted", "-s", "test.img", "mklabel", "msdos", "mkpart",
> -	                                  "primary", "ext4", "1M", "10M", NULL};
> +					"primary", "ext4", "1M", "10M", NULL};
>  
>  	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
>  	if (dev_num < 0)
> @@ -107,18 +108,8 @@ static void setup(void)
>  
>  	tst_fill_file("test.img", 0, 1024 * 1024, 10);
>  
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
>  
>  	sprintf(partscan_path, "/sys/block/loop%d/loop/partscan", dev_num);
>  	sprintf(autoclear_path, "/sys/block/loop%d/loop/autoclear", dev_num);
> @@ -152,5 +143,9 @@ static struct tst_test test = {
>  		{"linux-git", "6ac92fb5cdff"},
>  		{}
>  	},
> +	.needs_cmds = (struct tst_cmd[]) {
> +		{"parted", 0, 0},

No need to pass the zeros if we just initialize the cmd part. Also I
would use the named initializers as:

		{.cmd = "parted", .optional = 1},

> +		{}
> +	},
>  	.needs_tmpdir = 1,
>  };
> -- 
> 2.51.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
