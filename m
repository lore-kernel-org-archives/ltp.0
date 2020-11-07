From: Petr Vorel <pvorel@suse.cz>
Date: Sat, 7 Nov 2020 17:42:14 +0100
Subject: [LTP] [PATCH 03/19] Unify error handling in
 lib/tst_safe_timerfd.c
In-Reply-To: <5FA5E8D6.4040401@cn.fujitsu.com>
References: <20201026164756.30556-1-mdoucha@suse.cz>
 <20201026164756.30556-4-mdoucha@suse.cz>
 <5F97E6A0.8090506@cn.fujitsu.com> <20201106173545.GA30641@pevik>
 <5FA5E8D6.4040401@cn.fujitsu.com>
Message-ID: <20201107164214.GA10159@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin, Xu,

> > Hi Martin, Xu,

> > > > diff --git a/lib/tst_safe_timerfd.c b/lib/tst_safe_timerfd.c
> > > > index ffe7b2ef7..4c36a309c 100644
> > > > --- a/lib/tst_safe_timerfd.c
> > > > +++ b/lib/tst_safe_timerfd.c
> > > > @@ -17,9 +17,14 @@ int safe_timerfd_create(const char *file, const int lineno,
> > > >    	int fd;

> > > >    	fd = timerfd_create(clockid, flags);
> > > > -	if (fd<   0) {
> > > > -		tst_brk(TTYPE | TERRNO, "%s:%d timerfd_create(%s) failed",
> > > > -			file, lineno, tst_clock_name(clockid));
> > > > +
> > > > +	if (fd == -1) {
> > > > +		tst_brk_(file, lineno, TTYPE | TERRNO,
> > > > +			"timerfd_create(%s) failed", tst_clock_name(clockid));
> > > > +	} else if (fd<   0) {
> > nit: fd<   0 =>  fd<   0
> Sorry, It is my email format problem, on patchwork[1], the format is right.

Martin, sorry for not checking what you send in the patch.

> [1]https://patchwork.ozlabs.org/project/ltp/patch/20201026164756.30556-4-mdoucha@suse.cz/

Kind regards,
Petr
