From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Jan 2021 16:03:46 +0100
Subject: [LTP] [PATCH 1/1] mallopt01: Rewrite to new API
In-Reply-To: <6007A999.7090903@cn.fujitsu.com>
References: <20210119132427.6342-1-pvorel@suse.cz>
 <6007A999.7090903@cn.fujitsu.com>
Message-ID: <YAmX0tCKisM14QzS@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

thanks for your review and more search in man page than I did!

...
> > diff --git a/configure.ac b/configure.ac
> > index e44e25cc6..17ef76c1a 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -94,6 +94,7 @@ AC_CHECK_FUNCS_ONCE([ \
> >       io_uring_register \
> >       io_uring_enter \
> >       kcmp \
> > +    mallopt \
> If glibc/ulibc supports mallopt, it also should support mallinfo. So only
> check mallopt, I think it is ok.
Yes. These are glibc specific and uclibc tries to be API compatible with glibc.


> I guess musl libc doesn't support it, is it right?
Correct, musl don't support it, neither binder.

> > diff --git a/testcases/kernel/syscalls/mallopt/mallopt01.c b/testcases/kernel/syscalls/mallopt/mallopt01.c
...
> > -/*
> > - * NAME
> > - *	mallopt
> > - *
> > - * CALLS
> > - *	malloc(3x), mallopt(3x), mallinfo(3x).
> > - *
> > - * ALGORITHM
> > - *	Set options, malloc memory, and check resource ussage.
> > +/*\
> > + * [DESCRIPTION]
> >    *
> > - * RESTRICTIONS
> > - */
> > + * Basic mallinfo() and mallopt() testing (M_MXFAST, M_NLBLKS).
> > +\*/
> I see glibc code, it said "Only one of these (M_MXFAST) is used
>   in this malloc. The others (M_NLBLKS, M_GRAIN, M_KEEP) don't apply,
>   so setting them has no effect. But this malloc also supports four
>   other options in mallopt. "

> Also, I don't see M_NLBLKS handle in __libc_mallopt.

> I think that is why man-pages said "The SVID defined
> options M_MXFAST, M_NLBLKS, M_GRAIN, and M_KEEP, but only the first of these
> is implemented in glibc."

> I guess we can remove useless M_NLBLKS test.
Good catch! Agree. And it's also not supported on uclibc.

...
> >   	info = mallinfo();
> The lastest mallinfo man-pages said " However, the older function,
> mallinfo(), is deprecated since the type used for the fields is too small".
> The mallinfo2 structure used size_t data type instead of int data type in
> mallinfo struct. Maybe we can add a new test for it.

+1.
mallinfo2() was added few months ago to glibc by Martin Liska, released in 2.33.

Kind regards,
Petr
