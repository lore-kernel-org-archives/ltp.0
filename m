Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF83C433EF
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 13:19:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 458F23C949B
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 14:18:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F5343C93F6
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 14:18:49 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E18DF140052D
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 14:18:48 +0100 (CET)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A2466B81ED0;
 Wed, 12 Jan 2022 13:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76006C36AEF;
 Wed, 12 Jan 2022 13:18:41 +0000 (UTC)
Date: Wed, 12 Jan 2022 14:18:37 +0100
From: Christian Brauner <christian.brauner@ubuntu.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <20220112131837.igsjkkttqskw4eix@wittgenstein>
References: <CA+G9fYsMHhXJCgO-ykR0oO1kVdusGnthgj6ifxEKaGPHZJ-ZCw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYsMHhXJCgO-ykR0oO1kVdusGnthgj6ifxEKaGPHZJ-ZCw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [next]: LTP: getxattr05.c:97: TFAIL:
 unshare(CLONE_NEWUSER) failed: ENOSPC (28)
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
Cc: regressions@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Sven Schnelle <svens@linux.ibm.com>, containers@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>,
 LTP List <ltp@lists.linux.it>, "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jan 12, 2022 at 05:15:37PM +0530, Naresh Kamboju wrote:
> While testing LTP syscalls with Linux next 20220110 (and till date 20220112)
> on x86_64, i386, arm and arm64 the following tests failed.
> 
> tst_test.c:1365: TINFO: Timeout per run is 0h 15m 00s
> getxattr05.c:87: TPASS: Got same data when acquiring the value of
> system.posix_acl_access twice
> getxattr05.c:97: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
> tst_test.c:391: TBROK: Invalid child (13545) exit value 1
> 
> fanotify17.c:176: TINFO: Test #1: Global groups limit in privileged user ns
> fanotify17.c:155: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
> tst_test.c:391: TBROK: Invalid child (14739) exit value 1
> 
> sendto03.c:48: TBROK: unshare(268435456) failed: ENOSPC (28)
> 
> setsockopt05.c:45: TBROK: unshare(268435456) failed: ENOSPC (28)
> 
> strace output:
> --------------
> [pid   481] wait4(-1, 0x7fff52f5ae8c, 0, NULL) = -1 ECHILD (No child processes)
> [pid   481] clone(child_stack=NULL,
> flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
> child_tidptr=0x7f3af0fa7a10) = 483
> strace: Process 483 attached
> [pid   481] wait4(-1,  <unfinished ...>
> [pid   483] unshare(CLONE_NEWUSER)      = -1 ENOSPC (No space left on device)

This looks like another regression in the ucount code. Reverting the
following commit fixes it and makes the getxattr05 test work again:

commit 0315b634f933b0f12cfa82660322f6186c1aa0f4
Author: Alexey Gladkov <legion@kernel.org>
Date:   Fri Dec 17 15:48:23 2021 +0100

    ucounts: Split rlimit and ucount values and max values

    Since the semantics of maximum rlimit values are different, it would be
    better not to mix ucount and rlimit values. This will prevent the error
    of using inc_count/dec_ucount for rlimit parameters.

    This patch also renames the functions to emphasize the lack of
    connection between rlimit and ucount.

    v2:
    - Fix the array-index-out-of-bounds that was found by the lkp project.

    Reported-by: kernel test robot <oliver.sang@intel.com>
    Signed-off-by: Alexey Gladkov <legion@kernel.org>
    Link: https://lkml.kernel.org/r/73ea569042babda5cee2092423da85027ceb471f.1639752364.git.legion@kernel.org
    Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

The issue only surfaces if /proc/sys/user/max_user_namespaces is
actually written to.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
