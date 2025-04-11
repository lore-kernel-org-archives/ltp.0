Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A591CC36010
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 08:38:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C8583CB5B0
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 10:38:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 44E983CB57F
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 10:38:21 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 40482600ADD
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 10:38:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BC9FB1F456;
 Fri, 11 Apr 2025 08:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744360699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oLxqtjFerjRV7lVofjUtOzVUSZtU5HCREkF11SwMHO8=;
 b=YSJD22gzKTQEMEhCvD+qoXWO4eCG0lUtGT0U8vzLpoZGHIvzBgPcyKDdC33oBNehmJ5Spz
 IcJ9bC9wS8OzhErafaBVDdf9RKlsFffeTxTXWlnzL50PpQou3b4VSQM6o/gsZSbeJMBVnz
 fSxJRCgG5shWCCBgMbFIS1vrhkpyZQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744360699;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oLxqtjFerjRV7lVofjUtOzVUSZtU5HCREkF11SwMHO8=;
 b=xLq5JRPvo+E1qJ/fylRya9Ehof5qudGEzKu0eB6twKgK4eiqE10ZvPwasZSJk4lxj1N7/I
 JLvX216PDBFuXQDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=l9mnginn;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NVYZP+mi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744360698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oLxqtjFerjRV7lVofjUtOzVUSZtU5HCREkF11SwMHO8=;
 b=l9mnginnNlBfL4rrawyKg07n7Q8PsCkqu0L/Bzpr+RfTyKx7FxbYzmjBc7bxUjfSe9qjVW
 yveVbiYYGAHIZltdz3AUZZlV6VCwi4Z1TW7VS+T7KrYgzKVpa5hCP1/AyKdOrvFe7qJyIE
 fInZD9GVQ5eLCFg9md7IetAbcs32LMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744360698;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oLxqtjFerjRV7lVofjUtOzVUSZtU5HCREkF11SwMHO8=;
 b=NVYZP+mikqKy2C1RlCYVRsCI3aOI1XgrGUqKMKQIw/sFi+XIXbBs/ZrjWBLDXt60DKRaMn
 t4szad4FK4aJryDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AEA1E136A4;
 Fri, 11 Apr 2025 08:38:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id X2VEKvrU+GdYFwAAD6G6ig
 (envelope-from <akumar@suse.de>); Fri, 11 Apr 2025 08:38:18 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Fri, 11 Apr 2025 10:38:18 +0200
Message-ID: <5894423.DvuYhMxLoT@thinkpad>
In-Reply-To: <20250314115848.173676-1-liwang@redhat.com>
References: <20250314023120.169820-1-liwang@redhat.com>
 <20250314115848.173676-1-liwang@redhat.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: BC9FB1F456
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; CTE_CASE(0.50)[];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, configure.ac:url]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] ioctl_loop06: update loopback block size
 validation
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
Cc: Luis Chamberlain <mcgrof@kernel.org>, Christoph Hellwig <hch@lst.de>,
 ltp@lists.linux.it, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Friday, March 14, 2025 12:58:48 PM CEST Li Wang wrote:
> The kernel commit 47dd6753 ("block/bdev: lift block size restrictions to 64k")
> now supports block sizes larger than PAGE_SIZE, with a new upper limit of
> BLK_MAX_BLOCK_SIZE (64K). But ioctl_loop06 still assumes that PAGE_SIZE is the
> maximum allowed block size, causing failures on newer kernels(>= 6.14):
> 
>   ioctl_loop06.c:74: TINFO: Using LOOP_SET_BLOCK_SIZE with arg > PAGE_SIZE
>   ioctl_loop06.c:57: TFAIL: Set block size succeed unexpectedly
>   ...
>   ioctl_loop06.c:74: TINFO: Using LOOP_CONFIGURE with block_size > PAGE_SIZE
>   ioctl_loop06.c:57: TFAIL: Set block size succeed unexpectedly
> 
> This patch updates ioctl_loop06 to use BLK_MAX_BLOCK_SIZE instead of PAGE_SIZE
> for block size validation.
> 
> And, dynamically sets bs based on BLK_MAX_BLOCK_SIZE, using 1024 bytes if it's
> below 1MB or scaling it otherwise. Ensures tst_fill_file() writes efficiently
> while maintaining compatibility across different kernel versions.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.de>

Tested-by: Avinesh Kumar <akumar@suse.de>

