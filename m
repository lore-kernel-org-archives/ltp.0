From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Date: Fri, 27 Sep 2019 11:53:17 -0300
Subject: [LTP] [PATCH] timer_create01: accept ENOTSUP
In-Reply-To: <20190927144902.GA25060@rei.lan>
References: <20190926144507.15765-1-cascardo@canonical.com>
 <20190927144902.GA25060@rei.lan>
Message-ID: <20190927145316.GA8472@calabresa>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Sep 27, 2019 at 04:49:02PM +0200, Cyril Hrubis wrote:
> Hi!
> > CLOCK_REALTIME_ALARM and CLOCK_BOOTTIME_ALARM require an RTC with alarm
> > support, which may not be present on a system. In that case, the kernel
> > will return EOPNOTSUPP, which is defined as ENOTSUP in userspace.
> > 
> > As these clocks are already possibly unsupported, accept that as an error
> > code besides the EINVAL code.
> > 
> > Note that previously the kernel would incorrectly return the ENOTSUPP code,
> > which is undefined in userspace. With these unfixed kernels, the test will
> > fail when those RTCs are not present.
> 
> Can you please include the kernel commit id that fixed the kernel here?
> 
> Otherwise this patch is fine.

f18ddc13af981ce3c7b7f26925f099e7c6929aba ("alarmtimer: Use EOPNOTSUPP instead of ENOTSUPP")

Do you want me to send a v2, or will you fixup the patch?

Thanks a lot.
Cascardo.

> 
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> > ---
> >  testcases/kernel/syscalls/timer_create/timer_create01.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/testcases/kernel/syscalls/timer_create/timer_create01.c b/testcases/kernel/syscalls/timer_create/timer_create01.c
> > index 258b6444c362..1ae5b9b2d1c2 100644
> > --- a/testcases/kernel/syscalls/timer_create/timer_create01.c
> > +++ b/testcases/kernel/syscalls/timer_create/timer_create01.c
> > @@ -77,7 +77,8 @@ static void run(unsigned int n)
> >  				&created_timer_id));
> >  
> >  		if (TST_RET != 0) {
> > -			if (possibly_unsupported(clock) && TST_ERR == EINVAL) {
> > +			if (possibly_unsupported(clock) &&
> > +			    (TST_ERR == EINVAL || TST_ERR == ENOTSUP)) {
> >  				tst_res(TPASS | TTERRNO,
> >  					"%s unsupported, failed as expected",
> >  					get_clock_str(clock));
> > -- 
> > 2.20.1
> > 
> > 
> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
