Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05A9EB64D7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 07:43:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C1783CAD4B
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 09:43:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 60EB63CA9E1
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 09:42:59 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 637502009D6
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 09:42:57 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 79B2760FB7;
 Tue, 20 Jun 2023 07:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0EBC433C0;
 Tue, 20 Jun 2023 07:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1687246974;
 bh=YerGYPsch1T+BfxemUSZ9eeDg0EC2FKopbOQRfVYmiA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Ptm3hpM75VrbDf6TydCCqWsG923n8D/S+lLLWuFaWrbuq8WD6amZWLZCTezmA81A0
 kmNYvnPpLhvJH+Kw0J8CWCpYBWT0lX1/QLKx3mHpEZk3LgirHlcjAKOOo6tPa8nSKS
 i6NH7rdHzRqmOcfdf4622aLSFZr3klIfmyShbm++yqnhRbTu9HjiGqxFgwYY51Oqje
 ZfOTxlcAqzRsBRNpRYSSAY5A6SaXjNG03IMVwDj5bMLK6yMFHtaFFPH/8FO9u+YgR5
 TdAKtZNHuSp9/AdqFk8q7IC1ApaJx9B0zwCUo6aegPzS5HkzO2lq+K06V4MhIktvKm
 NtxpZvS3Qpw1A==
Message-ID: <61f22c1d-6b04-d193-57c9-8cad1c555e4b@kernel.org>
Date: Tue, 20 Jun 2023 16:42:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: kernel test robot <oliver.sang@intel.com>
References: <202306192248.1ece4c29-oliver.sang@intel.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <202306192248.1ece4c29-oliver.sang@intel.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linux-next:master] [scsi] eca2040972:
 ltp.ioprio_set03.fail
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>, lkp@intel.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 Hannes Reinecke <hare@suse.de>, oe-lkp@lists.linux.dev,
 Christoph Hellwig <hch@lst.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 6/20/23 14:58, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "ltp.ioprio_set03.fail" on:

LTP maintainers,

Patches have been submitted to fix this issue. Were these patches applied ?

Kernel test robot maintainers,

Once the LTP patches are applied, you will need to update LTP.

> 
> commit: eca2040972b411ec27483bf75dc8b84e730e88ff ("scsi: block: ioprio: Clean up interface definition")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master f7efed9f38f886edb450041b82a6f15d663c98f8]
> [test failed on fix commit 01584c1e233740519d0e11aa20daa323d26bf598]
> 
> 
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20230520
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: xfs
> 	test: syscalls-05
> 
> 
> 
> compiler: gcc-12
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202306192248.1ece4c29-oliver.sang@intel.com
> 
> 
> 
> <<<test_start>>>
> tag=ioprio_set03 stime=1687153195
> cmdline="ioprio_set03"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
> ioprio_set03.c:39: TFAIL: ioprio_set IOPRIO_CLASS_BE prio 8 should not work
> ioprio_set03.c:47: TINFO: tested illegal priority with class NONE
> ioprio_set03.c:50: TPASS: returned correct error for wrong prio: EINVAL (22)
> 
> Summary:
> passed   1
> failed   1
> broken   0
> skipped  0
> warnings 0
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=1 corefile=no
> cutime=0 cstime=3
> <<<test_end>>>
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

-- 
Damien Le Moal
Western Digital Research


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
