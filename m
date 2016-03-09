From: Yuriy Kolerov <Yuriy.Kolerov@synopsys.com>
Date: Wed, 9 Mar 2016 09:29:19 +0000
Subject: [LTP] [PATCH] syscalls/profil01: disable this test for uClibc
In-Reply-To: <20160307095424.GA3559@rei.suse.cz>
References: <1457109655-6170-1-git-send-email-yuriy.kolerov@synopsys.com>
 <20160307095424.GA3559@rei.suse.cz>
Message-ID: <3ABF60118B9B784CA5BF7C841D2F00ECFB6ABC@DE02WEMBXB.internal.synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Thanks! I've not noticed it earlier. I will make a proper fix. Indeed there are more tests which are excluded for uClibc and uClinux by that ugly way so they must be fixed properly in future too.

Regards,
Yuriy Kolerov

> -----Original Message-----
> From: Cyril Hrubis [mailto:chrubis@suse.cz]
> Sent: Monday, March 07, 2016 12:54 PM
> To: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
> Cc: ltp@lists.linux.it; Vineet.Gupta1@synopsys.com;
> Alexey.Brodkin@synopsys.com; Anton.Kolesov@synopsys.com
> Subject: Re: [LTP] [PATCH] syscalls/profil01: disable this test for uClibc
> 
> Hi!
> > diff --git a/testcases/kernel/syscalls/profil/profil01.c
> > b/testcases/kernel/syscalls/profil/profil01.c
> > index 2fc47aa..c44daa7 100644
> > --- a/testcases/kernel/syscalls/profil/profil01.c
> > +++ b/testcases/kernel/syscalls/profil/profil01.c
> > @@ -39,6 +39,8 @@
> >  char *TCID = "profil01";
> >  int TST_TOTAL = 1;
> >
> > +#if !defined(__UCLIBC__)
> > +
> >  static volatile sig_atomic_t profil_done;
> >
> >  static void alrm_handler(int sig)
> > @@ -124,3 +126,11 @@ int main(int ac, char *av[])
> >
> >  	tst_exit();
> >  }
> > +
> > +#else
> > +int main(void)
> > +{
> > +	tst_brkm(TCONF, NULL, "system doesn't have profiling support"); }
> > +#endif
> 
> Adding #ifdefs for each platform/libc implementation like this does not really
> scale.
> 
> What about handling it the same way we handle UCLINUX in the Makefiles?
> 
> Have a look at:
> 
> ltp/testcases/kernel/syscalls/Makefile
> ltp/testcases/kernel/syscalls/writev/Makefile
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
