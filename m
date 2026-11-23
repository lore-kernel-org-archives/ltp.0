Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF16606A31E
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=HjRcHgd6;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tErH92li;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=QFyAfwTB;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dWivYxwO
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8B813E98DB
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 11:51:35 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC3113E9167
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 11:51:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0BF1D1A007EB
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 11:51:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D32271F445;
 Mon, 23 Nov 2026 10:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795431077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E7tvw/xYBRHMikeDh9C8t/UCkLxHfRKtopcr9NO+H+8=;
 b=HjRcHgd6QuZhWlkW8GxxpVJdWtFKcIUhMgTJ3CkQZHZAiVb4TyvniOEsE/3qmOuqVMHdrS
 MHkHt7Ur1S+C23h02osXDsklWPfZg2v350ABUHMIhHaoeE2CF+PnFUqPpAmJlmiktDSB+0
 +n5B7RJBrCEEEZFFURJCgrhb4lShT7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795431077;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E7tvw/xYBRHMikeDh9C8t/UCkLxHfRKtopcr9NO+H+8=;
 b=tErH92li2D33Jl/SBc3NVk4hR4t9/qq2XPGJUWExYRxbGyrvLJT1K7vhy3y3Q+Iq/UkNun
 u43Iu22lWzEb4hBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795431076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E7tvw/xYBRHMikeDh9C8t/UCkLxHfRKtopcr9NO+H+8=;
 b=QFyAfwTB0NRgj33OfOLBjteajga0yudd++5YldzuPz0ggEqra3ah5JrrY4LMch3P0tVqMN
 hUVoK/hvoFVVnm6myv2KC6L8fI2e9i4csd4hyPMfu51s1fULu8P3esKio/l3435xr4ARgn
 h6oiI/NCo8ia1WReWOMmkr7Wm/N1pMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795431076;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E7tvw/xYBRHMikeDh9C8t/UCkLxHfRKtopcr9NO+H+8=;
 b=dWivYxwOeFRvCfz/9mGk0aKTnC8I7EIg1B1mHMLlz+u0izUuyp3UDKy8S1NKWBs6AJmzjA
 G3puH6K4ofIhDhAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4D4513510;
 Mon, 23 Nov 2026 10:51:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6jF1H6QaBGt8dwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 23 Nov 2026 10:51:16 +0000
Date: Mon, 23 Nov 2026 11:51:42 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <awQavtEBYYht-HIP@yuki.lan>
References: <20261116085612.20171-1-wegao@suse.com>
 <20261116085612.20171-2-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261116085612.20171-2-wegao@suse.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v19 1/3] lib: Add tst_attach_loopdev()
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +static int attach_device(const char *dev, const char *file, int warn_on_ebusy)
>  {
>  	int dev_fd, file_fd;
>  	struct loop_info loopinfo;
> @@ -168,7 +168,8 @@ int tst_attach_device(const char *dev, const char *file)
>  
>  	dev_fd = TST_RETRY_FN_EXP_BACKOFF(open(dev, O_RDWR), TST_RETVAL_GE0, 1);
>  	if (dev_fd < 0) {
> -		tst_resm(TWARN | TERRNO, "open('%s', O_RDWR) failed", dev);
> +		if (warn_on_ebusy || errno != EBUSY)
> +			tst_resm(TWARN | TERRNO, "open('%s', O_RDWR) failed", dev);
>  		return 1;
>  	}
>  
> @@ -180,10 +181,16 @@ int tst_attach_device(const char *dev, const char *file)
>  	}
>  
>  	if (ioctl(dev_fd, LOOP_SET_FD, file_fd) < 0) {
> +		int err = errno;
> +
>  		close(dev_fd);
>  		close(file_fd);
> -		tst_resm(TWARN | TERRNO, "ioctl(%s, LOOP_SET_FD, %s) failed",
> -			 dev, file);
> +		errno = err;

This errno needs to be restored right before the return, the tst_resm()
still may clobber the errno.

> +		if (warn_on_ebusy || errno != EBUSY) {
> +			tst_resm(TWARN | TERRNO, "ioctl(%s, LOOP_SET_FD, %s) failed",
> +				 dev, file);
> +		}
>  		return 1;
>  	}
>  
> @@ -207,6 +214,64 @@ int tst_attach_device(const char *dev, const char *file)
>  	return 0;
>  }
>  
> +int tst_attach_device(const char *dev, const char *file)
> +{
> +	return attach_device(dev, file, 1);
> +}
> +
> +static int attach_loopdev(char *dev, size_t dev_len, const char *file)
> +{
> +	if (tst_find_free_loopdev(dev, dev_len) == -1)
> +		return -1;
> +
> +	if (attach_device(dev, file, 0) == 0)
> +		return 0;
> +
> +	if (errno == EBUSY)
> +		return 1;
> +
> +	return -1;
> +}
> +
> +char *tst_attach_loopdev(const char *file)
> +{
> +	char dev[PATH_MAX];
> +	unsigned int delay = 1;
> +	unsigned int max_delay = tst_multiply_timeout(1000000);
> +	int ret;
> +
> +	for (;;) {
> +		ret = attach_loopdev(dev, sizeof(dev), file);
> +		if (ret <= 0)
> +			break;
> +
> +		if (delay < max_delay) {
> +			usleep(delay);
> +			delay *= 2;
> +		} else {
> +			ret = -1;
> +			break;
> +		}
> +	}
> +
> +	if (ret == 0)
> +		return strdup(dev);

It's unlikely, but the strdup() can fail. So I guess this should be
at least TBROK on NULL.

> +	return NULL;
> +}
> +
> +char *safe_attach_loopdev(const char *file, const int lineno, const char *file_path)
> +{
> +	char *dev = tst_attach_loopdev(file_path);
> +
> +	if (!dev) {
> +		tst_brkm_(file, lineno, TBROK, NULL,
> +			  "Failed to attach %s to loop device", file_path);
> +	}
> +
> +	return dev;
> +}
> +
>  uint64_t tst_get_device_size(const char *dev_path)
>  {
>  	int fd;
> @@ -386,17 +451,20 @@ int tst_dev_sync(int fd)
>  const char *tst_acquire_loop_device(unsigned int size, const char *filename)
>  {
>  	unsigned int acq_dev_size = size ? size : DEV_SIZE_MB;
> +	char *dev;
>  
>  	if (tst_prealloc_file(filename, 1024 * 1024, acq_dev_size)) {
>  		tst_resm(TWARN | TERRNO, "Failed to create %s", filename);
>  		return NULL;
>  	}
>  
> -	if (tst_find_free_loopdev(dev_path, sizeof(dev_path)) == -1)
> +	dev = tst_attach_loopdev(filename);
> +	if (!dev)
>  		return NULL;
>  
> -	if (tst_attach_device(dev_path, filename))
> -		return NULL;
> +	strncpy(dev_path, dev, sizeof(dev_path) - 1);
> +	dev_path[sizeof(dev_path) - 1] = '\0';
> +	free(dev);

Given that we allocate the path now, we can drop the dev_path global and
just return the allocated string instead.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
