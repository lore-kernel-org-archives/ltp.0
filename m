From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 13 Apr 2016 10:36:06 -0400 (EDT)
Subject: [LTP] [PATCH 3/4] tst_atomic: add atomic_add_return for x86/64,
 ppc/64 and s390/x
In-Reply-To: <20160413135957.GA11529@rei.lan>
References: <82bcc056edc64dee3a13275a2b4bdbec958f60eb.1460552890.git.jstancek@redhat.com>
 <7862473e97588497afd83d52937c5f3fc5aac120.1460552890.git.jstancek@redhat.com>
 <20160413135957.GA11529@rei.lan>
Message-ID: <165775875.873245.1460558166172.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Wednesday, 13 April, 2016 3:59:58 PM
> Subject: Re: [LTP] [PATCH 3/4] tst_atomic: add atomic_add_return for x86/64, ppc/64 and s390/x
> 
> Hi!
> > +#if defined(__i386__) || defined(__x86_64__)
> > +#define HAVE_ATOMIC_ADD_RETURN 1
> > +extern void __xadd_wrong_size(void);
> > +static inline __attribute__((always_inline)) int atomic_add_return(int i,
> > int *v)
> > +{
> > +	int __ret = i;
> > +
> > +	switch (sizeof(*v)) {
> > +	case 1:
> > +		asm volatile ("lock; xaddb %b0, %1\n"
> > +			: "+q" (__ret), "+m" (*v) : : "memory", "cc");
> > +		break;
> > +	case 2:
> > +		asm volatile ("lock; xaddw %w0, %1\n"
> > +			: "+r" (__ret), "+m" (*v) : : "memory", "cc");
> > +		break;
> 
> Do we really need byte and word version? As far as I can tell int is 4
> bytes on x86 and x86_64 and unlike kernel where this is a macro we
> cannot pass anything else than int.

Not really, it's again case where I tried to preserve original kernel code.

> 
> > +	case 4:
> > +		asm volatile ("lock; xaddl %0, %1\n"
> > +			: "+r" (__ret), "+m" (*v) : : "memory", "cc");
> > +		break;
> > +	case 8:
> > +		asm volatile ("lock; xaddq %q0, %1\n"
> > +			: "+r" (__ret), "+m" (*v) : : "memory", "cc");
> > +		break;
> 
> The same goes for the quad version here.
> 
> > +	default:
> > +		__xadd_wrong_size();
> 
> So this supposedly causes linker error by trying to link nonexistent
> function, right?
> 
> I guess that we should either add nonexistent to the function name or
> short commment with explanation.

I can add both.

> 
> Also it should start with tst_ in order to avoid teoretical collisions
> with system functions.
> 
> > +	}
> > +	return i + __ret;
> > +}
> > +#endif
> > +
> > +#if defined(__powerpc__) || defined(__powerpc64__)
> > +#define HAVE_ATOMIC_ADD_RETURN 1
> > +static inline __attribute__((always_inline)) int atomic_add_return(int i,
> > int *v)
> > +{
> > +	int t;
> > +
> > +	asm volatile(
> > +		"	sync\n"
> > +		"1:	lwarx	%0,0,%2		# atomic_add_return\n"
> > +		"	add %0,%1,%0\n"
> > +		"	stwcx.	%0,0,%2 \n"
> > +		"	bne-	1b\n"
> > +		"	sync\n"
> > +		: "=&r" (t)
> > +		: "r" (i), "r" (v)
> > +		: "cc", "memory");
> > +	return t;
> > +}
> > +#endif
> > +
> > +#if defined(__s390__) || defined(__s390x__)
> > +#define HAVE_ATOMIC_ADD_RETURN 1
> > +static inline __attribute__((always_inline)) int atomic_add_return(int i,
> > int *v)
> > +{
> > +	int old_val, new_val;
> > +
> > +	asm volatile(
> > +		"	l	%0,%2\n"
> > +		"0:	lr	%1,%0\n"
> > +		"	ar	%1,%3\n"
> > +		"	cs	%0,%1,%2\n"
> > +		"	jl	0b"
> > +		: "=&d" (old_val), "=&d" (new_val), "+Q" (*v)
> > +		: "d" (i)
> > +		: "cc", "memory");
> > +	return old_val + i;
> > +}
> > +#endif
> > +#endif /* HAVE_SYNC_ADD_AND_FETCH == 1 */
> > +
> > +#if !defined(HAVE_ATOMIC_ADD_RETURN)
> >  #error Your compiler does not provide __sync_add_and_fetch and LTP\
> >   implementation is missing for your architecture.
> >  #endif
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
