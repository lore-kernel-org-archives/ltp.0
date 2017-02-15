From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 15 Feb 2017 11:50:47 -0500 (EST)
Subject: [LTP] [PATCH] syscalls/mq_open: fix limits for queues_max
In-Reply-To: <20170215152406.GB29673@rei.lan>
References: <1486384930-28588-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20170215152406.GB29673@rei.lan>
Message-ID: <956936356.5228861.1487177447794.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Xiao Yang" <yangx.jy@cn.fujitsu.com>
> Cc: ltp@lists.linux.it, "Jan Stancek" <jstancek@redhat.com>
> Sent: Wednesday, 15 February, 2017 4:24:06 PM
> Subject: Re: [LTP] [PATCH] syscalls/mq_open: fix limits for queues_max
> 
> Hi!
> > This case fails on RHEL6.8GA and RHEL6.9Beta, because setting
> > queues_max to 0 is invalid.  the minimum value of queues_max
> > has been limitted to 1 on some distributions, Please see the
> > following kernel commit:
> > 
> > commit 5b5c4d1a1440e94994c73dddbad7be0676cd8b9a

since RHEL6.2

> > Author: Doug Ledford <dledford@redhat.com>
> > Date:   Thu May 31 16:26:30 2012 -0700
> > 
> > 	ipc/mqueue: update maximums for the mqueue subsystem
> > 
> > We set queues_max to 1 instead of 0, so this case can work on RHEL6.
> 
> First I think that you have wrong commit, the one that actually added
> the limits was:
> 
> commit 93e6f119c0ce8a1bba6e81dc8dd97d67be360844

since RHEL6.2

> Author: Doug Ledford <dledford@redhat.com>
> Date:   Thu May 31 16:26:28 2012 -0700
> 
>     ipc/mqueue: cleanup definition names and locations
> 
> Since this commit changes the proc handler in sysctl table and adds the
> minimum
> and maximum values there.
> 
> Secondly these limits were removed in:
> 
> commit a5c5928b759d8c7382cccc7be36769a68046cc58

doesn't seem to present in any RHEL6 kernel

> Author: Joe Perches <joe@perches.com>
> Date:   Fri Jun 6 14:38:07 2014 -0700
> 
>     ipc: convert use of typedef ctl_table to struct ctl_table
> 
> 
> I'm not sure if this is worth the effort.
> 
> Jan what do you think, should we apply this to fix the test on RHEL6?

I would like this to work with RHEL6, but it be good to understand
why failures started for Xiao only now.

I'm looking at results of kernel-2.6.32-694.el6 (6.9), and it's passing:
<<<test_start>>>
tag=mq_open01 stime=1487065446
cmdline="mq_open01"
contacts=""
analysis=exit
<<<test_output>>>
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       7 errno=0 (Success)
mq_open01    0  TINFO  :  (case00) START
mq_open01    0  TINFO  :  mq_maxmsg E:20,	R:20
mq_open01    0  TINFO  :  mq_msgsize E:16384,	R:16384
mq_open01    0  TINFO  :  (case00) END => OK
mq_open01    1  TPASS  :  mq_open call succeeded 
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>

I'll try 6.8 too.

Regards,
Jan
