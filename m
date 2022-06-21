Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDD6C43334
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 06:52:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2E393C93DC
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 08:52:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 628043C21D9
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 08:52:07 +0200 (CEST)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 71B986001E9
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 08:52:06 +0200 (CEST)
Received: from [10.40.94.3] (unknown [37.24.96.116])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 6EF739F7FD;
 Tue, 21 Jun 2022 06:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1655794306; bh=5AkBPEz+YxaMX2AatPeBhBSjCb0OEBJJi/NKKgNpDLg=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=Vqfh0Hgvr/Pba2lFT8khFTXUO2Xn3Qhe8h2eIp19tquBu/EmhkkiIloGKoYRFK2d9
 qCIAvP1KT33mmysn5vUaVxzrpDOw9mNGUxKP5qmLSt/+hEX+O8exgk6S6XQmrlTKTM
 XROHBvikXJLTDsBblclho2Q3xw0FT+Gcz4GicL0g=
Message-ID: <762be123-13ad-1fcf-e4f3-846c7e1b236a@jv-coder.de>
Date: Tue, 21 Jun 2022 08:51:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To: Cristian Marussi <cristian.marussi@arm.com>, ltp@lists.linux.it
References: <20220620133746.99167-1-cristian.marussi@arm.com>
From: Joerg Vehlow <lkml@jv-coder.de>
In-Reply-To: <20220620133746.99167-1-cristian.marussi@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Fix mountns01/02/03/04 final umounts using
 more peculiar dir names
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

Hi,

Am 6/20/2022 um 3:37 PM schrieb Cristian Marussi:
> Running LTP20220527 release it appears that the recently re-written tests
> mountns02/03/04 can now throw a warning on their final umount attempt in
> some setup:
> 
> <<<test_output>>>
> tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
> mountns04.c:38: TPASS: unbindable mount passed
> tst_device.c:395: TWARN: umount('A') failed with EINVAL
> mountns.h:36: TWARN: umount(A) failed: EINVAL (22)
> tst_device.c:434: TINFO: No device is mounted at B
> 
> Moreover, the underlying safe_umount() then upgrades the TWARN emitted
> from tst_umount to a TBROK, so causing the test to completely fail:
> 
> Summary:
> passed   1
> failed   0
> broken   0
> skipped  0
> warnings 2
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=4 corefile=no
> 
> Even though the final SAFE_UMOUNTs in the test body properly unmount the
> test created mountpoints, the final cleanup functions, that finally check
> to see if those mountpoints are still mounted, can be fooled into falsely
> thinking that test-chosen mountpoints "A" or "B" are still there: this is
> due to the fact that the internal helper tst_is_mounted() uses a simple
> strstr() on /proc/mounts to check if a directory is still mounted and
> clearly the currently test-chosen names are far too much simple, being
> one-letter, and they can be easily matched by other unrelated mountpoints
> that happen to exist on a specific setup.
> 
> Use a more peculiar naming for the test chosen mountpoints and generalize
> accordingly all the comments.
> 
> Cc: Andrea Cervesato <andrea.cervesato@suse.de>
> Cc: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v1 --> v2
> - using more peculiar naming for mountpoints
> - fix comments
> - dropped previous SAFE_UMONUT removal
> 
> A better, more long term fix should be to fix/harden tst_is_mounted logic,
> but looking at mountpoint(1) implementation this is far from trivial to
> be done (especially for bind mounts) and it would require a bit of
> 're-inventing the wheel' to bring all the mountpoint/libmount helpers and
> logic inside LTP; on the other side a dirty and ugly solution based on
> something like tst_system("mountpoint -q <dir>") would be less portable
> since would add the new mountpoint application as an LTP pre-requisite.
> (and so just breaking a few CI probably without having a 'mountpoint-less'
> failover mechanism)...so I just generalized the chosen names for now...
> ---
>  testcases/kernel/containers/mountns/mountns.h  |  4 ++--
>  .../kernel/containers/mountns/mountns01.c      | 18 +++++++++---------
>  .../kernel/containers/mountns/mountns02.c      | 18 +++++++++---------
>  .../kernel/containers/mountns/mountns03.c      | 18 +++++++++---------
>  .../kernel/containers/mountns/mountns04.c      |  8 ++++----
>  5 files changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/testcases/kernel/containers/mountns/mountns.h b/testcases/kernel/containers/mountns/mountns.h
> index ad8befa71..347f0783a 100644
> --- a/testcases/kernel/containers/mountns/mountns.h
> +++ b/testcases/kernel/containers/mountns/mountns.h
> @@ -10,8 +10,8 @@
>  #include "tst_test.h"
>  #include "lapi/namespaces_constants.h"
>  
> -#define DIRA "A"
> -#define DIRB "B"
> +#define DIRA "__DIR_A"
> +#define DIRB "__DIR_B"
This is the only non-comment change. How does renaming the directories
change anything? Am I missing something?

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
