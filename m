From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 19 Aug 2020 10:29:09 -0700
Subject: [LTP] NETDEV WATCHDOG: WARNING: at net/sched/sch_generic.c:442
 dev_watchdog
In-Reply-To: <20200819125732.1c296ce7@oasis.local.home>
References: <CA+G9fYtS_nAX=sPV8zTTs-nOdpJ4uxk9sqeHOZNuS4WLvBcPGg@mail.gmail.com>
 <20200819125732.1c296ce7@oasis.local.home>
Message-ID: <20200819102909.000016ac@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Steven Rostedt wrote:

> On Wed, 19 Aug 2020 17:01:06 +0530
> Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> 
> > kernel warning noticed on x86_64 while running LTP tracing ftrace-stress-test
> > case. started noticing on the stable-rc linux-5.8.y branch.
> > 
> > This device booted with KASAN config and DYNAMIC tracing configs and more.
> > This reported issue is not easily reproducible.
> > 
> > metadata:
> >   git branch: linux-5.8.y
> >   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >   git commit: ad8c735b1497520df959f675718f39dca8cb8019
> >   git describe: v5.8.2
> >   make_kernelversion: 5.8.2
> >   kernel-config:
> > https://builds.tuxbuild.com/bOz0eAwkcraRiWALTW9D3Q/kernel.config
> > 
> > 
> > [   88.139387] Scheduler tracepoints stat_sleep, stat_iowait,
> > stat_blocked and stat_runtime require the kernel parameter
> > schedstats=enable or kernel.sched_schedstats=1
> > [   88.139387] Scheduler tracepoints stat_sleep, stat_iowait,
> > stat_blocked and stat_runtime require the kernel parameter
> > schedstats=enable or kernel.sched_schedstats=1
> > [  107.507991] ------------[ cut here ]------------
> > [  107.513103] NETDEV WATCHDOG: eth0 (igb): transmit queue 2 timed out
> > [  107.519973] WARNING: CPU: 1 PID: 331 at net/sched/sch_generic.c:442
> > dev_watchdog+0x4c7/0x4d0
> > [  107.528907] Modules linked in: x86_pkg_temp_thermal
> > [  107.534541] CPU: 1 PID: 331 Comm: systemd-journal Not tainted 5.8.2 #1
> > [  107.541480] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> > 2.2 05/23/2018
> > [  107.549314] RIP: 0010:dev_watchdog+0x4c7/0x4d0
> > [  107.554226] Code: ff ff 48 8b 5d c8 c6 05 6d f7 94 01 01 48 89 df
> > e8 9e b4 f8 ff 44 89 e9 48 89 de 48 c7 c7 20 49 51 9c 48 89 c2 e8 91
> > 7e e9 fe <0f> 0b e9 03 ff ff ff 66 90 e8 9b 23 db fe 55 48 89 e5 41 57
> 
> I've triggered this myself in my testing, and I assumed that adding the
> overhead of tracing and here KASAN too, made some watchdog a bit
> unhappy. By commenting out the warning, I've seen no ill effects.
> 
> Perhaps this is something we need to dig a bit deeper into.

Looked into it a little, igb uses a timeout of 5 seconds, and the stack
prints the warning if we haven't completed the transmit in that time.

What I don't understand in the stack trace is this:
> > [  107.654661] Call Trace:
> > [  107.657735]  <IRQ>
> > [  107.663155]  ? ftrace_graph_caller+0xc0/0xc0
> > [  107.667929]  call_timer_fn+0x3b/0x1b0
> > [  107.672238]  ? netif_carrier_off+0x70/0x70
> > [  107.677771]  ? netif_carrier_off+0x70/0x70
> > [  107.682656]  ? ftrace_graph_caller+0xc0/0xc0
> > [  107.687379]  run_timer_softirq+0x3e8/0xa10
> > [  107.694653]  ? call_timer_fn+0x1b0/0x1b0
> > [  107.699382]  ? trace_event_raw_event_softirq+0xdd/0x150
> > [  107.706768]  ? ring_buffer_unlock_commit+0xf5/0x210
> > [  107.712213]  ? call_timer_fn+0x1b0/0x1b0
> > [  107.716625]  ? __do_softirq+0x155/0x467


If the carrier was turned off by something, that could cause the stack
to timeout since it appears the driver didn't call this itself after
finishing all transmits like it normally would have.

Is the trace above correct? Usually the ? indicate unsure backtrace due
to missing symbols, right?
