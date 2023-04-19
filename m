Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C335C77B73
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 07:57:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AF6D3CC00D
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 09:57:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 486713C8663
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 09:57:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4B50C200963
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 09:57:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EDD5021905;
 Wed, 19 Apr 2023 07:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1681891022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cD0t6NezfCDx0oKUGN4T+tmhx6pXCtbhV9oaU4kpHdY=;
 b=EPo0mk3BYne87vJI2zTBTtu9HzS4K8UbNwODrdDrEwQJGbnYjH3YQTJx4RWm4FFRnOCoww
 a9QvMkMj7anBtRkY0XyvEgzQZSjaaA6G9nFXIvmFRp2KtO3dTF9nt6Cc2dmQWxTbNQCmIs
 K1rSdWq9+rcLTqbeZcDXns+lwZ/YlOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1681891022;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cD0t6NezfCDx0oKUGN4T+tmhx6pXCtbhV9oaU4kpHdY=;
 b=+gYItwCqq24saD8UfWri5YBsxgw894Q6hcBVfdc0fyTmvyoLsJxZ4eF2YY54L5w+xyvX2q
 EyI2j8KhVW4BrrAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8357B1390E;
 Wed, 19 Apr 2023 07:57:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UooJIM6eP2QlVAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 19 Apr 2023 07:57:02 +0000
Date: Wed, 19 Apr 2023 09:58:05 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <ZD+fDeWVOXklD01f@yuki>
References: <20230418120304.658273364@linuxfoundation.org>
 <CA+G9fYuT3N0LFaJGzQW2SYPJxEbEWLONDZO2OfBbeHNrsowy2w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYuT3N0LFaJGzQW2SYPJxEbEWLONDZO2OfBbeHNrsowy2w@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5.4 00/92] 5.4.241-rc1 review
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
Cc: shuah@kernel.org, f.fainelli@gmail.com, Arnd Bergmann <arnd@arndb.de>,
 rwarsow@gmx.de, pavel@denx.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LTP List <ltp@lists.linux.it>, patches@lists.linux.dev, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org,
 srw@sladewatkins.net, patches@kernelci.org, akpm@linux-foundation.org,
 jonathanh@nvidia.com, torvalds@linux-foundation.org,
 sudipm.mukherjee@gmail.com, linux@roeck-us.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > This is the start of the stable review cycle for the 5.4.241 release.
> > There are 92 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 20 Apr 2023 12:02:44 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.241-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> 
> Recently we have upgraded the LTP test suite version and started noticing
> these test failures on 5.4.
> Test getting skipped on 4.19 and 4.14 as not supported features.
> 
> Need to investigate test case issues or kernel issues.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> NOTE:
> 
> ---
> creat09.c:73: TINFO: User nobody: uid = 65534, gid = 65534
> creat09.c:75: TINFO: Found unused GID 11: SUCCESS (0)
> creat09.c:120: TINFO: File created with umask(0)
> creat09.c:106: TPASS: mntpoint/testdir/creat.tmp: Owned by correct group
> creat09.c:112: TPASS: mntpoint/testdir/creat.tmp: Setgid bit not set
> creat09.c:106: TPASS: mntpoint/testdir/open.tmp: Owned by correct group
> creat09.c:112: TPASS: mntpoint/testdir/open.tmp: Setgid bit not set
> creat09.c:120: TINFO: File created with umask(S_IXGRP)
> creat09.c:106: TPASS: mntpoint/testdir/creat.tmp: Owned by correct group
> creat09.c:110: TFAIL: mntpoint/testdir/creat.tmp: Setgid bit is set
> creat09.c:106: TPASS: mntpoint/testdir/open.tmp: Owned by correct group
> creat09.c:110: TFAIL: mntpoint/testdir/open.tmp: Setgid bit is set
> 
> Test history links,
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.238-199-g230f1bde44b6/testrun/16338751/suite/ltp-syscalls/test/creat09/history/
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.238-199-g230f1bde44b6/testrun/16337895/suite/ltp-cve/test/cve-2018-13405/history/
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.238-199-g230f1bde44b6/testrun/16338751/suite/ltp-syscalls/test/creat09/log

That's likely a missing kernel patch, as this is a regression test there
should have been links to the patches and CVE referencies in the test
output as the test is tagged with kernel commits and CVE numbers:

        .tags = (const struct tst_tag[]) {
                {"linux-git", "0fa3ecd87848"},
                {"CVE", "2018-13405"},
                {"CVE", "2021-4037"},
                {"linux-git", "01ea173e103e"},
                {"linux-git", "1639a49ccdce"},
                {"linux-git", "426b4ca2d6a5"},
                {}
        },

> ---
> 
> fanotify14.c:161: TCONF: FAN_REPORT_TARGET_FID not supported in kernel?
> fanotify14.c:157: TINFO: Test case 7: fanotify_init(FAN_CLASS_NOTIF |
> FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_FID, O_RDONLY)
> fanotify14.c:161: TCONF: FAN_REPORT_TARGET_FID not supported in kernel?
> [  377.081993] EXT4-fs (loop0): mounting ext3 file system using the
> ext4 subsystem
> fanotify14.c:157: TINFO: Test case 8: fanotify_init(FAN_CLASS_NOTIF |
> FAN_REPORT_DFID_FID, O_RDONLY)
> [  377.099137] EXT4-fs (loop0): mounted filesystem with ordered data
> mode. Opts: (null)
> fanotify14.c:175: TFAIL: fanotify_init(tc->init.flags, O_RDONLY)
> failed: EINVAL (22)

Possibly like the test may be missing check for a FAN_REPORT_DFID_FID
support.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
