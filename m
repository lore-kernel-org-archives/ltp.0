Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD25CC4332F
	for <ltp@archiver.kernel.org>; Fri, 14 Oct 2022 06:51:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB3B13CAEF0
	for <ltp@archiver.kernel.org>; Fri, 14 Oct 2022 08:51:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FFEE3CAF16
 for <ltp@lists.linux.it>; Fri, 14 Oct 2022 08:50:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 63A5514011B5
 for <ltp@lists.linux.it>; Fri, 14 Oct 2022 08:50:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 851B01F385;
 Fri, 14 Oct 2022 06:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665730257;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7niQd0loBKJXkSAOejrX4Xq98kqHp6UfQ0/2/e5Ybvw=;
 b=EKILXOP5o3KCHzhgj9TXrP+D7erCIKCW8lFgYviMu5oSdQbc+oWv23cvl805SWhlQge4M1
 1fC42bEVvSs8Lgif/CNFd6dNM3Z4AaSbQyi4vV9gM8rS59NZ16V/mki2cqaDcGIELRaIJG
 z8kImn+XAPNyHovp5h4lO/J98d4XmVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665730257;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7niQd0loBKJXkSAOejrX4Xq98kqHp6UfQ0/2/e5Ybvw=;
 b=LWfyiAz6QUMORdowwvPST0cL61pHpQPJZzGxyjSBAwBO3BNWKP11/3iCkzYEeO63NckGuL
 qX4rEkfDo651gdDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01D2613451;
 Fri, 14 Oct 2022 06:50:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hMdqOtAGSWPlRQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 14 Oct 2022 06:50:56 +0000
Date: Fri, 14 Oct 2022 08:50:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: zhaogongyi <zhaogongyi@huawei.com>
Message-ID: <Y0kGzyqO4o3w6k1i@pevik>
References: <5eebb471e7dc4cc18758462a918d0596@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5eebb471e7dc4cc18758462a918d0596@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] needs_root: Add setting of needs_root
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>,
 Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi,


> > > > > Hi Petr,

> > > > > It is failed on my system:

> > > > > sh-4.4$ ./msgget03
> > > > > tst_test.c:1535: TINFO: Timeout per run is 0h 00m 30s
> > > > > msgget03.c:42: TINFO: Current environment 0 message queues are
> > > > already
> > > > > in use
> > > > > msgget03.c:45: TBROK: Failed to open FILE
> > '/proc/sys/kernel/msgmni'
> > > > > for writing: EACCES (13)

> > > > Ah, b740bfac5 ("msgget03: Set custom queue limit") causes the need
> > > > for root. IMHO this one is valid.

> > > > I'd suggest to remove needs_root for needs_device and
> > mount_device
> > > > now (i.e. send v2).

> > > Just remove the patch 1 and keep adding needs_root in patch 2?

> > If you haven't added it to any test which would have needs_device or
> > mount_device, then v2 can be kept.

> > But process_vm_readv02 works for me (on master, on Debian) without
> > root:

> > $ ./process_vm_readv02
> > tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
> > process_vm_readv02.c:32: TINFO: child 0: memory allocated and
> > initialized
> > process_vm_readv02.c:49: TINFO: child 1: reading string from same
> > memory location
> > process_vm_readv02.c:61: TPASS: expected string received

> > Summary:
> > passed   1
> > failed   0
> > broken   0
> > skipped  0
> > warnings 0

> > Also process_vm_readv03, process_vm_writev02 (I stopped checking
> > now).

> > Why you need it?



> On my system, these testcases failed and report EPERM:

> sh-4.4$ ./process_vm_readv02
OK, your system is Alpine (it can shorten our discussion next time if you report
you have problems on musl - i.e. which kernel and libc + versions you use).

Well, we should first check if this is not a bug in musl or Alpine before
requiring root.

It'd be interesting to know whether tools/testing/selftests/vm/memfd_secret.c
and tools/testing/selftests/x86/test_vsyscall.c also require root.

> tst_test.c:1528: TINFO: Timeout per run is 0h 00m 30s
> process_vm_readv02.c:32: TINFO: child 0: memory allocated and initialized
> process_vm_readv02.c:49: TINFO: child 1: reading string from same memory location
> process_vm_readv02.c:55: TBROK: process_vm_readv: EPERM
> process_vm_readv02.c:107: TFAIL: child 1: exited with 2

