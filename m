Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8F0E77171
	for <ltp@archiver.kernel.org>; Wed,  4 Dec 2024 09:46:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56EA53DEE0A
	for <ltp@archiver.kernel.org>; Wed,  4 Dec 2024 10:46:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A04523C0E0F
 for <ltp@lists.linux.it>; Wed,  4 Dec 2024 10:45:45 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=arndb.de (client-ip=103.168.172.158;
 helo=fhigh-a7-smtp.messagingengine.com; envelope-from=arnd@arndb.de;
 receiver=lists.linux.it)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 36C68140B697
 for <ltp@lists.linux.it>; Wed,  4 Dec 2024 10:45:43 +0100 (CET)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 2CF0F11401FF;
 Wed,  4 Dec 2024 04:45:42 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
 by phl-compute-10.internal (MEProxy); Wed, 04 Dec 2024 04:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1733305542;
 x=1733391942; bh=Q0iilQonabL8W1eFHHpHrkvpB0yU8fGWMw4T6dNuayM=; b=
 t+DCl+D0PAuyGwKsA/btZjd7YY6aEJqPq+RLtGsZbrnCA4lBpCiThWuaXioyqIP2
 L+f+D5G+lU9/7M0CgHA4+80wjQ8xCEKmkipNCVDfEYqWLmvf0vhF1z1weDEU38kA
 MeQZUiO4rsmYy84qxiQjujZlN0VNlVjKaHywCeRwU+aiuOCD5pLFwCouxbJvUxx1
 38eojlppoMNoDaa0gfayYZADFNaaDoDPMNC38oG46dWC7QbPXwGrhqZUL8UXp5vJ
 nwrmgVoSVsWXNLV3Y0AS9k5346Umwl1F3s6hXbm2vpdBenk9DKA1ULJriTCg3eeC
 bAAkH/Cf/QSC1+cT1MTIow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733305542; x=
 1733391942; bh=Q0iilQonabL8W1eFHHpHrkvpB0yU8fGWMw4T6dNuayM=; b=s
 GNWuJ6tOzIpdXsVhMFFhCNZxsAQAiZPJ6+V/O1jam78YMb8XbVnOSKlCSvEJz0g8
 xc/UKnxlE2lbjsBtDXymjigzW4EScWFhE6A7QGeMzwTUzh9rJlZtDDa0eBFtH3ne
 yyBkVcZZeTm3uaUFjxLj7mIRow6W3wbdMra7q3mxHzfsiTzeTTp+S//f+zlx/tbV
 GWbS0EiSGm41lJyd25MK2HfUNUP998ZvXENKlCmidYnH3WtfQStX42Rp291R24LM
 z+SSjmqFmIgdBc2llOP5e23Yfi+5/Ot6lPtQqaQshAUpKc78eLSMJgxqHRBQ5jtp
 +vvqi50fnb6oeBhT7EAuA==
X-ME-Sender: <xms:xSRQZ9YsTluTHV7I5lRdgp2o_encj7eLAoDkMnCDWoV_8wTrcJp9iQ>
 <xme:xSRQZ0Z3z03RtGYfTATA_SPzcJrAt799yji-VF0tPPVGVW3Uq2IkTDXo1sQXXOSEh
 d9Hn0MNqPWgNnRc3SE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieehgddthecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
 ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
 gvqeenucggtffrrghtthgvrhhnpeevkeevheeftddttdffgeelkeffjeffhefgffeuueei
 udduteejgefhteetjedthfenucffohhmrghinhepthhugihsuhhithgvrdgtohhmpdhlih
 hnrghrohdrohhrghdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptden
 ucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtg
 hpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhgruhhnvghr
 sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhguvghrshdrrhhogigvlhhlsehlih
 hnrghrohdrohhrghdprhgtphhtthhopegsvghnjhgrmhhinhdrtghophgvlhgrnhgusehl
 ihhnrghrohdrohhrghdprhgtphhtthhopegurghnrdgtrghrphgvnhhtvghrsehlihhnrg
 hrohdrohhrghdprhgtphhtthhopehnrghrvghshhdrkhgrmhgsohhjuheslhhinhgrrhho
 rdhorhhgpdhrtghpthhtoheplhhkfhhtqdhtrhhirghgvgeslhhishhtshdrlhhinhgrrh
 hordhorhhgpdhrtghpthhtoheprhgvghhrvghsshhiohhnsheslhhishhtshdrlhhinhhu
 gidruggvvhdprhgtphhtthhopehlthhpsehlihhsthhsrdhlihhnuhigrdhithdprhgtph
 htthhopegthhhruhgsihhssehsuhhsvgdrtgii
