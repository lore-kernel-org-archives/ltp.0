Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D150C32771
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 03:13:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 679203CACB3
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 05:13:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13AE83C945D
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 05:13:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 685FB14002B5
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 05:13:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 673981FB11;
 Mon, 19 Sep 2022 03:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663557226;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6peH+R3cd/sFU2E2lz14vVvHSTz56B5+TN+ZRMVovmQ=;
 b=1lzfjOyScBmkn5iE4bhW0ERud+W06yYYD9VyKryKirCMOSnL3JMg2h3AJw8HwSlSkoGIcx
 3HGv0Kqdx5KdnGSC3LvLwWycwAA5e8nfyaP41LNjMCHkkFE/7KDYjzaSAdcWVDtZIVqQfG
 AZcBJWcLEGgOeLfMvBOcOVVSdrEGSB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663557226;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6peH+R3cd/sFU2E2lz14vVvHSTz56B5+TN+ZRMVovmQ=;
 b=VoI6aMSW0uQgnbvABf4GI+Ga18V/vmCHA3BlaBb+fN/tKMbR93uu+f6blgJXFwe96Wpyo3
 ph5+HuGx1FnQ2RDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3AC9A13A4A;
 Mon, 19 Sep 2022 03:13:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UxZ3DGreJ2MiVwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 19 Sep 2022 03:13:46 +0000
Date: Mon, 19 Sep 2022 05:13:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: lkft@linaro.org
Message-ID: <YyfeaeMsvACB5dcf@pevik>
References: <010001834b528ae5-11a8d4c7-4e72-4f8d-af66-e9ec2a864017-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <010001834b528ae5-11a8d4c7-4e72-4f8d-af66-e9ec2a864017-000000@email.amazonses.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [REGRESSION] lkft ltp for cea142b
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Martin Doucha <martin.doucha@suse.com>, lkft-triage@lists.linaro.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> ## Build
> * kernel: 5.18.19
> * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
> * git branch: linux-5.18.y
> * git commit: 22a992953741ad79c07890d3f4104585e52ef26b
> * git describe: cea142b
> * test details: https://qa-reports.linaro.org/lkft/ltp/build/cea142b

> ## Test Regressions (compared to 98140f3)
> * qemu_i386, ltp-controllers
>   - cpuacct_100_100

> * qemu_x86_64, ltp-cve
>   - cve-2018-1000204
OK, 3252ea38d ("ioctl_sg01: Add max_runtime") didn't help.

looking at the log [1] I don't see anything obvious why test timeouts:

tst_test.c:1524: TINFO: Timeout per run is 0h 00m 30s
ioctl_sg01.c:81: TINFO: Found SCSI device /dev/sg1
Test timeouted, sending SIGKILL!
tst_test.c:1575: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1577: TBROK: Test killed! (timeout?)

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0

@lkft I haven't find dmesg after starting running tests in the test details [2].
Is there any? I really like you keep the history [3], thanks! It'd be great if
you could print the test name into dmesg, so that it can be visible which test
caused particular message / kernel oops.

Also, it'd be great if you could put some header for each test with the test
name or at least blank line to separate the end of the summary.

Kind regards,
Petr

[1] https://qa-reports.linaro.org/lkft/ltp/build/cea142b/testrun/11956785/suite/ltp-cve/test/cve-2018-1000204/log
[2] https://qa-reports.linaro.org/lkft/ltp/build/cea142b/testrun/11956785/suite/ltp-cve/test/cve-2018-1000204/details/
[3] https://qa-reports.linaro.org/lkft/ltp/build/cea142b/testrun/11956785/suite/ltp-cve/test/cve-2018-1000204/history/


> ## Metric Regressions (compared to 98140f3)
> No metric regressions found.

> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


> ## Test Fixes (compared to 98140f3)
> * qemu_arm64, ltp-controllers
>   - cpuacct_100_100


> ## Metric Fixes (compared to 98140f3)
> No metric fixes found.

> ## Test result summary
> total: 12630, pass: 10739, fail: 161, skip: 1730, xfail: 0

> ## Build Summary

> ## Test suites summary
> * log-parser-boot
> * log-parser-test
> * ltp-cap_bounds
> * ltp-commands
> * ltp-containers
> * ltp-controllers
> * ltp-cpuhotplug
> * ltp-crypto
> * ltp-cve
> * ltp-dio
> * ltp-fcntl-locktests
> * ltp-filecaps
> * ltp-fs
> * ltp-fs_bind
> * ltp-fs_perms_simple
> * ltp-fsx
> * ltp-hugetlb
> * ltp-io
> * ltp-ipc
> * ltp-math
> * ltp-mm
> * ltp-nptl
> * ltp-pty
> * ltp-sched
> * ltp-securebits
> * ltp-syscalls
> * ltp-tracing

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
