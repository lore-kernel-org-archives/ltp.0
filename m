From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 27 Jan 2017 07:21:34 -0500 (EST)
Subject: [LTP] [PATCH] arm64: add tst_atomic_add_return
In-Reply-To: <1134437611.1525799.1485511323099.JavaMail.zimbra@redhat.com>
References: <1485378822-6059-1-git-send-email-ynorov@caviumnetworks.com>
 <1134437611.1525799.1485511323099.JavaMail.zimbra@redhat.com>
Message-ID: <374642680.1552390.1485519694431.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: "Yury Norov" <ynorov@caviumnetworks.com>
> Cc: ltp@lists.linux.it
> Sent: Friday, 27 January, 2017 11:02:03 AM
> Subject: Re: [LTP] [PATCH] arm64: add tst_atomic_add_return
> 
> 
> 
> 
> 
> ----- Original Message -----
> > From: "Yury Norov" <ynorov@caviumnetworks.com>
> > To: ltp@lists.linux.it
> > Sent: Wednesday, 25 January, 2017 10:13:42 PM
> > Subject: [LTP] [PATCH] arm64: add tst_atomic_add_return
> > 
> > The patch fixes build of LTP, at least with gcc 5.3.
> > The implementation is taken from kernel v4.9.
> > 
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > ---
> >  include/tst_atomic.h | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> 
> Hi,
> 
> looks good to me, I'm getting a system to test this as well.

Forced my config to use new tst_atomic_return and ran few tests.
There were no issues.

@Cyril: would you like to try this too on some SuSe distros
or can I go ahead and push it?

Regards,
Jan

> 
> Regards,
> Jan
> 
> > 
> > diff --git a/include/tst_atomic.h b/include/tst_atomic.h
> > index 799d735..35a3b34 100644
> > --- a/include/tst_atomic.h
> > +++ b/include/tst_atomic.h
> > @@ -131,6 +131,27 @@ static inline int tst_atomic_add_return(int i, int *v)
> >  
> >  	return val;
> >  }
> > +
> > +#elif defined (__aarch64__)
> > +static inline int tst_atomic_add_return(int i, int *v)
> > +{
> > +	unsigned long tmp;
> > +	int result;
> > +
> > +	__asm__ __volatile__(
> > +"       prfm    pstl1strm, %2	\n"
> > +"1:     ldxr 	%w0, %2		\n"
> > +"       add	%w0, %w0, %w3	\n"
> > +"       stlxr	%w1, %w0, %2	\n"
> > +"       cbnz	%w1, 1b		\n"
> > +"       dmb ish			\n"
> > +	: "=&r" (result), "=&r" (tmp), "+Q" (*v)
> > +	: "Ir" (i)
> > +	: "memory");
> > +
> > +	return result;
> > +}
> > +
> >  #else /* HAVE_SYNC_ADD_AND_FETCH == 1 */
> >  # error Your compiler does not provide __sync_add_and_fetch and LTP\
> >  	implementation is missing for your architecture.
> > --
> > 2.7.4
> > 
> > 
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> > 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
