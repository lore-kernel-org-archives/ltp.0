Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DD9C83F17
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 11:08:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 652793CCD95
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 13:08:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 713A43C4E01
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 10:07:37 +0200 (CEST)
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 82FAD200AC7
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 10:07:36 +0200 (CEST)
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196]
 helo=home.neil.brown.name) by neil.brown.name with esmtp (Exim 4.95)
 (envelope-from <mr@neil.brown.name>) id 1ueUVR-0034tV-PL;
 Wed, 23 Jul 2025 08:07:19 +0000
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Harshvardhan Jha" <harshvardhan.j.jha@oracle.com>
In-reply-to: <ddaf94dd-30a2-4136-8dff-542b4433308c@oracle.com>
References: <>, <ddaf94dd-30a2-4136-8dff-542b4433308c@oracle.com>
Date: Wed, 23 Jul 2025 18:07:18 +1000
Message-id: <175325803891.2234665.5884275341421351947@noble.neil.brown.name>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 23 Jul 2025 13:07:55 +0200
Subject: Re: [LTP] [PATCH 1/2] SUNRPC: Don't allow waiting for exiting tasks
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
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
 Mark Brown <broonie@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Aishwarya.TCV@arm.com, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Chuck Lever <chuck.lever@oracle.com>,
 trondmy@kernel.org, Anna Schumaker <anna@kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, 23 Jul 2025, Harshvardhan Jha wrote:
> On 08/04/25 4:01 PM, Mark Brown wrote:
> > On Fri, Mar 28, 2025 at 01:40:44PM -0400, trondmy@kernel.org wrote:
> >> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >>
> >> Once a task calls exit_signals() it can no longer be signalled. So do
> >> not allow it to do killable waits.
> > We're seeing the LTP acct02 test failing in kernels with this patch
> > applied, testing on systems with NFS root filesystems:
> >
> > 10271 05:03:09.064993  tst_test.c:1900: TINFO: LTP version: 20250130-1-g60fe84aaf
> > 10272 05:03:09.076425  tst_test.c:1904: TINFO: Tested kernel: 6.15.0-rc1 #1 SMP PREEMPT Sun Apr  6 21:18:14 UTC 2025 aarch64
> > 10273 05:03:09.076733  tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > 10274 05:03:09.087803  tst_test.c:1722: TINFO: Overall timeout per run is 0h 01m 30s
> > 10275 05:03:09.088107  tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > 10276 05:03:09.093097  acct02.c:63: TINFO: CONFIG_BSD_PROCESS_ACCT_V3=y
> > 10277 05:03:09.093400  acct02.c:240: TINFO: Verifying using 'struct acct_v3'
> > 10278 05:03:10.053504  <6>[   98.043143] Process accounting resumed
> > 10279 05:03:10.053935  <6>[   98.043143] Process accounting resumed
> > 10280 05:03:10.064653  acct02.c:193: TINFO: == entry 1 ==
> > 10281 05:03:10.064953  acct02.c:84: TINFO: ac_comm != 'acct02_helper' ('acct02')
> > 10282 05:03:10.076029  acct02.c:133: TINFO: ac_exitcode != 32768 (0)
> > 10283 05:03:10.076331  acct02.c:141: TINFO: ac_ppid != 2466 (2461)

It seems that the acct02 process got logged..
Maybe the vfork attempt (trying to run acct02_helper) got half way an
aborted.
It got far enough that accounting got interested.
It didn't get far enough to update the ppid.
I'd be surprised if that were even possible....

If you would like to help debug this, changing the

+       if (unlikely(current->flags & PF_EXITING))

to

+       if (unlikely(WARN_ON(current->flags & PF_EXITING)))

would provide stack traces so we can wee where -EINTR is actually being
returned.  That should provide some hints.

NeilBrown


