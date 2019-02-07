From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 7 Feb 2019 13:51:29 +0100
Subject: [LTP] [PATCH 2/2] readdir02: use invalid DIR stream descriptor
In-Reply-To: <CAEemH2dC2M2UgnzbKK=WRnKjrP6UKOB6AierxE=hMbRmSn=Vcw@mail.gmail.com>
References: <20181220090811.21514-1-liwang@redhat.com>
 <20181220090811.21514-2-liwang@redhat.com>
 <20190128151622.GA10646@rei.lan>
 <CAEemH2dC2M2UgnzbKK=WRnKjrP6UKOB6AierxE=hMbRmSn=Vcw@mail.gmail.com>
Message-ID: <20190207125129.GB9277@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > In this patch, I simply modify the test to use an exist FILE *
> > > stream to simulate the invalid directory stream descriptor. Then
> > > it won't hit the use-after-free issue any more.
> >
> > Actually I think that the best we can do here is to delete the testcase
> > because:
> >
> > * Casting FILE* to DIR* is IMHO invoking even worse undefined behavior
> >   than the original test that called readdir() on closed DIR*
> >
> 
> Why say this? Does this CASTING will do something more bad?

Yes.

> AFAICT that changing an variable of one data type into another, and
> the worst harmness is to loss of information in the variable so we'd
> better avoid that. But in this test we only need a invalid DIR* for
> readdir() tesst, it does *not* really care about the pointer content I
> guess?

Not at all, both FILE and DIR are typedefs to C structures, which are
just chunks of memory, by doing this you are basically passing random
data to the call because all it does when the C library gets the fd from
these strucutres is that it takes bytes from at some offest in the chunk
of memory. There are no abstract types, methods or objects in C, just
chunks of memory.

> >
> > * We do cover the EBADF for getents() syscalls getents02 test
> >
> 
> I'm sorry, I don't find this testcase in LTP, or did I miss anything?

Sorry typo, it's getdents02.

-- 
Cyril Hrubis
chrubis@suse.cz
