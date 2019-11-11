From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 11 Nov 2019 04:41:33 -0500 (EST)
Subject: [LTP] [PATCH] kernel: use ktime_get_real_ts64() to calculate
 acct.ac_btime
In-Reply-To: <20191107125559.GI4131@hirez.programming.kicks-ass.net>
References: <a87876829697e1b3c63601b1401a07af79eddae6.1572651216.git.jstancek@redhat.com>
 <20191107123224.GA6315@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1911071335320.4256@nanos.tec.linutronix.de>
 <20191107125559.GI4131@hirez.programming.kicks-ass.net>
Message-ID: <475677126.11444968.1573465293662.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> It's wrecked in general. It also jumps around for any REALTIME
> adjustment.
> 
> > So a CLOCK_REALTIME time stamp at fork would at least be correct
> > vs. suspend resume.
> 
> But still wrecked vs REALTIME jumps, as in, when DST flips the clock
> back an hour, your timestamp is in the future.
> 
> Any which way around the whole thing is buggered.  The only real fix is
> not using REALTIME anything. Which is why I'm loath to add that REALTIME
> timestamp at fork(), it just encourages more use.

Thank you for feedback and listing all other problems.
I'll adjust test expectations.

Regards,
Jan

