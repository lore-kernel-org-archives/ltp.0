Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <carmelo.amoroso@st.com>) id 1P30fQ-0002v6-Ev
	for ltp-list@lists.sourceforge.net; Tue, 05 Oct 2010 06:06:24 +0000
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141])
	by sog-mx-1.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P30fO-0002is-Jr
	for ltp-list@lists.sourceforge.net; Tue, 05 Oct 2010 06:06:24 +0000
From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Tue, 5 Oct 2010 08:05:42 +0200
Message-ID: <4CAAC036.4080505@st.com>
References: <4CA09D4D.6050708@st.com>	<4CA34070.9070505@st.com>
	<20100930133120.GA4070@hannu-debian.research.nokia.com>
	<4CA469A0.5090700@st.com>	<20101001040609.GA2090@hannu-ubuntu>
	<4CA9D0EB.5090309@st.com>
	<AANLkTim_Ay4yjdBfm8tzEiK_z4JzQyg6RRsR3E1tCH9h@mail.gmail.com>
In-Reply-To: <AANLkTim_Ay4yjdBfm8tzEiK_z4JzQyg6RRsR3E1tCH9h@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] ltp_clone alignment issues.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/4/2010 3:28 PM, Garrett Cooper wrote:
> On Mon, Oct 4, 2010 at 6:04 AM, Carmelo AMOROSO <carmelo.amoroso@st.com> wrote:
>  > -----BEGIN PGP SIGNED MESSAGE-----
>  > Hash: SHA1
>  >
>  > On 10/1/2010 6:06 AM, Hannu Heikkinen wrote:
>  >> On 30/09/10 12:42 +0200, Carmelo AMOROSO wrote:
>  >> On 9/30/2010 3:31 PM, Hannu Heikkinen wrote:
>  >>> On 29/09/10 15:34 +0200, ext Carmelo AMOROSO wrote:
>  >>> > -----BEGIN PGP SIGNED MESSAGE-----
>  >>> > Hash: SHA1
>  >>> >
>  >>> > On 9/27/2010 3:34 PM, Carmelo AMOROSO wrote:
>  >>> > > Folks,
>  >>> > > I want to reopen an old discussion on ltp_clone and stack alignment
>  >>> > > issue (see
>  >>> > >
>  >>
>  >>> 
> http://sourceforge.net/mailarchive/message.php?msg_name=4B421480.1040400%40petalogix.com).
>  >>> > > Indeed recently a commit has partially fixed a problem on ARM
>  >>> > > (0056e395170eb8fc3ffbb22d7bd364fe47c2013e), but I think this should be
>  >>> > > extended to all archs that have stack that grows downwards.
>  >>> > >
>  >>> > > Indeed, as Jiri replied in that old thread, the value passed to clone as
>  >>> > > child stack should be never accessed, because it is the topmost address
>  >>> > > of the memory allocated for the child process (it's the previous stack
>  >>> > > pointer).
>  >>> > >
>  >>> > > So, in archs that do not like unaligned stack, using (stack - size - 1 )
>  >>> > > will cause the process to be killed by a SIGBUS, on other archs, we are
>  >>> > > just wasting one byte of the malloc-ed stack.
>  >>> > >
>  >>> > > On my SH4 arch, the stack must be 4byte aligned (as in ARM).
>  >>> > >
>  >>> > > Please, find attached a patch against master branch
>  >>> > >
>  >>> > > Best regards,
>  >>> > > Carmelo
>  >>> >
>  >>> > Hi,
>  >>> > any feedback on this ?
>  >>> >
>  >>> > Cheers,
>  >>> > Carmelo
>  >>
>  >>> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>  >>> Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
>  >>> ---
>  >>> lib/cloner.c | 9 +++------
>  >>> 1 files changed, 3 insertions(+), 6 deletions(-)
>  >>
>  >>> diff --git a/lib/cloner.c b/lib/cloner.c
>  >>> index 6ad4a00..e53c9cf 100644
>  >>> --- a/lib/cloner.c
>  >>> +++ b/lib/cloner.c
>  >>> @@ -59,16 +59,13 @@ ltp_clone(unsigned long clone_flags, int (*fn)(void
>  >>> *arg), void *arg,
>  >>> ret = clone(fn, stack, clone_flags, arg);
>  >>> #elif defined(__ia64__)
>  >>> ret = clone2(fn, stack, stack_size, clone_flags, arg, NULL, NULL,
>  >>> NULL);
>  >>> -#elif defined(__arm__)
>  >>> +#else
>  >>> /*
>  >>> - * Stack size should be a multiple of 32 bit words
>  >>> - * & stack limit must be aligned to a 32 bit boundary
>  >>> + * For archs where stack grows downwards, stack points to the topmost
>  >>> address
>  >>> + * of the memory space set up for the child stack.
>  >>> */
>  >>> ret = clone(fn, (stack ? stack + stack_size : NULL),
>  >>> clone_flags, arg);
>  >>> -#else
>  >>> - ret = clone(fn, (stack ? stack + stack_size - 1 : NULL),
>  >>> - clone_flags, arg);
>  >>> #endif
>  >>
>  >>> return ret;
>  >>> --
>  >>> <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
>  >>
>  >>> Hi,
>  >>
>  >>> Acked-by Hannu Heikkinen <ext-hannu.m.heikkinen@nokia.com>
>  >>
>  >>> Br,
>  >>> Hannu
>  >>
>  >>> --
>  >>> Hannu Heikkinen
>  >>> http://www.nixu.com
>  >>
>  >>
>  >> Thanks, Hannu
>  >
>  >> Hi,
>  >
>  >> I was thinking your patch once again, and I think it would be wiser if
>  >> we would have something like:
>  >
>  >> --- ../tmp2/ltp-full-20100630/lib/cloner.c 2010-07-03 21:29:04.000000000
>  >> +0300
>  >> +++ lib/cloner.c 2010-09-03 14:48:20.000000000 +0300
>  >> @@ -43,6 +43,16 @@
>  >> pid_t *parent_tid, void *tls, pid_t *child_tid);
>  >> #endif
>  >
>  >> +/*
>  >> + * Most arch really want to have stack aligned to some sane boundary.
>  >> + */
>  >> +#ifdef __arm__
>  >> +#define ALIGN_STACK(stack) \
>  >> + ((void *)(((unsigned long)stack) & ~((sizeof(void *)) - 1)))
>  >> +#else
>  >> +#define ALIGN_STACK(stack) (stack)
>  >> +#endif
>  >> +
>  >> /***********************************************************************
>  >> * ltp_clone: wrapper for clone to hide the architecture dependencies.
>  >> * 1. hppa takes bottom of stack and no stacksize (stack grows up)
>  >> @@ -60,7 +70,7 @@
>  >> #elif defined(__ia64__)
>  >> ret = clone2(fn, stack, stack_size, clone_flags, arg, NULL, NULL,
>  >> NULL);
>  >> #else
>  >> - ret = clone(fn, (stack ? stack + stack_size - 1 : NULL),
>  >> + ret = clone(fn, (stack ? ALIGN_STACK(stack + stack_size - 1) : NULL),
>  >> clone_flags, arg);
>  >> #endif
>  >
>  >
>  >> The above patch iis in use in our ARM based LTP test suite. Note that -1 is
>  >> needed for not clobbering eg possibly malloced area after child stack.
>  >> Could u please change that prev patch a bit, for ensuring that child stack
>  >> is in proper size etc. Above patch is not sufficient, because ALIGN_STACK
>  >> in that is only used for arm archs.
>  >
>  >> br,
>  >> Hannu
>  >
>  >
>  > Hannu,
>  > I don't think that it is a good to force the alignment; we could need to
>  > write a test case that calls LTP_clone with an unaligned stack just to
>  > test the behavior of the clone implementation.
>  >
>  > Likely, it should be useful to add a check inside the C lib clone
>  > implementation (arch specific) to protect against unaligned stack, but
>  > this is a different matter.
>  >
>  > I would just leave the LTP_clone passing the argument to the clone as
>  > they came from the caller.
> 
> I believe this is already handled to some degree with the clone
> testcases. If not that should be added and I'll review patches which
> add this testing to LTP.

No it doesn't, otherwise those tests would have failed on SH and ARM
that do not accept unaligned stack, instead they were all failing just
because in all cases the stack argument was unaligned due to - 1.

I will think again if it's worth to add a check in clone code to
protected against unaligned stack forcing the clone to fail... not sure
what all other cpu are actually doing.

Carmelo
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkyqwDYACgkQoRq/3BrK1s8UBQCfU5i7oyJD5/qZukRXKDGLjZ1x
I+AAoNyn0mUvSL6ZhH5HsAeLQM0uX2Td
=DYlP
-----END PGP SIGNATURE-----

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
