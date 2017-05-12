From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 12 May 2017 03:33:09 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] pselect01: Tune thresholds
In-Reply-To: <20170512071719.GB24762@rei.lan>
References: <20170505131855.32545-1-chrubis@suse.cz>
 <2075581666.10581422.1494518085371.JavaMail.zimbra@redhat.com>
 <20170512065131.GA24762@rei.lan>
 <1541549049.10767477.1494573107488.JavaMail.zimbra@redhat.com>
 <20170512071719.GB24762@rei.lan>
Message-ID: <1049610106.10797216.1494574389728.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> > > >   requested_us = tst_timespec_to_us(t->tv) * t->iterations;
> > > > 
> > > > If slack_per_run is slack of all iterations, why is it multiplied
> > > > again with number of iterations?
> > > 
> > > That variable is poorly named. It should have been slack_per_call or
> > > slack_per_iteration. It's slack per one syscall computed using the same
> > > formula that is used in kernel...
> > 
> > If it's per iteration, shouldn't this function be passed time per
> > iteration?
> > At the moment, it's time of all iterations:
> >   requested_us = tst_timespec_to_us(t->tv) * t->iterations;
> >   threshold = compute_threshold(requested_us, t->iterations);
> > 
> > Should it be ... ?
> >   threshold = compute_threshold(tst_timespec_to_us(t->tv), t->iterations);
> 
> Good catch, I will fix that, retest and send v2.

OK, if we agree, it's supposed to be time of single iteration,
isn't new function (in some cases) more strict than it used to be?

Before we had:
  threshold = requested_us / 100 + 200 * t->iterations;
which was 1% slack plus small number (200) that scales with iterations.

Now we have 0.1% slack plus small number (40) that scales
with iterations plus big number (20000) that scales inverse
to number number of iterations.

Say for 1000 us and 1000 iterations we used to have slack
10000 + 200*1000 =~ 210000. And now it's
(40 + 1) * 1000 + 20000 / (1000/200+1) = 41000 + 3333 =~ 44333

Regards,
Jan