X-ME-Proxy: <xmx:xSRQZ_8EZyYNT7xhudPkdJOFSERHbPr5pWFXqQ1TdGifE25O08HLKQ>
 <xmx:xSRQZ7qmUeouxhphfHus4Rxaooj67oh4s1Yqswb1BGSqSplT52wgSQ>
 <xmx:xSRQZ4rdSlx-oqaZH8dsCH5pDv-WuC94f9mGCqCEjlXRAvTbb9Y_Gg>
 <xmx:xSRQZxTsCPdH-Wh274beLuNj6vPEYU5kAV0YaCSc_-0VROB0s-TwPQ>
 <xmx:xiRQZ_3pZYvW91hUev1IiKyogQ0IapZjlSzlefID6soOH0lf-f455GXS>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 8D6F42220072; Wed,  4 Dec 2024 04:45:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Wed, 04 Dec 2024 10:45:21 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>, "LTP List" <ltp@lists.linux.it>,
 lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>,
 "Christian Brauner" <brauner@kernel.org>
Message-Id: <0b91d70b-bc7a-462c-a52d-092df1f91e39@app.fastmail.com>
In-Reply-To: <CA+G9fYv4tUvUj1+rv5AU98QT9P8-RYVTkLAc-fCbLvy3wLtpJw@mail.gmail.com>
References: <CA+G9fYv4tUvUj1+rv5AU98QT9P8-RYVTkLAc-fCbLvy3wLtpJw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] next-20241203: LTP syscalls: name_to_handle_at01 and
 open_by_handle_at01 failed
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
Cc: Benjamin Copeland <benjamin.copeland@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Dec 4, 2024, at 10:38, Naresh Kamboju wrote:
> The following LTP syscalls name_to_handle_at01 and open_by_handle_at01
> / 02 tests
> failed on the Linux next-20241203 tag.
>
> First seen on Linux next-20241204 tag
> GOOD: Linux next-20241128 tag
> BAD: Linux next-20241203 tag

I see Christian Brauner's pidfs series getting merged between
those tags:

06b93f9cebca selftests/pidfd: add pidfs file handle selftests
c605dbc9850c pidfs: check for valid ioctl commands
fa3364a34c29 Merge patch series "pidfs: implement file handle support"
b3b0ad5f7eb3 pidfs: implement file handle support
6bf89dd80121 exportfs: add permission method
3fa98a43cb09 fhandle: pull CAP_DAC_READ_SEARCH check into may_decode_fh()
4afd8ca9c4b4 exportfs: add open method
e911ec82c48d fhandle: simplify error handling
a5eeba41d048 Merge patch series "pidfs: file handle preliminaries"
1010ba2fe904 pidfs: support FS_IOC_GETVERSION
5fe02e1e8f8c pidfs: remove 32bit inode number handling
799a5aeedc0d pidfs: rework inode number allocation
5dc3727ebd0b Merge patch series "exportfs: add flag to allow marking export operations as only supporting file handles"
4309a6099bfd ovl: restrict to exportable file handles
5e28f4a9d373 kernfs: restrict to local file handles
29b35e260929 exportfs: add flag to indicate local file handles

Adding Christian to Cc, he probably already knows what is
going on, and if this is a regression in the kernel or a
problem in the LTP test case.

    Arnd

