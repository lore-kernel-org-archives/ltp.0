Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D72C636CC
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 13:45:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A82733CC3C9
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 14:45:26 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 352023CB4DB
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 14:22:57 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5D77E100042B
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 14:22:56 +0100 (CET)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 290A53F214
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 13:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1676467375;
 bh=Vc+spTkpwnOf/2/foxLE7ZHLvZ51H6Hm9OZU6lz+EVo=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
 b=X6WjcWc0iwWA+1spLASog9aZo+b0jDY2rQ3PlkjQ6kHVEZS8LCSoF+1hQwhzckmOV
 VVpO1T7x6/2/WdHOB6TyOXmsn4xvAz+Zeksu+yOPg0DPePHqJ+fGt9N4KGrcCu7L0M
 7j1LpSFxS/6l9nd7KSQs30L0/Uf24xVSO0nWBvlkSzTMdE4wukuMQpMbWFCzhz+zth
 ogQ/D8rF51ywlSB3NX9Py5Bnb0x63F/hHZRRBdCVkhrXbwjJpxQOATmWlembFfMnbI
 9Hvw5z6w5g/G33oPTzxPbQentO7eypdfgRu7EsCYNUdutFhz+PD4whuKOXfo6+AO+3
 uTd0A7gXD+CjQ==
Received: by mail-wr1-f72.google.com with SMTP id
 f14-20020a0560001a8e00b002c3b562d76cso3649542wry.12
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 05:22:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vc+spTkpwnOf/2/foxLE7ZHLvZ51H6Hm9OZU6lz+EVo=;
 b=VKgwABF0vpmDUjEEuKd9vhef0Cc84QE1kh6nN5H4bcbXHD8YsEqNsYrtIjRoqzfI7d
 IJCm9HJiX+mTShWKIjP+LaQHcXM3WzXowhVeLoyTCy6Q2ZLW8mEgAc1XjTb2KzlcCkcI
 MuaTw33P5E82LB5ieVKpEdePH7yCnQ6wjzbqN7K+naiyvnTDvyQ2FhMVv2sst4mng/7M
 TMhAT91uPxH/RBHsqg+ranD2ptucomqAsujiB7MEiOEdOPs2OFg7RQxd+koMieWoaJN5
 NsJUBUPuIQp322IWSPH0CFz1fllkYUmTPO2mx7Rk1WrtVI7z30Lj3goNxA4Jevh+M7pv
 WFfg==
X-Gm-Message-State: AO0yUKWhw19Yimw3JNsW4KWruWcLe5KZaL3gefbVPqDa2c3C1y9bbvVE
 2wext1r2iVnVJukOkxJkEsTAV3fFjikatMQDcOfkNRYf6sUIOYaXOB6orjNjp+s1bA9qq/Ww2Q7
 R/ggWFOuAZCQragl2OlsUPhh4UsY8YMwQOLv9
X-Received: by 2002:a05:600c:180a:b0:3e1:f8b3:6333 with SMTP id
 n10-20020a05600c180a00b003e1f8b36333mr1879304wmp.27.1676467372789; 
 Wed, 15 Feb 2023 05:22:52 -0800 (PST)
X-Google-Smtp-Source: AK7set9ov6lbmX1Nt0mTbdJKV0TUmjoir+yDeHpMDes1b3VEzCMVvXUdo0pxwpzApmL3iJnqz4l3ag==
X-Received: by 2002:a05:600c:180a:b0:3e1:f8b3:6333 with SMTP id
 n10-20020a05600c180a00b003e1f8b36333mr1879294wmp.27.1676467372430; 
 Wed, 15 Feb 2023 05:22:52 -0800 (PST)
Received: from qwirkle (38-242-176-173.ofnl.uk. [38.242.176.173])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a05600c3b1100b003dd1bd0b915sm2253024wms.22.2023.02.15.05.22.51
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Feb 2023 05:22:52 -0800 (PST)
Date: Wed, 15 Feb 2023 13:22:50 +0000
From: Andrei Gherzan <andrei.gherzan@canonical.com>
To: ltp@lists.linux.it
Message-ID: <Y+zcqqNE01cNcm1Y@qwirkle>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 15 Feb 2023 14:45:05 +0100
Subject: [LTP] LTP fs_fill test on vfat - ENOSPC
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

tl;dr fs_fill test broken for vfat on systems with more than 256 CPUs.

The fs_fill test runs a fill test on all the supported filesystems. One
of them being vfat. This filesystem is configured dynamically or through
flags/arguments for its file allocation table type (12/16/32).

The size of the test device (which is a loop mounted fs) is 300MB. When
not instructed, mkfs will "automatically select between 12, 16 and 32
bit, whatever fits better for the filesystem size"[1]. For the case of
a 300Mb that wwould end up as FAT16:

# sudo file -s /dev/loop0
/dev/loop0: DOS/MBR boot sector, code offset 0x3c+2, OEM-ID "mkfs.fat",
sectors/cluster 16, reserved sectors 16, root entries 512, Media
descriptor 0xf8, sectors/FAT 160, sectors/track 32, heads 64, sectors
600000 (volumes > 32 MB), serial number 0x5de1e96b, unlabeled, FAT (16
bit)

This is pretty well known, but it's important to start with because it is
linked with another configuration that is the actual impact on this
issue and that is the maximum number of directories in the root of the
filesystem.  FAT12 and FAT16 uses a special system region for "Root
Directory Region". And by default (there is also an argument to
configure this at mkfs-time) this ends up being 256 when no custom
arguments are provided.

On the other hand, the test sets up the filesystem with a
"tst_ncpus_conf + 2" number of directories in the root which can break
the limit explained above on systems that take the value over the
default 256 limit of root directories.

There a couple of ways to deal with this:

1. Force the filesystem creation in FAT32. This would be the best way
forward in my opinion, but I can't see anything that supports doing so on
a per-filesystem basis in LTP.
2. Increase the minimal numbers of entries available in the root
directory via "-r ROOT-DIR-ENTRIES"[1]. This would only push the crash
on fewer systems.
3. Use a subdirectory in the test setup. Something like /subdir/threadX.
If I'm not missing any support to do 1, this would probably be the
easiest to do.

I'm happy to go forward with a PR to fix this properly but looking
forward to your feedback on how to steer this.

[1] MKFS.FAT(8)

-- 
Andrei Gherzan

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
