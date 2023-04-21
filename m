Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A24C77B78
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 08:05:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB09E3CBEE3
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 10:05:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47A953CB32D
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 10:04:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 635751A00268
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 10:04:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 963E721A36;
 Fri, 21 Apr 2023 08:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682064290;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5StWWj+w1KUl4+HyVtWVGj32yDGQYLskTdzziZvHcn0=;
 b=tBma7/5H8UACRRP4uhvJ1XFPn0cH5j87T3qGW5EBO+mjIS+UpgC6Kp9CbIvkuVFxcv3HmV
 mpHfUxgxr0jYLovLDfdbyF2fd6WThEelBW3YH29mk338JQ93PhOwS/7vjbaOXtNMkUr/ay
 TaVk9Jd3URPZ+G/Nd/RK5XnhqPwimCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682064290;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5StWWj+w1KUl4+HyVtWVGj32yDGQYLskTdzziZvHcn0=;
 b=pGOhMt1TaBvJ2SFwx/cL7Fyxn0YXubuwyXUcqKRDAcHN9jWU1b/vMviKlXpPOJNcY8f2Gm
 gzSYk5p9bYsSTACQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F09DB1390E;
 Fri, 21 Apr 2023 08:04:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FPpMOaFDQmQUJAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Apr 2023 08:04:49 +0000
Date: Fri, 21 Apr 2023 10:04:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230421080455.GB2747101@pevik>
References: <20230418120304.658273364@linuxfoundation.org>
 <CA+G9fYuT3N0LFaJGzQW2SYPJxEbEWLONDZO2OfBbeHNrsowy2w@mail.gmail.com>
 <ZD+fDeWVOXklD01f@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZD+fDeWVOXklD01f@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: lkft-triage@lists.linaro.org, linux-kernel@vger.kernel.org,
 shuah@kernel.org, f.fainelli@gmail.com, jonathanh@nvidia.com,
 patches@kernelci.org, linux@roeck-us.net, Arnd Bergmann <arnd@arndb.de>,
 srw@sladewatkins.net, LTP List <ltp@lists.linux.it>, rwarsow@gmx.de,
 pavel@denx.de, patches@lists.linux.dev, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > This is the start of the stable review cycle for the 5.4.241 release.
> > > There are 92 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.

> > > Responses should be made by Thu, 20 Apr 2023 12:02:44 +0000.
> > > Anything received after that time might be too late.

> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.241-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > > and the diffstat can be found below.

> > > thanks,

> > > greg k-h


> > Recently we have upgraded the LTP test suite version and started noticing
> > these test failures on 5.4.
> > Test getting skipped on 4.19 and 4.14 as not supported features.

> > Need to investigate test case issues or kernel issues.

> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

> > NOTE:

> > ---
> > creat09.c:73: TINFO: User nobody: uid = 65534, gid = 65534
> > creat09.c:75: TINFO: Found unused GID 11: SUCCESS (0)
> > creat09.c:120: TINFO: File created with umask(0)
> > creat09.c:106: TPASS: mntpoint/testdir/creat.tmp: Owned by correct group
> > creat09.c:112: TPASS: mntpoint/testdir/creat.tmp: Setgid bit not set
> > creat09.c:106: TPASS: mntpoint/testdir/open.tmp: Owned by correct group
> > creat09.c:112: TPASS: mntpoint/testdir/open.tmp: Setgid bit not set
> > creat09.c:120: TINFO: File created with umask(S_IXGRP)
> > creat09.c:106: TPASS: mntpoint/testdir/creat.tmp: Owned by correct group
> > creat09.c:110: TFAIL: mntpoint/testdir/creat.tmp: Setgid bit is set
> > creat09.c:106: TPASS: mntpoint/testdir/open.tmp: Owned by correct group
> > creat09.c:110: TFAIL: mntpoint/testdir/open.tmp: Setgid bit is set

> > Test history links,
> >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.238-199-g230f1bde44b6/testrun/16338751/suite/ltp-syscalls/test/creat09/history/
> >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.238-199-g230f1bde44b6/testrun/16337895/suite/ltp-cve/test/cve-2018-13405/history/
> >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.238-199-g230f1bde44b6/testrun/16338751/suite/ltp-syscalls/test/creat09/log

> That's likely a missing kernel patch, as this is a regression test there
> should have been links to the patches and CVE referencies in the test
> output as the test is tagged with kernel commits and CVE numbers:

>         .tags = (const struct tst_tag[]) {
>                 {"linux-git", "0fa3ecd87848"},
>                 {"CVE", "2018-13405"},
>                 {"CVE", "2021-4037"},
>                 {"linux-git", "01ea173e103e"},
Only this one has been backported (as
e76bd6da51235ce86f5a8017dd6c056c76da64f9), the other two are missing.
>                 {"linux-git", "1639a49ccdce"},
>                 {"linux-git", "426b4ca2d6a5"},
The last one is merge tag, I wonder if it's correct:
426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0' of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux")
Maybe just 1639a49ccdce would be ok.

@Yang Xu
1) why 1639a49ccdce has not been merged to stable tree? It does not apply now,
was that the only reason? Or is it not applicable?

@Yang Xu is really 426b4ca2d6a5 needed? Was it easier to list merge commit than
particular fixes? Merge commit contains:

5fadbd992996 ("ceph: rely on vfs for setgid stripping")
1639a49ccdce ("fs: move S_ISGID stripping into the vfs_*() helpers")
ac6800e279a2 ("fs: Add missing umask strip in vfs_tmpfile")
2b3416ceff5e ("fs: add mode_strip_sgid() helper")

They have not been backported to 5.4 stable, nor to the older releases.
Again, they don't apply.


>                 {}
>         },

> > ---

> > fanotify14.c:161: TCONF: FAN_REPORT_TARGET_FID not supported in kernel?
> > fanotify14.c:157: TINFO: Test case 7: fanotify_init(FAN_CLASS_NOTIF |
> > FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_FID, O_RDONLY)
> > fanotify14.c:161: TCONF: FAN_REPORT_TARGET_FID not supported in kernel?
> > [  377.081993] EXT4-fs (loop0): mounting ext3 file system using the
> > ext4 subsystem
> > fanotify14.c:157: TINFO: Test case 8: fanotify_init(FAN_CLASS_NOTIF |
> > FAN_REPORT_DFID_FID, O_RDONLY)
> > [  377.099137] EXT4-fs (loop0): mounted filesystem with ordered data
> > mode. Opts: (null)
> > fanotify14.c:175: TFAIL: fanotify_init(tc->init.flags, O_RDONLY)
> > failed: EINVAL (22)

> Possibly like the test may be missing check for a FAN_REPORT_DFID_FID
> support.

@Amir could you please look at this fanotify14.c failure on 5.4.241-rc1?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
