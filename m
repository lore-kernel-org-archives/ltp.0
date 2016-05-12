From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 May 2016 13:26:45 +0200
Subject: [LTP] [PATCH 2/4] memcg_process_stress: allocate memory not in
 the signal handler
In-Reply-To: <5734647E.2040801@oracle.com>
References: <1461338590-1309-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160511143913.GH24701@rei.lan> <5734647E.2040801@oracle.com>
Message-ID: <20160512112512.GC31561@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >>   	while (!flag_exit) {
> >>   		sleep(interval);
> >>
> >> -		if (flag_ready)
> >> +		if (flag_ready) {
> >> +			if (!allocated) {
> >> +				alloc_memory();
> >> +				allocated = 1;
> >> +			}
> >> +
> >>   			touch_memory();
> >> +		}
> >>   	}
> >
> >
> > We can do even better if we change the sleep() for pause().
> 
> Thank you for the review. I agree with all other comments to this 
> series, except this one.
> 
> I'd keep sleep() here, because it allows the process to perform a series 
> of touch_memory() invocations before it receives the final SIGINT signal.

You are right, I've missed that yesterday.

-- 
Cyril Hrubis
chrubis@suse.cz
