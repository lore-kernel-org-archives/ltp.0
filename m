From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 2 Mar 2020 09:46:51 +0100
Subject: [LTP] [PATCH] syscalls/openat2: New tests
In-Reply-To: <20200302063714.claovt5uyi7gxf2o@vireshk-i7>
References: <b927e5f2cd36ec2dd57202b492563922b1a94e77.1582886993.git.viresh.kumar@linaro.org>
 <20200228132210.GC8324@rei>
 <20200302063714.claovt5uyi7gxf2o@vireshk-i7>
Message-ID: <20200302084651.GA4736@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > +static void run(unsigned int n)
> > > +{
> > > +	int fd;
> > > +	struct stat file_stat;
> > > +	struct tcase *tc = &tcases[n];
> > > +	struct open_how how = {
> > > +		.flags = tc->flags | O_CREAT,
> > > +		.mode = tc->mode,
> > > +		.resolve = tc->resolve
> > > +	};
> > 
> > This structure should be allocated tst_buffers, see capget01.c for
> > example.
> 
> This changed few things.
> 
> I am getting a build warning now (same happen if I build bpf stuff as
> well). I don't understand why this warning comes though.
> 
> openat202.c:69:1: warning: missing initializer for field 'caps' of 'struct tst_test' [-Wmissing-field-initializers]
>  };
>  ^
> In file included from openat202.c:7:0:
> ../../../../include/tst_test.h:236:18: note: 'caps' declared here
>   struct tst_cap *caps;

The compiler is confused by different styles of initialization
apparently.

> Also for the failure test where larger size was passed, the error
> reported now is EFAULT as kernel can't access out of bound dynamically
> allocated memory (instead of stack one earlier). In order to get
> E2BIG, I need to add some hacks (allocate more memory and write
> non-zero value to excess memory) and I don't think that would be worth
> it, so my test will expect EFAULT now.

Hmm, I guess that it makes sense to add the pointer to how to the tcase
structure and allocate exact size for the E2BIG case. That should work
fine, right?

> > > +	TEST(fd = openat2(*tc->dfd, tc->pathname, &how, sizeof(how)));
> > > +	if (fd == -1) {
> > > +		tst_res(TFAIL | TTERRNO, "openat2() failed (%d)", n);
> > > +		return;
> > > +	}
> > > +
> > > +	SAFE_FSTAT(fd, &file_stat);
> > > +
> > > +	if (file_stat.st_size == 0)
> > > +		tst_res(TPASS, "openat2() passed (%d)", n);
> > > +	else
> > > +		tst_res(TFAIL, "fstat() didn't work as expected (%d)", n);
> > 
> > So this is very basic test that just checks that openat() can open a
> > file and we would need a few more for each of the newly introduced
> > RESOLVE_* flags.
> 
> Hmm, this file is already testing openat2() with all different type of
> resolve flags. What kind of further tests are you suggesting here ?

Well do not test that the flags actually works, right?

So for example for RESOLVE_BENATH we need to pass paths with ".." or
symlinks pointing upwards in the filesystem and expect openat2() to
fail. And the same for the rest of the flags.

-- 
Cyril Hrubis
chrubis@suse.cz
