From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 10 Oct 2019 11:30:11 +0200
Subject: [LTP] [RFC PATCH] LTP Wrapper for Syzkaller reproducers
In-Reply-To: <CACT4Y+ZABX2z4Lxrvokf5DHz351xTys-gJPNhFjP+Zx6Qd2zsg@mail.gmail.com>
References: <20191009142446.6997-1-rpalethorpe@suse.com>
 <CACT4Y+b0tTAQ0r_2gCVjjRh--Xwv=aLzh6MY=ciXMMrK+cAQsA@mail.gmail.com>
 <20191009145416.GA5014@rei.lan>
 <CACT4Y+ZL8ocQPpwR-_8+0PdF=r3AkFZKvOR==+P0y0GF67w1Vg@mail.gmail.com>
 <20191009180447.GD15291@rei.lan>
 <CACT4Y+ZABX2z4Lxrvokf5DHz351xTys-gJPNhFjP+Zx6Qd2zsg@mail.gmail.com>
Message-ID: <20191010093011.GA2508@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > > Indeed, it's removed recursively by the test library.
> > >
> > > :popcorn:
> > >
> > > It took me several years to figure out how to more or less reliably
> > > remove dirs after the fuzzer ;)
> > > (no, unlink won't do ;))
> >
> > I guess that there are things such as immutable file attributes that has
> > to be cleared and many more. Do you have piece of code somewhere that we
> > can look into to spare us from reinventing the wheel?
> 
> Here is what we have:
> https://github.com/google/syzkaller/blob/c4b9981b5f5b70dc03eb3f76c618398510101a1d/executor/common_linux.h#L2358-L2461
> Maybe it can be simplified, but that's what we ended up with after
> some organic evolution. At least the comments may give some hints as
> to what may go wrong.

Thanks a lot!

Also I see that you are using namespaces, and much more, to sandbox the
fuzzer, I was wondering if we should do that, at least separate user and
pid namespace sounds like a good idea to me.

-- 
Cyril Hrubis
chrubis@suse.cz
