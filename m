Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2461DC433F5
	for <ltp@archiver.kernel.org>; Wed, 20 Apr 2022 12:03:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C35B3CA6C6
	for <ltp@archiver.kernel.org>; Wed, 20 Apr 2022 14:03:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F3A53C192A
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 14:03:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D1DEA20098E
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 14:03:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C0CEF1F380;
 Wed, 20 Apr 2022 12:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650456204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=az1mXiWhmbwnDy1axFGJb76kPFElU4kxUXwHkXxIk9A=;
 b=mZ3KRq+eQHXbyCmR1ExmsmDDoPywqsrvbxWxpWK0yiHXcDGXD+Y+LJ69zTiks5OVhgsUUU
 8tF+d/GU4wMm0+QhnzcklnNYh39SwHdHCFruqCZahZZoquT/8M+vG010a3SDaRlISrbFY3
 8A/1+MWJeb0AGt+a9aHAYGIsOR0xhx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650456204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=az1mXiWhmbwnDy1axFGJb76kPFElU4kxUXwHkXxIk9A=;
 b=cT97IAJeKd3iGRPYOIicZF7dpBFX/Ow4+isU9GgpyokCJFyrbQ1Cawu6bCyyiRiUAWGjWg
 T6pTUxy48K7r6XAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AEF0E13A30;
 Wed, 20 Apr 2022 12:03:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id o1h6KYz2X2LSWAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 20 Apr 2022 12:03:24 +0000
Date: Wed, 20 Apr 2022 14:05:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Yl/3FchHScs8YS6c@yuki>
References: <20220420114720.1463473-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220420114720.1463473-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] ioctl09: wait for udevd complete the uevent
 handling
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
> This is quite necessary to wait for uevent handing settled before
> checking the partition is taken effect.
> 
>   `udevadm monitor` listening from another terminal:
> 
>   KERNEL[447.077683] change   /devices/virtual/block/loop0 (block)
>   KERNEL[447.077939] add      /devices/virtual/block/loop0/loop0p1 (block)
>   KERNEL[447.077999] add      /devices/virtual/block/loop0/loop0p2 (block)
>   UDEV  [447.081138] change   /devices/virtual/block/loop0 (block)
>   UDEV  [447.083490] add      /devices/virtual/block/loop0/loop0p1 (block)
>   UDEV  [447.086898] add      /devices/virtual/block/loop0/loop0p2 (block)
> 
> Which helps to get rid of such boring failures:
> 
>   ioctl09.c:44: TPASS: access /sys/block/loop0/loop0p1 succeeds
>   ioctl09.c:52: TPASS: access /dev/loop0p1 succeeds
>   ioctl09.c:47: TFAIL: access /sys/block/loop0/loop0p2 fails
>   ioctl09.c:55: TFAIL: access /dev/loop0p2 fails
> 
> I manually confirmed those failures disappeared from a reproducible system
> even with running 10000 times.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/syscalls/ioctl/ioctl09.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl09.c b/testcases/kernel/syscalls/ioctl/ioctl09.c
> index 9728ecb9c..533a4a5d0 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl09.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl09.c
> @@ -58,6 +58,10 @@ static void check_partition(int part_num, bool value)
>  
>  static void verify_ioctl(void)
>  {
> +	char cmd[BUFSIZ];
> +
> +	sprintf(cmd, "udevadm settle --exit-if-exists=%s", dev_path);
> +
>  	const char *const cmd_parted_old[] = {"parted", "-s", "test.img",
>  					      "mklabel", "msdos", "mkpart",
>  					      "primary", "ext4", "1M", "10M",
> @@ -75,11 +79,13 @@ static void verify_ioctl(void)
>  
>  	loopinfo.lo_flags =  LO_FLAGS_PARTSCAN;
>  	SAFE_IOCTL(dev_fd, LOOP_SET_STATUS, &loopinfo);
> +	tst_system(cmd);
>  	check_partition(1, true);
>  	check_partition(2, false);
>  
>  	change_partition(cmd_parted_new);
>  	TST_RETRY_FUNC(ioctl(dev_fd, BLKRRPART, 0), TST_RETVAL_EQ0);
> +	tst_system(cmd);
>  	check_partition(1, true);
>  	check_partition(2, true);

We allready use TST_RETRY_FN_EXP_BACKOFF() in there with 30 second
timeout isn't that enough? And if it isn't wouldn't simply increasing
the timeout to a minute or two fix the issue?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
