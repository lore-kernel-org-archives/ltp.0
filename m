From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 10 Aug 2018 14:42:56 +0200
Subject: [LTP] [RFC] statx Timestamp Test case
In-Reply-To: <d1c5e0ca49ef02e6ca2f87a8ac524428.squirrel@pike.zilogic.com>
References: <d1c5e0ca49ef02e6ca2f87a8ac524428.squirrel@pike.zilogic.com>
Message-ID: <20180810124256.GA32275@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >void my_clock_gettime(struct timespec *time)
> > {
> >    int ret;
> >    struct timespec prev_time;
> 
> 
> >    ret = clock_gettime(CLOCK_REALTIME_COARSE, &prev_time);
> >    if (ret == -1)
> >	tst_brk(TINFO | TERRNO, "clock_gettime failed");
> 
> >    do {
> >	ret = clock_gettime(CLOCK_REALTIME_COARSE, time);
> >	if (ret == -1)
> >	    tst_brk(TINFO | TERRNO, "clock_gettime failed");
> >    } while (time == prev_time);
> >}
> 
> Is this approach fine or is there any other better way of doing it?

You can use clock_getres() to query the lenght of the timer tick then
usleep a bit more than that, e.g. multiply that by 1.5.

-- 
Cyril Hrubis
chrubis@suse.cz
