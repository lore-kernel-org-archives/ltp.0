Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD07C282C1
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 14:07:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A44813C9E4A
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 15:07:01 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85C9D3C9CE1
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 15:06:45 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=cristian.marussi@arm.com; receiver=lists.linux.it)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id 441B063D159
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 15:06:43 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67FFC1515;
 Fri, 28 Feb 2025 06:06:57 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01C293F6A8;
 Fri, 28 Feb 2025 06:06:40 -0800 (PST)
Date: Fri, 28 Feb 2025 14:06:32 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z8HC6E5dK9O8n6FS@pluto>
References: <20250227183359.918722-1-cristian.marussi@arm.com>
 <20250228130619.GB3222454@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250228130619.GB3222454@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup_fj_commmon.sh: Avoid explicitly disabling
 controllers on cleanup
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
Cc: aishwarya.tcv@arm.com, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Feb 28, 2025 at 02:06:19PM +0100, Petr Vorel wrote:
> Hi all,
> 
> [ Cc Way and Li (1204b1d853), Cyril and Michal (the cgroup expert) ]
> 

Hi Petr,

thanks for having a look.

> > The cgroup_cleanup helper, called by common_cleanup, takes already care
> > to remove/disable all the subsystems that were previously enabled using
> > the complementary cgroup_require helper, for the sake of testing.
> 
> > Doing it also explicitly after cgroup_cleanup has been called, causes a
> > WARN that makes all cgroup_fj tests to fail.
> 
> >   cgroup_fj_function 10 TINFO: Removing all ltp subgroups...
> >   tst_rod: Failed to open /sys/fs/cgroup/cgroup.subtree_control for writing: Read-only file system
> >   cgroup_fj_function 10 TWARN: echo -cpuset > /sys/fs/cgroup/cgroup.subtree_control failed
> 
> cgroup_fj_common.sh has TST_NEEDS_ROOT=1, it checks for root. It might be some bug in the test.
> 
> nit: it looks like you're trying to revert 1204b1d853, right? If the code is
> really broken, it would be:
> 
> Fixes: 1204b1d853 ("cgroup_fj_common.sh: Disable cgroup controller in cleanup function")
>

Indeed but I am not sure it is so straightforward since there are 2 more
patches on top of that.

> I guess you run cgroup_fj_function.sh cpuset, right? I was not able to reproduce
> the problem on some old (unupdated) Debian GNU/Linux 11 (bullseye), nor on
> Tumbleweed, nor on SLE15-SP4:
> 

All of the cgroup_fj* fails for us since tried to update to 20250130

> === Debian GNU/Linux 11 (bullseye) ===
> $ mount |grep cgroup
> cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot)
> 
> $ ls /sys/fs/cgroup/cgroup.controllers
> /sys/fs/cgroup/cgroup.controllers
> 
> $ grep cgroup /proc/cmdline # nothing (obviously)
> 

Indeed, we are using Bullseye with forced CGROUP v1 with:

	systemd.legacy_systemd_cgroup_controller=true

I vaguely remember some test issues in V2 in the past, so that is where
this comes from probably.

[WITHOUT any fix]

root # mount| grep cgroup
tmpfs on /sys/fs/cgroup type tmpfs (ro,nosuid,nodev,noexec,size=4096k,nr_inodes=1024,mode=755)
cgroup on /sys/fs/cgroup/systemd type cgroup (rw,nosuid,nodev,noexec,relatime,xattr,release_agent=/lib/systemd/systemd-cgroups-agent,name=systemd)
cgroup on /sys/fs/cgroup/cpu,cpuacct type cgroup (rw,nosuid,nodev,noexec,relatime,cpu,cpuacct)
cgroup on /sys/fs/cgroup/perf_event type cgroup (rw,nosuid,nodev,noexec,relatime,perf_event)
cgroup on /sys/fs/cgroup/hugetlb type cgroup (rw,nosuid,nodev,noexec,relatime,hugetlb)
cgroup on /sys/fs/cgroup/devices type cgroup (rw,nosuid,nodev,noexec,relatime,devices)
cgroup on /sys/fs/cgroup/freezer type cgroup (rw,nosuid,nodev,noexec,relatime,freezer)
cgroup on /sys/fs/cgroup/pids type cgroup (rw,nosuid,nodev,noexec,relatime,pids)
cgroup on /sys/fs/cgroup/blkio type cgroup (rw,nosuid,nodev,noexec,relatime,blkio)


