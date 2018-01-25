From: Juri Lelli <juri.lelli@redhat.com>
Date: Thu, 25 Jan 2018 14:29:06 +0100
Subject: [LTP] [lkp-robot] [sched/deadline] e0367b1267:
 WARNING:at_kernel/sched/sched.h:#assert_clock_updated
In-Reply-To: <20180125122458.GB3420@rei>
References: <20180125062839.GM5185@yexl-desktop>
 <20180125112013.GA6110@localhost.localdomain>
 <20180125122458.GB3420@rei>
Message-ID: <20180125132906.GA10968@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 25/01/18 13:24, Cyril Hrubis wrote:
> Hi!
> > Hummm, wondering how LTP sched tests could trigger this, since a quick
> > grep into ltp didn't show DEADLINE usage.
> 
> See kernel/syscalls/sched_setattr/sched_setattr01.c

Right, saw that. I was still thinking though why the report seemed to
point to sched, and not syscalls, tests.

Thanks for pointing this out.

Best,

- Juri