> List of device :
>   - juno-r2 - arm64
>   - juno-r2-compat
>   - qemu-arm64
>   - qemu-arm64-compat
>   - qemu-armv7
>   - qemu-riscv64
>   - qemu-x86_64
>   - qemu-x86_64-compat
>   - x15 - arm
>   - x86_64
>   - x86-compat
>
> ltp-syscalls:
>     * open_by_handle_at01
>     * open_by_handle_at02
>     * name_to_handle_at01
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Test failed log:
> =================
> tst_buffers.c:57: TINFO: Test is using guarded buffers
> name_to_handle_at01.c:102: TPASS: name_to_handle_at() passed (0)
> name_to_handle_at01.c:98: TBROK: fstat(1,0x7fffda449ce0) failed: EBADF (9)
>
> Summary:
> passed   1
> failed   0
> broken   1
>
> tst_tmpdir.c:316: TINFO: Using /scratch/ltp-B0Mf6pVtaR/LTP_opehXJa6X
> as tmpdir (ext2/ext3/ext4 filesystem)
> tst_test.c:1860: TINFO: LTP version: 20240930
> tst_test.c:1864: TINFO: Tested kernel: 6.13.0-rc1-next-20241203 #1 SMP
> PREEMPT_DYNAMIC @1733269464 x86_64
> tst_test.c:1703: TINFO: Timeout per run is 0h 02m 30s
> tst_buffers.c:57: TINFO: Test is using guarded buffers
> open_by_handle_at01.c:101: TPASS: open_by_handle_at() passed (0)
> open_by_handle_at01.c:97: TBROK: fstat(1,0x7fff409f94e0) failed: EBADF (9)
>
> Summary:
> passed   1
> failed   0
> broken   1
> skipped  0
> warnings 0
> tst_tmpdir.c:316: TINFO: Using /scratch/ltp-B0Mf6pVtaR/LTP_opeN4blFw
> as tmpdir (ext2/ext3/ext4 filesystem)
> tst_test.c:1860: TINFO: LTP version: 20240930
> tst_test.c:1864: TINFO: Tested kernel: 6.13.0-rc1-next-20241203 #1 SMP
> PREEMPT_DYNAMIC @1733269464 x86_64
> tst_test.c:1703: TINFO: Timeout per run is 0h 02m 30s
> tst_buffers.c:57: TINFO: Test is using guarded buffers
> open_by_handle_at02.c:98: TPASS: invalid-dfd: open_by_handle_at()
> failed as expected: EBADF (9)
> open_by_handle_at02.c:86: TFAIL: stale-dfd: open_by_handle_at() passed
> unexpectedly
> open_by_handle_at02.c:85: TBROK: close(1) failed: EBADF (9)
>
> Summary:
> passed   1
> failed   1
>
> Links:
> ---
> - 
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOWmHmfmcNEt4XL6h7GdVCZf/
> - 
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26192368/suite/ltp-syscalls/tests/
> - 
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26192368/suite/ltp-syscalls/test/name_to_handle_at01/log
> - 
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26192368/suite/ltp-syscalls/test/name_to_handle_at01/details/
> - 
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26188858/suite/ltp-syscalls/test/open_by_handle_at02/history/
>
> Steps to reproduce:
> ------------
> - tuxmake \
>         --runtime podman \
>         --target-arch arm64 \
>         --toolchain gcc-13 \
>         --kconfig
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOWmHmfmcNEt4XL6h7GdVCZf/config
>
> metadata:
> ----
>   git describe: 6.13.0-rc1-next-20241203
>   git repo: 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   git sha: c245a7a79602ccbee780c004c1e4abcda66aec32
>   kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOWmHmfmcNEt4XL6h7GdVCZf/config
>   build url: 
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOWmHmfmcNEt4XL6h7GdVCZf/
>   toolchain: gcc-13
>   config: gcc-13-defconfig-lkftconfig
>   arch: arm64
>
> --
> Linaro LKFT
> https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
