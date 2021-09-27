Return-Path: <SRS0=FiD7=OR=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CF2C433EF
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 01:37:47 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12A4F60F0F
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 01:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 12A4F60F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90DDC3CA0ED
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 03:37:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B29C13C87AA
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 03:37:34 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8669C14001EA
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 03:37:33 +0200 (CEST)
Received: by mail-qv1-xf2b.google.com with SMTP id gs10so10181639qvb.13
 for <ltp@lists.linux.it>; Sun, 26 Sep 2021 18:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=aXGQd04IhRYN9R2qW8gPrOwrXWI0xTXX7YQtvJUgK6w=;
 b=uCeozUe5gAnMtXrMhdlGdQuCQenfA3V8L1P2tKR6v5y6cOoqP/cdn37FVsbuGZVfLo
 TKjGFIHntvVNzUPaUOhII5Ia6yRx/TJlK2LMPUwu9aKB95xvHT2akMU+hOZJLAbIFEdL
 f/2K/SltyW68XJIyzelgeZJhcGzyIIkq3LBMmbGDKx+ycG/ySHNxlPMwUBUjvGMGNHjF
 0mKtBnj+WDYqEWa68WChy4AUguPtt1Wl+7AWgU4eHNKROxvKikFQ19fGOu8dQJeVZleX
 5uGZrD0oTv19nZClYfkEG+Z7TOyl2PKcYLG/OU6YvP1J3OgExleuPs1ceG10eBQceWyQ
 DIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aXGQd04IhRYN9R2qW8gPrOwrXWI0xTXX7YQtvJUgK6w=;
 b=Vg4ynBQaBsmt+uXgoU1OuCZhK6mkP1pfTQQYQ5iPDdhEVmUtM5sJiymoy0t9Zpuyox
 cLF1vKYbcx1mShgMMloGnHxHtMfrFinkHiXaSudKDKHzv4UvbparghxcTJ+TRO0hmewC
 2dRkbmZohSTnw39wPXW1eNmse+OO3/2O1gZCMytC8wol9jvv7FdXrDMBsHO3QRIltdEV
 uOuyMXOPr6nATPv+UtayxoxtE6TxMmTGzNJfeuZUXjpbATVuNq27RLjptjd3LBMOfmCN
 7iqBD+gs8Fhaq0VdMaj2BoG3a1TeroZ/we303kcq1c7hOKShNMWRMm7XS/zUvuDICNq+
 2IyA==
X-Gm-Message-State: AOAM533ZK5RlsemzmBk+rw4MRHpX5fReLqtnqOzh2WwhNzyn3QiBlfaj
 ws7rny//S3G+0bqY+YXT9iFm+A==
X-Google-Smtp-Source: ABdhPJwKa8klON0M0ako12i6b7pDQ1S8xOWKNqeqadPKfeqp6oXx740czMLKp4fpFsZzDEl3BWRp5w==
X-Received: by 2002:ad4:4d90:: with SMTP id cv16mr7102233qvb.8.1632706652184; 
 Sun, 26 Sep 2021 18:37:32 -0700 (PDT)
Received: from localhost (rfs.netwinder.org. [206.248.184.2])
 by smtp.gmail.com with ESMTPSA id l3sm9509570qtu.47.2021.09.26.18.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Sep 2021 18:37:31 -0700 (PDT)
Date: Sun, 26 Sep 2021 21:37:31 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Li Wang <liwang@redhat.com>
Message-ID: <20210927013731.GA4173236@maple.netwinder.org>
References: <YUr9676LXNi0xMs6@yuki>
 <CAEemH2c37Qx6uEG40utX8pGC2Gp0ZLtT_z194L4RVNm6N2CefQ@mail.gmail.com>
 <YUs+jf35Zqp8GjJl@yuki>
 <20210922165218.GA3081072@maple.netwinder.org>
 <YUyQMBLPbCs4/Gur@yuki>
 <20210924014900.GA3975163@maple.netwinder.org>
 <CAEemH2diTBrnYAbBedQN+bog6y4NdLZG628egCqxuopZ7DHB0Q@mail.gmail.com>
 <20210924151130.GA4029248@maple.netwinder.org>
 <YU4YOI4yPufWP9uC@yuki>
 <CAEemH2e7LpOgVfNXXthovR4xt4aHYkTLCW+j4OsGoHegta+-uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e7LpOgVfNXXthovR4xt4aHYkTLCW+j4OsGoHegta+-uQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] fallocate05: increase the fallocate and
 defallocate size
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
Cc: LTP List <ltp@lists.linux.it>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Sun, Sep 26, 2021 at 03:39:35PM +0800, Li Wang wrote:
>
>However, unlimit tmpfs-size does not mean set .dev_min_size to zero.
>It should be returned mnt_data directly in limit_tmpfs_mount_size.
>That also does the 20210524 version.