tag=cgroup_fj_function_cpuset stime=1738893051
cmdline="cgroup_fj_function.sh cpuset"
contacts=""
analysis=exit
<<<test_output>>>
cgroup_fj_function 1 TINFO: Running: cgroup_fj_function.sh cpuset
cgroup_fj_function 1 TINFO: Tested kernel: Linux debian-bullseye-arm64 6.13.0 #3 SMP PREEMPT Tue Feb  4 17:28:01 GMT 2025 aarch64 GNU/Linux
cgroup_fj_function 1 TINFO: Using /tmp/ltp-1zH1YcvyXZ/LTP_cgroup_fj_function.OZ7zfBNqql as tmpdir (tmpfs filesystem)
cgroup_fj_function 1 TINFO: timeout per run is 0h 5m 0s
tst_cgroup.c:718: TINFO: Mounted V2 CGroups on /tmp/ltp-1zH1YcvyXZ/cgroup_unified
cgroup_fj_function 1 TINFO: test starts with cgroup version 2
cgroup_fj_function 1 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
cgroup_fj_function 2 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
cgroup_fj_function 3 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
cgroup_fj_function 4 TINFO: Attaching task 1557 to /tmp/ltp-1zH1YcvyXZ/cgroup_unified/ltp/test-1509/ltp_1
cgroup_fj_function 4 TPASS: Group /tmp/ltp-1zH1YcvyXZ/cgroup_unified/ltp/test-1509/ltp_1 with task 1557 cannot be removed
cgroup_fj_function 5 TPASS: Dir /tmp/ltp-1zH1YcvyXZ/cgroup_unified/ltp/test-1509/ltp_1 with subdir 'a' cannot be removed
cgroup_fj_function 6 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
cgroup_fj_function 7 TPASS: Tasks file /tmp/ltp-1zH1YcvyXZ/cgroup_unified/ltp/test-1509/ltp_1/tasks cannot be removed
cgroup_fj_function 8 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
cgroup_fj_function 9 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
cgroup_fj_function 10 TINFO: Removing all ltp subgroups...
tst_rod: Failed to open '/sys/fs/cgroup/cgroup.subtree_control' for writing: Read-only file system
cgroup_fj_function 10 TWARN: echo -cpuset > /sys/fs/cgroup/cgroup.subtree_control failed

ii  systemd        247.3-7+deb11u2 arm64        system and service manager

with sort of mainline: 6.13.0

The test anyway attempts and successfully runs on a V2 mount (done by
the test AFAICS) and then fails on cleanup, since all is already gone.