> > 10284 05:03:10.076572  acct02.c:183: TFAIL: end of file reached
> > 10285 05:03:10.076790  
> > 10286 05:03:10.087439  HINT: You _MAY_ be missing kernel fixes:
> > 10287 05:03:10.087741  
> > 10288 05:03:10.087979  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4d9570158b626
> > 10289 05:03:10.088201  
> > 10290 05:03:10.088414  Summary:
> > 10291 05:03:10.088618  passed   0
> > 10292 05:03:10.098852  failed   1
> > 10293 05:03:10.099212  broken   0
> > 10294 05:03:10.099454  skipped  0
> > 10295 05:03:10.099675  warnings 0
> >
> > I ran a bisect which zeroed in on this commit (log below), I didn't look
> > into it properly but the test does start and exit a test program to
> > verify that accounting records get created properly which does look
> > relevant.
> 
> Hi there,
> I faced the same issue and reverting this patch fixed the issue.
> Is this an issue introduced by this patch or it's due to the ltp
> testcase being outdated?
> 
> Thanks & Regards,
> Harshvardhan
> 
> >
> > git bisect start
> > # status: waiting for both good and bad commits
> > # bad: [0af2f6be1b4281385b618cb86ad946eded089ac8] Linux 6.15-rc1
> > git bisect bad 0af2f6be1b4281385b618cb86ad946eded089ac8
> > # status: waiting for good commit(s), bad commit known
> > # good: [38fec10eb60d687e30c8c6b5420d86e8149f7557] Linux 6.14
> > git bisect good 38fec10eb60d687e30c8c6b5420d86e8149f7557
> > # good: [fd71def6d9abc5ae362fb9995d46049b7b0ed391] Merge tag 'for-6.15-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> > git bisect good fd71def6d9abc5ae362fb9995d46049b7b0ed391
> > # good: [93d52288679e29aaa44a6f12d5a02e8a90e742c5] Merge tag 'backlight-next-6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight
> > git bisect good 93d52288679e29aaa44a6f12d5a02e8a90e742c5
> > # good: [2cd5769fb0b78b8ef583ab4c0015c2c48d525dac] Merge tag 'driver-core-6.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
> > git bisect good 2cd5769fb0b78b8ef583ab4c0015c2c48d525dac
> > # bad: [25757984d77da731922bed5001431673b6daf5ac] Merge tag 'staging-6.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
> > git bisect bad 25757984d77da731922bed5001431673b6daf5ac
> > # good: [28a1b05678f4e88de90b0987b06e13c454ad9bd6] Merge tag 'i2c-for-6.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
> > git bisect good 28a1b05678f4e88de90b0987b06e13c454ad9bd6
> > # good: [92b71befc349587d58fdbbe6cdd68fb67f4933a8] Merge tag 'objtool-urgent-2025-04-01' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> > git bisect good 92b71befc349587d58fdbbe6cdd68fb67f4933a8
> > # good: [5e17b5c71729d8ce936c83a579ed45f65efcb456] Merge tag 'fuse-update-6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse
> > git bisect good 5e17b5c71729d8ce936c83a579ed45f65efcb456
> > # good: [344a50b0f4eecc160c61d780f53d2f75586016ce] staging: gpib: lpvo_usb_gpib: struct gpib_board
> > git bisect good 344a50b0f4eecc160c61d780f53d2f75586016ce
> > # bad: [9e8f324bd44c1fe026b582b75213de4eccfa1163] NFSv4: Check for delegation validity in nfs_start_delegation_return_locked()
> > git bisect bad 9e8f324bd44c1fe026b582b75213de4eccfa1163
> > # good: [df210d9b0951d714c1668c511ca5c8ff38cf6916] sunrpc: Add a sysfs file for adding a new xprt
> > git bisect good df210d9b0951d714c1668c511ca5c8ff38cf6916
> > # good: [bf9be373b830a3e48117da5d89bb6145a575f880] SUNRPC: rpc_clnt_set_transport() must not change the autobind setting
> > git bisect good bf9be373b830a3e48117da5d89bb6145a575f880
> > # good: [c81d5bcb7b38ab0322aea93152c091451b82d3f3] NFSv4: clp->cl_cons_state < 0 signifies an invalid nfs_client
> > git bisect good c81d5bcb7b38ab0322aea93152c091451b82d3f3
> > # bad: [14e41b16e8cb677bb440dca2edba8b041646c742] SUNRPC: Don't allow waiting for exiting tasks
> > git bisect bad 14e41b16e8cb677bb440dca2edba8b041646c742
> > # good: [0af5fb5ed3d2fd9e110c6112271f022b744a849a] NFSv4: Treat ENETUNREACH errors as fatal for state recovery
> > git bisect good 0af5fb5ed3d2fd9e110c6112271f022b744a849a
> > # first bad commit: [14e41b16e8cb677bb440dca2edba8b041646c742] SUNRPC: Don't allow waiting for exiting tasks
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
