From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 5 Apr 2017 19:29:06 +0200
Subject: [LTP] [RFC] [PATCH] lib: Fix undefined reference to `mq_open'
 build failures
In-Reply-To: <20170405113417.49876712@linux-v3j5>
References: <20170329165008.6396-1-chrubis@suse.cz>
 <20170405113417.49876712@linux-v3j5>
Message-ID: <20170405172906.GA16120@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +mqd_t __attribute__((weak)) mq_open(const char *name __attribute__((unused)),
> > +				    int oflag __attribute__((unused)), ...)
> > +{
> > +	tst_brk(TBROK, "mq_open() stub called!");
> 
> Maybe expand this to "mq_open() stub called! Add -lrt to linker flags".

Good idea, I will add a hint that -lr is probably missing in LDFLAGS to
the message.

> If we start stubbing a lot of functions then we could have a TST_STUB macro
> which takes the function name, arguments and linker switch (e.g. -lrt) and
> produces a stub.

That could end up quite complicated fast. For instance adding
__attribute__((unused)) to each of the parametes would either need
different version of the macro for each number of arguments or load of
macro trickery...

Let's keep it simple for now.

> > +	return 0;
> > +}
> > +
> >  int safe_mq_open(const char *file, const int lineno, const char *pathname,
> >  	int oflags, ...)
> >  {
> 
> I ran into this problem and the stub fixed it. I wonder why a test which never
> calls SAFE_MQ_OPEN triggers it and others do not and why it does not happen
> consistently. Perhaps the linker tries to do some relocation at a stage when
> the library is not available and whether it tries to do the relocation is
> effected by whatever libraries are available in the environment. I can't think
> why else it would only try to resolve it some of the time?

I do not understand why the problem manifests only rarely either, but I
fear that understanding it would require a few days of research...

-- 
Cyril Hrubis
chrubis@suse.cz
