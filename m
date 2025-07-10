Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BE5C83F09
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 08:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752134481; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=vwemXk/mVMuosvJj97Ok5WV8cyhDt2a3T4qoL8pTKtY=;
 b=nv7+U+7qI8etP+doEievGIZo4RotAnlh48/uafB/kWgW8nXeabQySAc1kmP+JCpZKy/pB
 jdyANIz9FyHLscIl7aAU0zhjQh9bTWw3FYrzzIETf/oipiNjS51sJLpO076WnEIrY4HAB5G
 FIpgxL4xi+SQ0ZA8otfHkKM7UJYZVoo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D3DA3CAFAA
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 10:01:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D17A53CAE45
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 10:00:59 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9FC38600BB5
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 10:00:57 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B942A61476;
 Thu, 10 Jul 2025 08:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9BDC4CEE3;
 Thu, 10 Jul 2025 08:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752134455;
 bh=3kJXKGVy19HwRS0v8G4JAZbl9NgESNksh+wuchZQHok=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GGf2wODUPZB/EEXI0mi84RwgS5MLrJXyRX17IKrUPTWEWDDQQ+nINLDhMYWR5/uoO
 go2vPoVflCUWA3uyRgB11W5vOfq7RKfENtWfYwj6BiLnNLSlipSmfzLKVnPfl1eS/+
 t+SfH91y5Qs4IbTW8SzuLoyyzuhnG/rXubMaQTSo1r6DphveXGcxcpXQ/NamJHBStM
 3q06LyImZ559wXvkq7miclNeKMHLEciIx/esPs/ZueLMqe0q4lmJYaTLBnhchQjef7
 dyvfBjs9ez5J/FKNxug3E7XivS1a+IMXqf2Mg6oyROilNFuRXi67c4C46GB4GTBQCC
 jdAYHoKSrlkHw==
Date: Thu, 10 Jul 2025 10:00:48 +0200
To: Arnd Bergmann <arnd@kernel.org>
Message-ID: <20250710-passen-petersilie-32f6f1e9a1fc@brauner>
References: <20250709181030.236190-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250709181030.236190-1-arnd@kernel.org>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] block: fix FS_IOC_GETLBMD_CAP parsing in
 blkdev_common_ioctl()
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
From: Christian Brauner via ltp <ltp@lists.linux.it>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Eric Biggers <ebiggers@google.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Anuj Gupta <anuj20.g@samsung.com>,
 linux-kernel@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
 linux-block@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 dan.carpenter@linaro.org, rbm@suse.com, linux-fsdevel@vger.kernel.org,
 benjamin.copeland@linaro.org, ltp@lists.linux.it,
 Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jul 09, 2025 at 08:10:14PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Anders and Naresh found that the addition of the FS_IOC_GETLBMD_CAP
> handling in the blockdev ioctl handler breaks all ioctls with
> _IOC_NR==2, as the new command is not added to the switch but only
> a few of the command bits are check.
> 
> Refine the check to also validate the direction/type/length bits,
> but still allow all supported sizes for future extensions.
> 
> Move the new command to the end of the function to avoid slowing
> down normal ioctl commands with the added branches.
> 
> Fixes: 9eb22f7fedfc ("fs: add ioctl to query metadata and protection info capabilities")
> Link: https://lore.kernel.org/all/CA+G9fYvk9HHE5UJ7cdJHTcY6P5JKnp+_e+sdC5U-ZQFTP9_hqQ@mail.gmail.com/
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks!

> It seems that we have a lot of drivers with the same bug, as the
> large majority of all _IOC_NR() users in the kernel fail to also
> check the other bits of the ioctl command code. There are currently
> 55 files referencing _IOC_NR, and they all need to be manually
> checked for this problem.
> ---

The current documentation in Documentation/dev-tools/checkuapi.rst needs
updating too then.

I want this to work. So as a start we should have a common static inline
helper that encapsulates the barrage of checks.

>  block/ioctl.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 9ad403733e19..5e5a422bd09f 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -567,9 +567,6 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
>  {
>  	unsigned int max_sectors;
>  
> -	if (_IOC_NR(cmd) == _IOC_NR(FS_IOC_GETLBMD_CAP))
> -		return blk_get_meta_cap(bdev, cmd, argp);
> -
>  	switch (cmd) {
>  	case BLKFLSBUF:
>  		return blkdev_flushbuf(bdev, cmd, arg);
> @@ -647,9 +644,16 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
>  		return blkdev_pr_preempt(bdev, mode, argp, true);
>  	case IOC_PR_CLEAR:
>  		return blkdev_pr_clear(bdev, mode, argp);
> -	default:
> -		return -ENOIOCTLCMD;
>  	}
> +
> +	if (_IOC_DIR(cmd)  == _IOC_DIR(FS_IOC_GETLBMD_CAP) &&
> +	    _IOC_TYPE(cmd) == _IOC_TYPE(FS_IOC_GETLBMD_CAP) &&
> +	    _IOC_NR(cmd)   == _IOC_NR(FS_IOC_GETLBMD_CAP) &&
> +	    _IOC_SIZE(cmd) >= LBMD_SIZE_VER0 &&
> +	    _IOC_SIZE(cmd) <= _IOC_SIZE(FS_IOC_GETLBMD_CAP))

This part is wrong as we handle larger sizes just fine via
copy_struct_{from,to}_user().

Arnd, objections to writing it as follows?:

diff --git a/block/ioctl.c b/block/ioctl.c
index 9ad403733e19..9887ec55f8ce 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -567,9 +567,6 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 {
        unsigned int max_sectors;

-       if (_IOC_NR(cmd) == _IOC_NR(FS_IOC_GETLBMD_CAP))
-               return blk_get_meta_cap(bdev, cmd, argp);
-
        switch (cmd) {
        case BLKFLSBUF:
                return blkdev_flushbuf(bdev, cmd, arg);
@@ -647,9 +644,25 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
                return blkdev_pr_preempt(bdev, mode, argp, true);
        case IOC_PR_CLEAR:
                return blkdev_pr_clear(bdev, mode, argp);
-       default:
-               return -ENOIOCTLCMD;
        }
+
+       /* extensible ioctls */
+       switch (_IOC_NR(cmd)) {
+       case _IOC_NR(FS_IOC_GETLBMD_CAP):
+               if (_IOC_DIR(cmd) != _IOC_DIR(FS_IOC_GETLBMD_CAP))
+                       break;
+               if (_IOC_TYPE(cmd) != _IOC_TYPE(FS_IOC_GETLBMD_CAP))
+                       break;
+               if (_IOC_NR(cmd) != _IOC_NR(FS_IOC_GETLBMD_CAP))
+                       break;
+               if (_IOC_SIZE(cmd) < LBMD_SIZE_VER0)
+                       break;
+               if (_IOC_SIZE(cmd) > PAGE_SIZE)
+                       break;
+               return blk_get_meta_cap(bdev, cmd, argp);
+       }
+
+       return -ENOIOCTLCMD;
 }

 /*

And can I ask you to please take a look at fs/pidfs.c:pidfd_ioctl() and
fs/nsfs.c:ns_ioctl()?


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
