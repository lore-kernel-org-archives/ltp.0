Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FCA606A323
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=bhx9YwIE;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HlFouv25;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=SJk14HWF;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=l+L/jnL+
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B82E3D23FD
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 12:29:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 448493C2EA3
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 12:28:50 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1BB0B1400168
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 12:28:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DD92F221AF;
 Fri, 30 Oct 2026 11:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793359728;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e3fzFRqHMgg9duHkUv8pZoD4u3zJTp5FNp8Kr3DA7b0=;
 b=bhx9YwIExzB/+kNXsOKdkHEtEU3LIBtPgpnpDnw0VR/Bnh3KsIbFtaLcmgp26UkqbGZH+H
 mXNcPajDnLU8oaEALT6SJZ7wPp4FcDL8ukFF7vIsv2L/XloIRmu/frurYKHFmljTVrsOOn
 qwa2Q2eM/gYWfEDbXiAg/cQmjqvHYgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793359728;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e3fzFRqHMgg9duHkUv8pZoD4u3zJTp5FNp8Kr3DA7b0=;
 b=HlFouv25X3QQTdUBYnG5/tvYWrLSZkbgfi5t31l/NBzTQU8IBgBO9+w9D64KHUxJNBIpBV
 fp4Q7M6/nvi5JDAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SJk14HWF;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="l+L/jnL+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793359727;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e3fzFRqHMgg9duHkUv8pZoD4u3zJTp5FNp8Kr3DA7b0=;
 b=SJk14HWFDyAhgX4LkHG9FoM/B084b66CKpTS5TjluBna0dQtTy9n6CprNh25tOhcuJ7a71
 nqnlawlxKBZbylshsqmZPEvwDXmeDJk0rI/wSz4Zt/SqjcKQR6EGROivkQkMt16dvDkwfb
 eMfEYc+Ruj+ZEQg/ZEWgc+lXx8x3Ge4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793359727;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e3fzFRqHMgg9duHkUv8pZoD4u3zJTp5FNp8Kr3DA7b0=;
 b=l+L/jnL+0AHbqbGvm4hkNg37BL9MobTwdsVWUGkREd+buPKFxWkGrOUOxvdo64GF/y3rJ7
 e8FNH0iaXXz+HZAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A739132C9;
 Fri, 30 Oct 2026 11:28:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CI/cHG9/5GpbWwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 30 Oct 2026 11:28:47 +0000
Date: Fri, 30 Oct 2026 12:28:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Message-ID: <20261030112846.GA68558@pevik>
References: <20261022115410.23845-1-sebastian.chlad@suse.com>
 <20261027142747.19192-1-sebastianchlad@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261027142747.19192-1-sebastianchlad@gmail.com>
