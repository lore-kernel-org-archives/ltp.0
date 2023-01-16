Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FD7C54EBE
	for <ltp@archiver.kernel.org>; Mon, 16 Jan 2023 13:41:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C67403CC8EF
	for <ltp@archiver.kernel.org>; Mon, 16 Jan 2023 14:41:28 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1F433C9F6B
 for <ltp@lists.linux.it>; Mon, 16 Jan 2023 14:41:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 91ED41400522
 for <ltp@lists.linux.it>; Mon, 16 Jan 2023 14:41:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1B0FA375D5;
 Mon, 16 Jan 2023 13:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1673876476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NHHpVHFcQsOSRa7nya3DM/roIqNrxpuUR4jMhDl3dz4=;
 b=3CuYe00XS2AXerr/6NhretMK1m74RxEA7aPB4TChUwN8VvTulVN22DNfrNv3ic38l8RruM
 nPbUtnu9r7JIAMTeavL5nVDKkJ5SVjCV0k0skxASMwQOFUC+552mNJYiR0RfPF9nX2OKs1
 noxAF/HnmCkxFc6zM9fFNQ8JsoIbkn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1673876476;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NHHpVHFcQsOSRa7nya3DM/roIqNrxpuUR4jMhDl3dz4=;
 b=v+0XZ7urGA9p+vMy9Q7X9eKYbEvuQU7IjC74EtZP+/Gasb7w86TDxd0lswgDOES3LijQgX
 JN4m6Ux505a75SDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 08120138FA;
 Mon, 16 Jan 2023 13:41:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uUDxAPxTxWNhRgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 16 Jan 2023 13:41:16 +0000
Date: Mon, 16 Jan 2023 14:42:49 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Y8VUWX54JpVqGloP@yuki>
References: <20230116084802.6510-1-wegao@suse.com>
 <20230116111749.18865-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230116111749.18865-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] readahead02.c: Fix check input fsize
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
> diff --git a/include/tst_device.h b/include/tst_device.h
> index 977427f1c..f03f17f7d 100644
> --- a/include/tst_device.h
> +++ b/include/tst_device.h
> @@ -6,6 +6,8 @@
>  #ifndef TST_DEVICE_H__
>  #define TST_DEVICE_H__
>  
> +#define DEV_SIZE_MB 300u
> +
>  #include <unistd.h>
>  #include <stdint.h>
>  #include <sys/stat.h>
> @@ -49,7 +51,7 @@ int tst_clear_device(const char *dev);
>   * free loopdev). If path is non-NULL, it will be filled with free loopdev path.
>   *
>   */
> -int tst_find_free_loopdev(const char *path, size_t path_len);
> +int tst_find_free_loopdev(char *path, size_t path_len);
>  
>  /*
>   * Attaches a file to a loop device.
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index 48d7e3ab6..b098fc80b 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -38,6 +38,7 @@
>  #include "lapi/syscalls.h"
>  #include "test.h"
>  #include "safe_macros.h"
> +#include "tst_device.h"
>  
>  #ifndef LOOP_CTL_GET_FREE
>  # define LOOP_CTL_GET_FREE 0x4C82
> @@ -46,7 +47,6 @@
>  #define LOOP_CONTROL_FILE "/dev/loop-control"
>  
>  #define DEV_FILE "test_dev.img"
> -#define DEV_SIZE_MB 300u
>  #define UUID_STR_SZ 37
>  #define UUID_FMT "%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x"

These changes are useless now.

> diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
> index 7acf4bb18..5989c7cbf 100644
> --- a/testcases/kernel/syscalls/readahead/readahead02.c
> +++ b/testcases/kernel/syscalls/readahead/readahead02.c
> @@ -33,6 +33,7 @@
>  #include "tst_test.h"
>  #include "tst_timer.h"
>  #include "lapi/syscalls.h"
> +#include "tst_device.h"
>  
>  static char testfile[PATH_MAX] = "testfile";
>  #define DROP_CACHES_FNAME "/proc/sys/vm/drop_caches"
> @@ -366,11 +367,24 @@ static void setup_readahead_length(void)
>  
>  static void setup(void)
>  {
> -	if (opt_fsizestr) {
> -		testfile_size = SAFE_STRTOL(opt_fsizestr, 1, INT_MAX);
> -		tst_set_max_runtime(1 + testfile_size / (DEFAULT_FILESIZE/32));
> +	/*
> +	 * Acutaly dev size will reduced after create filesystem,
> +	 * so use dev_szie * 0.8 as dev real usage size, test case will
> +	 * create two files within dev so we need div 2 get max file size
> +	 */
> +	size_t fsize_max = tst_device->size * 0.8 / 2 * 1024 * 1024;

I'm not entirely sure about the * 0.8 here. I suppose that we need some
space for metadata and some manipulation space but 20% is probably way
to much. What motivation is behind the exact number here?

> +	/* At least two pagesize for test case */
> +	pagesize = getpagesize();
> +	size_t fsize_min = pagesize * 2;
> +
> +	if (tst_parse_filesize(opt_fsizestr, (long long *)&testfile_size, fsize_min, fsize_max)) {
                                              ^
					      This is wrong, as long as
					      size of size_t and long
					      long is different it will
					      either corrupt memory or
					      crash.

The testfile_size has to be defined long long there is no way around it.

> +		tst_set_max_runtime(1 + DEFAULT_FILESIZE / (DEFAULT_FILESIZE/32));

Why do we even bother with setting runtime if we are doing
tst_brk(TBROK, ...) on the next line?

> +		tst_brk(TBROK, "invalid initial filesize '%s'", opt_fsizestr);
                                             ^
					I do not understand what
					'initial' means in this context.
>  	}
>  
> +	tst_set_max_runtime(1 + testfile_size / (DEFAULT_FILESIZE/32));
> +
>  	if (access(PROC_IO_FNAME, F_OK))
>  		tst_brk(TCONF, "Requires " PROC_IO_FNAME);
>  
> @@ -380,7 +394,6 @@ static void setup(void)
>  	/* check if readahead is supported */
>  	tst_syscall(__NR_readahead, 0, 0, 0);
>  
> -	pagesize = getpagesize();
>  
>  	setup_readahead_length();
>  	tst_res(TINFO, "readahead length: %d", readahead_length);
> -- 
> 2.35.3
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