This was my mistake - I had assumed 0 means unlimited - my apologies.

I have now amended the limit_tmpfs_mount_size() function as suggested.
And also the other two suggestions from your follow-up emails.

The tmpfs test now appears to be passing.

Regards,
Ralph

OMMAND:    /opt/ltp/bin/ltp-pan -q  -e -S   -a 1939     -n 1939 -p -f /ltp-tmp/ltp-NH5QtKmmxA/alltests -l /home/root/test-definitions/automated/linux/ltp/output/LTP_syscalls.log  -C 
/home/root/test-definitions/automated/linux/ltp/output/LTP_syscalls.failed -T /opt/ltp/output/LTP_RUN_ON-LTP_syscalls.log.tconf
INFO: Restricted to fallocate05
LOG File: /home/root/test-definitions/automated/linux/ltp/output/LTP_syscalls.log
FAILED COMMAND File: /home/root/test-definitions/automated/linux/ltp/output/LTP_syscalls.failed
TCONF COMMAND File: /opt/ltp/output/LTP_RUN_ON-LTP_syscalls.log.tconf
Running tests.......
tst_device.c:88: TINFO: Found free device 0 '/dev/loop0'
tst_supported_fs_types.c:147: TINFO: Skipping ext2 as requested by the test
tst_supported_fs_types.c:147: TINFO: Skipping ext3 as requested by the test
tst_supported_fs_types.c:147: TINFO: Skipping ext4 as requested by the test
tst_supported_fs_types.c:147: TINFO: Skipping xfs as requested by the test
tst_supported_fs_types.c:147: TINFO: Skipping btrfs as requested by the test
tst_supported_fs_types.c:147: TINFO: Skipping vfat as requested by the test
tst_supported_fs_types.c:115: TINFO: Filesystem exfat is not supported
tst_supported_fs_types.c:147: TINFO: Skipping ntfs as requested by the test
tst_supported_fs_types.c:89: TINFO: Kernel supports tmpfs
tst_supported_fs_types.c:38: TINFO: mkfs is not needed for tmpfs
tst_test.c:1433: TINFO: Testing on tmpfs
tst_test.c:934: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:1365: TINFO: Timeout per run is 0h 15m 00s
devtmpfs    on  /dev                                        type  devtmpfs    (rw,relatime,size=87560k,nr_inodes=21890,mode=755)
tmpfs       on  /dev/shm                                    type  tmpfs       (rw,nosuid,nodev)
tmpfs       on  /run                                        type  tmpfs       (rw,nosuid,nodev,mode=755)
tmpfs       on  /sys/fs/cgroup                              type  tmpfs       (ro,nosuid,nodev,noexec,mode=755)
tmpfs       on  /tmp                                        type  tmpfs       (rw,nosuid,nodev)
tmpfs       on  /var/volatile                               type  tmpfs       (rw,relatime)
tmpfs       on  /run/user/0                                 type  tmpfs       (rw,nosuid,nodev,relatime,size=17716k,mode=700)
ltp-tmpfs   on  /ltp-tmp/ltp-NH5QtKmmxA/falDMCkys/mntpoint  type  tmpfs       (rw,relatime)
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file0 size 21710183
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file1 size 8070086
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file2 size 3971177
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file3 size 36915315
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file4 size 70310993
tst_fill_fs.c:59: TINFO: write(): ENOSPC (28)
fallocate05.c:83: TPASS: write() wrote 1048576 bytes
fallocate05.c:104: TINFO: fallocate()d 0 extra blocks on full FS
fallocate05.c:116: TPASS: fallocate() on full FS
fallocate05.c:132: TPASS: fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)
fallocate05.c:138: TPASS: write()

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
