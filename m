From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 May 2017 17:38:25 +0200
Subject: [LTP] [RFC] [PATCH] pselect01: Tune thresholds
In-Reply-To: <1049610106.10797216.1494574389728.JavaMail.zimbra@redhat.com>
References: <20170505131855.32545-1-chrubis@suse.cz>
 <2075581666.10581422.1494518085371.JavaMail.zimbra@redhat.com>
 <20170512065131.GA24762@rei.lan>
 <1541549049.10767477.1494573107488.JavaMail.zimbra@redhat.com>
 <20170512071719.GB24762@rei.lan>
 <1049610106.10797216.1494574389728.JavaMail.zimbra@redhat.com>
Message-ID: <20170512153825.GC25149@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > If it's per iteration, shouldn't this function be passed time per
> > > iteration?
> > > At the moment, it's time of all iterations:
> > >   requested_us = tst_timespec_to_us(t->tv) * t->iterations;
> > >   threshold = compute_threshold(requested_us, t->iterations);
> > > 
> > > Should it be ... ?
> > >   threshold = compute_threshold(tst_timespec_to_us(t->tv), t->iterations);
> > 
> > Good catch, I will fix that, retest and send v2.
> 
> OK, if we agree, it's supposed to be time of single iteration,
> isn't new function (in some cases) more strict than it used to be?
> 
> Before we had:
>   threshold = requested_us / 100 + 200 * t->iterations;
> which was 1% slack plus small number (200) that scales with iterations.

The slack has to be multiplied by the number of iterations. I did
several measurements with the attached program and on x86 the mean seems
to consist of constant offset that is somewhere between 50us and 250us
and slack that does follow 0.1% of the sleep time.

Here are measurements on otherwise idle AMD Phenom Quad-Core:

min 112 max 301 median 154 mean 154.56 0.1% 0.10
min 520 max 595 median 555 mean 555.37 0.1% 0.50
min 1015 max 1126 median 1056 mean 1056.13 0.1% 1.00
min 2014 max 2128 median 2056 mean 2056.89 0.1% 2.00
min 3018 max 3219 median 3057 mean 3057.80 0.1% 3.00
min 4008 max 4072 median 4057 mean 4056.28 0.1% 4.00
min 10015 max 10275 median 10057 mean 10058.41 0.1% 10.00
min 100010 max 100354 median 100111 mean 100153.25 0.1% 100.00
min 500014 max 500702 median 500499 mean 500474.65 0.1% 500.00
min 1000652 max 1001351 median 1001000 mean 1000999.24 0.1% 1000.00

It looks like the offset is 50us and that the mean more or less follows
the slack. The offset seems to be closer to 250us for virtual machines.

On machines that use only jiffies the timer overshoot is close to twice
of the monotonic clock resolution.

> Now we have 0.1% slack plus small number (40) that scales
> with iterations plus big number (20000) that scales inverse
> to number number of iterations.
> 
> Say for 1000 us and 1000 iterations we used to have slack
> 10000 + 200*1000 =~ 210000. And now it's
> (40 + 1) * 1000 + 20000 / (1000/200+1) = 41000 + 3333 =~ 44333

See v2. It's more complicated now but looks like I've managed to break
it into several pieces and the new formula works fine but there has to
be at least one idle CPU. When machine is under heavy load the sleep
times are affected by scheduler slices...

Looking at it again we can also play it safe and allow 0.2% slack but otherwise
I think that I got it right this time.

-- 
Cyril Hrubis
chrubis@suse.cz
-------------- next part --------------
A non-text attachment was scrubbed...
Name: measure.c
Type: text/x-c
Size: 2371 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170512/16580293/attachment-0001.bin>