Before I wrote to musl ML and/or ptrace maintainer, anybody knows why
__NR_process_vm_readv requires root? Looking at kernel mm/process_vm_access.c,
process_vm_rw() calls process_vm_rw_core(), where:

	mm = mm_access(task, PTRACE_MODE_ATTACH_REALCREDS);
	if (!mm || IS_ERR(mm)) {
		rc = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
		/*
		 * Explicitly map EACCES to EPERM as EPERM is a more
		 * appropriate error code for process_vw_readv/writev
		 */
		if (rc == -EACCES)
			rc = -EPERM;
		goto put_task_struct;
	}

=> kernel/fork.c

struct mm_struct *mm_access(struct task_struct *task, unsigned int mode)
{
	...
	mm = get_task_mm(task);
	if (mm && mm != current->mm &&
			!ptrace_may_access(task, mode)) {
		mmput(mm);
		mm = ERR_PTR(-EACCES);
	}

=> kernel/ptrace.c

/* Returns 0 on success, -errno on denial. */
static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
{
	const struct cred *cred = current_cred(), *tcred;
	struct mm_struct *mm;
	kuid_t caller_uid;
	kgid_t caller_gid;

	if (!(mode & PTRACE_MODE_FSCREDS) == !(mode & PTRACE_MODE_REALCREDS)) {
		WARN(1, "denying ptrace access check without PTRACE_MODE_*CREDS\n");
		return -EPERM;
	}

	...
	rcu_read_unlock();
	return -EPERM;
ok:
	...

Failing LTP code:
	TEST(tst_syscall(__NR_process_vm_readv, pid_alloc, &local, 1UL, &remote,
					 1UL, 0UL));

	if (TST_RET != length)
		tst_brk(TBROK, "process_vm_readv: %s", tst_strerrno(-TST_RET));

> Summary:
> passed   0
> failed   1
> broken   1
> skipped  0
> warnings 0

> sh-4.4$ ./process_vm_readv03
> tst_test.c:1528: TINFO: Timeout per run is 0h 00m 30s
> process_vm_readv03.c:165: TINFO: bufsize=1024, remote_iovecs=1024, local_iovecs=8
> process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
> process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
> process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
> process_vm_readv03.c:118: TBROK: process_vm_readv: expected 1024 bytes but got -1
> process_vm_readv03.c:185: TFAIL: child_read: exited with 2
> process_vm_readv03.c:165: TINFO: bufsize=1024, remote_iovecs=512, local_iovecs=16
> process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
> process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
> process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
> process_vm_readv03.c:118: TBROK: process_vm_readv: expected 1024 bytes but got -1
> process_vm_readv03.c:185: TFAIL: child_read: exited with 2
> process_vm_readv03.c:165: TINFO: bufsize=1024, remote_iovecs=256, local_iovecs=32
> process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
> process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
> process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
> process_vm_readv03.c:118: TBROK: process_vm_readv: expected 1024 bytes but got -1
> process_vm_readv03.c:185: TFAIL: child_read: exited with 2
> process_vm_readv03.c:165: TINFO: bufsize=1024, remote_iovecs=128, local_iovecs=64
> process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
> process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
> process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
> process_vm_readv03.c:118: TBROK: process_vm_readv: expected 1024 bytes but got -1
> process_vm_readv03.c:185: TFAIL: child_read: exited with 2
> process_vm_readv03.c:165: TINFO: bufsize=1024, remote_iovecs=64, local_iovecs=128
> process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
> process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
> process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
> process_vm_readv03.c:118: TBROK: process_vm_readv: expected 1024 bytes but got -1
> process_vm_readv03.c:185: TFAIL: child_read: exited with 2
> process_vm_readv03.c:165: TINFO: bufsize=1024, remote_iovecs=32, local_iovecs=256
> process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
> process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
> process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
> process_vm_readv03.c:118: TBROK: process_vm_readv: expected 1024 bytes but got -1
> process_vm_readv03.c:185: TFAIL: child_read: exited with 2
> process_vm_readv03.c:165: TINFO: bufsize=1024, remote_iovecs=16, local_iovecs=512
> process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
> process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
> process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
> process_vm_readv03.c:118: TBROK: process_vm_readv: expected 1024 bytes but got -1
> process_vm_readv03.c:185: TFAIL: child_read: exited with 2
> process_vm_readv03.c:165: TINFO: bufsize=1024, remote_iovecs=8, local_iovecs=1024
> process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
> process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
> process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
> process_vm_readv03.c:118: TBROK: process_vm_readv: expected 1024 bytes but got -1
> process_vm_readv03.c:185: TFAIL: child_read: exited with 2
> process_vm_readv03.c:165: TINFO: bufsize=131072, remote_iovecs=1024, local_iovecs=8
> process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
> process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
> process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
> process_vm_readv03.c:118: TBROK: process_vm_readv: expected 131072 bytes but got -1
> process_vm_readv03.c:185: TFAIL: child_read: exited with 2
> process_vm_readv03.c:165: TINFO: bufsize=131072, remote_iovecs=512, local_iovecs=16
> process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
> process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
> process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
> process_vm_readv03.c:118: TBROK: process_vm_readv: expected 131072 bytes but got -1
> process_vm_readv03.c:185: TFAIL: child_read: exited with 2
> process_vm_readv03.c:165: TINFO: bufsize=131072, remote_iovecs=256, local_iovecs=32
> process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
> process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
> process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
> process_vm_readv03.c:118: TBROK: process_vm_readv: expected 131072 bytes but got -1
> process_vm_readv03.c:185: TFAIL: child_read: exited with 2
> process_vm_readv03.c:165: TINFO: bufsize=131072, remote_iovecs=128, local_iovecs=64
> process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
> process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
> process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
> process_vm_readv03.c:118: TBROK: process_vm_readv: expected 131072 bytes but got -1
> process_vm_readv03.c:185: TFAIL: child_read: exited with 2
> process_vm_readv03.c:165: TINFO: bufsize=131072, remote_iovecs=64, local_iovecs=128
> process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
> process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
> process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
> process_vm_readv03.c:118: TBROK: process_vm_readv: expected 131072 bytes but got -1
> process_vm_readv03.c:185: TFAIL: child_read: exited with 2
> process_vm_readv03.c:165: TINFO: bufsize=131072, remote_iovecs=32, local_iovecs=256
> process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
> process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
> process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
> process_vm_readv03.c:118: TBROK: process_vm_readv: expected 131072 bytes but got -1
> process_vm_readv03.c:185: TFAIL: child_read: exited with 2
> process_vm_readv03.c:165: TINFO: bufsize=131072, remote_iovecs=16, local_iovecs=512
> process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
> process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
> process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
> process_vm_readv03.c:118: TBROK: process_vm_readv: expected 131072 bytes but got -1
> process_vm_readv03.c:185: TFAIL: child_read: exited with 2
> process_vm_readv03.c:165: TINFO: bufsize=131072, remote_iovecs=8, local_iovecs=1024
> process_vm_readv03.c:83: TINFO: child_alloc: memory allocated and initialized
> process_vm_readv03.c:110: TINFO: child_read: reading string from same memory location
> process_vm_readv03.c:114: TFAIL: process_vm_read() failed: EPERM (1)
> process_vm_readv03.c:118: TBROK: process_vm_readv: expected 131072 bytes but got -1
> process_vm_readv03.c:185: TFAIL: child_read: exited with 2

> Summary:
> passed   0
> failed   32
> broken   16
> skipped  0
> warnings 0



> sh-4.4$ ./process_vm_writev02
> tst_test.c:1528: TINFO: Timeout per run is 0h 00m 30s
> process_vm_writev02.c:32: TINFO: child 0: allocate memory
> process_vm_writev02.c:55: TINFO: child 1: write to the same memory location
> process_vm_writev02.c:65: TFAIL: tst_syscall(__NR_process_vm_writev, pid_alloc, &local, 1UL, &remote, 1UL, 0UL) failed: EPERM (1)
> process_vm_writev02.c:69: TBROK: process_vm_writev: expected 100000 bytes but got -1
> process_vm_writev02.c:112: TFAIL: write child: exited with 2
> process_vm_writev02.c:45: TFAIL: child 0: found 100000 differences from expected data

> Summary:
> passed   0
> failed   3
> broken   1
> skipped  0
> warnings 0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
