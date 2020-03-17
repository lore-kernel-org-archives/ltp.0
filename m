From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 17 Mar 2020 10:04:12 +0100
Subject: [LTP] [RFC] Define minimal supported kernel and (g)libc version
In-Reply-To: <CAEemH2dCckuUw=x-yKpBe4FpjTdovytSqpOoRSTFiR96_ECeDA@mail.gmail.com>
References: <20200313141458.GB21248@dell5510>
 <CAEemH2cNc7pCc-wB=4hGVquJT1Y5NCeZ_z8nH6D9V+J_5o_TWw@mail.gmail.com>
 <20200317081547.GA15989@dell5510>
 <CAEemH2dCckuUw=x-yKpBe4FpjTdovytSqpOoRSTFiR96_ECeDA@mail.gmail.com>
Message-ID: <20200317090412.GA31467@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> > The oldest system in travis we have CentOS 6: kernel-2.6.32 / glibc-2.12 /
> > gcc-4.4.7 (clang-3.4.2, but we don't test it with clang). I'm ok to have
> > this
> > older dependency, just to make sure it builds.  But code would be cleaner
> > for
> > sure if we drop it.

> +1
> Sounds good to me.
I'm sorry, are you for removing CentOS 6 from Travis or not?


> > BTW I also occasionally test build on SLES 11-SP3 (kernel 3.0 /
> > glibc-2.11.3 /
> > gcc-4.3.4 - older glibc and gcc), but this is not even in travis.
> > But for testing these distros we use older releases (the same mentioned
> > Jan [1]).


> Agreed, we can explicitly declare that(in some place of Doc) from a
> specific LTP(e.g ltp-full-20200120) version, we don't provide code
> supporting for the older kernel/glibc/gcc package anymore. If people who
> are going to test old distros, they can just pick up an old released LTP
> version and hack it by themself. The latest branch of LTP doesn't accept
> that patch for old things.
+1

Kind regards,
Petr
