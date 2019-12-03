From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 3 Dec 2019 07:37:44 -0500 (EST)
Subject: [LTP] ??? FAIL: Test report for kernel 5.3.13-cc9917b.cki
 (stable-queue)
In-Reply-To: <20191203122236.GC2844@rei>
References: <cki.B4696121A3.SRVKVUGWT3@redhat.com>
 <546bd6ac-8ab1-9a9b-5856-e6410fb8ee89@redhat.com> <20191203122236.GC2844@rei>
Message-ID: <1532241482.14811981.1575376664944.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > > We ran automated tests on a recent commit from this kernel tree:
> > > 
> > >         Kernel repo:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
> > >              Commit: cc9917b40848 - mdio_bus: Fix init if
> > >              CONFIG_RESET_CONTROLLER=n
> > > 
> > > The results of these automated tests are provided below.
> > > 
> > >      Overall result: FAILED (see details below)
> > >               Merge: OK
> > >             Compile: OK
> > >               Tests: FAILED
> > > 
> > > All kernel binaries, config files, and logs are available for download
> > > here:
> > > 
> > >    https://artifacts.cki-project.org/pipelines/309848
> > > 
> > > One or more kernel tests failed:
> > > 
> > >      ppc64le:
> > >       ??? LTP
> > 
> > I see a slew of syscalls failures here for LTP:
> > https://artifacts.cki-project.org/pipelines/309848/logs/ppc64le_host_1_LTP_resultoutputfile.log
> > https://artifacts.cki-project.org/pipelines/309848/logs/ppc64le_host_1_LTP_syscalls.run.log
> 
> There are a few syslog failures, which does not seem to be related to
> the kernel commit at all. The commit above seems to touch error handling
> in a mdio bus which is used to configure network hardware. I would say
> that this is connected to the rest of the unexplained failures on
> ppc64le that seems to happen randomly.

I think this is different. Test is spam-ing serial console with:
 preadv203 (765613): drop_caches: 3

which leads to RCU stall:
[ 4338.611873] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[ 4517.198118] systemd[1]: systemd-journald.service: State 'stop-watchdog' timed out. Terminating.
[ 4518.688311] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[ 4518.688318] rcu: 	0-...0: (2 ticks this GP) idle=7da/1/0x4000000000000000 softirq=208692/208696 fqs=11772 
[ 4518.688321] 	(detected by 3, t=24007 jiffies, g=280901, q=430)
[ 4518.688324] Sending NMI from CPU 3 to CPUs 0:
[ 4524.259240] CPU 0 didn't respond to backtrace IPI, inspecting paca.
[ 4524.259243] irq_soft_mask: 0x01 in_mce: 0 in_nmi: 0 current: 765613 (preadv203)
[ 4524.259245] Back trace of paca->saved_r1 (0xc000000029b47990) (possibly stale):
[ 4524.259246] Call Trace:
[ 4524.259250] [c000000029b47990] [0000000000000001] 0x1 (unreliable)
[ 4524.259255] [c000000029b47a00] [c0000000007e8b28] hvterm_raw_put_chars+0x48/0x70
[ 4524.259257] [c000000029b47a20] [c0000000007eb174] hvc_console_print+0x124/0x2c0
[ 4524.259260] [c000000029b47ab0] [c0000000001b2238] console_unlock+0x588/0x760
[ 4524.259262] [c000000029b47b90] [c0000000001b4a8c] vprintk_emit+0x22c/0x330
[ 4524.259264] [c000000029b47c00] [c0000000001b5d28] vprintk_func+0x78/0x1b0
[ 4524.259266] [c000000029b47c50] [c0000000001b5294] printk+0x40/0x54
[ 4524.259269] [c000000029b47c70] [c0000000004e6c7c] drop_caches_sysctl_handler+0x14c/0x170
[ 4524.259271] [c000000029b47ce0] [c000000000512390] proc_sys_call_handler+0x230/0x240
[ 4524.259273] [c000000029b47d60] [c000000000432098] __vfs_write+0x38/0x70
[ 4524.259275] [c000000029b47d80] [c0000000004363c8] vfs_write+0xd8/0x250
[ 4524.259277] [c000000029b47dd0] [c000000000436798] ksys_write+0x78/0x130
[ 4524.259280] [c000000029b47e20] [c00000000000bae4] system_call+0x5c/0x70

Maybe we could temporarily lower printk level during this test.

Test also fails to release loop device and subsequent tests fail
because they try to use same one.

