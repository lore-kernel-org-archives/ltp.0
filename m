From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 25 Jan 2018 14:35:51 +0100
Subject: [LTP] [lkp-robot] [sched/deadline] e0367b1267:
 WARNING:at_kernel/sched/sched.h:#assert_clock_updated
In-Reply-To: <20180125132906.GA10968@localhost.localdomain>
References: <20180125062839.GM5185@yexl-desktop>
 <20180125112013.GA6110@localhost.localdomain>
 <20180125122458.GB3420@rei>
 <20180125132906.GA10968@localhost.localdomain>
Message-ID: <20180125133551.GB19878@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > Hummm, wondering how LTP sched tests could trigger this, since a quick
> > > grep into ltp didn't show DEADLINE usage.
> > 
> > See kernel/syscalls/sched_setattr/sched_setattr01.c
> 
> Right, saw that. I was still thinking though why the report seemed to
> point to sched, and not syscalls, tests.

These collections of tests have sometimes non empty intersections. In
this case the particular test is both part of the sched and syscall
testruns (grep sched_setattr01 runtest/*). So I suppose that the test
fails both in the sched and syscall run but the sched one was simply
picked first here.

> Thanks for pointing this out.

Glad to help :-).

-- 
Cyril Hrubis
chrubis@suse.cz
