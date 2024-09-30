Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551C9CF6497
	for <ltp@archiver.kernel.org>; Mon, 30 Sep 2024 10:15:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6BD33C563A
	for <ltp@archiver.kernel.org>; Mon, 30 Sep 2024 12:15:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B446C3C561D
 for <ltp@lists.linux.it>; Mon, 30 Sep 2024 12:15:19 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 10CB760212E
 for <ltp@lists.linux.it>; Mon, 30 Sep 2024 12:15:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727691317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wCUdNikGJCngAq5rrc4vcaoiBZukIDMXIdCY4aEjVyM=;
 b=L1CIMS5MU7fRVqElXJEZ7CYwsiPOzKaMHxjKJv/m3S9op1MNCgnz9ljZXXr5lzdwuzlKoA
 leVNmKbEHdj1dLwfBgV/aI/R3/yRMh84l26w4BeT7/Z+O8G0U+cVxnByrIk5svWbslaasq
 M3ZIB6pQpJJPygokJdFYUEyd0m5lN5I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-8hhAjuFjOCmzzSRpHVLnOg-1; Mon, 30 Sep 2024 06:15:15 -0400
X-MC-Unique: 8hhAjuFjOCmzzSRpHVLnOg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cceb06940so27942655e9.0
 for <ltp@lists.linux.it>; Mon, 30 Sep 2024 03:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727691315; x=1728296115;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wCUdNikGJCngAq5rrc4vcaoiBZukIDMXIdCY4aEjVyM=;
 b=huRMtWw/4hh8L1O/0xS6ce8O6+/+PB0KuImTmxp4RdwPaRVtBfky+jV8p9TfcOuo7g
 9FekAoLY7vei0CPiaYyhj+q2nOK+FuvYPqikGUyJ+/p7YZqcJot9QPdCQ+ai3AJIGYu8
 Hy3f1q0MSlpuzCyl4orjyz9ClwTt+WmSga5Y2UsOl2Wd5+AAes49bFqGIvgR/OdR83k+
 xa7LBSY4FC/Ab6OWn8vlsDzanRrQH4RUwLh+0Y9ppdU2jsykQd3Dg+D2z7JtOA+io0Qm
 i2DKbMHSl/tRN344fLD25u03oklQ5f9kxvqyjww3yFitPZXI/bjXdUjkXcBHr3rrZN5T
 IDFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQsoEc4ombTLXJIDECdSu1yOHusFibaStgw9gtUhIyTo51ADMccGJYdseGQiONcbIzFTE=@lists.linux.it
X-Gm-Message-State: AOJu0YwFFDZ/qm3vv0rZIbxJ1P6q0wMxPrHC018mWdOToKDl4kp8g4BX
 +ZFeg9AohH/8J/BDxRunWeNAwrnnsvSG+EegNyGEYn0RmIv+DXIirRYTY5wAnQHMSG6pl12MZlv
 AnR0Fs2MHpWW5BD4e/jAWAbB8ZPpIlXST+rwXhdhSsMZxfhXEuGIS8C8+
X-Received: by 2002:a5d:5258:0:b0:37c:cc54:ea72 with SMTP id
 ffacd0b85a97d-37cd5a687c8mr6230533f8f.4.1727691314539; 
 Mon, 30 Sep 2024 03:15:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAmQ9keNL/1ukB9mMF7yp8J5+HTw3AMKd/GNMHUzlXqNxxyeInkNU+WTVYZxy9eRgobMCc5w==
X-Received: by 2002:a5d:5258:0:b0:37c:cc54:ea72 with SMTP id
 ffacd0b85a97d-37cd5a687c8mr6230519f8f.4.1727691314158; 
 Mon, 30 Sep 2024 03:15:14 -0700 (PDT)
Received: from t14s (109-81-84-73.rct.o2.cz. [109.81.84.73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd564d0a3sm8797984f8f.15.2024.09.30.03.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 03:15:13 -0700 (PDT)
Date: Mon, 30 Sep 2024 12:15:11 +0200
From: Jan Stancek <jstancek@redhat.com>
To: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Message-ID: <Zvp6L+oFnfASaoHl@t14s>
References: <20240805201241.27286-1-jack@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20240805201241.27286-1-jack@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ext4: don't set SB_RDONLY after filesystem errors
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
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Aug 05, 2024 at 10:12:41PM +0200, Jan Kara wrote:
>When the filesystem is mounted with errors=remount-ro, we were setting
>SB_RDONLY flag to stop all filesystem modifications. We knew this misses
>proper locking (sb->s_umount) and does not go through proper filesystem
>remount procedure but it has been the way this worked since early ext2
>days and it was good enough for catastrophic situation damage
>mitigation. Recently, syzbot has found a way (see link) to trigger
>warnings in filesystem freezing because the code got confused by
>SB_RDONLY changing under its hands. Since these days we set
>EXT4_FLAGS_SHUTDOWN on the superblock which is enough to stop all
>filesystem modifications, modifying SB_RDONLY shouldn't be needed. So
>stop doing that.
>
>Link: https://lore.kernel.org/all/000000000000b90a8e061e21d12f@google.com
>Reported-by: Christian Brauner <brauner@kernel.org>
>Signed-off-by: Jan Kara <jack@suse.cz>
>---
> fs/ext4/super.c | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>
>Note that this patch introduces fstests failure with generic/459 test because
>it assumes that either freezing succeeds or 'ro' is among mount options. But
>we fail the freeze with EFSCORRUPTED. This needs fixing in the test but at this
>point I'm not sure how exactly.
>
>diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>index e72145c4ae5a..93c016b186c0 100644
>--- a/fs/ext4/super.c
>+++ b/fs/ext4/super.c
>@@ -735,11 +735,12 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
>
> 	ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
> 	/*
>-	 * Make sure updated value of ->s_mount_flags will be visible before
>-	 * ->s_flags update
>+	 * EXT4_FLAGS_SHUTDOWN was set which stops all filesystem
>+	 * modifications. We don't set SB_RDONLY because that requires
>+	 * sb->s_umount semaphore and setting it without proper remount
>+	 * procedure is confusing code such as freeze_super() leading to
>+	 * deadlocks and other problems.
> 	 */
>-	smp_wmb();
>-	sb->s_flags |= SB_RDONLY;

Hi,

shouldn't the SB_RDONLY still be set (in __ext4_remount()) for the case
when user triggers the abort with mount(.., "abort")? Because now we seem
to always hit the condition that returns EROFS to user-space.

I'm seeing LTP's fanotify22 failing for a about week (roughly since
commit de5cb0dcb74c) on:

   fanotify22.c:59: TINFO: Mounting /dev/loop0 to /tmp/LTP_fanqgL299/test_mnt fstyp=ext4 flags=21
   fanotify22.c:59: TBROK: mount(/dev/loop0, test_mnt, ext4, 33, 0x4211ed) failed: EROFS (30)

	static void trigger_fs_abort(void)
	{
		SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
			   MS_REMOUNT|MS_RDONLY, "abort");
	}

Thanks,
Jan


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
