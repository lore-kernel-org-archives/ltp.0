Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1BDC6FD1D
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 15:25:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E28AC3CCBB0
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 17:25:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 597853C53E3
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 17:25:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7134E60086C
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 17:25:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1ED151FDF5;
 Mon, 27 Mar 2023 15:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679930700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4w+xWDPijQOiE26joS+0aa6Aec5sIYYvJuLHgu3dR9s=;
 b=GfP26xsX73b9jJOyZnBAvykH26ujnKQs5DJewOfn/YboyfHpn9r3aOy2KmC/iSsbmTTImu
 ZJuLuJFA62tWNUZcQTPrJj9fJ5+wMm8cUG/ZoEX1wAwuR7QBP5u5HJkCSe0RVdjcApK6ke
 oYmN8BnXpywEn5dRlW+UkbWsv0mbHEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679930700;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4w+xWDPijQOiE26joS+0aa6Aec5sIYYvJuLHgu3dR9s=;
 b=LeReAhR2kHBRZE2gwRrAN6L51a1Cdx1ym/7wm0ZDOefHzSZ30qj9oyF6b5EGk08dqWaMGt
 11GxaWw+EPVQGHAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 095B613329;
 Mon, 27 Mar 2023 15:25:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mJg+Aky1IWSkNQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 27 Mar 2023 15:25:00 +0000
Date: Mon, 27 Mar 2023 17:26:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <ZCG1ktXb6w/oOXSI@yuki>
References: <20230324002441.987778-1-edliaw@google.com>
 <20230324002441.987778-5-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230324002441.987778-5-edliaw@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/4] tst_find_backing_dev: Also check
 /dev/block/ for backing device
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  -------------------------------------------------------------------------------
>  #include "tst_test.h"
>  
> -void tst_find_backing_dev(const char *path, char *dev);
> +void tst_find_backing_dev(const char *path, char *dev, size_t dev_len);
>  -------------------------------------------------------------------------------
>  
>  This function finds the block dev that this path belongs to, using uevent in sysfs.
> diff --git a/include/tst_device.h b/include/tst_device.h
> index 977427f1c..f0aff4473 100644
> --- a/include/tst_device.h
> +++ b/include/tst_device.h
> @@ -110,8 +110,9 @@ void tst_purge_dir(const char *path);
>   * Find the file or path belongs to which block dev
>   * @path  Path to find the backing dev
>   * @dev   The block dev
> + * @dev_len   The length of the dev string
>   */
> -void tst_find_backing_dev(const char *path, char *dev);
> +void tst_find_backing_dev(const char *path, char *dev, size_t dev_len);
                                                                  ^
This would be a bit better as dev_size since the common usage is that
strings have length and buffers have size.

>  /*
>   * Stat the device mounted on a given path.
> diff --git a/lib/newlib_tests/tst_device.c b/lib/newlib_tests/tst_device.c
> index 87cec3961..53099f9bc 100644
> --- a/lib/newlib_tests/tst_device.c
> +++ b/lib/newlib_tests/tst_device.c
> @@ -71,7 +71,7 @@ static void test_tst_find_backing_dev(void)
>  {
>  	char block_dev[100];
>  
> -	tst_find_backing_dev(mntpoint, block_dev);
> +	tst_find_backing_dev(mntpoint, block_dev, sizeof(block_dev));
>  
>  	if (!strcmp(tst_device->dev, block_dev))
>  		tst_res(TPASS, "%s belongs to %s block dev", mntpoint,
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index ba46b7613..74de307e7 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -60,6 +60,11 @@ static const char *dev_loop_variants[] = {
>  	"/dev/block/loop%i"
>  };
>  
> +static const char *dev_variants[] = {
> +	"/dev/%s",
> +	"/dev/block/%s"
> +};
> +
>  static int set_dev_loop_path(int dev, char *path, size_t path_len)
>  {
>  	unsigned int i;
> @@ -75,6 +80,21 @@ static int set_dev_loop_path(int dev, char *path, size_t path_len)
>  	return 1;
>  }
>  
> +static int set_dev_path(char *dev, char *path, size_t path_len)
> +{
> +	unsigned int i;
> +	struct stat st;
> +
> +	for (i = 0; i < ARRAY_SIZE(dev_variants); i++) {
> +		snprintf(path, path_len, dev_variants[i], dev);
> +
> +		if (stat(path, &st) == 0 && S_ISBLK(st.st_mode))
> +			return 0;
> +	}
> +
> +	return 1;
> +}
> +
>  int tst_find_free_loopdev(char *path, size_t path_len)
>  {
>  	int ctl_fd, dev_fd, rc, i;
> @@ -511,7 +531,7 @@ unsigned long tst_dev_bytes_written(const char *dev)
>  }
>  
>  __attribute__((nonnull))
> -void tst_find_backing_dev(const char *path, char *dev)
> +void tst_find_backing_dev(const char *path, char *dev, size_t dev_len)
>  {
>  	struct stat buf;
>  	struct btrfs_ioctl_fs_info_args args = {0};
> @@ -574,7 +594,7 @@ void tst_find_backing_dev(const char *path, char *dev)
>  			sprintf(uevent_path, "%s/%s/uevent",
>  				bdev_path, d->d_name);
>  		} else {
> -			tst_brkm(TBROK | TERRNO, NULL, "No backining device found while looking in %s.", bdev_path);
> +			tst_brkm(TBROK | TERRNO, NULL, "No backing device found while looking in %s.", bdev_path);
>  		}
>  
>  		if (SAFE_READDIR(NULL, dir))
> @@ -590,17 +610,12 @@ void tst_find_backing_dev(const char *path, char *dev)
>  	if (!access(uevent_path, R_OK)) {
>  		FILE_LINES_SCANF(NULL, uevent_path, "DEVNAME=%s", dev_name);
>  
> -		if (dev_name[0])
> -			sprintf(dev, "/dev/%s", dev_name);
> +		if (!dev_name[0] || set_dev_path(dev_name, dev, dev_len) != 0)
                                                                          ^
									  isn't
									  this
									  redundant?

These two are the only minor issues I've found in the patchset,
otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
