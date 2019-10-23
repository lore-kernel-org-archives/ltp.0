From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Oct 2019 17:36:31 +0200
Subject: [LTP] [PATCH] timer_create01: accept kernel ENOTSUPP
In-Reply-To: <20191023145640.GD4055@calabresa>
References: <cb6173ec393a23949ec40c9747fc7f75fed2591f.1571838908.git.jstancek@redhat.com>
 <1714198769.8739783.1571839133168.JavaMail.zimbra@redhat.com>
 <20191023140408.GC4055@calabresa>
 <6089b924-8dbe-c43d-72d9-a4086a13b0d5@suse.cz>
 <20191023143510.GA10116@rei> <20191023145640.GD4055@calabresa>
Message-ID: <20191023153631.GA12897@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Beware that kernel defines ENOTSUP that is not equal to EOPNOTSUPP and
> > in this case this value leaked to userspace leading to invalid userspace
> > errno value.
> 
> That was ENOTSUPP (the internal kernel error, defined as 524). ENOTSUP, defined
> as EOPNOTSUPP, is the userspace error I guess Martin is saying should not be
> used either.

Ah, right, I misunderstand that.

> In that case, we need to fix the kernel to return EINVAL instead. Looking at
> older changes here, I see commit 98d6f4dd84a134d942827584a3c5f67ffd8ec35f
> ("alarmtimer: return EINVAL instead of ENOTSUPP if rtcdev doesn't exist")
> claiming exactly this. Though it was about clock_getres and clock_gettime,
> quoting from that commit:
> 
> "
>     Second, Posix and Linux man pages agree that clock_gettime and
>     clock_getres should return EINVAL if clk_id argument is invalid.
>     While the arugment that the clockid is valid, but just not supported
>     on this hardware could be made, this is just a technicality that
>     doesn't help userspace applicaitons, and only complicates error
>     handling.
> "

I would disagree, if you check latest POSIX it has:

[ENOTSUP]
    The implementation does not support the creation of a timer attached
    to the CPU-time clock that is specified by clock_id and associated
    with a process or thread different from the process or thread
    invoking timer_create().

https://pubs.opengroup.org/onlinepubs/9699919799/

So the implementation is required to return ENOTSUPP in certain cases
anyways so applying it to CLOCK_REALTIME_ALARM and
CLOCK_BOOTTIME_ALARM certainly makes sense.

-- 
Cyril Hrubis
chrubis@suse.cz
