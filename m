Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588EEC433EF
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 11:50:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B06103C9858
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 12:50:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABB673C9826
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 12:50:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7DAD41000608
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 12:50:41 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A0AE6212B5;
 Tue,  1 Feb 2022 11:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643716240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F4IUvMxmH1E4J/8c9by4aai2xn9pOO1Pvpgr/rsG/B0=;
 b=bAgJraM3WIozPkxWnCW62GxGjsNwD2N8LPP+m3ryQByZATWVuEDIclYqxhaiKlzF2R6oIf
 YMJAIOq7equx4Os6izNqIH3Fd+7gEeS4JFaWzyLA0sFCtFEI+OLBXJMkh/Z8F0mDUfsJ2R
 PXLhr9SdLSARCR4SZJfi8BCl1TYMyQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643716240;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F4IUvMxmH1E4J/8c9by4aai2xn9pOO1Pvpgr/rsG/B0=;
 b=OW5E5R2aI/QR6C6l7y6nRhPHWyQssTZzYfkMn3WF7aDwi48vbEYVbKbTQNaCf4hYmjIE25
 7/XSxal2sDkkixCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8CADB13D54;
 Tue,  1 Feb 2022 11:50:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OMXaIJAe+WFWPAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 01 Feb 2022 11:50:40 +0000
Date: Tue, 1 Feb 2022 12:52:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YfkfA+DNsKsVuu7h@yuki>
References: <20220114145227.12707-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220114145227.12707-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add tst_dev_block_size utility
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
> +[source,c]
> +-------------------------------------------------------------------------------
> +#include "tst_test.h"
> +
> +int tst_dev_block_size(const char *path);
> +-------------------------------------------------------------------------------
> +
> +This function returns the size of a single IO block for the specific `path`.
                                        ^
					physical device block size for
					the specific `path`
> +It finds the device where `path` is located and then uses `ioctl` to get a
                                                                   ^
								   Maybe
								   we
								   should
								   add
								   here
								   the
								   ioctl
								   constant
								   i.e.
								   BLKSSZGET
> +single device block size.
   ^
   physical
> +
>  1.16 Formatting a device with a filesystem
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> diff --git a/include/tst_device.h b/include/tst_device.h
> index 72c560c02..bf0fb5320 100644
> --- a/include/tst_device.h
> +++ b/include/tst_device.h
> @@ -112,4 +112,11 @@ void tst_purge_dir(const char *path);
>   */
>  void tst_find_backing_dev(const char *path, char *dev);
>  
> +/*
> + * Returns the size of a single IO block for the specific path
                               ^
			       physical device block size for ...
> + * @path   Path to find the block size
> + * @return Size of the block size
> + */
> +int tst_dev_block_size(const char *path);
> +
>  #endif	/* TST_DEVICE_H__ */
> diff --git a/lib/newlib_tests/tst_device.c b/lib/newlib_tests/tst_device.c
> index 0bee0a939..3f9a43576 100644
> --- a/lib/newlib_tests/tst_device.c
> +++ b/lib/newlib_tests/tst_device.c
> @@ -1,47 +1,103 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2016 Linux Test Project
> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>   */
> +#define _GNU_SOURCE
>  
>  #include <stdlib.h>
>  #include <sys/mount.h>
>  #include <stdint.h>
> +#include <stdio.h>
> +#include <lapi/loop.h>
> +#include <time.h>
>  
>  #include "tst_test.h"
>  
> -static void do_test(void)
> +#define PAGESIZE 2048
            ^
	    Huh?

The usuall PAGESIZE is 4k, then there are architecture with (optional)
64k pages, but I doubt that I have seen anything with 2k PAGESIZE.

This should have been named DEVBLOCKSIZE instead, naming it PAGESIZE
makes it utterly confusing.

