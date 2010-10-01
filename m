Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hannuxx@gmail.com>) id 1P1Wt5-0006OV-T1
	for ltp-list@lists.sourceforge.net; Fri, 01 Oct 2010 04:06:23 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P1Wt4-0000Ur-FK
	for ltp-list@lists.sourceforge.net; Fri, 01 Oct 2010 04:06:23 +0000
Received: by bwz2 with SMTP id 2so2745121bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 30 Sep 2010 21:06:15 -0700 (PDT)
Date: Fri, 1 Oct 2010 07:06:09 +0300
From: Hannu Heikkinen <hannuxx@iki.fi>
Message-ID: <20101001040609.GA2090@hannu-ubuntu>
References: <4CA09D4D.6050708@st.com> <4CA34070.9070505@st.com>
	<20100930133120.GA4070@hannu-debian.research.nokia.com>
	<4CA469A0.5090700@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4CA469A0.5090700@st.com>
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
To: Carmelo AMOROSO <carmelo.amoroso@st.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On 30/09/10 12:42 +0200, Carmelo AMOROSO wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 9/30/2010 3:31 PM, Hannu Heikkinen wrote:
> > On 29/09/10 15:34 +0200, ext Carmelo AMOROSO wrote:
> >  > -----BEGIN PGP SIGNED MESSAGE-----
> >  > Hash: SHA1
> >  >
> >  > On 9/27/2010 3:34 PM, Carmelo AMOROSO wrote:
> >  > > Folks,
> >  > > I want to reopen an old discussion on ltp_clone and stack alignment
> >  > > issue (see
> >  > > 
> > http://sourceforge.net/mailarchive/message.php?msg_name=4B421480.1040400%40petalogix.com).
> >  > > Indeed recently a commit has partially fixed a problem on ARM
> >  > > (0056e395170eb8fc3ffbb22d7bd364fe47c2013e), but I think this should be
> >  > > extended to all archs that have stack that grows downwards.
> >  > >
> >  > > Indeed, as Jiri replied in that old thread, the value passed to clone as
> >  > > child stack should be never accessed, because it is the topmost address
> >  > > of the memory allocated for the child process (it's the previous stack
> >  > > pointer).
> >  > >
> >  > > So, in archs that do not like unaligned stack, using (stack - size - 1 )
> >  > > will cause the process to be killed by a SIGBUS, on other archs, we are
> >  > > just wasting one byte of the malloc-ed stack.
> >  > >
> >  > > On my SH4 arch, the stack must be 4byte aligned (as in ARM).
> >  > >
> >  > > Please, find attached a patch against master branch
> >  > >
> >  > > Best regards,
> >  > > Carmelo
> >  >
> >  > Hi,
> >  > any feedback on this ?
> >  >
> >  > Cheers,
> >  > Carmelo
> > 
> >  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> > Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
> > ---
> > lib/cloner.c | 9 +++------
> > 1 files changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/lib/cloner.c b/lib/cloner.c
> > index 6ad4a00..e53c9cf 100644
> > --- a/lib/cloner.c
> > +++ b/lib/cloner.c
> > @@ -59,16 +59,13 @@ ltp_clone(unsigned long clone_flags, int (*fn)(void
> > *arg), void *arg,
> > ret = clone(fn, stack, clone_flags, arg);
> > #elif defined(__ia64__)
> > ret = clone2(fn, stack, stack_size, clone_flags, arg, NULL, NULL,
> > NULL);
> > -#elif defined(__arm__)
> > +#else
> > /*
> > - * Stack size should be a multiple of 32 bit words
> > - * & stack limit must be aligned to a 32 bit boundary
> > + * For archs where stack grows downwards, stack points to the topmost
> > address
> > + * of the memory space set up for the child stack.
> > */
> > ret = clone(fn, (stack ? stack + stack_size : NULL),
> > clone_flags, arg);
> > -#else
> > - ret = clone(fn, (stack ? stack + stack_size - 1 : NULL),
> > - clone_flags, arg);
> > #endif
> > 
> > return ret;
> > --
> > <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> > 
> > Hi,
> > 
> > Acked-by Hannu Heikkinen <ext-hannu.m.heikkinen@nokia.com>
> > 
> > Br,
> > Hannu
> > 
> > --
> > Hannu Heikkinen
> > http://www.nixu.com
> > 
> 
> Thanks, Hannu
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (MingW32)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
> 
> iEYEARECAAYFAkykaaAACgkQoRq/3BrK1s9XQQCgqFuIf0UtZVE2cIY07ZY+6PrN
> pmwAnRP5T4nCrFDwre+9VEwJ7WB6r0em
> =w2Z8
> -----END PGP SIGNATURE-----

Hi,

I was thinking your patch once again, and I think it would be wiser if 
we would have something like:

--- ../tmp2/ltp-full-20100630/lib/cloner.c      2010-07-03 21:29:04.000000000
+0300
+++ lib/cloner.c        2010-09-03 14:48:20.000000000 +0300
@@ -43,6 +43,16 @@
                pid_t *parent_tid, void *tls, pid_t *child_tid);
 #endif
 
+/*
+ * Most arch really want to have stack aligned to some sane boundary.
+ */
+#ifdef __arm__
+#define ALIGN_STACK(stack) \
+       ((void *)(((unsigned long)stack) & ~((sizeof(void *)) - 1)))
+#else
+#define ALIGN_STACK(stack)     (stack)
+#endif
+
 /***********************************************************************
  * ltp_clone: wrapper for clone to hide the architecture dependencies.
  *   1. hppa takes bottom of stack and no stacksize (stack grows up)
@@ -60,7 +70,7 @@
 #elif defined(__ia64__)
        ret = clone2(fn, stack, stack_size, clone_flags, arg, NULL, NULL,
NULL);
 #else
-       ret = clone(fn, (stack ? stack + stack_size - 1 : NULL),
+       ret = clone(fn, (stack ? ALIGN_STACK(stack + stack_size - 1) : NULL),
                        clone_flags, arg);
 #endif


The above patch iis in use in our ARM based LTP test suite. Note that -1 is
needed for not clobbering eg possibly malloced area after child stack.
Could u please change that prev patch a bit, for ensuring that child stack
is in proper size etc. Above patch is not sufficient, because ALIGN_STACK
in that is only used for arm archs.

br,
Hannu

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
