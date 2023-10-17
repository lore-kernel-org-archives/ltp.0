Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43929CDB474
	for <ltp@archiver.kernel.org>; Tue, 17 Oct 2023 11:08:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5A093CD129
	for <ltp@archiver.kernel.org>; Tue, 17 Oct 2023 13:08:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7D193CD0E0
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 13:08:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 27B911400077
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 13:08:05 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B636021D0C;
 Tue, 17 Oct 2023 11:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697540884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3NWu8Ctkh2TRLgmNewbtrKwGeOq7W7dWd5W8N6C/g9s=;
 b=zinqRJBuG7d0Y/ZUZCnGgX7q3gpau+pOGXUMKskVXPuLLppj8q8xgTCxpQkG5p0tMxiPo/
 8/pF3fC+zaVcMxzW9/5nkb7ZNnLR0uClCt8FcrQNyRmX+uJGhyJE372MoMAtj9OzcYd1Ob
 6BhyBHTuTpCN+h8yDInTpaxkRRBcXHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697540884;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3NWu8Ctkh2TRLgmNewbtrKwGeOq7W7dWd5W8N6C/g9s=;
 b=+vTuqO89eaBDb02DvM5/AuIyhmD/RRNoN6eryhAypomD5hXELYoH8cvYxvGDOMN6u+0Cer
 PSZSNPCqiASYt3Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9794813584;
 Tue, 17 Oct 2023 11:08:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8Qe0IxRrLmVfJgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 17 Oct 2023 11:08:04 +0000
Date: Tue, 17 Oct 2023 13:08:40 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZS5rOMFkG-znhXMf@yuki>
References: <20231012112548.6887-1-wegao@suse.com>
 <20231014033104.31424-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231014033104.31424-1-wegao@suse.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.60 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add test for UI_GET_NAME ioctl
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
> Fix:#573
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/input/input_helper.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/input/input_helper.c b/testcases/kernel/input/input_helper.c
> index 09530fb4d..b9dc50a7f 100644
> --- a/testcases/kernel/input/input_helper.c
> +++ b/testcases/kernel/input/input_helper.c
> @@ -32,6 +32,7 @@
>  
>  static int uinput_loaded;
>  static int check_device(void);
> +static void check_ui_get_sysname_ioctl(int fd);

I do not think that this is needed, we do not call the function before
it's definition.

>  static int try_open_device(void)
>  {
> @@ -185,6 +186,22 @@ void send_rel_move(int fd, int x, int y)
>  	send_event(fd, EV_SYN, 0, 0);
>  }
>  
> +static void check_ui_get_sysname_ioctl(int fd)
> +{
> +	char sys_name[256];
> +	char dev_name[256];
> +	char *path;
> +
> +	SAFE_IOCTL(NULL, fd, UI_GET_SYSNAME(sizeof(sys_name)), sys_name, NULL);
> +	SAFE_ASPRINTF(NULL, &path, "/sys/devices/virtual/input/%s/name", sys_name);
> +	SAFE_FILE_SCANF(NULL, path, "%s", dev_name);

I would be inclined to use the FILE_SCANF() instead here and report
failure if the file does not exist or couldn't be read, something as:

	if (FILE_SCANF(NULL, path, "%s", dev_name)) {
		tst_res(TFAIL, "Failed to read name from the sysfs path");
		free(path);
		return;
	}

> +	if (strcmp(VIRTUAL_DEVICE, dev_name)) {
> +		tst_brkm(TBROK, NULL, "Unable to find the input device through ioctl");
> +	}

I do not think that tst_brkm() is the right here either, this is simple
TPASS/TFAIL situation. Can we just print TPASS/TFAIL based on if these
names match?

> +	free(path);
> +}
> +
>  void create_device(int fd)
>  {
>  	int nb;
> @@ -202,8 +219,10 @@ void create_device(int fd)
>  	SAFE_IOCTL(NULL, fd, UI_DEV_CREATE, NULL);
>  
>  	for (nb = 100; nb > 0; nb--) {
> -		if (check_device())
> +		if (check_device()) {
> +			check_ui_get_sysname_ioctl(fd);
>  			return;
> +		}
>  		usleep(10000);
>  	}
>  
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
