Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03819C433FE
	for <ltp@archiver.kernel.org>; Mon, 25 Apr 2022 15:19:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BE5B3C9449
	for <ltp@archiver.kernel.org>; Mon, 25 Apr 2022 17:19:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC1C73C1769
 for <ltp@lists.linux.it>; Mon, 25 Apr 2022 17:19:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0FDE6680E20
 for <ltp@lists.linux.it>; Mon, 25 Apr 2022 17:19:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 182BA210EC;
 Mon, 25 Apr 2022 15:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650899965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oX5dCHroBpJhud0XHJZhyNBrIZslzcmToOcH5dhHPeg=;
 b=lQZzRJZYqMIkRBOMsQUVVHIY1UKAcQhOODkEB/zlOiNiAdsb8iuRSbS3EANOzMAJL61KMk
 BheQHcQlDFkPhbVyl4QGtOHG6/6MmhcddsrLewDNu93vwPyXipK4OJ/8QETqtP0TL36dXL
 yOjKCSaEniuzKA5SLYVwULmZI0xmdT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650899965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oX5dCHroBpJhud0XHJZhyNBrIZslzcmToOcH5dhHPeg=;
 b=ad6IM8V0OZ97L6Lfxls2TTQVYmR1BbuK8tDCYEFUUzGajLYctlqx6TsrH3KhZfajPgBfTb
 ccTA3cJGlSyjlvBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01E5513AED;
 Mon, 25 Apr 2022 15:19:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id G3asOvy7ZmIFPgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 25 Apr 2022 15:19:24 +0000
Date: Mon, 25 Apr 2022 17:21:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Yma8g4NUSRAIvMAW@yuki>
References: <20220406110837.14773-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220406110837.14773-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: Check for leftover partition info in
 loopdev ioctl tests
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
> Due to a kernel bug, successful ioctl09 and ioctl_loop01 test runs
> sometimes leave behind stale partition info on the loop device they used,
> which then causes mkfs.vfat to fail in later tests. Check that partition
> info was properly removed in cleanup.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
> 
> This does not fix the mkfs.vfat failures but it makes the true cause visible.
> We could add a workaround for the mkfs.vfat failures by simply initializing
> the loop device with the LO_FLAGS_PARTSCAN flag by default, or at least when
> stale partition info is found by tst_find_free_loopdev().

I guess that it would be cleaner to put the stale partition info
detection into the loop library. We can print a warning there and then
do the workaround.

Also do we want to add a regression test for the stale partition info?
Should be easy enough. Or at least add the hash of the kernel commit
that fixed it to the ioctl tests?

>  testcases/kernel/syscalls/ioctl/ioctl09.c      | 12 +++++++++++-
>  testcases/kernel/syscalls/ioctl/ioctl_loop01.c |  6 ++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl09.c b/testcases/kernel/syscalls/ioctl/ioctl09.c
> index 9728ecb9c..09867a5c5 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl09.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl09.c
> @@ -19,7 +19,7 @@
>         ({ value ? TST_RETVAL_EQ0(x) : TST_RETVAL_NOTNULL(x); })
>  
>  static char dev_path[1024];
> -static int dev_num, attach_flag, dev_fd;
> +static int dev_num = -1, attach_flag, dev_fd;
>  static char loop_partpath[1026], sys_loop_partpath[1026];
>  
>  static void change_partition(const char *const cmd[])
> @@ -102,6 +102,16 @@ static void cleanup(void)
>  		SAFE_CLOSE(dev_fd);
>  	if (attach_flag)
>  		tst_detach_device(dev_path);
> +
> +	if (dev_num < 0)
> +		return;
> +
> +	sprintf(sys_loop_partpath, "/sys/block/loop%d/loop%dp1", dev_num,
> +		dev_num);
> +	sprintf(loop_partpath, "%sp1", dev_path);
> +
> +	if (!access(sys_loop_partpath, F_OK) || !access(loop_partpath, F_OK))
> +		tst_res(TWARN, "Partition info was not cleared from loop dev");
>  }
>  
>  static struct tst_test test = {
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> index 734d803d5..17168ae04 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> @@ -135,6 +135,12 @@ static void cleanup(void)
>  		SAFE_CLOSE(dev_fd);
>  	if (attach_flag)
>  		tst_detach_device(dev_path);
> +
> +	if (!*sys_loop_partpath || !*loop_partpath)
> +		return;
> +
> +	if (!access(sys_loop_partpath, F_OK) || !access(loop_partpath, F_OK))
> +		tst_res(TWARN, "Partition info was not cleared from loop dev");
>  }
>  
>  static struct tst_test test = {
> -- 
> 2.35.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