X-Spamd-Result: default: False [-12.71 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FREEMAIL_TO(0.00)[gmail.com];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -12.71
X-Spam-Level: 
X-Rspamd-Queue-Id: DD92F221AF
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: tst_device: Use exponential backoff for
 loop device detach
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Seba,

> detach_loop_fd() retries LOOP_CLR_FD 40 times in 50ms steps, a fixed
> 2s timeout that ignores LTP_TIMEOUT_MUL. When another process still
> holds the loop device at cleanup for longer than that, e.g. on a
> loaded machine, the test ends with an unwanted
> "ioctl(/dev/loopN, LOOP_CLR_FD, 0) no ENXIO for too long" TWARN.

> Use TST_RETRY_FN_EXP_BACKOFF() instead, as attach already does since
> d90d20046 ("lib: Use backoff polling to wait for loop device nodes").
> The detach finishes quickly when the device is released right away,
> polling slows down when it is not, and the total timeout (about 2s by
> default) is scaled by tst_multiply_timeout().

Out of curiosity, which of ioctl test is affected by this on a slow worker?
Baremetal issue?

BTW ioctl_loop01 is not working with -i (not caused by this patch):

# ./testcases/kernel/syscalls/ioctl/ioctl_loop01
...
tst_buffers.c:57: TINFO: Test is using guarded buffers
ioctl_loop01.c:82: TPASS: /sys/block/loop0/loop/partscan = 0
ioctl_loop01.c:83: TPASS: /sys/block/loop0/loop/autoclear = 0
ioctl_loop01.c:84: TPASS: /sys/block/loop0/loop/backing_file = '/tmp/LTP_iocMhKZxH/test.img'
ioctl_loop01.c:57: TPASS: get expected lo_flag 12
ioctl_loop01.c:59: TPASS: /sys/block/loop0/loop/partscan = 1
ioctl_loop01.c:60: TPASS: /sys/block/loop0/loop/autoclear = 1
ioctl_loop01.c:69: TPASS: access /dev/loop0p1 succeeds
ioctl_loop01.c:75: TPASS: access /sys/block/loop0/loop0p1 succeeds
ioctl_loop01.c:90: TINFO: Test flag can be clear
ioctl_loop01.c:57: TPASS: get expected lo_flag 8
ioctl_loop01.c:59: TPASS: /sys/block/loop0/loop/partscan = 1
ioctl_loop01.c:60: TPASS: /sys/block/loop0/loop/autoclear = 0
ioctl_loop01.c:69: TPASS: access /dev/loop0p1 succeeds
ioctl_loop01.c:75: TPASS: access /sys/block/loop0/loop0p1 succeeds
ioctl_loop01.c:82: TBROK: Failed to open FILE '/sys/block/loop0/loop/partscan' for reading: ENOENT (2)

> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Sebastian Chlad <sebastianchlad@gmail.com>
> ---
> Changes in v2:
> - Use TST_RETRY_FN_EXP_BACKOFF() instead of scaling the retry count
>   with tst_multiply_timeout() (Cyril).
> - Link to v1:
>   https://lore.kernel.org/ltp/20261022115410.23845-1-sebastian.chlad@suse.com/

>  lib/tst_device.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)

> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index 00304711b..bf77c9ded 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -249,9 +249,14 @@ uint64_t tst_get_device_size(const char *dev_path)
>  	return size/1024/1024;
>  }

> +static int loop_clr_fd_busy(int dev_fd)
> +{
> +	return !ioctl(dev_fd, LOOP_CLR_FD, 0) || errno == EBUSY;
> +}
> +
>  static int detach_loop_fd(const char *dev, int *dev_fd)
>  {
> -	int ret, i, retval = 1;
> +	int ret, retval = 1;

>  	/* keep trying to clear LOOPDEV until we get ENXIO, a quick succession
>  	 * of attach/detach might not give udev enough time to complete
> @@ -259,22 +264,19 @@ static int detach_loop_fd(const char *dev, int *dev_fd)
>  	 * Since 18048c1af783 ("loop: Fix a race between loop detach and loop open")
>  	 * device is detached only after last close.
>  	 */
> -	for (i = 0; i < 40; i++) {
> -		ret = ioctl(*dev_fd, LOOP_CLR_FD, 0);
> +	ret = TST_RETRY_FN_EXP_BACKOFF(loop_clr_fd_busy(*dev_fd),
> +				       TST_RETVAL_EQ0, 2);

> -		if (ret && (errno == ENXIO)) {
> -			retval = 0;
> -			goto exit;
> -		}
> -
> -		if (ret && (errno != EBUSY)) {
> -			tst_resm(TWARN,
> -				 "ioctl(%s, LOOP_CLR_FD, 0) unexpectedly failed with: %s",
> -				 dev, tst_strerrno(errno));
> -			goto exit;
> -		}
> +	if (!ret && (errno == ENXIO)) {
> +		retval = 0;
> +		goto exit;
> +	}

> -		usleep(50000);
> +	if (!ret) {
> +		tst_resm(TWARN,
> +			 "ioctl(%s, LOOP_CLR_FD, 0) unexpectedly failed with: %s",
> +			 dev, tst_strerrno(errno));

nit: While you at it, could you change to use TERRNO?

		tst_resm(TWARN | TERRNO,
			 "ioctl(%s, LOOP_CLR_FD, 0) failed, dev);

But maybe it can be done as an separate effort (there are more tst_strerrno()
calls).

The rest LGTM. Thanks!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +		goto exit;
>  	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
