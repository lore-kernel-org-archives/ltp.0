Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF99BC4706C
	for <ltp@archiver.kernel.org>; Fri, 12 Jan 2024 05:15:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C92CC3CD0D6
	for <ltp@archiver.kernel.org>; Fri, 12 Jan 2024 06:15:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65F243C1BC7
 for <ltp@lists.linux.it>; Fri, 12 Jan 2024 06:15:20 +0100 (CET)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3EB69208DED
 for <ltp@lists.linux.it>; Fri, 12 Jan 2024 06:15:20 +0100 (CET)
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-4b72f2bdbdaso1756720e0c.3
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 21:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705036519; x=1705641319; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IgIz5Jw3xaCiRypp9t/7nFofZKzAWe2AVuDOEAahvJw=;
 b=f8uoHCsT5xilz2u5wJSi19SU0/4XpD4/gF3aJbgtyyh7TyyYZifucV+s5tCWRVdnDZ
 FvT93i8bUafF0imUiq/C/4Nys877kG7hQq/iIH6oNG9LZYb+4BALFgMlGtIrEb3Bw+4U
 1uIaQrS1HZYDqIt0fCKrQamHDD2XBbX4Lt/dtZIoat0+LfFo5VsZ9E9A2F0o+d7e8zqK
 V6ARIVVoOsi9OQmu9/oFg3IZkDWLTRK/0SxoHwUIGLV5P0bV7RBVcKByQUG9oaxKvC+b
 Otp0NU9z5Cn1E20iPfADKmKl2V0DaKQRqQbqwtu8g4Rzm9fp9UrGGvimo9wGAqikID1A
 lh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705036519; x=1705641319;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IgIz5Jw3xaCiRypp9t/7nFofZKzAWe2AVuDOEAahvJw=;
 b=WbtwhPj3+PlqYJaa0rq7nZND7NXteLp3ml1JcWD1dew2AZazcFMBpOdHLwG1x0lGmh
 3D35EnQxalgqDvDtA66dXy4C+wESvV3oMU9/5d82zrhbeIo6R1ut3g1QqYLadYFulx9v
 qts6gzuHHYEmaM7ngFZ6AgPG8Nr9WGggPKshdodSHTbwg8+qG8evjeLiOBz9pnfbh2fJ
 RVtN+B8SDv8grkf0NkoXqQi88IDo7jl2rj6Z3Xp5eTQsF20mC3lZ8qagxT6P1GwakvIG
 hhuA1xcG2mlhLEyToP71hhpMSTSEXVnd5O3W3l+l2RT5H9Fx1CU8mt6CFMMOnqRt7ITO
 dYoQ==
X-Gm-Message-State: AOJu0YxG5gf6XnO/9t03UCJLAA8qqXFOQCvmBQWbU3hyLdqI1EXDrlzs
 DlrTel79ylrinD3xLkaEl4d09SaXvnLGp6KsYfHlHqOFnatWPw==
X-Google-Smtp-Source: AGHT+IHPLvPAb+MT+s200UzDgvlLJVHSQjmJYTb0cHfWBa5Vn8ew9C7G9AwMneG0HO+in1yTFy80+h7ZYa1cXDFsG/w=
X-Received: by 2002:a05:6122:4d0e:b0:4b7:a95b:7b3 with SMTP id
 fi14-20020a0561224d0e00b004b7a95b07b3mr706190vkb.26.1705036518758; Thu, 11
 Jan 2024 21:15:18 -0800 (PST)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 12 Jan 2024 10:45:08 +0530
Message-ID: <CA+G9fYu1hB2OMf0EFrt_86OE=0Ug3y6nQd3=OZeEeM1jp3P92g@mail.gmail.com>
To: linux-block <linux-block@vger.kernel.org>, LTP List <ltp@lists.linux.it>, 
 Linux Regressions <regressions@lists.linux.dev>,
 lkft-triage@lists.linaro.org, open list <linux-kernel@vger.kernel.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] scsi: block: ioprio: Clean up interface definition -
 ioprio_set03.c:40: TFAIL: ioprio_set IOPRIO_CLASS_BE prio 8 should not work
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
Cc: Jens Axboe <axboe@kernel.dk>, Niklas Cassel <niklas.cassel@wdc.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The LTP test 'iopri_set03' fails on all the devices.
It fails on linux kernel >= v6.5. ( on Debian rootfs ).
Test fail confirmed on LTP release 20230929 and 20230516.

Test failed log:
------------
tst_test.c:1690: TINFO: LTP version: 20230929
tst_test.c:1574: TINFO: Timeout per run is 0h 05m 00s
ioprio_set03.c:40: TFAIL: ioprio_set IOPRIO_CLASS_BE prio 8 should not work
ioprio_set03.c:48: TINFO: tested illegal priority with class NONE
ioprio_set03.c:51: TPASS: returned correct error for wrong prio: EINVAL (22)

