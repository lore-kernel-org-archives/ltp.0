Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5573B606A880
	for <ltp@archiver.kernel.org>; Thu, 12 Nov 2026 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=QDZCEfvh;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DKELQ97k;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=p8/vg7dx;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XRtJ84f2
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 973713EAB25
	for <ltp@archiver.kernel.org>; Thu, 12 Nov 2026 14:05:25 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0A903CF0EF
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 14:05:09 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2476310006B7
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 14:05:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1B6281F82F;
 Thu, 12 Nov 2026 13:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794488708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3NTUua7sdLS7xvBuzHwXGjovkncmGi4VZ0Nhpcg6BG8=;
 b=QDZCEfvhXQiSPVNe3IJ0ikbs55HzyYBndLmrINKpmXikhkZkzGhnqBJizjo5ji1jqMQRWB
 sVfCpnz0odvaqy88hduTw6Z+uxNGyyhfV+lpJKt9D3IXIdMauh4shcko7SBF+LTCGyw4Ym
 nfdBxjfmbQOnUN1JEikyhjRbinjiG3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794488708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3NTUua7sdLS7xvBuzHwXGjovkncmGi4VZ0Nhpcg6BG8=;
 b=DKELQ97k9OL0jn9I51klkaR+VGTD8D99vPm6yQksICx84ooCumX5u3bIoc9IAjtIUDZMWV
 CqEFgwey3sSO6tCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="p8/vg7dx";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XRtJ84f2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794488707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3NTUua7sdLS7xvBuzHwXGjovkncmGi4VZ0Nhpcg6BG8=;
 b=p8/vg7dxm23Th+6YpLwQ4l1MfNUQGYTw6E1n4yapqP+LzNWoFbApNnx8N3VY+3D5yJQOdd
 yGGURcBxw7N096X4ViLa6ymx0Z9U34e6A0Uyiq7cSS2CdLdkndKCT8VE+u6ercEaFpUEoY
 qzgfshSDEkl1HfcHLtFhBdtd3W0zmuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794488707;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3NTUua7sdLS7xvBuzHwXGjovkncmGi4VZ0Nhpcg6BG8=;
 b=XRtJ84f2f2eI3xyhvRgWOaIOBXswK0Cil30Bn0TOvPrRi0iLRYjcuona5nls1D05+fsGZ1
 QN6lfpgZs1LOqZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3C90134F4;
 Thu, 12 Nov 2026 13:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IQpcLoK59WobagAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 12 Nov 2026 13:05:06 +0000
Date: Thu, 12 Nov 2026 14:05:33 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <avW5nQPbSJxRGzgJ@yuki.lan>
References: <20261102022245.3922-1-wegao@suse.com>
 <20261102022245.3922-2-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261102022245.3922-2-wegao@suse.com>
X-Rspamd-Queue-Id: 1B6281F82F
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -13.51
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v18 1/3] lib: Add tst_attach_loopdev()
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
> Calling tst_find_free_loopdev() followed by tst_attach_device() has
> a race window where another process can claim the loop device before
> LOOP_SET_FD is issued, causing attachment to fail with EBUSY.
> 
> Introduce tst_attach_loopdev() which finds an unused loop device and
> attaches a backing file to it, retrying the lookup with exponential
> backoff if the candidate device is claimed concurrently (EBUSY). In
> addition, only populate the caller's device path buffer on successful
> attachment, and clear it on failure to prevent accidental cleanup of
> unattached devices.
> 
> Update tst_acquire_loop_device() to use tst_attach_loopdev().
> 
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
> v17->v18:
> - New patch in v18.
> 
>  include/tst_device.h | 13 +++++++
>  lib/tst_device.c     | 87 ++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 92 insertions(+), 8 deletions(-)
> 
> diff --git a/include/tst_device.h b/include/tst_device.h
> index 0989e4501..2e7dadd59 100644
> --- a/include/tst_device.h
> +++ b/include/tst_device.h
> @@ -110,6 +110,19 @@ int tst_find_free_loopdev(char *path, size_t path_len);
>   */
>  int tst_attach_device(const char *dev_path, const char *file_path);
>  
> +/**
> + * tst_attach_loopdev() - Find a free loop device and attach a file to it.
> + * @dev_path: If non-NULL, buffer filled with the attached loop device path.
> + * @dev_path_len: Size of @dev_path buffer.
> + * @file_path: Path to a file (e.g. disk.img).
> + *
> + * Finds an unused loop device and attaches @file_path to it, automatically
> + * retrying the lookup if the chosen device is claimed concurrently (EBUSY).
> + *
> + * Return: Zero on success, non-zero otherwise.
> + */
> +int tst_attach_loopdev(char *dev_path, size_t dev_path_len, const char *file_path);
> +
>  /**
>   * tst_get_device_size() - Get device size in megabytes.
>   * @dev_path: Device path.
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index 00304711b..199c14059 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -156,7 +156,7 @@ int tst_find_free_loopdev(char *path, size_t path_len)
>  	return -1;
>  }
>  
> -int tst_attach_device(const char *dev, const char *file)
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
> +
> +		if (warn_on_ebusy || errno != EBUSY) {
> +			tst_resm(TWARN | TERRNO, "ioctl(%s, LOOP_SET_FD, %s) failed",
> +				 dev, file);
> +		}
>  		return 1;
>  	}
>  
> @@ -207,6 +214,73 @@ int tst_attach_device(const char *dev, const char *file)
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
> +int tst_attach_loopdev(char *dev_path, size_t dev_path_len, const char *file)
> +{
> +	char dev[PATH_MAX];
> +	unsigned int delay = 1;
> +	unsigned int max_delay = tst_multiply_timeout(1000000);
> +	int ret, fd;
> +
> +	if (strlen(file) >= LO_NAME_SIZE) {
> +		tst_brkm(TBROK, NULL, "Device name can't be longer than %u chars",
> +			 LO_NAME_SIZE);
> +	}
> +
> +	fd = open(file, O_RDWR);
> +	if (fd < 0) {
> +		tst_resm(TWARN | TERRNO, "open('%s', O_RDWR) failed", file);
> +		goto fail;
> +	}
> +	close(fd);

I would drop this part, it's making the API ugly. The attach loopdev
should ideally just take the file name as an parameter and return newly
allocated string with the path to the device it was attached to or NULL
in a case of a failure so that we can call it as:

	dev = tst_attach_loopdev(file);
	if (!dev)
		tst_brk();

Or even have:
	dev = SAFE_ATTACH_LOOPDEV(file);

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
> +	if (ret == 0) {
> +		if (dev_path && dev_path_len) {
> +			strncpy(dev_path, dev, dev_path_len);
> +			dev_path[dev_path_len - 1] = '\0';
> +		}
> +		return 0;
> +	}
> +
> +fail:
> +	if (dev_path && dev_path_len)
> +		dev_path[0] = '\0';
> +
> +	return 1;
> +}
> +
>  uint64_t tst_get_device_size(const char *dev_path)
>  {
>  	int fd;
> @@ -390,10 +464,7 @@ const char *tst_acquire_loop_device(unsigned int size, const char *filename)
>  		return NULL;
>  	}
>  
> -	if (tst_find_free_loopdev(dev_path, sizeof(dev_path)) == -1)
> -		return NULL;
> -
> -	if (tst_attach_device(dev_path, filename))
> +	if (tst_attach_loopdev(dev_path, sizeof(dev_path), filename))
>  		return NULL;
>  
>  	return dev_path;
> -- 
> 2.55.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
