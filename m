Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62598CDB482
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 08:45:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6CD6D3CD138
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 10:45:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 781573C8689
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 10:45:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 295961000DD6
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 10:45:16 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id EC63E1FDB2
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 08:45:15 +0000 (UTC)
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 8D5282D0FD;
 Mon, 16 Oct 2023 08:45:15 +0000 (UTC)
References: <20231013074748.702214-1-pvorel@suse.cz> <87h6mrx9ff.fsf@suse.de>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: rpalethorpe@suse.de
Date: Mon, 16 Oct 2023 09:41:34 +0100
Organization: Linux Private Site
In-reply-to: <87h6mrx9ff.fsf@suse.de>
Message-ID: <87cyxfx8fa.fsf@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: EC63E1FDB2
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/4] Add .modprobe (loading modules in C API)
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Richard Palethorpe <rpalethorpe@suse.de> writes:

> Hello,
>
> Petr Vorel <pvorel@suse.cz> writes:
>
>> Hi,
>>
>> when I started this patch it looked to me that quite a few C tests executes
>> modprobe to load kernel module. In the end, so far only can_bcm01.c and
>> madvise11.c uses it. But maybe more could be used.
>
> Just to be clear this is a great idea in principle.
>
> What concerns me is that module detection and loading will be
> mandatory. Then tests which can work without root, even run in a sandbox,
> will require real root.
>
> I want to be able to see if a bug is reachable from inside a container,
> embedded system or nsjail without adding /lib/modules to the
> environment or recompiling the test.
>
> In particular the module detection is a problem because it stops the
> test from running when the module is present, but some file is not. If
> it is acceptable for Android to disable this check then it should be
> acceptable for any system.
>
> If we make the check "best efforts", then we don't need a special define
> for Android either.

Also it occurred to me that in .modprobe you could add a field which
specifies the kconfig parameter name for the module.

So we could avoid modules.builtin, by checking the kernel configuration
first. If the module is builtin or set to N, then no more checks are
required.

>
>>
>> If I add support for module parameters (it would be easy to add), it could be
>> used also in can_common.h testcases/network/can/filter-tests/.
>>
>> It could also be used in the old API C tests in testcases/kernel/input (which
>> use input_helper.c), of course after we rewrite them to the new API.
>>
>> Tests which use modprobe but using .modprobe is not usable:
>> * kvm_pagefault01.c (more complicated use - it requires checks).
>> * zram03.c, zram_lib.sh (too complicated check due /sys/class/zram-control
>>   introduced in v4.2-rc1 vs. the old API, but maybe this could be simplified)
>> * netstress.c (used only when testing dccp, which is determined by getopts)
>>
>> But if we move code I put into tst_test.c into separate function, we could be
>> unified interface which would be usable for those tests as well.
>>
>> I haven't added support for parameters (it would be easy to add), atm only
>> kvm_pagefault01.c and can_common.h use them.
>>
>> If is .modprobe (as TST_MODPROBE) supported in shell API, then these could use it:
>> * new API shell tests: binfmt_misc_lib.sh, rcu_torture.sh, ip_tests.sh (if we
>>   don't delete this test), mpls01.sh, tests which use mpls_lib.sh, tests which
>>   use tcp_cc_lib.sh, tc01.sh
>> * fou01.sh (new API) needs to load module after getopts, but it could use some
>>   unified interface.
>> * old API shell tests (after they are rewritten): lock_torture.sh
>>
>> Few notes on modprobe:
>> * Do we even need to remove modules?
>
> IDK, but it could be useful for triggering a double free or counter
> underflow etc.
>
>> * should we use "modprobe -r" instead of "rmmod" on cleanup? rmmod is a simple
>> program which removes (unloads) a module from the Linux kernel. "modprobe -r"
>> handles a dependencies (if more modules loded, they are also removed).
>
> These should probably be configurable. There are different
> implementations of these tools (e.g. busybox, toybox etc.). In Toybox
> modprobe is in "pending", meanwhile lsmod, insmod and rmmod are complete.
>
>>
>> * Network tests use -s on remote (log errors into syslog), I guess we probably
>> prefer for general use error on stderr.
>>
>> Petr Vorel (4):
>>   tst_kernel: Add safe_check_driver()
>>   lib: Add .modprobe
>>   madvise11: Replace .needs_drivers with .modprobe
>>   can_bcm01: Move vcan to .modprobe
>>
>>  doc/C-Test-API.asciidoc                       |  5 ++
>>  doc/Test-Writing-Guidelines.asciidoc          |  1 +
>>  include/tst_kernel.h                          |  9 +++
>>  include/tst_test.h                            |  5 +-
>>  lib/tst_kernel.c                              |  6 ++
>>  lib/tst_test.c                                | 56 ++++++++++++++++++-
>>  testcases/kernel/syscalls/madvise/madvise11.c | 36 +-----------
>>  testcases/network/can/cve/can_bcm01.c         | 19 ++++---
>>  8 files changed, 90 insertions(+), 47 deletions(-)
>>
>> -- 
>> 2.42.0
>
>
> -- 
> Thank you,
> Richard.


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