> +#define DEV_MIN_SIZE 300
> +
> +static char *mntpoint;
> +static uint64_t ltp_dev_size;
> +
> +static void setup(void)
>  {
>  	int fd;
> -	const char *dev;
> -	char block_dev[100];
> -	uint64_t ltp_dev_size;
> +	int ret;
>  
> -	dev = tst_device->dev;
> -	if (!dev)
> -		tst_brk(TCONF, "Failed to acquire test device");
> +	ret = asprintf(&mntpoint, "%s/mnt", tst_get_tmpdir());
> +	if (ret < 0)
> +		tst_brk(TBROK, "asprintf failure");
>  
> -	SAFE_MKFS(dev, "ext2", NULL, NULL);
> +	while ((fd = SAFE_OPEN(tst_device->dev, O_RDONLY, 0666)) < 0)
> +		usleep(100);

Why the loop here?

It does not make any sense especially since you call SAFE_OPEN() that
cannot fail.

> -	fd = SAFE_OPEN(dev, O_RDONLY);
>  	SAFE_IOCTL(fd, BLKGETSIZE64, &ltp_dev_size);
> +	SAFE_IOCTL(fd, LOOP_SET_BLOCK_SIZE, PAGESIZE);
>  	SAFE_CLOSE(fd);
>  
> -	if (ltp_dev_size/1024/1024 == 300)
> -		tst_res(TPASS, "Got expected device size");
> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
> +
> +	SAFE_MKDIR(mntpoint, 0777);
> +	SAFE_MOUNT(tst_device->dev, mntpoint, tst_device->fs_type, 0, 0);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (tst_is_mounted(mntpoint))
> +		SAFE_UMOUNT(mntpoint);
> +}
> +
> +static void test_dev_min_size(void)
> +{
> +	uint64_t size;
> +
> +	size = ltp_dev_size / 1024 / 1024;
> +
> +	if (size == DEV_MIN_SIZE)
> +		tst_res(TPASS, "Got expected device size %lu", size);
> +	else
> +		tst_res(TFAIL, "Expected device size is %d but got %lu", DEV_MIN_SIZE, size);
> +}
> +
> +static void test_tst_find_backing_dev(void)
> +{
> +	char block_dev[100];
> +
> +	tst_find_backing_dev(mntpoint, block_dev);
> +
> +	if (!strcmp(tst_device->dev, block_dev))
> +		tst_res(TPASS, "%s belongs to %s block dev", mntpoint, block_dev);
>  	else
> -		tst_res(TFAIL, "Got unexpected device size");
> -
> -	tst_find_backing_dev("/boot", block_dev);
> -	tst_res(TPASS, "/boot belongs to %s block dev", block_dev);
> -	tst_find_backing_dev("/", block_dev);
> -	tst_res(TPASS, "/ belongs to %s block dev", block_dev);
> -	tst_find_backing_dev("/tmp", block_dev);
> -	tst_find_backing_dev("/boot/xuyang", block_dev);
> +		tst_res(TFAIL, "%s should belong to %s, but %s is returned", mntpoint, tst_device->dev, block_dev);
> +}
> +
> +static void test_tst_dev_block_size(void)
> +{
> +	int block_size;
> +
> +	block_size = tst_dev_block_size(mntpoint);
> +
> +	if (block_size == PAGESIZE)
> +		tst_res(TPASS, "%s has %d block size", mntpoint, block_size);
> +	else
> +		tst_res(TFAIL, "%s has %d block size, but expected is %i", mntpoint, block_size, PAGESIZE);
> +}
> +
> +static void do_test(void)
> +{
> +	test_dev_min_size();
> +	test_tst_find_backing_dev();
> +	test_tst_dev_block_size();
>  }
>  
>  static struct tst_test test = {
>  	.needs_root = 1,
>  	.needs_device = 1,
> -	.dev_min_size = 300,
> +	.needs_tmpdir = 1,
> +	.dev_min_size = DEV_MIN_SIZE,
>  	.test_all = do_test,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.min_kver = "4.14",
>  };
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index 73e70d26e..1ef667fa0 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -547,3 +547,18 @@ void tst_find_backing_dev(const char *path, char *dev)
>  	if (S_ISBLK(buf.st_mode) != 1)
>  		tst_brkm(TCONF, NULL, "dev(%s) isn't a block dev", dev);
>  }
> +
> +int tst_dev_block_size(const char *path)
> +{
> +	int fd;
> +	int size;
> +	char dev_name[1024];
> +
> +	tst_find_backing_dev(path, dev_name);
> +
> +	fd = SAFE_OPEN(NULL, dev_name, O_RDONLY);
> +	SAFE_IOCTL(NULL, fd, BLKSSZGET, &size);
> +	SAFE_CLOSE(NULL, fd);
> +
> +	return size;
> +}

I guess that it would make sense to add tst_dev_block_size_fd(int fd)
that would do the same but for a file descriptor later on, but apart
from the minor things the patch looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
