Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610EAC71133
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 08:27:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47C3A3CC480
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 10:27:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CC533CC3A5
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 10:27:05 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 23D931A00FD7
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 10:27:03 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F2B7363DF3;
 Fri, 25 Aug 2023 08:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09DFC433C7;
 Fri, 25 Aug 2023 08:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1692952021;
 bh=/0P/Vuu4CvmfjvkFoCAuWPAgUuDaHWfDtDf85MPvZxw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=q05XK44U5RagfHRVH0HdFvF60AQUL8F1lSh4qbFMj/4u21g+5OxK2QEgCC63YSqG3
 k7jQrPtv/h8eV9ROnJjknqx/dGefG+dblKD+BzZw3qBSYmJSnLtuMI0sko5lJqg3JL
 nUN210NrpBA3Xw/htCH1snORJ+3XyBpex2vJ0ejU=
Date: Fri, 25 Aug 2023 10:10:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <2023082512-amusement-luncheon-8d8d@gregkh>
References: <20230824141447.155846739@linuxfoundation.org>
 <CA+G9fYsPPpduLzJ4+GZe_18jgYw56=w5bQ2W1jnyWa-8krmOSw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYsPPpduLzJ4+GZe_18jgYw56=w5bQ2W1jnyWa-8krmOSw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6.1 00/15] 6.1.48-rc1 review
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
Cc: lkft-triage@lists.linaro.org, patches@lists.linux.dev,
 stable@vger.kernel.org, shuah@kernel.org, f.fainelli@gmail.com,
 Sherry Yang <sherry.yang@oracle.com>, jonathanh@nvidia.com,
 patches@kernelci.org, linux@roeck-us.net, linux-nfs@vger.kernel.org,
 srw@sladewatkins.net, LTP List <ltp@lists.linux.it>,
 Christian Brauner <brauner@kernel.org>, rwarsow@gmx.de, pavel@denx.de,
 Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
 conor@kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 akpm@linux-foundation.org, torvalds@linux-foundation.org,
 sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Aug 25, 2023 at 12:35:46PM +0530, Naresh Kamboju wrote:
> + linux-nfs and more
> 
> On Thu, 24 Aug 2023 at 19:45, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.1.48 release.
> > There are 15 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 26 Aug 2023 14:14:28 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.48-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> 
> Following test regression found on stable-rc 6.1.
> Rpi4 is using NFS mount rootfs and running LTP syscalls testing.
> chown02 tests creating testfile2 on NFS mounted and validating
> the functionality and found that it was a failure.
> 
> This is already been reported by others on lore and fix patch merged
> into stable-rc linux-6.4.y [1] and [2].
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Odd, it's not a regression in this -rc cycle, so it was missed in the
previous ones somehow?

> Test log:
> --------
> chown02.c:46: TPASS: chown(testfile1, 0, 0) passed
> chown02.c:46: TPASS: chown(testfile2, 0, 0) passed
> chown02.c:58: TFAIL: testfile2: wrong mode permissions 0100700, expected 0102700
> 
> fchown02.c:57: TPASS: fchown(3, 0, 0) passed
> fchown02.c:57: TPASS: fchown(4, 0, 0) passed
> fchown02.c:67: TFAIL: testfile2: wrong mode permissions 0100700,
> expected 0102700
> 
> 
> ## Build
> * kernel: 6.1.48-rc1
> * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
> * git branch: linux-6.1.y
> * git commit: c079d0dd788ad4fe887ee6349fe89d23d72f7696
> * git describe: v6.1.47-16-gc079d0dd788a
> * test details:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.47-16-gc079d0dd788a
> 
> ## Test Regressions (compared to v6.1.46)
> * bcm2711-rpi-4-b, ltp-syscalls
>   - chown02
>   - fchown02
> 
> * bcm2711-rpi-4-b-64k_page_size, ltp-syscalls
>   - chown02
>   - fchown02
> 
> * bcm2711-rpi-4-b-clang, ltp-syscalls
>   - chown02
>   - fchown02
> 
> 
> 
> 
> Do we need the following patch into stable-rc linux-6.1.y ?
> 
> I see from mailing thread discussion, says that
> 
> the above commit is backported to LTS kernels -- 5.10.y,5.15.y and 6.1.y.

What "above commit"?

And what commit should be backported?

confused,

greg k-h

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
