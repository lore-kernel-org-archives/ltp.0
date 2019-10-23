From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Oct 2019 17:38:03 +0200
Subject: [LTP] [PATCH] timer_create01: accept kernel ENOTSUPP
In-Reply-To: <20191023153631.GA12897@rei>
References: <cb6173ec393a23949ec40c9747fc7f75fed2591f.1571838908.git.jstancek@redhat.com>
 <1714198769.8739783.1571839133168.JavaMail.zimbra@redhat.com>
 <20191023140408.GC4055@calabresa>
 <6089b924-8dbe-c43d-72d9-a4086a13b0d5@suse.cz>
 <20191023143510.GA10116@rei> <20191023145640.GD4055@calabresa>
 <20191023153631.GA12897@rei>
Message-ID: <20191023153802.GB12897@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I would disagree, if you check latest POSIX it has:
> 
> [ENOTSUP]
>     The implementation does not support the creation of a timer attached
>     to the CPU-time clock that is specified by clock_id and associated
>     with a process or thread different from the process or thread
>     invoking timer_create().
> 
> https://pubs.opengroup.org/onlinepubs/9699919799/
> 
> So the implementation is required to return ENOTSUPP in certain cases
                                               ^
					       And again, should have
					       been ENOTSUP!
> anyways so applying it to CLOCK_REALTIME_ALARM and
> CLOCK_BOOTTIME_ALARM certainly makes sense.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
