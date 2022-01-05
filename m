Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611C6C433EF
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 06:02:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E50E83C9253
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 07:02:24 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DFB43C023C
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 07:02:12 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D4E2D2000A7
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 07:02:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641362530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UsnDgBrLAEwGQTfXYYh2c/WBcbW4GDhYu26dlbXvFFE=;
 b=I4Fw/nc/lXfVXlyS4Q6fjUvqP1nWOy+DFpucSOCd64oKGZSR2qNHe39LlG3PVxKLTDUw9y
 tXvnuKyl8B7TopFSn7DSe/By/sFi9ePi/VBgaQnEDQ9ItIQa4BXEcWjHp/CTU240aoHJIM
 xRLfdoCWbpWM2hd3Kz7PhhcBV+dmR0g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-fUG3wGrTPR2wrGPDI5jA7g-1; Wed, 05 Jan 2022 01:02:08 -0500
X-MC-Unique: fUG3wGrTPR2wrGPDI5jA7g-1
Received: by mail-wr1-f70.google.com with SMTP id
 l9-20020adfa389000000b001a23bd1c661so12229041wrb.6
 for <ltp@lists.linux.it>; Tue, 04 Jan 2022 22:02:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=UsnDgBrLAEwGQTfXYYh2c/WBcbW4GDhYu26dlbXvFFE=;
 b=UPgkVqIXIuX4PTHmD1+qhWQ157+e7brLR43doSAGtvn9DR/ORyUZhk3cGAgDXfxtof
 lk6UKIEgoU7HYu7nqRJfCIGTq+KGeiOwg3CfGv1igB+2VFqjSzO3x0J/PaPAvQptyfAs
 P8GAWWrOPK1X9Jrqw5i7HLWvZzvVdG6BuJcsB0efle/tb9kRXSB8qJOzn7uUN6GmBZmS
 2RnEVmloXUY6WqnfEqaVl35UalRb84FIM1ymvJhcUBiFL1PagQPQ5NZLwdNzcpf2CwF1
 qBCWhVDvDgZnzozT58Ecfbl29TuvAOdVkTryfkJ51FNuzJF+7zfp1uuIlvi3GnHwzAUr
 CZ1w==
X-Gm-Message-State: AOAM531Yhdb3bxsVf9hpV/w3r5X8Vcpv05zrDSL0jeBiE3ydtgM4voz2
 twj1t6UwF965jG5b1WUnNl7ksbKO0HRuR7azhhrtgzwzm+ZlmOX8eal8K+EdAZNbw4bMOVBPdn0
 IgdS7kxGXl0Q=
X-Received: by 2002:a5d:6289:: with SMTP id k9mr44195061wru.501.1641362527026; 
 Tue, 04 Jan 2022 22:02:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFua50IjNGi5PRHE2pOwFiMtCEhgZWRl+dkzr5nM9kJN3A/N6yn0CRBxAiG0rLOgncXlQlgg==
X-Received: by 2002:a5d:6289:: with SMTP id k9mr44195036wru.501.1641362526760; 
 Tue, 04 Jan 2022 22:02:06 -0800 (PST)
Received: from janakin.usersys.redhat.com ([83.148.38.137])
 by smtp.gmail.com with ESMTPSA id p1sm1462112wma.42.2022.01.04.22.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jan 2022 22:02:06 -0800 (PST)
Date: Wed, 5 Jan 2022 07:02:04 +0100
From: Jan Stancek <jstancek@redhat.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <20220105060201.GA2261405@janakin.usersys.redhat.com>
References: <03f43407-c34b-b7b2-68cd-d4ca93a993b8@i-love.sakura.ne.jp>
 <20211229172902.GC27693@lst.de>
 <4e7b711f-744b-3a78-39be-c9432a3cecd2@i-love.sakura.ne.jp>
MIME-Version: 1.0
In-Reply-To: <4e7b711f-744b-3a78-39be-c9432a3cecd2@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] make autoclear operation synchronous again
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
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
 linux-block <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 ltp@lists.linux.it, Dan Schatzberg <schatzberg.dan@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Dec 30, 2021 at 07:52:34PM +0900, Tetsuo Handa wrote:
>OK. Two patches shown below. Are these look reasonable?
>
>
>
>>From 1409a49181efcc474fbae2cf4e60cbc37adf34aa Mon Sep 17 00:00:00 2001
>From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>Date: Thu, 30 Dec 2021 18:41:05 +0900
>Subject: [PATCH 1/2] loop: Revert "loop: make autoclear operation asynchronous"
>

Thanks, the revert fixes failures we saw recently in LTP tests,
which do mount/umount in close succession:

# for i in `seq 1 2`;do mount -t iso9660 -o loop /root/isofs.iso /mnt/isofs; umount /mnt/isofs/; done
mount: /mnt/isofs: WARNING: source write-protected, mounted read-only.
mount: /mnt/isofs: wrong fs type, bad option, bad superblock on /dev/loop0, missing codepage or helper program, or other error.
umount: /mnt/isofs/: not mounted.