tst_tmpdir.c:316: TINFO: Using /tmp/LTP_iocxHZLn0 as tmpdir (tmpfs filesystem)
tst_test.c:1905: TINFO: LTP version: 20250130
tst_test.c:1909: TINFO: Tested kernel: 6.15.0-rc1-1.ge4c97fd-default #1 SMP PREEMPT_DYNAMIC Mon Apr  7 21:58:09 UTC 2025 (e4c97fd) x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1722: TINFO: Overall timeout per run is 0h 02m 00s
tst_device.c:98: TINFO: Found free device 1 '/dev/loop1'
ioctl_loop06_new.c:76: TINFO: Using LOOP_SET_BLOCK_SIZE with arg < 512
ioctl_loop06_new.c:67: TPASS: Set block size failed as expected: EINVAL (22)
ioctl_loop06_new.c:76: TINFO: Using LOOP_SET_BLOCK_SIZE with arg > BLK_MAX_BLOCK_SIZE
ioctl_loop06_new.c:67: TPASS: Set block size failed as expected: EINVAL (22)
ioctl_loop06_new.c:76: TINFO: Using LOOP_SET_BLOCK_SIZE with arg != power_of_2
ioctl_loop06_new.c:67: TPASS: Set block size failed as expected: EINVAL (22)
ioctl_loop06_new.c:76: TINFO: Using LOOP_CONFIGURE with block_size < 512
tst_device.c:255: TINFO: ioctl return: 0: ECHILD (10)
tst_device.c:255: TINFO: ioctl return: 0: ECHILD (10)
tst_device.c:255: TINFO: ioctl return: -1: ENXIO (6)
ioctl_loop06_new.c:67: TPASS: Set block size failed as expected: EINVAL (22)
ioctl_loop06_new.c:76: TINFO: Using LOOP_CONFIGURE with block_size > BLK_MAX_BLOCK_SIZE
ioctl_loop06_new.c:67: TPASS: Set block size failed as expected: EINVAL (22)
ioctl_loop06_new.c:76: TINFO: Using LOOP_CONFIGURE with block_size != power_of_2
ioctl_loop06_new.c:67: TPASS: Set block size failed as expected: EINVAL (22)

Summary:
passed   6
failed   0
broken   0
skipped  0
warnings 0

> ---
>  configure.ac                                  |  1 +
>  include/lapi/blkdev.h                         | 19 +++++++++++++++++++
>  .../kernel/syscalls/ioctl/ioctl_loop06.c      | 12 ++++++++----
>  3 files changed, 28 insertions(+), 4 deletions(-)
>  create mode 100644 include/lapi/blkdev.h
> 
> diff --git a/configure.ac b/configure.ac
> index 0f2b6f332..5538d88d5 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -52,6 +52,7 @@ AC_CHECK_HEADERS_ONCE([ \
>      emmintrin.h \
>      ifaddrs.h \
>      keyutils.h \
> +    linux/blkdev.h \
>      linux/can.h \
>      linux/cgroupstats.h \
>      linux/cryptouser.h \
> diff --git a/include/lapi/blkdev.h b/include/lapi/blkdev.h
> new file mode 100644
> index 000000000..3ee058ce0
> --- /dev/null
> +++ b/include/lapi/blkdev.h
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Linux Test Project
> + *  Li Wang <liwang@redhat.com>
> + */
> +
> +#ifndef LAPI_BLKDEV_H__
> +#define LAPI_BLKDEV_H__
> +
> +#ifdef HAVE_LINUX_BLKDEV_H
> +#include <linux/blkdev.h>
> +#endif
> +
> +/* Define BLK_MAX_BLOCK_SIZE for older kernels */
> +#ifndef BLK_MAX_BLOCK_SIZE
> +#define BLK_MAX_BLOCK_SIZE 0x00010000 /* 64K */
> +#endif
> +
> +#endif /* LAPI_BLKDEV_H */
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
> index 573871bc1..35e9e79e9 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
> @@ -14,7 +14,9 @@
>  #include <unistd.h>
>  #include <sys/types.h>
>  #include <stdlib.h>
> +#include "lapi/blkdev.h"
>  #include "lapi/loop.h"
> +#include "tst_fs.h"
>  #include "tst_test.h"
>  
>  static char dev_path[1024];
> @@ -31,7 +33,7 @@ static struct tcase {
>  	"Using LOOP_SET_BLOCK_SIZE with arg < 512"},
>  
>  	{&invalid_value, LOOP_SET_BLOCK_SIZE,
> -	"Using LOOP_SET_BLOCK_SIZE with arg > PAGE_SIZE"},
> +	"Using LOOP_SET_BLOCK_SIZE with arg > BLK_MAX_BLOCK_SIZE"},
>  
>  	{&unalign_value, LOOP_SET_BLOCK_SIZE,
>  	"Using LOOP_SET_BLOCK_SIZE with arg != power_of_2"},
> @@ -40,7 +42,7 @@ static struct tcase {
>  	"Using LOOP_CONFIGURE with block_size < 512"},
>  
>  	{&invalid_value, LOOP_CONFIGURE,
> -	"Using LOOP_CONFIGURE with block_size > PAGE_SIZE"},
> +	"Using LOOP_CONFIGURE with block_size > BLK_MAX_BLOCK_SIZE"},
>  
>  	{&unalign_value, LOOP_CONFIGURE,
>  	"Using LOOP_CONFIGURE with block_size != power_of_2"},
> @@ -103,10 +105,12 @@ static void setup(void)
>  	if (dev_num < 0)
>  		tst_brk(TBROK, "Failed to find free loop device");
>  
> -	tst_fill_file("test.img", 0, 1024, 1024);
> +	size_t bs = (BLK_MAX_BLOCK_SIZE < TST_MB) ? 1024 : 4 * BLK_MAX_BLOCK_SIZE / 1024;
> +	tst_fill_file("test.img", 0, bs, 1024);
> +
>  	half_value = 256;
>  	pg_size = getpagesize();
> -	invalid_value = pg_size * 2 ;
> +	invalid_value = BLK_MAX_BLOCK_SIZE * 2;
>  	unalign_value = pg_size - 1;
>  
>  	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
> 





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
