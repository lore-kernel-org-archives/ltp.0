Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72417C4332F
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 20:39:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1E2A3CAD3B
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 21:39:47 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 942143CA8A4
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 21:39:36 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 72D3C1A00A45
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 21:39:35 +0100 (CET)
Received: by mail-wm1-x334.google.com with SMTP id 5so11379262wmo.1
 for <ltp@lists.linux.it>; Wed, 02 Nov 2022 13:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hM54vg37dUpKVgDrBvaWZa98YNV02Uz6DfLZEZukbVE=;
 b=S6vjgcDdJaoO2R2s+7OYK0SnfVJQNu/Td6Byv5sVin1qcwcr/DQ4mN9obPx2nOPOxX
 bHa+kksyGya203jGsOsFuXi3yV3dqReCkJcVkkH2onhoju4rrEulZZqD0gAjIdxbi4QC
 22wkrAGwDuDw+4mNRV9kEQr8t/lKW6gWFS+qzFcSDqddZURV11y1TD2nY+b+lse2UmET
 i5dUhO/hwsaWomvysRFyBZZ2iMKkskhwFgujdRzQg9Rtb9q+ezseSPGLpUo++DVC944S
 wjW0fUUM4/+vzbkEjV4IH6gcF/WHTO1JaW557T81q9qhFVyMjVOqoYUtPFUt9ikprTYl
 ZRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hM54vg37dUpKVgDrBvaWZa98YNV02Uz6DfLZEZukbVE=;
 b=PzQsty3BTs1Wr3k8kXcjXmGpEJxOlMPVOgnK/hsSGOoyPsAuTKYYAlGrM//oyvJXl3
 WUhEKmJw16VEQT86NiaJUbyVfmNh2vak2VM7JDcztsgD7DhPC5j9EWo/3cQrKwMdMeq0
 Om0I3jUY37VrsujDI92jEZS8LZ9wCwGhEI0bScDifrrTEYc7ij6YyfBjNt9cg75zkHak
 oWj1Cnj3YOZlWwO1bR4/1WSpZ2lj1zxlap6x9l2Xd1KNKTKNaBNwXtELg0AEzAWrjudG
 P+EhPtqFL/LZN7NL+lCGjzosew4bIyZ+YFmYyocD/2d1HN0Y1qyAp5IxAlerDLIAopC5
 BXng==
X-Gm-Message-State: ACrzQf2w/A5mpkk9A7o5uixCGog2+IK3/YaIWXYYetVPLfHjSjG3xS+j
 hofso2/BZzduR/9hQHU2c8YgNzaSMA0=
X-Google-Smtp-Source: AMsMyM4uor3WcPcDVmImazIfWJbDk818D5oDcPJ0E4sq5g8uumrcLjMjQTPpDn7dJvTsF2GuGFrICg==
X-Received: by 2002:a05:600c:5114:b0:3c7:8eb:fb1c with SMTP id
 o20-20020a05600c511400b003c708ebfb1cmr27107563wms.204.1667421574325; 
 Wed, 02 Nov 2022 13:39:34 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
 by smtp.googlemail.com with ESMTPSA id
 j19-20020a05600c1c1300b003a8434530bbsm3460435wms.13.2022.11.02.13.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Nov 2022 13:39:33 -0700 (PDT)
From: Alessandro Carminati <alessandro.carminati@gmail.com>
To: ltp@lists.linux.it
Date: Wed,  2 Nov 2022 20:34:11 +0000
Message-Id: <20221102203413.547089-1-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87pme79f3d.fsf@suse.de>
References: <87pme79f3d.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] tst_find_backing_dev: fix stat fails /dev/root
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
Cc: Alessandro Carminati <alessandro.carminati@gmail.com>, rpalethorpe@suse.com,
 acarmina@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This tst_find_backing_dev patch version adds support for btrfs
filesystems.
Strategy here is to understand if the subject is btrfs or not.
btrfs uses virtual device, and the major is 0. In all other test
supported file systems the major is always non zero.

If non btrfs it proceed as the previous version using sysfs minor
and major.
If btrfs it uses the BTRFS_IOC_FS_INFO ioctl to get it FS uuid.