> $ dpkg -l systemd
> ii  systemd        247.3-6      amd64        system and service manager
> 
> $ uname -r
> 5.10.0-28-amd64
> 
> # PATH="/opt/ltp/testcases/bin/:$PATH" cgroup_fj_function.sh cpuset
> cgroup_fj_function 1 TINFO: Running: cgroup_fj_function.sh cpuset
> cgroup_fj_function 1 TINFO: Tested kernel: Linux ds 5.10.0-28-amd64 #1 SMP Debian 5.10.209-2 (2024-01-31) x86_64 GNU/Linux
> cgroup_fj_function 1 TINFO: Using /tmp/LTP_cgroup_fj_function.m7y4JnrU32 as tmpdir (ext2/ext3 filesystem)
> cgroup_fj_function 1 TINFO: timeout per run is 0h 5m 0s
> cgroup_fj_function 1 TINFO: test starts with cgroup version 2
> cgroup_fj_function 1 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
> cgroup_fj_function 2 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
> cgroup_fj_function 3 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
> cgroup_fj_function 4 TINFO: Attaching task 1850 to /sys/fs/cgroup/ltp/test-1800/ltp_1
> cgroup_fj_function 4 TPASS: Group /sys/fs/cgroup/ltp/test-1800/ltp_1 with task 1850 cannot be removed
> cgroup_fj_function 5 TPASS: Dir /sys/fs/cgroup/ltp/test-1800/ltp_1 with subdir 'a' cannot be removed
> cgroup_fj_function 6 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
> cgroup_fj_function 7 TPASS: Tasks file /sys/fs/cgroup/ltp/test-1800/ltp_1/tasks cannot be removed
> cgroup_fj_function 8 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
> cgroup_fj_function 9 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
> cgroup_fj_function 10 TINFO: Removing all ltp subgroups...
> 
> Summary:
> passed   3
> failed   0
> broken   0
> skipped  6
> warnings 0
> 
> === openSUSE Tumbleweed ===
> $ mount |grep cgroup
> cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot)
> 
> $ ls /sys/fs/cgroup/cgroup.controllers
> /sys/fs/cgroup/cgroup.controllers
> 
> $ grep cgroup /proc/cmdline # nothing (obviously)
> 
> $ uname -r
> 6.14.0-rc3-1.gb6b4102-default
> 
> $ rpm -q systemd
> systemd-256.10-2.2.x86_64
> 
> # PATH="/opt/ltp/testcases/bin/:$PATH" cgroup_fj_function.sh cpuset
> cgroup_fj_function 1 TINFO: Running: cgroup_fj_function.sh cpuset
> cgroup_fj_function 1 TINFO: Tested kernel: Linux ts 6.14.0-rc3-1.gb6b4102-default #1 SMP PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64 x86_64 x86_64 GNU/Linux
> cgroup_fj_function 1 TINFO: Using /tmp/LTP_cgroup_fj_function.6HznnEZMIo as tmpdir (tmpfs filesystem)
> cgroup_fj_function 1 TINFO: timeout per run is 0h 5m 0s
> cgroup_fj_function 1 TINFO: test starts with cgroup version 2
> cgroup_fj_function 1 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
> cgroup_fj_function 2 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
> cgroup_fj_function 3 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
> cgroup_fj_function 4 TINFO: Attaching task 3268 to /sys/fs/cgroup/ltp/test-3220/ltp_1
> cgroup_fj_function 4 TPASS: Group /sys/fs/cgroup/ltp/test-3220/ltp_1 with task 3268 cannot be removed
> cgroup_fj_function 5 TPASS: Dir /sys/fs/cgroup/ltp/test-3220/ltp_1 with subdir 'a' cannot be removed
> cgroup_fj_function 6 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
> cgroup_fj_function 7 TPASS: Tasks file /sys/fs/cgroup/ltp/test-3220/ltp_1/tasks cannot be removed
> cgroup_fj_function 8 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
> cgroup_fj_function 9 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
> cgroup_fj_function 10 TINFO: Removing all ltp subgroups...
> 
> Summary:
> passed   3
> failed   0
> broken   0
> skipped  6
> warnings 0
> 
> === SUSE Linux Enterprise Server 15 SP4 ===
> $ mount |grep cgroup # 
> tmpfs on /sys/fs/cgroup type tmpfs (ro,nosuid,nodev,noexec,size=4096k,nr_inodes=1024,mode=755,inode64)
> cgroup2 on /sys/fs/cgroup/unified type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate)
> cgroup on /sys/fs/cgroup/systemd type cgroup (rw,nosuid,nodev,noexec,relatime,xattr,name=systemd)
> cgroup on /sys/fs/cgroup/freezer type cgroup (rw,nosuid,nodev,noexec,relatime,freezer)
> cgroup on /sys/fs/cgroup/perf_event type cgroup (rw,nosuid,nodev,noexec,relatime,perf_event)
> cgroup on /sys/fs/cgroup/rdma type cgroup (rw,nosuid,nodev,noexec,relatime,rdma)
> cgroup on /sys/fs/cgroup/misc type cgroup (rw,nosuid,nodev,noexec,relatime,misc)
> cgroup on /sys/fs/cgroup/cpu,cpuacct type cgroup (rw,nosuid,nodev,noexec,relatime,cpu,cpuacct)
> cgroup on /sys/fs/cgroup/net_cls,net_prio type cgroup (rw,nosuid,nodev,noexec,relatime,net_cls,net_prio)
> cgroup on /sys/fs/cgroup/hugetlb type cgroup (rw,nosuid,nodev,noexec,relatime,hugetlb)
> cgroup on /sys/fs/cgroup/pids type cgroup (rw,nosuid,nodev,noexec,relatime,pids)
> cgroup on /sys/fs/cgroup/cpuset type cgroup (rw,nosuid,nodev,noexec,relatime,cpuset)
> cgroup on /sys/fs/cgroup/memory type cgroup (rw,nosuid,nodev,noexec,relatime,memory)
> cgroup on /sys/fs/cgroup/blkio type cgroup (rw,nosuid,nodev,noexec,relatime,blkio)
> cgroup on /sys/fs/cgroup/devices type cgroup (rw,nosuid,nodev,noexec,relatime,devices)
> 
> $ ls /sys/fs/cgroup/cgroup.controllers
> ls: cannot access '/sys/fs/cgroup/cgroup.controllers': No such file or directory
> 
> $ grep cgroup /proc/cmdline # nothing, due v1 + v2? But what sets both?
> 
> $ uname -r
> 5.14.21-...
> 
> $ rpm -q systemd
> systemd-249.15-*
> 
> # PATH="/opt/ltp/testcases/bin/:$PATH" cgroup_fj_function.sh cpuset
> cgroup_fj_function 1 TINFO: Running: cgroup_fj_function.sh cpuset
> cgroup_fj_function 1 TINFO: Tested kernel: Linux s4 5.14.21-150400.24.49-default #1 SMP PREEMPT_DYNAMIC Tue Mar 7 08:07:05 UTC 2023 (bad820e) x86_64 x86_64 x86_64 GNU/Linux
> cgroup_fj_function 1 TINFO: Using /tmp/LTP_cgroup_fj_function.U0V6xiD1hU as tmpdir (btrfs filesystem)
> cgroup_fj_function 1 TINFO: timeout per run is 0h 5m 0s
> cgroup_fj_function 1 TINFO: test starts with cgroup version 1
> cgroup_fj_function 1 TINFO: Attaching task 2809 to /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_1
> cgroup_fj_function 1 TINFO: Attaching task 2809 to /sys/fs/cgroup/cpuset/ltp/test-2759
> cgroup_fj_function 1 TPASS: Task attached successfully
> cgroup_fj_function 2 TPASS: Successfully moved /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_2 to /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_3
> cgroup_fj_function 3 TPASS: Failed to move /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_2 over existing /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_1
> cgroup_fj_function 4 TINFO: Attaching task 2809 to /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_1
> cgroup_fj_function 4 TPASS: Group /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_1 with task 2809 cannot be removed
> cgroup_fj_function 5 TPASS: Dir /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_1 with subdir 'a' cannot be removed
> cgroup_fj_function 6 TPASS: Subgroup /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_1 cannot be moved to /tmp/LTP_cgroup_fj_function.U0V6xiD1hU/ltp
> cgroup_fj_function 7 TPASS: Tasks file /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_1/tasks cannot be removed
> cgroup_fj_function 8 TPASS: Cannot write invalid values to /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_1/notify_on_release
> cgroup_fj_function 9 TPASS: Set /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_1/notify_on_release to 1
> cgroup_fj_function 10 TINFO: Removing all ltp subgroups...
> 
> Summary:
> passed   9
> failed   0
> broken   0
> skipped  0
> warnings 0
> 
> > Observed on a Debian Bullseye with systemd using by default cgroup_V1:
> > in such a case the cgroup_require/cleanup helpers take care to create and
> > cleanup the cgroup_V2 needed by the testcase, but fail to cleamup for
> > the above reasons.
> 
> As shown above and also from from runc doc [1] it is obvious that Bullseye already
> uses cgroup v2. How do you force v1? That is not the default behavior, right?
>

I stated above with indeed run with V1 due to past issues...I will try
to run with default V2 using the latest release and see if it is
improved.

> @Wei, do you remember which SLES version required to to disable the tests?
> Important is which cgroup version it uses and maybe kernel and systemd version.
> 

I will dig deeper next week to see what happens in my setup with V2 and
why V1 is failing to clean...
(not anymore so familiar with all of this sorry :P)

Thanks for the review in the meantime,
Cristian

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