>The kernel test robot is reporting that xfstest can fail at
>
>  umount ext2 on xfs
>  umount xfs
>
>sequence, for commit 322c4293ecc58110 ("loop: make autoclear operation
>asynchronous") broke what commit ("loop: Make explicit loop device
>destruction lazy") wanted to achieve.
>
>Although we cannot guarantee that nobody is holding a reference when
>"umount xfs" is called, we should try to close a race window opened
>by asynchronous autoclear operation.
>
>Reported-by: kernel test robot <oliver.sang@intel.com>
>Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>---
> drivers/block/loop.c | 65 ++++++++++++++++++++------------------------
> drivers/block/loop.h |  1 -
> 2 files changed, 29 insertions(+), 37 deletions(-)
>
>diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>index b1b05c45c07c..e52a8a5e8cbc 100644
>--- a/drivers/block/loop.c
>+++ b/drivers/block/loop.c
>@@ -1082,7 +1082,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
> 	return error;
> }
>
>-static void __loop_clr_fd(struct loop_device *lo)
>+static void __loop_clr_fd(struct loop_device *lo, bool release)
> {
> 	struct file *filp;
> 	gfp_t gfp = lo->old_gfp_mask;
>@@ -1144,6 +1144,8 @@ static void __loop_clr_fd(struct loop_device *lo)
> 	/* let user-space know about this change */
> 	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
> 	mapping_set_gfp_mask(filp->f_mapping, gfp);
>+	/* This is safe: open() is still holding a reference. */
>+	module_put(THIS_MODULE);
> 	blk_mq_unfreeze_queue(lo->lo_queue);
>
> 	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
>@@ -1151,52 +1153,44 @@ static void __loop_clr_fd(struct loop_device *lo)
> 	if (lo->lo_flags & LO_FLAGS_PARTSCAN) {
> 		int err;
>
>-		mutex_lock(&lo->lo_disk->open_mutex);
>+		/*
>+		 * open_mutex has been held already in release path, so don't
>+		 * acquire it if this function is called in such case.
>+		 *
>+		 * If the reread partition isn't from release path, lo_refcnt
>+		 * must be at least one and it can only become zero when the
>+		 * current holder is released.
>+		 */
>+		if (!release)
>+			mutex_lock(&lo->lo_disk->open_mutex);
> 		err = bdev_disk_changed(lo->lo_disk, false);
>-		mutex_unlock(&lo->lo_disk->open_mutex);
>+		if (!release)
>+			mutex_unlock(&lo->lo_disk->open_mutex);
> 		if (err)
> 			pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
> 				__func__, lo->lo_number, err);
> 		/* Device is gone, no point in returning error */
> 	}
>
>+	/*
>+	 * lo->lo_state is set to Lo_unbound here after above partscan has
>+	 * finished. There cannot be anybody else entering __loop_clr_fd() as
>+	 * Lo_rundown state protects us from all the other places trying to
>+	 * change the 'lo' device.
>+	 */
> 	lo->lo_flags = 0;
> 	if (!part_shift)
> 		lo->lo_disk->flags |= GENHD_FL_NO_PART;
>-
>-	fput(filp);
>-}
>-
>-static void loop_rundown_completed(struct loop_device *lo)
>-{
> 	mutex_lock(&lo->lo_mutex);
> 	lo->lo_state = Lo_unbound;
> 	mutex_unlock(&lo->lo_mutex);
>-	module_put(THIS_MODULE);
>-}
>-
>-static void loop_rundown_workfn(struct work_struct *work)
>-{
>-	struct loop_device *lo = container_of(work, struct loop_device,
>-					      rundown_work);
>-	struct block_device *bdev = lo->lo_device;
>-	struct gendisk *disk = lo->lo_disk;
>-
>-	__loop_clr_fd(lo);
>-	kobject_put(&bdev->bd_device.kobj);
>-	module_put(disk->fops->owner);
>-	loop_rundown_completed(lo);
>-}
>
>-static void loop_schedule_rundown(struct loop_device *lo)
>-{
>-	struct block_device *bdev = lo->lo_device;
>-	struct gendisk *disk = lo->lo_disk;
>-
>-	__module_get(disk->fops->owner);
>-	kobject_get(&bdev->bd_device.kobj);
>-	INIT_WORK(&lo->rundown_work, loop_rundown_workfn);
>-	queue_work(system_long_wq, &lo->rundown_work);
>+	/*
>+	 * Need not hold lo_mutex to fput backing file. Calling fput holding
>+	 * lo_mutex triggers a circular lock dependency possibility warning as
>+	 * fput can take open_mutex which is usually taken before lo_mutex.
>+	 */
>+	fput(filp);
> }
>
> static int loop_clr_fd(struct loop_device *lo)
>@@ -1228,8 +1222,7 @@ static int loop_clr_fd(struct loop_device *lo)
> 	lo->lo_state = Lo_rundown;
> 	mutex_unlock(&lo->lo_mutex);
>
>-	__loop_clr_fd(lo);
>-	loop_rundown_completed(lo);
>+	__loop_clr_fd(lo, false);
> 	return 0;
> }
>
>@@ -1754,7 +1747,7 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
> 		 * In autoclear mode, stop the loop thread
> 		 * and remove configuration after last close.
> 		 */
>-		loop_schedule_rundown(lo);
>+		__loop_clr_fd(lo, true);
> 		return;
> 	} else if (lo->lo_state == Lo_bound) {
> 		/*
>diff --git a/drivers/block/loop.h b/drivers/block/loop.h
>index 918a7a2dc025..082d4b6bfc6a 100644
>--- a/drivers/block/loop.h
>+++ b/drivers/block/loop.h
>@@ -56,7 +56,6 @@ struct loop_device {
> 	struct gendisk		*lo_disk;
> 	struct mutex		lo_mutex;
> 	bool			idr_visible;
>-	struct work_struct      rundown_work;
> };
>
> struct loop_cmd {
>-- 
>2.32.0
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