Investigation:
----------
Bisecting this test between kernel v6.4 and v6.5 shows patch
eca2040972b4 ("scsi: block: ioprio: Clean up interface definition")
as the first faulty commit.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240109/testrun/22021120/suite/ltp-syscalls/test/ioprio_set03/details/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240110/testrun/22034175/suite/ltp-syscalls/test/ioprio_set03/history/

Steps to reproduce:
---------------
This is how you can reproduce it easily:
Install podman or docker, tuxmake and tuxrun, if docker please change
the --runtime below to docker.
cd into the kernel you want to build:
$ tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig defconfig --results-hook 'tuxrun --runtime podman --device
qemu-arm64 --boot-args rw --tuxmake ./ --rootfs
https://storage.tuxboot.com/debian/bookworm/arm64/rootfs.ext4.xz
--parameters SKIPFILE=skipfile-lkft.yaml --timeouts boot=30 --overlay
https://storage.tuxboot.com/overlays/debian/bookworm/arm64/ltp/20230929/ltp.tar.xz
/ --save-outputs --log-file - -- "cd /opt/ltp && ./runltp -s
ioprio_set03"'


Bisection log:
------------
# bad: [2dde18cd1d8fac735875f2e4987f11817cc0bc2c] Linux 6.5
# good: [6995e2de6891c724bfeb2db33d7b87775f913ad1] Linux 6.4
git bisect start 'v6.5' 'v6.4'
# good: [b775d6c5859affe00527cbe74263de05cfe6b9f9] Merge tag
'mips_6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
git bisect good b775d6c5859affe00527cbe74263de05cfe6b9f9
# bad: [56cbceab928d7ac3702de172ff8dcc1da2a6aaeb] Merge tag
'usb-6.5-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect bad 56cbceab928d7ac3702de172ff8dcc1da2a6aaeb
# good: [b30d7a77c53ec04a6d94683d7680ec406b7f3ac8] Merge tag
'perf-tools-for-v6.5-1-2023-06-28' of
git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next
git bisect good b30d7a77c53ec04a6d94683d7680ec406b7f3ac8
# bad: [dfab92f27c600fea3cadc6e2cb39f092024e1fef] Merge tag
'nfs-for-6.5-1' of git://git.linux-nfs.org/projects/trondmy/linux-nfs
git bisect bad dfab92f27c600fea3cadc6e2cb39f092024e1fef
# bad: [28968f384be3c064d66954aac4c534a5e76bf973] Merge tag
'pinctrl-v6.5-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
git bisect bad 28968f384be3c064d66954aac4c534a5e76bf973
# bad: [af92c02fb2090692f4920ea4b74870940260cf49] Merge patch series
"scsi: fixes for targets with many LUNs, and scsi_target_block rework"
git bisect bad af92c02fb2090692f4920ea4b74870940260cf49
# bad: [2e2fe5ac695a00ab03cab4db1f4d6be07168ed9d] scsi: 3w-xxxx: Add
error handling for initialization failure in tw_probe()
git bisect bad 2e2fe5ac695a00ab03cab4db1f4d6be07168ed9d
# good: [8759924ddb93498bd5777f0b05b6bc9cacf4ffe3] Merge patch series
"scsi: hisi_sas: Some misc changes"
git bisect good 8759924ddb93498bd5777f0b05b6bc9cacf4ffe3
# good: [7907ad748bdba8ac9ca47f0a650cc2e5d2ad6e24] Merge patch series
"Use block pr_ops in LIO"
git bisect good 7907ad748bdba8ac9ca47f0a650cc2e5d2ad6e24
# bad: [390e2d1a587405a522dc6b433d45648f895a352c] scsi: sd: Handle
read/write CDL timeout failures
git bisect bad 390e2d1a587405a522dc6b433d45648f895a352c
# bad: [734326937b65cec7ffd00bfbbce0f791ac4aac84] scsi: core: Rename
and move get_scsi_ml_byte()
git bisect bad 734326937b65cec7ffd00bfbbce0f791ac4aac84
# bad: [6c913257226a25879bfd6226e0ee265e98904ce6] scsi: block:
Introduce ioprio hints
git bisect bad 6c913257226a25879bfd6226e0ee265e98904ce6
# bad: [eca2040972b411ec27483bf75dc8b84e730e88ff] scsi: block: ioprio:
Clean up interface definition
git bisect bad eca2040972b411ec27483bf75dc8b84e730e88ff
# first bad commit: [eca2040972b411ec27483bf75dc8b84e730e88ff] scsi:
block: ioprio: Clean up interface definition


--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
