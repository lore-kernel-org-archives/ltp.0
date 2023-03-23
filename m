Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF2FC6FD1C
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 08:52:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A41C3CCA5F
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 09:52:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4E933C0214
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 09:52:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4884A600629
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 09:52:18 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2F4B133B63;
 Thu, 23 Mar 2023 08:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679561538;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HNuEYjjNoancLZy01U8FS/ydxJE4fCfMj7fbKz+pSGM=;
 b=vnq7GuwV8250Y5bA3mUQnZTPVayE8jBNKmBM/nV+ECJKMFAiFb+URISzTZ/rOMa4HNnuxc
 QYig+VAliDxHWq0bNzQb7ulGDUyHZ5CMWX2SKw9JwozIrzz3dl6LJvLsnEb6+j/SaiPgSX
 VEt49pJu1us9vtkUsMxngO1kmBbAux4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679561538;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HNuEYjjNoancLZy01U8FS/ydxJE4fCfMj7fbKz+pSGM=;
 b=xZtsUS5PFHrE85Bq4jiRKO6qx3tLHemVvtdFXjfKHb4FXEPUMB8s0FebI7wWeaA+wjmIYW
 Y4RCLQhmqs9627Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 08C6C13596;
 Thu, 23 Mar 2023 08:52:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JeDCAEITHGRaMgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 23 Mar 2023 08:52:18 +0000
Date: Thu, 23 Mar 2023 09:52:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <20230323085216.GC405493@pevik>
References: <20230320235108.2058967-1-edliaw@google.com>
 <20230320235108.2058967-3-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230320235108.2058967-3-edliaw@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] set_dev_loop_path: Refactor set_dev_path
 and check return value
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
Cc: kernel-team@android.com,
 Alessandro Carminati <alessandro.carminati@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edward,

> tst_find_free_loopdev does not check the return value of set_dev_path
> and will return the last attempted path even if it does not pass a stat
> check.  set_dev_path also has a return value that is not consistent with
> the other functions in this file.

This change and change of return is a bit burden in loop rename changes.
I'm ok it's in single patch, but it'd be more readable if it were separate.

> Renames the function to set_dev_loop_path, the const array to
> dev_loop_variants and changes the return value to 0 on success and 1 on
> failure.  Check the return value when called in tst_find_free_loopdev
> for failure to acquire a loop device.

> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  lib/tst_device.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index a61c5a748..ae665f7b6 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -54,25 +54,25 @@ static char dev_path[PATH_MAX];
>  static int device_acquired;
>  static unsigned long prev_dev_sec_write;

> -static const char *dev_variants[] = {
> +static const char *dev_loop_variants[] = {
>  	"/dev/loop%i",
>  	"/dev/loop/%i",
>  	"/dev/block/loop%i"
>  };

> -static int set_dev_path(int dev, char *path, size_t path_len)
> +static int set_dev_loop_path(int dev, char *path, size_t path_len)
>  {
>  	unsigned int i;
>  	struct stat st;

> -	for (i = 0; i < ARRAY_SIZE(dev_variants); i++) {
> -		snprintf(path, path_len, dev_variants[i], dev);
> +	for (i = 0; i < ARRAY_SIZE(dev_loop_variants); i++) {
> +		snprintf(path, path_len, dev_loop_variants[i], dev);

>  		if (stat(path, &st) == 0 && S_ISBLK(st.st_mode))
> -			return 1;
> +			return 0;
>  	}

> -	return 0;
> +	return 1;
>  }

>  int tst_find_free_loopdev(char *path, size_t path_len)
> @@ -88,8 +88,8 @@ int tst_find_free_loopdev(char *path, size_t path_len)
>  		rc = ioctl(ctl_fd, LOOP_CTL_GET_FREE);
>  		close(ctl_fd);
>  		if (rc >= 0) {
> -			if (path)
> -				set_dev_path(rc, path, path_len);
> +			if (!path || set_dev_loop_path(rc, path, path_len) != 0)
> +				tst_brkm(TBROK, NULL, "Could not stat loop device %i", rc);

set_dev_path() is going to be called only if non-NULL path
(see include/tst_device.h). I haven't found a test which uses it this way,
but shouldn't it be checking path, instead of !path?

	if (path && set_dev_loop_path(rc, path, path_len) != 0)

Kind regards,
Petr

>  			tst_resm(TINFO, "Found free device %d '%s'",
>  				rc, path ?: "");
>  			return rc;
> @@ -116,7 +116,7 @@ int tst_find_free_loopdev(char *path, size_t path_len)
>  	 */
>  	for (i = 0; i < 256; i++) {

> -		if (!set_dev_path(i, buf, sizeof(buf)))
> +		if (set_dev_loop_path(i, buf, sizeof(buf)) != 0)
>  			continue;

>  		dev_fd = open(buf, O_RDONLY);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
