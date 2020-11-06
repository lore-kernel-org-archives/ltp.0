From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 6 Nov 2020 18:35:45 +0100
Subject: [LTP] [PATCH 03/19] Unify error handling in
 lib/tst_safe_timerfd.c
In-Reply-To: <5F97E6A0.8090506@cn.fujitsu.com>
References: <20201026164756.30556-1-mdoucha@suse.cz>
 <20201026164756.30556-4-mdoucha@suse.cz>
 <5F97E6A0.8090506@cn.fujitsu.com>
Message-ID: <20201106173545.GA30641@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin, Xu,

> > diff --git a/lib/tst_safe_timerfd.c b/lib/tst_safe_timerfd.c
> > index ffe7b2ef7..4c36a309c 100644
> > --- a/lib/tst_safe_timerfd.c
> > +++ b/lib/tst_safe_timerfd.c
> > @@ -17,9 +17,14 @@ int safe_timerfd_create(const char *file, const int lineno,
> >   	int fd;

> >   	fd = timerfd_create(clockid, flags);
> > -	if (fd<  0) {
> > -		tst_brk(TTYPE | TERRNO, "%s:%d timerfd_create(%s) failed",
> > -			file, lineno, tst_clock_name(clockid));
> > +
> > +	if (fd == -1) {
> > +		tst_brk_(file, lineno, TTYPE | TERRNO,
> > +			"timerfd_create(%s) failed", tst_clock_name(clockid));
> > +	} else if (fd<  0) {
nit: fd<  0 => fd <  0
> > +		tst_brk_(file, lineno, TBROK | TERRNO,
> > +			"Invalid timerfd_create(%s) return value %d",
> > +			tst_clock_name(clockid), fd);

> >   	}

> >   	return fd;
> > @@ -31,9 +36,14 @@ int safe_timerfd_gettime(const char *file, const int lineno,
> >   	int rval;

> >   	rval = timerfd_gettime(fd, curr_value);
> > -	if (rval != 0) {
> > -		tst_brk(TTYPE | TERRNO, "%s:%d timerfd_gettime() failed",
> > -			file, lineno);
> > +
> > +	if (rval == -1) {
> > +		tst_brk_(file, lineno, TTYPE | TERRNO,
> > +			"timerfd_gettime() failed");
> > +	}
> > +	if (rval) {
> > +		tst_brk_(file, lineno, TBROK | TERRNO,
> > +			"Invalid timerfd_gettime() return value %d", rval);
> Here also should use else if.
+1.
If I'm not wrong we need to count that safe functions does not quit the test in
cleanup function (tst_brk__() and tst_brk_entered).

Kind regards,
Petr
