From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 6 Jun 2016 09:51:17 -0400 (EDT)
Subject: [LTP] [PATCH] sched_rr_get_interval: run tests under SCHED_RR
 policy
In-Reply-To: <20160606115941.GA20756@rei>
References: <2acd53b3a170f75ee579e0e6cb694748db755678.1464959671.git.jstancek@redhat.com>
 <20160606115941.GA20756@rei>
Message-ID: <1897541276.3723702.1465221077297.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Monday, 6 June, 2016 1:59:41 PM
> Subject: Re: [LTP] [PATCH] sched_rr_get_interval: run tests under SCHED_RR policy
> 
> Hi!
> > Man page says:
> >  The specified process should be running under the SCHED_RR
> >  scheduling policy.
> 
> There does not seem to be such limitation in POSIX at:
> 
> http://pubs.opengroup.org/onlinepubs/9699919799/
> 
> But they explain that the the time quantum returned by the call is only
> applicable for SCHED_RR in schedulling policies at:
> 
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html#tag_15_08_04_01
> 
> > sched_rr_get_interval_1-1 can rarely fail if run as
> > SCHED_OTHER, because time quantum calculated/returned by
> > get_rr_interval_fair() can change between two calls.
> > For example it depends on number of running tasks on runq.
> 
> So this is fine, acked.

Pushed.

Regards,
Jan
