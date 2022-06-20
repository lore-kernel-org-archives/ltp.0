Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2C0C43334
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 10:27:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F3D13C9221
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 12:26:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D01D23C08E1
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 12:26:48 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id 1052D6000ED
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 12:26:46 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97E20113E;
 Mon, 20 Jun 2022 03:26:44 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0473A3F7D7;
 Mon, 20 Jun 2022 03:26:43 -0700 (PDT)
Date: Mon, 20 Jun 2022 11:26:37 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YrBLXWOAcpujtG4p@e120937-lin>
References: <20220617172641.122296-1-cristian.marussi@arm.com>
 <62AFFE20.1080106@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <62AFFE20.1080106@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix mountns01/02/03/04 removing unneeded final
 umounts
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Jun 20, 2022 at 03:55:53AM +0000, xuyang2018.jy@fujitsu.com wrote:
> Hi  Cristian
> 

Hi Yang Xu

thanks for the feedback.

> > Running LTP20220527 release it appears that the recently re-written tests
> > mountns02/03/04 now throw a warning on their final umount attempt:
> >
> > <<<test_output>>>
> > tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
> > mountns04.c:38: TPASS: unbindable mount passed
> > tst_device.c:395: TWARN: umount('A') failed with EINVAL
> > mountns.h:36: TWARN: umount(A) failed: EINVAL (22)
> > tst_device.c:434: TINFO: No device is mounted at B
> 
> I guess this failure because /proc/mounts still has "A", so 
> tst_is_mounted returns true and umount failed.
> 
> we can reproduce it by using a /mnt/A mntpoint in /proc/mounts.

Yes indeed, reasoning about your feedback on this I think the issue
really is different from what I thought (my bad): it is the final
SAFE_UMOUNT in the cleanup function that fails really because the
tst_is_mounted() that protects it is based on a simnple strstr() on
/proc/mounts/ and the directory names used are too much simple ("A")
so it is sufficient to have some unrelated mountpoint like
"/mnt/this_is_Another_mnt" to fool tst_is_mounted and make it think
our "A" still needs to be removed.

This also would explin why this bug has not been noticed elsewhere...
...it depends on your final running environment. (i.e. mountpoints)

Using a bit more peculiar names like to __DIR_A __DIR_B solves for me
indeed:


root@debian-arm64-bullseye:~# ./mountns01
tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
mountns01.c:42: TPASS: shared mount in parent passed
mountns01.c:83: TPASS: shared mount in child passed
tst_device.c:434: TINFO: No device is mounted at __DIR_B

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
root@debian-arm64-bullseye:~# ./mountns02
tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
mountns02.c:45: TPASS: private mount in parent passed
mountns02.c:86: TPASS: private mount in child passed
tst_device.c:434: TINFO: No device is mounted at __DIR_A
tst_device.c:434: TINFO: No device is mounted at __DIR_B

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
root@debian-arm64-bullseye:~# ./mountns03
tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
mountns03.c:51: TPASS: propagation to slave mount passed
mountns03.c:94: TPASS: propagation from slave mount passed
tst_device.c:434: TINFO: No device is mounted at __DIR_A
tst_device.c:434: TINFO: No device is mounted at __DIR_B

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0
root@debian-arm64-bullseye:~# ./mountns04
tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
mountns04.c:38: TPASS: unbindable mount passed
tst_device.c:434: TINFO: No device is mounted at __DIR_A
tst_device.c:434: TINFO: No device is mounted at __DIR_B


> >
> > Moreover, the underlying safe_umount() then upgrades the TWARN emitted
> > from tst_umount to a TBROK, so causing the test to completely fail:
> >
> > Summary:
> > passed   1
> > failed   0
> > broken   0
> > skipped  0
> > warnings 2
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=0 termination_type=exited termination_id=4 corefile=no
> >
> > In fact, the final umounts on DIRA seem not needed in mountns02/03/04
> > looking at the previous chain of umounts calls and the tests logic and,
> > in any case, the .cleanup functions of all these tests take care to
> > finally unmount both DIRA/DIRB after having checked if they were still
> > mounted at all.
> >
> > Remove all the final SAFE_UMOUNT calls (even for mountns01) since all the
> > possibly needed umounts are already eventually performed by .cleanup.
> 
> Yes, it can fix this problem but these case still will fail when 
> /proc/mounts has a B mntpoint,
> 
> ie
>   mount /dev/sda11 /mnt/B
> ./mountns04
> tst_test.c:1528: TINFO: Timeout per run is 0h 00m 30s
> mountns04.c:38: TPASS: unbindable mount passed
> tst_device.c:395: TWARN: umount('B') failed with EINVAL
> mountns.h:39: TWARN: umount(B) failed: EINVAL (22)
> 
> So I think a right fix should fix the tst_is_mounted function or 
> umount_folders instead of removing final SAFE_UMOUNT.
> 

Agreed that the failure was elsewhere as above mentioned, so I will
keep the final SAFE_UMOUNT and just change the dir names and let the
cleanups remove what remains to be removed (e.g. in case of error)

Thanks,
Cristian

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
