From: Murphy Zhou <xzhou@redhat.com>
Date: Mon, 23 Mar 2020 10:25:57 +0800
Subject: [LTP] 
 =?utf-8?q?=F0=9F=92=A5_PANICKED=3A_Test_report_for_kernel_?=
 =?utf-8?q?5=2E5=2E11-6df57ed=2Ecki_=28stable-queue=29?=
In-Reply-To: <20200323015828.GS4189@sasha-vm>
References: <cki.D9E02DA05E.6L1W61X8RG@redhat.com>
 <20200323015828.GS4189@sasha-vm>
Message-ID: <20200323022557.vm3hlc3ndggp5yws@xzhoux.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sun, Mar 22, 2020 at 09:58:28PM -0400, Sasha Levin wrote:
> On Sun, Mar 22, 2020 at 11:50:11PM -0000, CKI Project wrote:
> > 
> > Hello,
> > 
> > We ran automated tests on a recent commit from this kernel tree:
> > 
> >       Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >            Commit: 6df57ed14ddf - Revert "drm/fbdev: Fallback to non tiled mode if all tiles not present"
> > 
> > The results of these automated tests are provided below.
> > 
> >    Overall result: FAILED (see details below)
> >             Merge: OK
> >           Compile: OK
> >             Tests: PANICKED
> > 
> > All kernel binaries, config files, and logs are available for download here:
> > 
> >  https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/03/22/500600
> > 
> > One or more kernel tests failed:
> > 
> >    ppc64le:
> >     ? LTP
> > 
> >    aarch64:
> >     ? Boot test
> > 
> >    x86_64:
> >     ? xfstests - ext4
> 
> So I go in the xfstests___ext4/ directory to see what paniced, right? I
> don't see panics in those logs...

It's in the x86_64_3_console.log

[  247.623251] BUG: kernel NULL pointer dereference, address: 0000000000000000 
[  247.631021] #PF: supervisor write access in kernel mode 
[  247.636848] #PF: error_code(0x0002) - not-present page 
[  247.642579] PGD 0 P4D 0  
[  247.645402] Oops: 0002 [#1] SMP PTI 
[  247.649292] CPU: 2 PID: 1897 Comm: kworker/2:40 Tainted: G          I 5.5.11-6df57ed.cki #1 
[  247.659192] Hardware name: IBM System x3250 M4 -[2583ECU]-/00D3729, BIOS -[JQE168BUS-1.09]- 09/17/2014 
[  247.669580] Workqueue: cgroup_destroy css_killed_work_fn 
[  247.675506] RIP: 0010:bfq_bfqq_move+0x21/0x160 
[  247.680462] Code: c0 c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 41 55 41
54 49 89 fc 55 48 89 f5 53 48 89 d3 48 39 b7 a0 00 00 00 0f 84 22 01 00
00 <83> 45 00 01 48 89 ef e8 a3 87 ff ff 85 c0 0f 85 d7 00 00 00 80 bd 
[  247.701415] RSP: 0018:ffffb61340e87db0 EFLAGS: 00010086 
[  247.707242] RAX: 0000000000000000 RBX: ffff99d9b1dd8000 RCX: 0000000000000000 
[  247.715202] RDX: ffff99d9b1dd8000 RSI: 0000000000000000 RDI: ffff99d9b1dda000 
[  247.723161] RBP: 0000000000000000 R08: 000000003b9aca00 R09: ffff99d9b1d87300 
[  247.731123] R10: 0000000000000000 R11: ffff99d9b1d87300 R12: ffff99d9b1dda000 
[  247.739083] R13: ffff99d98492d1b0 R14: ffff99d9b1dda3f0 R15: ffff99d98492d098 
[  247.747044] FS:  0000000000000000(0000) GS:ffff99d9b7c80000(0000) knlGS:0000000000000000 
[  247.756073] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 
[  247.762481] CR2: 0000000000000000 CR3: 000000023060a005 CR4: 00000000001606e0 
[  247.770441] Call Trace: 
[  247.773170]  bfq_pd_offline+0x87/0xf0 
[  247.777254]  blkg_destroy+0x52/0xf0 
[  247.781143]  blkcg_destroy_blkgs+0x4f/0xa0 
[  247.785710]  css_killed_work_fn+0x4d/0xd0 
[  247.790181]  process_one_work+0x1b5/0x360 
[  247.794651]  worker_thread+0x50/0x3c0 
[  247.798733]  kthread+0xf9/0x130 
[  247.802234]  ? process_one_work+0x360/0x360 
[  247.806899]  ? kthread_park+0x90/0x90 
[  247.810983]  ret_from_fork+0x35/0x40 
> 
> -- 
> Thanks,
> Sasha
> 

-- 
Murphy

