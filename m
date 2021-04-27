From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Apr 2021 13:03:21 +0200
Subject: [LTP] [PATCH v3 2/7] API: Add macro for the container_of trick
In-Reply-To: <87o8e1m5zs.fsf@suse.de>
References: <20210412145506.26894-1-rpalethorpe@suse.com>
 <20210412145506.26894-3-rpalethorpe@suse.com>
 <CAEemH2ejA9kY2P4HsYEds3g9AjzFQ4mDRuWiF2176istdOMtaA@mail.gmail.com>
 <87o8e1m5zs.fsf@suse.de>
Message-ID: <YIfveS/5sIwHP7FG@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> ---
> >>  include/tst_common.h | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/include/tst_common.h b/include/tst_common.h
> >> index fd7a900d4..317925d1d 100644
> >> --- a/include/tst_common.h
> >> +++ b/include/tst_common.h
> >> @@ -83,4 +83,9 @@
> >>  #define TST_RES_SUPPORTS_TCONF_TFAIL_TINFO_TPASS_TWARN(condition) \
> >>         TST_BUILD_BUG_ON(condition)
> >>
> >> +#define tst_container_of(ptr, type, member) ({              \
> >> +       const typeof( ((type *)0)->member ) *__mptr = (ptr); \
> >> +       (type *)( (char *)__mptr - offsetof(type,member) );  \
> >> +})
> >>
> >
> > I'd suggest defining it as uppercase 'TST_CONTAINER_OF(...)' to respect
> > other macro's naming policy in tst_common.h.
> 
> I don't mind either way. I suspect it is lower case to match offsetof
> and maybe it is expected to become a compiler intrinsic. Perhaps we
> should remove the tst_. WDYT Cyril??

I think that it makes sense to use the same name as in the Linux kernel
since the macro is well known there. I would go just with container_of()
in this case.

-- 
Cyril Hrubis
chrubis@suse.cz
