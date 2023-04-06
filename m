Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B58DC7618D
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 09:55:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FCBB3CCFD6
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 11:55:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C2E63CAC9B
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 11:55:00 +0200 (CEST)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 105E31400F48
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 11:54:55 +0200 (CEST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 5FDC35C00F9;
 Thu,  6 Apr 2023 05:54:53 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute6.internal (MEProxy); Thu, 06 Apr 2023 05:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm2; t=1680774893; x=1680861293; bh=K2
 AVl6vrCYar0zLsisjWZlV3DqrFG8SifdnzFAf2npQ=; b=gHzkHDVtXjXcrCLQ05
 s3dVEH4cr4G0pUFt1JL5ujeqjzA7iE1GatZUq726+k+WwYpVQT013PyN4SvRpEXD
 mqlzIVJoscWrkKsQX780j9vVhnRq31HJ05eX/gCdI7T0+mfNJQoHOAPtMFsRfvYc
 7vZQhHmYTwpvpxF5hAwPOQRIHY5t6RpT6IO+G1+BW5i9kcR7H1cLZMuxcM2N529a
 YotlxzLKdYB8CgOOunlCHsGWskBm4xwoW6MalrQILq19E7kmurZUoJWZJiOxu5tE
 45k0ljzJD4H9IQYtu+SdCj8D8x/ExVorhuisSLcFAFF5eIjeZV5UmA5OvVDGWW4d
 s8Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1680774893; x=1680861293; bh=K2AVl6vrCYar0
 zLsisjWZlV3DqrFG8SifdnzFAf2npQ=; b=Yfgy5U5afgZSuiJofdldtq4y8IpR7
 GeqrFht842tRRdv95YXuz5bo55xbXouij3B8KY7hc8+OgdRX51M3x9Qty0IvyINm
 smoPenGVm4oTR3ewC9BGR4p6lY6kBxC7GIaMxxEv6cNeL/K8J7L3vuqAUEtd/gSL
 /oEncIpgcJY6fE3P4ZdAS2v/6kTd2CaKbw3jWZkGGPQpJ64QcddQv4gX/jabTOZw
 wBB8iAiO8ru8LuXUey+I48CdVDpfu0aU3sPcJC/Gq371wLXSzzJwQ+HeIWAs1uJc
 MX5XVA6xegOUxfqcTU2xcGqYrJNECVQ0mUgWeNi09PR54fp6Nk8DCwcwA==
X-ME-Sender: <xms:7JYuZPhl2SZimkB8KXs-WmJOCci_YR-pW5qBl-25Ty9SylpaXVUbkg>
 <xme:7JYuZMBWwzSeleT6_tw_ZOzZAlfwbXBmrMxa3_z9XzficTFEB8XLXI4rCraR82bpU
 uszbtP2ey0ZOTEWC6c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejfedgudejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
 nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
 htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
 hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:7JYuZPHHfGcDdGo7ZV9y9mFQddPGz5JGNl5nWfZbKsqs5otiUGZ-1A>
 <xmx:7JYuZMQT08B4sqw0z0bXWRWUQUqFjZ1i6MCpMUMXJcDz7MzhLb3MXg>
 <xmx:7JYuZMxGlSohLMucZtB8lF0x7n8dIQmv046m4p9QbbcG-g8oF5iRQA>
 <xmx:7ZYuZLmOIXErcU7HW-osL_6sNY0P1LuudFPMnxm_HThErMXsTEmnGA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id D9AC4B60093; Thu,  6 Apr 2023 05:54:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <96b67ae8-98dd-40fe-9dde-302e09d12551@app.fastmail.com>
In-Reply-To: <CA+G9fYtVXsKSbdxcTNiLc8oYRTBOZzWNQRF92daLE58NPbOkFg@mail.gmail.com>
References: <CA+G9fYtVXsKSbdxcTNiLc8oYRTBOZzWNQRF92daLE58NPbOkFg@mail.gmail.com>
Date: Thu, 06 Apr 2023 11:54:31 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>, "LTP List" <ltp@lists.linux.it>,
 llvm@lists.linux.dev
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP: list of failures on 32bit and compat mode
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
Cc: Benjamin Copeland <ben.copeland@linaro.org>,
 Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Apr 6, 2023, at 11:11, Naresh Kamboju wrote:
> Following LTP syscalls failed on the i386 and arm environments with
> Linux next / mainline kernels. The userspace is coming from Open
> Embedded kirkstone.

Thanks for the report and summary! I went through the list and found
that most if not all of the bugs looks like incompatibilities
with musl, not with 32-bit. It's probably not well tested with
musl.

Can you try again with glibc and see if there are any remaining
issues then? LTP should probably be fixed to work with both, but
if nobody has done that so far, it's likely that this has come
up in the past but ran into problems upstreaming the fixes.

> Anyone seeing this problem on 32-bit i386 or arm ?
> You get to see "segfault" in the following logs that have been noticed
> on i386 only.
>
> This is not a new problem. We have been noticing these failures for a
> really long time.
> Would it be worth investigating the reason for failures on 32bit architectures ?
>
> Test logs,
> -----
> [    0.000000] Linux version 6.3.0-rc5-next-20230406 (tuxmake@tuxmake)
> (i686-linux-gnu-gcc (Debian 11.3.0-11) 11.3.0, GNU ld (GNU Binutils
> for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC @1680759389
>
>
> Test environment: i386
> Suite: ltp-syscalls
> Toolchain: gcc-11
>
>
> fstatfs02
> fstatfs02    1  TPASS  :  expected failure - errno = 9 : Bad file descriptor
> fstatfs02    2  TBROK  :  tst_sig.c:232: unexpected signal SIGSEGV(11)
> received (pid = 17841).
> fstatfs02    3  TBROK  :  tst_sig.c:232: Remaining cases broken

I think this is the same thing that Tudor reported last year,
looks like valid behavior of the libc implementation that should
be handled by ltp:

https://lore.kernel.org/all/20220822113919.196953-5-tudor.cretu@arm.com/

Are you building the 32-bit x86 userspace with musl or glibc?

> ---
> ioctl03
> ioctl03.c:85: TFAIL: (UNKNOWN 0x40)

0x40 was added by kernel commit 195624d9c26b ("tun: support not
enabling carrier in TUNSETIFF"), this needs to be fixed in ltp
as well. Should not be specific to 32-bit though.

> ----
> mq_timedreceive01
>
> [  283.875014] mq_timedreceive[2354]: segfault at b7f5a004 ip b7dc1b0f
> sp bfc4dde0 error 4 in libc.so.6[b7d52000+175000] likely on CPU 2
> (core 2, socket 0)
> [  283.894804] Code: 65 c7 07 4b 00 00 00 b8 ff ff ff ff e9 7b fe ff
> ff 8d b4 26 00 00 00 00 8d 76 00 f3 0f 1e fb 83 ec 1c 8b 44 24 30 85
> c0 74 1d <8b> 50 04 c7 44 24 0c 00 00 00 00 8b 00 89 54 24 08 89 04 24
> c1 f8
> [  283.913703] audit: type=1701 audit(1680761716.789:31):
> auid=4294967295 uid=0 gid=0 ses=4294967295 subj=kernel pid=2354
> comm=\"mq_timedreceive\"
> exe=\"/opt/ltp/testcases/bin/mq_timedreceive01\" sig=11 res=1
>    0
>
> mq_timedreceive01
> mq_timedreceive01.c:197: TPASS: mq_timedreceive() failed expectedly: EINTR (4)
> tst_test.c:1581: TBROK: Test killed by SIGSEGV!

I think this is the same problem as fstatfs02, where ltp passes
an invalid pointer and expects EFAULT, but musl touches the data
first in order to do the time64 conversion. Needs the same fix.

> ----
> mq_timedsend01
>
> [  283.982220] mq_timedsend01[2357]: segfault at b7f06004 ip b7d6dd6f
> sp bfb58fe0 error 4 in libc.so.6[b7cfe000+175000] likely on CPU 0
> (core 0, socket 0)
> [  283.996745] Code: 65 c7 07 4b 00 00 00 b8 ff ff ff ff e9 7b fe ff
> ff 8d b4 26 00 00 00 00 8d 76 00 f3 0f 1e fb 83 ec 1c 8b 44 24 30 85
> c0 74 1d <8b> 50 04 c7 44 24 0c 00 00 00 00 8b 00 89 54 24 08 89 04 24
> c1 f8
> lls/mq_notify/..[  284.015564] audit: type=1701
> audit(1680761716.891:32): auid=4294967295 uid=0 gid=0 ses=4294967295
> subj=kernel pid=2357 comm=\"mq_timedsend01\"
> exe=\"/opt/ltp/testcases/bin/mq_timedsend01\" sig=11 res=1
> /utils/mq.h:70: TINFO: receive 1/1 message
>
> mq_timedsend01.c:210: TPASS: mq_timedsend() failed expectedly: EFAULT (14)
> tst_test.c:1581: TBROK: Test killed by SIGSEGV!

same here

> ---
>
> pread02_64
>
> tst_test.c:1524: TINFO: Timeout per run is 0h 05m 00s
> pread02.[  319.705083] /dev/zero: Can't open blockdev
> c:44: TPASS: pread(3, 1024, 0) (null) : ESPIPE (29)
> tst_test.c:1581: TBROK: Test killed by SIGSEGV!

This looks like LTP is calling the wrong function here
for musl: it passes D_FILE_OFFSET_BITS=64 for some tests
but not others, but on musl you always get the 64-bit
behavior.

> ---
> recvmmsg01
>
> [  369.451748] recvmmsg01[3821]: segfault at b7cb1004 ip b7dd7413 sp
> bf992430 error 4 in libc.so.6[b7cda000+175000] likely on CPU 3 (core
> 3, socket 0)
> [  369.466232] Code: 26 00 00 00 00 66 90 f3 0f 1e fb 55 57 56 53 83
> ec 2c 8b 5c 24 50 8b 44 24 40 8b 54 24 44 8b 4c 24 48 8b 74 24 4c 85
> db 74 55 <8b> 7b 04 c7 44 24 1c 00 00 00 00 83 ec 08 8b 2b 89 7c 24 14
> 8b 7c
> [  369.485043] audit: type=1701 audit(1680761802.360:44):
> auid=4294967295 uid=0 gid=0 ses=4294967295 subj=kernel pid=3821
> comm=\"recvmmsg01\" exe=\"/opt/ltp/testcases/bin/recvmmsg01\" sig=11
> res=1
> [  369.496491] mmap: remap_file_page (3822) uses deprecated
> remap_file_pages() syscall. See Documentation/mm/remap_file_pages.rst.
>
>
> recvmmsg01.c:92: TPASS: recvmmsg() overflow in nanoseconds in timeout
> : EINVAL (22)
> tst_test.c:1581: TBROK: Test killed by SIGSEGV!

Same time64 conversion issue as above.

> ---
> semctl03
>
> [  441.271399] semctl03[6093]: segfault at 0 ip b7e53fc0 sp bf93c0a0
> error 4 in libc.so.6[b7d56000+175000] likely on CPU 1 (core 1, socket
> 0)
> [  441.284432] Code: 24 5c ff 74 24 5c e8 cf fd ff ff 83 c4 10 85 c0
> 78 0e ba 04 00 14 00 0f a3 fa 0f 82 ba 00 00 00 83 c4 40 5b 5e 5f c3
> 8d 76 00 <8b> 03 31 d2 89 e6 66 0f 6e ca 89 04 24 8b 43 04 89 44 24 04
> 8b 43
> [  441.303267] audit: type=1701 audit(1680761874.178:46):
> auid=4294967295 uid=0 gid=0 ses=4294967295 subj=kernel pid=6093
> comm=\"semctl03\" exe=\"/opt/ltp/testcases/bin/semctl03\" sig=11 res=1
>
> semctl03.c:73: TPASS: semctl() with invalid IPC command : EINVAL (22)
> tst_test.c:1581: TBROK: Test killed by SIGSEGV!

time64 again

> semctl04
> semctl04.c:69: TBROK: semget(1628514830, 10, 600) failed: EEXIST (17)
>
> semctl05
> semctl05.c:54: TBROK: semget(1628514830, 10, 780) failed: EEXIST (17)

These are probably broken by semctl03 having failed first, and
they should be fine if you clear out the semaphore first, or
skip the semctl03 test.

> ----
> sigtimedwait01
>
>
> [  486.624973] sigtimedwait01[6644]: segfault at 5 ip b7d9758f sp
> bfda7290 error 4 in libc.so.6[b7d80000+175000] likely on CPU 1 (core
> 1, socket 0)
> [  486.639052] Code: c7 03 4b 00 00 00 b8 ff ff ff ff e9 3b fe ff ff
> 8d b4 26 00 00 00 00 8d 74 26 00 f3 0f 1e fb 83 ec 1c 8b 44 24 28 85
> c0 74 1d <8b> 50 04 c7 44 24 0c 00 00 00 00 8b 00 89 54 24 08 89 04 24
> c1 f8
> [  486.659213] audit: type=1701 audit(1680761919.535:49):
> auid=4294967295 uid=0 gid=0 ses=4294967295 subj=kernel pid=6644
> comm=\"sigtimedwait01\" exe=\"/opt/ltp/testcases/bin/sigtimedwait01\"
> sig=11 res=1
>
>
> sigwait.c:344: TPASS: Child exited with expected code
> tst_test.c:1581: TBROK: Test killed by SIGSEGV!

sigwait calls sigtimedwait and copies the signal number into
the provided pointer, so apparently a similar problem. I couldn't
find the testcase in the ltp sources, only see a sigwait01.c
not sigwait.c, but that doesn't trigger the bug.

> ---
>
>
> statfs02
>
> statfs02    4  TPASS  :  expected failure: TEST_ERRNO=EFAULT(14): Bad address
> statfs02    5  TBROK  :  tst_sig.c:232: unexpected signal SIGSEGV(11)
> received (pid = 6728).
> statfs02    6  TBROK  :  tst_sig.c:232: Remaining cases broken

I don't know why musl copes statfs, but this is yet another instance.
Not time64

>
> statx01
>
> statx01.c:138: TPASS: stx_nlink(1) is c[  833.666410] /dev/zero: Can't
> open blockdev
> orrect
> statx01.c:82: TFAIL: statx.stx_mnt_id(421) is different from
> mount_id(34280324422697381)[  833.678950] /dev/zero: Can't open
> blockdev
>  in /proc/self/mountinfo
> statx01.c:88: TPASS: /proc/12304/fdinfo/3 mnt_id: = 421

No idea, possibly some type mismatch between definitions in musl
and ltp.

> ---
> ustat01
>
> tst_test.c:1524: TINFO: Timeout per run is 0h 05m 00s
> ustat01.c:39: TBROK: stat(/,0xbfb96278) failed: EOVERFLOW (75)
>
> tst_test.c:1524: TINFO: Timeout per run is 0h 05m 00s
> ustat02.c:57: TBROK: stat(/,0xbfa11098) failed: EOVERFLOW (75)

I think the definition of 'struct ustat' in  ltp/include/lapi/ustat.h
is wrong and does not match the kernel. This uses a libc-provided
'ino_t', which is probably different from what the kernel expects
here.

    Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
