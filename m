Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D804DC77B61
	for <ltp@archiver.kernel.org>; Mon,  1 May 2023 16:05:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3251F3CD945
	for <ltp@archiver.kernel.org>; Mon,  1 May 2023 18:05:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3556B3CB909
 for <ltp@lists.linux.it>; Mon,  1 May 2023 18:05:23 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CFC77140045D
 for <ltp@lists.linux.it>; Mon,  1 May 2023 18:05:22 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DB9D760ECF;
 Mon,  1 May 2023 16:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7F7C433EF;
 Mon,  1 May 2023 16:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682957119;
 bh=7FribDT9SJ/YDiHEbJbcbFVmncjfH516wIysqkoawmI=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=BM17fRuQqkErjgt9KD3XT1M0sPeo7p502r37c2iLmtEFceXfctgbkHy7R//xbaHvk
 h1uUThmKKefzE3XB7nIsoiawCyXbvao9pNnc1hbZDxpTEWSHuJ9Nbize6ZnwWFqPp1
 A22gvHOXKPoU60zdUhUzPNIG+5cPQ0tb+JWBgZRK8XQGNx0CkcrDZY3zdqu2E8FICg
 ujNlmyWEQyKZOJuEiavo8yyjnUkPZE4Ux2Tn83KAZJ5YJ1M6cRB2vGRUPwADI1+U/p
 fSZV1X4kzWel2p2hO4s8P2gnE3SC3ZvmaA6t2M1LRPPNBIeW1SzjvSKMXWAncWmRee
 3BBPBHG01oNYw==
Message-ID: <0dc1a9d7f2b99d2bfdcabb7adc51d7c0b0c81457.camel@kernel.org>
From: Jeff Layton <jlayton@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Date: Mon, 01 May 2023 12:05:17 -0400
In-Reply-To: <202305012130.cc1e2351-oliver.sang@intel.com>
References: <202305012130.cc1e2351-oliver.sang@intel.com>
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [jlayton:ctime] [ext4]  ff9aaf58e8: ltp.statx06.fail
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
Cc: Christian Brauner <brauner@kernel.org>, lkp@intel.com,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, oe-lkp@lists.linux.dev,
 linux-ext4@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, 2023-05-01 at 22:09 +0800, kernel test robot wrote:
> Hello,
> 
> kernel test robot noticed "ltp.statx06.fail" on:
> 
> commit: ff9aaf58e816635c454fbe9e9ece94b0eee6f0b1 ("ext4: convert to multigrain timestamps")
> https://git.kernel.org/cgit/linux/kernel/git/jlayton/linux.git ctime
> 
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20230429
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: xfs
> 	test: syscalls-04
> 
> test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/
> 
> 
> compiler: gcc-11
> test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Link: https://lore.kernel.org/oe-lkp/202305012130.cc1e2351-oliver.sang@intel.com
> 
> 
> 
> <<<test_start>>>
> tag=statx06 stime=1682919030
> cmdline="statx06"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext4 opts='-I 256' extra opts=''
> mke2fs 1.46.6-rc1 (12-Sep-2022)
> tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
> statx06.c:136: TFAIL: Birth time < before time
> statx06.c:138: TFAIL: Modified time > after_time
> statx06.c:136: TFAIL: Access time < before time
> statx06.c:136: TFAIL: Change time < before time
> 
> Summary:
> passed   0
> failed   4
> broken   0
> skipped  0
> warnings 0
> incrementing stop
> <<<execution_status>>>
> initiation_status="ok"
> duration=1 termination_type=exited termination_id=1 corefile=no
> cutime=0 cstime=5
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: 20230127-165-gbd512e733
> 
>        ###############################################################
> 
>             Done executing testcases.
>             LTP Version:  20230127-165-gbd512e733
>        ###############################################################
> 
> 
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>         sudo bin/lkp run generated-yaml-file
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> 

(adding linux-fsdevel and a few other folks who have shown interest in
the multigrain ctime patches)

I haven't posted the ext4 patch for this yet since I'm still testing it,
but this is an interesting test result. The upshot is that we'll
probably not be able to pass this testcase without modifying it if we go
with multigrain ctimes.

The test does this:

        SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &before_time);
        clock_wait_tick();
        tc->operation();
        clock_wait_tick();
        SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &after_time);

...and with that, I usually end up with before/after_times that are 1ns
apart, since my machine is reporting a 1ns granularity.

The first problem is that the coarse grained timestamps represent the
lower bound of what time could end up in the inode. With multigrain
ctimes, we can end up grabbing a fine-grained timestamp to store in the
inode that will be later than either coarse grained time that was
fetched.

That's easy enough to fix -- grab a coarse time for "before" and a fine-
grained time for "after".

The clock_getres function though returns that it has a 1ns granularity
(since it does). With multigrain ctimes, we no longer have that at the
filesystem level. It's a 2ns granularity now (as we need the lowest bit
for the flag).

The following patch to the testcase fixes it for me, but I'm not sure if
it'll be acceptable. Maybe we need some way to indicate to userland that
multigrain timestamps are in effect, for "applications" like this that
care about such things?
-- 
Jeff Layton <jlayton@kernel.org>

diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
index ce82b905b..1f5367583 100644
--- a/testcases/kernel/syscalls/statx/statx06.c
+++ b/testcases/kernel/syscalls/statx/statx06.c
@@ -107,9 +107,11 @@ static void test_statx(unsigned int test_nr)
 
        SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &before_time);
        clock_wait_tick();
+       clock_wait_tick();
        tc->operation();
        clock_wait_tick();
-       SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &after_time);
+       clock_wait_tick();
+       SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &after_time);
 
        TEST(statx(AT_FDCWD, TEST_FILE, 0, STATX_ALL, &buff));
        if (TST_RET != 0) {


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
