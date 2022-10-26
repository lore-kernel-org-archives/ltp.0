Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3827AC433FE
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 14:10:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8A923CA7F0
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 16:10:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B7B23C0282
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 16:09:59 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6F34F1A00A3C
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 16:09:59 +0200 (CEST)
Received: by mail-ej1-x634.google.com with SMTP id y14so21564001ejd.9
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 07:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=REMZhIoF9B9JfiQcEKTvAiC+ThfAR4nspfGdmFqV4Qw=;
 b=jRb58hMUjSUHre2cMeuAx+nxSm68BiRGg8IwqOXryhgkx9Uo8y23dcR7ACOida+yOw
 kl36h52Qs8GxNExsnw+Me+OwMyUbwAUwW63aXRB1oFxItRlU8ODZEcPcV/Ds+3boc1JC
 PIF67Rhzc3PT5OrM1fEn2P0IjP1z6CClWUIhE7AZoJL9qIuBF127iM40Wiqfl16mVTls
 y0kbvd8UsUY2I5C41BsBCgqbIzIvRjDAttpYqQOt9pYDzV2XxigNq5Z9Pc9PMG8FPckm
 S1sdkoUXgZiVdSq/3+S451XWsDYT8Sz/yauUSdAoHUYkpOPC53/ZScZJ04xPw5uVwFKG
 ThyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=REMZhIoF9B9JfiQcEKTvAiC+ThfAR4nspfGdmFqV4Qw=;
 b=Yny+yblzzeEabVOy2Tod/TL8MHfEzAWH0InRja7yqnuTjl+Z+bs7KrgMCtHZ/6/dQn
 rgGJMzEehPRtzjbDfRupqz6iKaTuK6rDmDiRvtHdbEg1SUZ5wPH0+UOCw+jiucj/W7mF
 KCTg/47j4i6GeN949/ZpxX0pPSGj0jgFAMb/AfNlz39Rgwez+rEU7dKoDahP8EcMk+T+
 6N7CcYGsXNTMOypJoT2BT+Ab6plRer/M2z6L1HIsPKmuqvrbamhtuJvlxPC3JQR1JmrT
 O3/lqTulHic95CKC1NNCiIIlGqU5G9zoDsMn9wuBXsNdWhdZGmDrG7KRelOW2Gawl/g3
 Ki7g==
X-Gm-Message-State: ACrzQf2DPnmMJdI4s7QOWoS165p8nA0/g8HgG04QzKEOL+6ZN6H+tKPO
 1fvpDZSatfCfS9zlaZ3Lrkd7b5JrQIfv+w==
X-Google-Smtp-Source: AMsMyM48/KJ7cWX1csGxA91kNt+OJySFy9rAvkRgcShNPDoUEN+0gHJQKL0qGfW9vMbvouqimTfJFg==
X-Received: by 2002:a17:906:cc5b:b0:7a9:e58d:bad9 with SMTP id
 mm27-20020a170906cc5b00b007a9e58dbad9mr12557602ejb.237.1666793398538; 
 Wed, 26 Oct 2022 07:09:58 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
 by smtp.googlemail.com with ESMTPSA id
 ka3-20020a170907990300b0073cd7cc2c81sm3022156ejc.181.2022.10.26.07.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Oct 2022 07:09:57 -0700 (PDT)
From: Alessandro Carminati <alessandro.carminati@gmail.com>
To: ltp@lists.linux.it
Date: Wed, 26 Oct 2022 14:04:06 +0000
Message-Id: <20221026140408.471609-1-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <[LTP] [PATCH] Fix tst_find_backing_dev when no initramfs>
References: <[LTP] [PATCH] Fix tst_find_backing_dev when no initramfs>
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

Working on minor fixes, I noticed a strong dependency from the test suite
and sysfs.
Many tests, including the one that triggered the mail in the first place,
simply terminate broken when no sysfs is there.
The motivation that kept the old montinfo at its place, do not stand, and
in my opinion, the montinfocan be dropped altogether.

The following is an example of what happen to a test that supports both
methods:
in this first, the test uses the uevent strategy

% /usr/lib/ltp-testsuite/testcases/bin/ioctl_loop05
tst_test.c:1363: TINFO: Timeout per run is 0h 05m 00s
tst_test.c:1115: TINFO: ext2/ext3/ext4 is supported by the test
tst_device.c:91: TINFO: Found free device 0 '/dev/loop0'
loop0: detected capacity change from 0 to 2048
tst_device.c:570: TINFO: Device name retrived through uevent
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

in this second, the sysfs is unmounted, and the test uses the backup
mountinfo strategy

% ln -s /dev/sda /dev/root
% umount /sys
% /usr/lib/ltp-testsuite/testcases/bin/ioctl_loop05
tst_test.c:1363: TINFO: Timeout per run is 0h 05m 00s
tst_test.c:1115: TINFO: ext2/ext3/ext4 is supported by the test
tst_device.c:91: TINFO: Found free device 0 '/dev/loop0'
loop0: detected capacity change from 0 to 2048
tst_device.c:570: TINFO: Device name retrived through mountinfo
ioctl_loop05.c:126: TINFO: backing dev(/dev/root) logical_block_size is 512
ioctl_loop05.c:62: TINFO: Without setting lo_offset or sizelimit
ioctl_loop05.c:45: TINFO: In dio mode
ioctl_loop05.c:48: TPASS: lo_flags has LO_FLAGS_DIRECT_IO flag
ioctl_loop05.c:52: TBROK: Failed to open FILE '/sys/block/loop0/loop/dio' for reading: ENOENT (2)

Summary:
passed   1
failed   0
broken   1
skipped  0
warnings 0
%

The fact that whithout sysfs the backing device can't be found is not
relevant since the test fails with broken.

As a consequence of the drop of the mountinfo strategy, the API
documentation needs to be updated.

Alessandro Carminati (2):
  tst_find_backing_dev: Get dev name from /sys/dev/block/*/uevent
  c-test-api: Documentation updated

 doc/c-test-api.txt |  7 +++----
 lib/tst_device.c   | 41 ++++++++++-------------------------------
 2 files changed, 13 insertions(+), 35 deletions(-)

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
