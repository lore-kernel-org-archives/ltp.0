From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 19 Aug 2020 15:17:01 -0400
Subject: [LTP] NETDEV WATCHDOG: WARNING: at net/sched/sch_generic.c:442
 dev_watchdog
In-Reply-To: <20200819102909.000016ac@intel.com>
References: <CA+G9fYtS_nAX=sPV8zTTs-nOdpJ4uxk9sqeHOZNuS4WLvBcPGg@mail.gmail.com>
 <20200819125732.1c296ce7@oasis.local.home>
 <20200819102909.000016ac@intel.com>
Message-ID: <20200819151701.747769ce@oasis.local.home>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, 19 Aug 2020 10:29:09 -0700
Jesse Brandeburg <jesse.brandeburg@intel.com> wrote:


> What I don't understand in the stack trace is this:
> > > [  107.654661] Call Trace:
> > > [  107.657735]  <IRQ>
> > > [  107.663155]  ? ftrace_graph_caller+0xc0/0xc0
> > > [  107.667929]  call_timer_fn+0x3b/0x1b0
> > > [  107.672238]  ? netif_carrier_off+0x70/0x70
> > > [  107.677771]  ? netif_carrier_off+0x70/0x70
> > > [  107.682656]  ? ftrace_graph_caller+0xc0/0xc0
> > > [  107.687379]  run_timer_softirq+0x3e8/0xa10
> > > [  107.694653]  ? call_timer_fn+0x1b0/0x1b0
> > > [  107.699382]  ? trace_event_raw_event_softirq+0xdd/0x150
> > > [  107.706768]  ? ring_buffer_unlock_commit+0xf5/0x210
> > > [  107.712213]  ? call_timer_fn+0x1b0/0x1b0
> > > [  107.716625]  ? __do_softirq+0x155/0x467  
> 
> 
> If the carrier was turned off by something, that could cause the stack
> to timeout since it appears the driver didn't call this itself after
> finishing all transmits like it normally would have.
> 
> Is the trace above correct? Usually the ? indicate unsure backtrace due
> to missing symbols, right?

The "?" means that there wasn't a stack frame to confirm that this was
the true call stack. What happens is that the scan of the stack will
look for any address in the stack that is for a function. If it finds
one, it will print it and add a "?" to that address. Basically, those
functions with the "?" are just addresses found in the stack but was not
part of a stack frame link.

-- Steve
