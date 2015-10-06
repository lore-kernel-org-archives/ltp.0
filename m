From: Yuriy Kolerov <Yuriy.Kolerov@synopsys.com>
Date: Tue, 6 Oct 2015 13:38:42 +0000
Subject: [LTP] [PATCH] syscalls/setregid02: Fix retrieving a group of
 user "nobody"
In-Reply-To: <20151005154723.GB21607@rei>
References: <1443010817-10169-1-git-send-email-yuriy.kolerov@synopsys.com>
 <20151005154723.GB21607@rei>
Message-ID: <3ABF60118B9B784CA5BF7C841D2F00ECFA2870@de02wembxa.internal.synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril.

Yes, it would be wise. I'll do it in the second version of patch.

Regards,
Yuriy Kolerov


> -----Original Message-----
> From: Cyril Hrubis [mailto:chrubis@suse.cz]
> Sent: Monday, October 05, 2015 6:47 PM
> To: Yuriy Kolerov
> Cc: ltp@lists.linux.it; Vineet.Gupta1@synopsys.com;
> Alexey.Brodkin@synopsys.com; Anton.Kolesov@synopsys.com;
> Francois.Bedard@synopsys.com
> Subject: Re: [LTP] [PATCH] syscalls/setregid02: Fix retrieving a group of user
> "nobody"
> 
> Hi!
> > -#define GET_GID(group)	do {		\
> > +#define GET_GROUP_BY_NAME(group)	do {		\
> >  	junk = getgrnam(#group);	\
> >  	if (junk == NULL) {		\
> >  		tst_brkm(TBROK|TERRNO, NULL, "getgrnam(\"%s\") failed",
> #group); \
> > @@ -156,9 +156,18 @@ static void setup(void)
> >  	group = *(junk); \
> >  } while (0)
> >
> > -	GET_GID(root);
> > -	GET_GID(nobody);
> > -	GET_GID(bin);
> > +#define GET_GROUP_BY_GID(group, gid)	do {		\
> > +	junk = getgrgid(gid);	\
> > +	if (junk == NULL) {		\
> > +		tst_brkm(TBROK|TERRNO, NULL, "getgrgid(\"%d\") failed",
> gid); \
> > +	}				\
> > +	GID16_CHECK(junk->gr_gid, setregid, NULL); \
> > +	group = *(junk); \
> > +} while (0)
> 
> 
> Can we please get rid of the ugly macros and write them as functions
> instead?
> 
> Othewise it looks good to me.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
