From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Nov 2015 12:00:48 +0100
Subject: [LTP] [PATCH] controllers/cpuacct: rewrote testcases
In-Reply-To: <20151109175127.GC23947@rei>
References: <1447061722-12065-1-git-send-email-chnyda@suse.com>
 <20151109175127.GC23947@rei>
Message-ID: <20151110110048.GE23947@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +## check that cpuacct.usage != 0 for every subgroup
> > +((TST_COUNT = TST_COUNT + 1))
> > +if [ "$error" -eq "1" ]; then
> > +	tst_resm TFAIL "cpuacct.usage should not be equal to 0"
> > +else
> > +	tst_resm TPASS "cpuacct.usage is not equal to 0 for every subgroup"
> > +fi
> 
> I'm not 100% sure that this assertion will always hold. I will have to
> look into this.

I've given it some thoughts and what we can do is to create the helper
process in a way that it kill itself after it spends defined time
executing code.

#include <stdio.h>
#include <sys/time.h>

int main(void)
{
        struct itimerval it = {.it_value = {.tv_sec = 0, .tv_usec = 10000}};

        setitimer(ITIMER_VIRTUAL, &it, NULL);

	for (;;);

        return 0;
}


This code sets up timer that sends a signal to a process after 1ms of
execution.

Now we can run as many of these as we need and then we can do wait on the pids
in the main process. That way we would have guaranteed that the execution time
is slightly above 1ms.

-- 
Cyril Hrubis
chrubis@suse.cz
