From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 7 Nov 2019 13:49:18 +0100
Subject: [LTP] [PATCH] kernel: use ktime_get_real_ts64() to calculate
 acct.ac_btime
In-Reply-To: <alpine.DEB.2.21.1911051304420.17054@nanos.tec.linutronix.de>
References: <a87876829697e1b3c63601b1401a07af79eddae6.1572651216.git.jstancek@redhat.com>
 <alpine.DEB.2.21.1911051304420.17054@nanos.tec.linutronix.de>
Message-ID: <20191107124918.GH4131@hirez.programming.kicks-ass.net>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Nov 07, 2019 at 09:56:12AM +0100, Thomas Gleixner wrote:
> But it would be way simpler just to store the CLOCK_REALTIME start time
> along with BOOT and MONOTONIC and just get rid of all these horrible
> calculations which are bound to be wrong.
> 
> Peter?

So I'd really hate to do that, as that gives the impression REALTIME is
a sane clock to use. As I argued in that other email, REALTIME is
horrible crap.

