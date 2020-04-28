From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 28 Apr 2020 09:19:41 +0200
Subject: [LTP] [PATCH] common_timers: staticize all definitions
In-Reply-To: <20200428061424.fj4mq676aoosoqyw@vireshk-i7>
References: <20200427145212.GA5678@dell5510>
 <90ea553dfdea21683c517a7f47b2a5d3c2dba77f.1588050000.git.viresh.kumar@linaro.org>
 <20200428061424.fj4mq676aoosoqyw@vireshk-i7>
Message-ID: <CAK8P3a0On9euT2mzx+LsXVe21cqwNMR4Hzj3eVDhbCS_KeGb4w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Apr 28, 2020 at 8:14 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 28-04-20, 10:30, Viresh Kumar wrote:
> > Staticize all variable and function definitions to avoid build failures
> > in the future if this gets included by multiple files.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  include/lapi/common_timers.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/lapi/common_timers.h b/include/lapi/common_timers.h
> > index df4196eeb579..d2d0d0dab5fd 100644
> > --- a/include/lapi/common_timers.h
> > +++ b/include/lapi/common_timers.h
> > @@ -15,7 +15,7 @@
> >  #define NSEC_PER_SEC (1000000000L)
> >  #endif
> >
> > -clock_t clock_list[] = {
> > +static clock_t clock_list[] = {
> >       CLOCK_REALTIME,
> >       CLOCK_MONOTONIC,
> >       CLOCK_PROCESS_CPUTIME_ID,
> > @@ -34,7 +34,7 @@ clock_t clock_list[] = {
> >       case def_name:          \
> >               return #def_name;
>
> Unfortunately this still generates warning:
>
> warning: ?clock_list? defined but not used
>
> I missed seeing this earlier in the full build and saw it now while
> building a single test case.
>
> I think we need to move this to some .c file and remove the "static"
> part. But I am not sure which one to. If we do that, then rest of the
> series will not be affected by it.

That is probably the cleanest way, yes

> Or we can simply drop the "static" part and multiple copies of this
> will be present in different .c files. Which I don't really like to be
> honest.

There is usually no warning about variables in header files
that are marked 'static const' rather than just 'static', as that
is a common way to do things in C++.

> Or we can simply drop the "static" part and multiple copies of this
> will be present in different .c files. Which I don't really like to be
> honest.

With gcc-10 and clang-10 this will cause a link-time failure, because
they now both default to "-fno-common" behavior.

       Arnd
