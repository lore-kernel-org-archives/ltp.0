From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 22 Mar 2019 14:34:25 +0100
Subject: [LTP] [PATCH v3 4/4] syscalls/clock_adjtime: create
 clock_adjtime syscall tests
In-Reply-To: <5A6B4777-4D7E-4D2A-A338-8972236466C1@linaro.org>
References: <20190321141015.GG1252@rei>
 <20190321202732.3331-1-rafael.tinoco@linaro.org>
 <20190321202732.3331-4-rafael.tinoco@linaro.org>
 <5A6B4777-4D7E-4D2A-A338-8972236466C1@linaro.org>
Message-ID: <20190322133425.GB20408@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +	if (rval != TIME_OK)
> > +		tst_brk(TBROK | TTERRNO, "unsynced clock or on-going leap???);
> 
> I choose to break test if rval > 0 mainly because it could still have
> on-going leap operations, since clock_adjtime() is async, and also
> because doing the test with an unsynced clock seems weird.

We should print the saved with timex_show() here and the rval at least.

It however it looks like kernel boots with STA_UNSYNC until NTP manges
to sync the time and clears the flag but only if it manages to sync the
clock.

See:

http://linuxelf.com/blog/2017/03/27/clock-status-unsync/

Which itself is an argument to run the test with unsynced clock, since
not all environments have access to internet or ntp daemon running.

-- 
Cyril Hrubis
chrubis@suse.cz
