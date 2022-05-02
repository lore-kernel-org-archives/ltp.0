Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479ECC433F5
	for <ltp@archiver.kernel.org>; Mon,  2 May 2022 09:24:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1849B3CA836
	for <ltp@archiver.kernel.org>; Mon,  2 May 2022 11:24:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A0E43CA793
 for <ltp@lists.linux.it>; Mon,  2 May 2022 11:24:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5404020035A
 for <ltp@lists.linux.it>; Mon,  2 May 2022 11:24:39 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 932651F894;
 Mon,  2 May 2022 09:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1651483479;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JUl4WPuT2/hlJWCnwGVNImgInYufmKRXRjy3t/VyIJg=;
 b=J8cFqca1+NpXkzwYOunv+FPhyzopuW9teTutTryEx/y3pzqHQWUErgPVMnybhu3p9gTMkv
 J22xGJxxqUtPcsVexAm7+08TWR+Mxwmit9iSUP9SzSvr+QhD2yAvRny/Lk02G0BH5g/D9Y
 bZV/u4jxWdVf+WtYEzwo4YeEaRs05VY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1651483479;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JUl4WPuT2/hlJWCnwGVNImgInYufmKRXRjy3t/VyIJg=;
 b=2nTg9Vc9ofU8apiIKLcKm023PZO9piQdE2ABhBoiVlvwv+mUwGVA58UyIzcnS98GTVQjPP
 sOUKPMVXgd1xmkDg==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4DC492C141;
 Mon,  2 May 2022 09:24:39 +0000 (UTC)
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Mon, 02 May 2022 10:19:28 +0100
In-reply-to: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
Message-ID: <87ee1ce17u.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 00/19] Expand Cgroup lib and modify controller
 tests
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

Hello Luke,

I'm happy with this. Although perhaps there will be some issues with the
tests because there are quite a lot of changes. Would be nice to get it
into the next release.

For the whole patch series:
Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com> writes:

> This patchset aims to expand the cgroup_lib shell library to simplify
> and centralize the whole mounting and cleanup process that can get
> rather confusing and redundant when writing cgroup controller tests from
> a shell environment. This is done by having the shell library make calls
> to the C cgroup API from a binary utility.
>
> In this patch set there are a few tests that have been extensively
> rewritten to work with the new test API and to use the new functionality
> from the cgroup lib. Because the test Cgroup lib handles mounting for v1
> and v2 controllers, some tests were modified to also work under cgroup
> v2. Some tests that were written for v1 controller also effictively test
> v2 controllers, while others were written to test v2 controllers in the
> spirit of the test or skipped outright.
>
> Luke Nowakowski-Krijger (19):
>   API/cgroup: Modify tst_cg_print_config for parsing and consumption
>   API/cgroup: Add option for specific pid to tst_cg_opts
>   API/cgroup: Add cgroup_find_root helper function
>   API/cgroup: Add CTRL_NAME_MAX define
>   tst_test_macros: Add TST_TOSTR macro
>   API/cgroup: Implement tst_cg_load_config
>   API/cgroup: Add more controllers to tst_cgroup
>   API/cgroup: refuse to mount blkio when io controller is mounted
>   testcases/lib: Implement tst_cgctl binary
>   testcases/lib: Add tst_flag2mask function
>   controllers: Expand cgroup_lib shell library
>   controllers: Update cgroup_fj_* to use newer cgroup lib and test lib
>   controllers: Update memcg_control_test to newer test lib and cgroup
>     lib
>   controllers: Update memcg/regression/* to new test and cgroup lib
>   controllers: Update memcg_stress_test to use newer cgroup lib
>   controllers: update memcg/functional to use newer cgroup lib
>   controllers: Update pids.sh to use newer cgroup lib
>   controllers: update cpuset_regression_test.sh to use newer cgroup lib
>   controllers: update cgroup_regression_test to use newer cgroup lib
>
>  include/tst_cgroup.h                          |  17 +-
>  include/tst_test_macros.h                     |   3 +
>  lib/tst_cgroup.c                              | 215 +++++++++++++++++-
>  .../cgroup/cgroup_regression_test.sh          |  31 +--
>  .../controllers/cgroup_fj/cgroup_fj_common.sh | 113 +++------
>  .../cgroup_fj/cgroup_fj_function.sh           | 169 ++++++++------
>  .../controllers/cgroup_fj/cgroup_fj_proc.c    |  24 +-
>  .../controllers/cgroup_fj/cgroup_fj_stress.sh | 168 +++++++-------
>  testcases/kernel/controllers/cgroup_lib.sh    | 141 ++++++++++--
>  .../cpuset/cpuset_regression_test.sh          |  26 +--
>  .../controllers/memcg/control/mem_process.c   |  28 +--
>  .../memcg/control/memcg_control_test.sh       | 150 +++---------
>  .../memcg/functional/memcg_force_empty.sh     |   2 +-
>  .../controllers/memcg/functional/memcg_lib.sh |  54 +++--
>  .../memcg/regression/memcg_regression_test.sh | 202 ++++++++--------
>  .../memcg/regression/memcg_test_1.c           |  40 ++--
>  .../memcg/regression/memcg_test_2.c           |  24 +-
>  .../memcg/regression/memcg_test_3.c           |  38 ++--
>  .../memcg/regression/memcg_test_4.c           |  24 +-
>  .../memcg/regression/memcg_test_4.sh          |  50 ++--
>  .../memcg/stress/memcg_stress_test.sh         |  32 +--
>  testcases/kernel/controllers/pids/pids.sh     |  67 +-----
>  testcases/lib/Makefile                        |   2 +-
>  testcases/lib/tst_cgctl.c                     |  87 +++++++
>  testcases/lib/tst_test.sh                     |  13 ++
>  25 files changed, 927 insertions(+), 793 deletions(-)
>  create mode 100644 testcases/lib/tst_cgctl.c


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
