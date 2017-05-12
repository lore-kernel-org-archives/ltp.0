From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 May 2017 08:51:31 +0200
Subject: [LTP] [RFC] [PATCH] pselect01: Tune thresholds
In-Reply-To: <2075581666.10581422.1494518085371.JavaMail.zimbra@redhat.com>
References: <20170505131855.32545-1-chrubis@suse.cz>
 <2075581666.10581422.1494518085371.JavaMail.zimbra@redhat.com>
Message-ID: <20170512065131.GA24762@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +static int compute_threshold(long long requested_us, unsigned int
> > iterations)
> > +{
> > +	unsigned int slack_per_run = MIN(100000, requested_us / 1000);
> > +
> > +	return (40 + slack_per_run) * iterations + 20000 / (iterations/200 + 1);
> > +}
> 
>   requested_us = tst_timespec_to_us(t->tv) * t->iterations;
> 
> If slack_per_run is slack of all iterations, why is it multiplied
> again with number of iterations?

That variable is poorly named. It should have been slack_per_call or
slack_per_iteration. It's slack per one syscall computed using the same
formula that is used in kernel...

-- 
Cyril Hrubis
chrubis@suse.cz
