From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Apr 2016 17:03:11 +0200
Subject: [LTP] [PATCH 3/4] tst_atomic: add atomic_add_return for x86/64,
 ppc/64 and s390/x
In-Reply-To: <165775875.873245.1460558166172.JavaMail.zimbra@redhat.com>
References: <82bcc056edc64dee3a13275a2b4bdbec958f60eb.1460552890.git.jstancek@redhat.com>
 <7862473e97588497afd83d52937c5f3fc5aac120.1460552890.git.jstancek@redhat.com>
 <20160413135957.GA11529@rei.lan>
 <165775875.873245.1460558166172.JavaMail.zimbra@redhat.com>
Message-ID: <20160413150310.GH10941@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > +#if defined(__i386__) || defined(__x86_64__)
> > > +#define HAVE_ATOMIC_ADD_RETURN 1
> > > +extern void __xadd_wrong_size(void);
> > > +static inline __attribute__((always_inline)) int atomic_add_return(int i,
> > > int *v)
> > > +{
> > > +	int __ret = i;
> > > +
> > > +	switch (sizeof(*v)) {
> > > +	case 1:
> > > +		asm volatile ("lock; xaddb %b0, %1\n"
> > > +			: "+q" (__ret), "+m" (*v) : : "memory", "cc");
> > > +		break;
> > > +	case 2:
> > > +		asm volatile ("lock; xaddw %w0, %1\n"
> > > +			: "+r" (__ret), "+m" (*v) : : "memory", "cc");
> > > +		break;
> > 
> > Do we really need byte and word version? As far as I can tell int is 4
> > bytes on x86 and x86_64 and unlike kernel where this is a macro we
> > cannot pass anything else than int.

I would say that we should remove this part as it's effectively dead
code. But if you really think that we should preserve it I'm fine with
that as well.

-- 
Cyril Hrubis
chrubis@suse.cz