non btrfs:
----------------------------------------------------------------
EXT4-fs (sda): re-mounted. Opts: (null). Quota mode: none.
Welcome to Buildroot
buildroot login: root
# /usr/lib/ltp-testsuite/testcases/bin/ioctl_loop05
tst_test.c:1363: TINFO: Timeout per run is 0h 05m 00s
tst_test.c:1115: TINFO: ext2/ext3/ext4 is supported by the test
tst_device.c:90: TINFO: Found free device 0 '/dev/loop0'
loop0: detected capacity change from 0 to 2048
tst_device.c:579: TINFO: Device numbers: 8/0
tst_device.c:611: TINFO: Use uevent strategy
ioctl_loop05.c:126: TINFO: backing dev(/dev/sda) logical_block_size is 512
ioctl_loop05.c:62: TINFO: Without setting lo_offset or sizelimit
ioctl_loop05.c:45: TINFO: In dio mode
ioctl_loop05.c:48: TPASS: lo_flags has LO_FLAGS_DIRECT_IO flag
ioctl_loop05.c:52: TPASS: /sys/block/loop0/loop/dio = 1
ioctl_loop05.c:45: TINFO: In non dio mode
ioctl_loop05.c:50: TPASS: lo_flags doesn't have LO_FLAGS_DIRECT_IO flag
ioctl_loop05.c:52: TPASS: /sys/block/loop0/loop/dio = 0
ioctl_loop05.c:69: TINFO: With offset equal to logical_block_size
loop0: detected capacity change from 2048 to 2047
ioctl_loop05.c:74: TPASS: LOOP_SET_DIRECT_IO succeeded
ioctl_loop05.c:45: TINFO: In dio mode
ioctl_loop05.c:48: TPASS: lo_flags has LO_FLAGS_DIRECT_IO flag
ioctl_loop05.c:52: TPASS: /sys/block/loop0/loop/dio = 1
ioctl_loop05.c:81: TINFO: With nonzero offset less than logical_block_size
ioctl_loop05.c:92: TPASS: LOOP_SET_DIRECT_IO failed as expected: EINVAL (22)

Summary:
passed   8
failed   0
broken   0
skipped  0
warnings 0
#

btrfs
----------------------------------------------------------------
BTRFS info (device sda): disk space caching is enabled
Welcome to Buildroot
buildroot login: root
# /usr/lib/ltp-testsuite/testcases/bin/ioctl_loop05
tst_test.c:1363: TINFO: Timeout per run is 0h 05m 00s
tst_test.c:1115: TINFO: btrfs is supported by the test
tst_device.c:90: TINFO: Found free device 0 '/dev/loop0'
loop0: detected capacity change from 0 to 2048
tst_device.c:579: TINFO: Device numbers: 0/15
tst_device.c:582: TINFO: Use BTRFS specific strategy
ioctl_loop05.c:126: TINFO: backing dev(/dev/sda) logical_block_size is 512
ioctl_loop05.c:62: TINFO: Without setting lo_offset or sizelimit
ioctl_loop05.c:45: TINFO: In dio mode
ioctl_loop05.c:48: TPASS: lo_flags has LO_FLAGS_DIRECT_IO flag
ioctl_loop05.c:52: TPASS: /sys/block/loop0/loop/dio = 1
ioctl_loop05.c:45: TINFO: In non dio mode
ioctl_loop05.c:50: TPASS: lo_flags doesn't have LO_FLAGS_DIRECT_IO flag
ioctl_loop05.c:52: TPASS: /sys/block/loop0/loop/dio = 0
ioctl_loop05.c:69: TINFO: With offset equal to logical_block_size
loop0: detected capacity change from 2048 to 2047
ioctl_loop05.c:74: TPASS: LOOP_SET_DIRECT_IO succeeded
ioctl_loop05.c:45: TINFO: In dio mode
ioctl_loop05.c:48: TPASS: lo_flags has LO_FLAGS_DIRECT_IO flag
ioctl_loop05.c:52: TPASS: /sys/block/loop0/loop/dio = 1
ioctl_loop05.c:81: TINFO: With nonzero offset less than logical_block_size
ioctl_loop05.c:87: TPASS: LOOP_SET_DIRECT_IO succeeded, offset is ignored

Summary:
passed   8
failed   0
broken   0
skipped  0
warnings 0
#

Alessandro Carminati (2):
  tst_find_backing_dev: Get dev name from /sys/dev/block/*/uevent
  c-test-api: Documentation updated

 doc/c-test-api.txt |  7 ++--
 lib/tst_device.c   | 86 ++++++++++++++++++++++++++++++----------------
 2 files changed, 62 insertions(+), 31 deletions(-)

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
