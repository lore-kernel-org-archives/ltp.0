Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82711C43334
	for <ltp@archiver.kernel.org>; Wed, 15 Jun 2022 10:21:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC7AC3C1BBD
	for <ltp@archiver.kernel.org>; Wed, 15 Jun 2022 12:21:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67F6E3C0756
 for <ltp@lists.linux.it>; Wed, 15 Jun 2022 12:20:58 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DBF4C1400346
 for <ltp@lists.linux.it>; Wed, 15 Jun 2022 12:20:57 +0200 (CEST)
Received: by mail-ej1-x62e.google.com with SMTP id bg6so22383632ejb.0
 for <ltp@lists.linux.it>; Wed, 15 Jun 2022 03:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ht5yNJv6U/VAL82aX6i5nQDIRsBdgWpM9aDfCPLHOJc=;
 b=aHOydtVyEBWVd0DRrbNy5j5N5WGuuowKT9sw4hEBJ6TZItYU5k6sA4MlZXrtRvYeAg
 XISZ8sfOJaaSbM+n74oZ7e9+3yw23r2pPbIr5lR2bP87N2rSoDMV/pEjtXWqLGFZRuVE
 /D6Eq0e6e43r6vq56RwXwL1alkxk2fjzVw60uZRKFOfILAgja+Ci/AkvFrDG5T4r0GMB
 D66v263NUoGpWEmgwuSt2a/hPVPdYBvGFUmj9kZtztDkEtS09Zzg99jbkgr4LyQ03NmR
 GGf7OyBFh4iy2GygxhM1tiXUqWDzLJOyY3T6Ct0dujnFaMHHgof3ogGi4Ssya/0gIad9
 UVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ht5yNJv6U/VAL82aX6i5nQDIRsBdgWpM9aDfCPLHOJc=;
 b=jQlMu11VLlTFszXkW08dxOyYIz1lP+/NGM6ojUwPvJIXDXv9jWSIEwH8IWZ6rn81pq
 gp5YF3ALG54dE2JMDqkp+HtVO8ox+tozAZEbeGi/0pQ7HKqBAqnItRXWFoyqjeZjDrtX
 iGJGxoEKRSiKEanzVfpAqAC+zuGBng8uEEV2iiXP2FeAjDZ7a6nlz12z4t++0stR58Z3
 sVJSf2emc8CJMs8iZBsC3L4Ki4LZCnzJ45zIwPGcMrNmY5exodLJmMlae25ZmOeWDaBI
 Q9+HUgoN8QRB+zG3GAUfCUsV0hGjzJ0c8qWx1Sa+y8G3MJUbzd9OnRkuI/E1/XivE7Ee
 0LaQ==
X-Gm-Message-State: AJIora9ZLzeve32RRKF002+M++tdb7Dn18qKJD2sLb7AA9bMTKPIVUee
 VxeKkmmpsyQDoGnAKvnjzJJGRSFwFyawW6XEz/E=
X-Google-Smtp-Source: ABdhPJwA0YhVpMtFFLsm5nOXKfp12AEPXdYN/grs2h9+q/PZbwjRdUwlAdKtIvQXKw6771NyM4E7VhAj/uqpfTbYbQA=
X-Received: by 2002:a17:906:739d:b0:713:c3f4:6ef with SMTP id
 f29-20020a170906739d00b00713c3f406efmr8110222ejl.180.1655288457343; Wed, 15
 Jun 2022 03:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220615081212.GF36441@xsang-OptiPlex-9020>
In-Reply-To: <20220615081212.GF36441@xsang-OptiPlex-9020>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 15 Jun 2022 13:20:44 +0300
Message-ID: <CAOQ4uxgHPgFTWBOF34=UDtaCOk0EA6f=66szS-Ox62YNPx1b=A@mail.gmail.com>
To: kernel test robot <oliver.sang@intel.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [vfs] 0b398f980a: ltp.copy_file_range01.fail
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
Cc: CIFS <linux-cifs@vger.kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 kbuild test robot <lkp@intel.com>, Luis Henriques <lhenriques@suse.de>,
 lkp@lists.01.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jun 15, 2022 at 11:12 AM kernel test robot
<oliver.sang@intel.com> wrote:
>
>
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-11):
>
> commit: 0b398f980a75ee5e5d7317a9d0e5860e4c79e9b8 ("vfs: fix copy_file_range() regression in cross-fs copies")
> https://github.com/amir73il/linux copy-file-range-fixes
>
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20220614
> with following parameters:
>
>         disk: 1HDD
>         fs: ext4
>         test: syscalls-03
>         ucode: 0xec
>
> test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/
>
>
> on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
> <<<test_start>>>
> tag=copy_file_range01 stime=1655248189
> cmdline="copy_file_range01"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
> tst_test.c:1526: TINFO: Timeout per run is 0h 02m 30s
> tst_supported_fs_types.c:89: TINFO: Kernel supports ext2
> tst_supported_fs_types.c:51: TINFO: mkfs.ext2 does exist
> tst_supported_fs_types.c:89: TINFO: Kernel supports ext3
> tst_supported_fs_types.c:51: TINFO: mkfs.ext3 does exist
> tst_supported_fs_types.c:89: TINFO: Kernel supports ext4
> tst_supported_fs_types.c:51: TINFO: mkfs.ext4 does exist
> tst_supported_fs_types.c:89: TINFO: Kernel supports xfs
> tst_supported_fs_types.c:51: TINFO: mkfs.xfs does exist
> tst_supported_fs_types.c:89: TINFO: Kernel supports btrfs
> tst_supported_fs_types.c:51: TINFO: mkfs.btrfs does exist
> tst_supported_fs_types.c:89: TINFO: Kernel supports vfat
> tst_supported_fs_types.c:51: TINFO: mkfs.vfat does exist
> tst_supported_fs_types.c:115: TINFO: Filesystem exfat is not supported
> tst_supported_fs_types.c:119: TINFO: FUSE does support ntfs
> tst_supported_fs_types.c:51: TINFO: mkfs.ntfs does exist
> tst_supported_fs_types.c:89: TINFO: Kernel supports tmpfs
> tst_supported_fs_types.c:38: TINFO: mkfs is not needed for tmpfs
> tst_test.c:1599: TINFO: Testing on ext2
> tst_test.c:1064: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
> mke2fs 1.46.2 (28-Feb-2021)
> copy_file_range.h:36: TINFO: Testing libc copy_file_range()
> copy_file_range01.c:133: TFAIL: copy_file_range() failed: EOPNOTSUPP (95)
> copy_file_range01.c:133: TFAIL: copy_file_range() failed: EOPNOTSUPP (95)
>
> ...
>
> copy_file_range01.c:133: TFAIL: copy_file_range() failed: EOPNOTSUPP (95)
> copy_file_range01.c:133: TFAIL: copy_file_range() failed: EOPNOTSUPP (95)
> copy_file_range01.c:210: TFAIL: non cross-device copy_file_range failed 144 of 144 copy jobs.


First of all, good catch! and thanks for testing my github branches :)
I should not have changed the behavior for non cross-device copy.

Second, the history of cross-device copy is hazy - old kernels do not support
it then v5.3 does support it and now we want to un-support it again,
so it's nice
to see that the work that Petr did on this test to work correctly by first
testing verify_cross_fs_copy_support() works as expected and the test passes
with my fixed patch.

Will post v15 soon...

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
