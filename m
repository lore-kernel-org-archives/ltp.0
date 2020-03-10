From: Ronald Monthero <rmonther@redhat.com>
Date: Tue, 10 Mar 2020 12:54:24 +1000
Subject: [LTP] Fix build error because of undefined CAP_SYS_TIME
In-Reply-To: <7adf2e52-6960-584f-bef4-c0179ade342a@cn.fujitsu.com>
References: <CAGR3Yi6r+caUYV+yZYHGsuRUPQBbpsN_PJOTTSvHwE2VARy92g@mail.gmail.com>
 <7adf2e52-6960-584f-bef4-c0179ade342a@cn.fujitsu.com>
Message-ID: <CAGR3Yi6zV9hLhaY+kKRHZYByo-Vtc_MvqEdTEOXjbnHK6tFR6w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Sure thanks

Regards,
Ronald

On Tue, Mar 10, 2020 at 12:51 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:
>
> Hi Ronald
>
> acked, but I think we can sort them by num.
>
> @xiao, can you merge this patch?
>
> Best Regards
> Yang Xu
>
> > Details of the build log at pr#654
> > https://github.com/linux-test-project/ltp/pull/654
> >
> > Signed-off-by: Ronald Monthero <rmonther@redhat.com
> > <mailto:rmonther@redhat.com>>
> > ---
> > diff --git a/include/lapi/capability.h b/include/lapi/capability.h
> > index 8833f0605..8ed68bfce 100644
> > --- a/include/lapi/capability.h
> > +++ b/include/lapi/capability.h
> > @@ -24,6 +24,10 @@
> >   # define CAP_NET_RAW          13
> >   #endif
> >
> > +#ifndef CAP_SYS_TIME
> > +#define CAP_SYS_TIME          25
> > +#endif
> > +
> >   #ifndef CAP_SYS_ADMIN
> >   # define CAP_SYS_ADMIN        21
> >   #endif
> > ---
> >
> >
>
>


-- 
Regards,
Ronald

