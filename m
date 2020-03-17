From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 17 Mar 2020 09:15:47 +0100
Subject: [LTP] [RFC] Define minimal supported kernel and (g)libc version
In-Reply-To: <CAEemH2cNc7pCc-wB=4hGVquJT1Y5NCeZ_z8nH6D9V+J_5o_TWw@mail.gmail.com>
References: <20200313141458.GB21248@dell5510>
 <CAEemH2cNc7pCc-wB=4hGVquJT1Y5NCeZ_z8nH6D9V+J_5o_TWw@mail.gmail.com>
Message-ID: <20200317081547.GA15989@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> This is a good topic, thanks for kicking off this initiative!
Thanks for your input.

> > I'm sorry, I've raised this question in the past, but it got lost.
> > I remember we talked about 2.6 something.

> Yes, the past discussion is still valuable to us. see:
> http://lists.linux.it/pipermail/ltp/2019-May/011990.html
Great, thanks!

> > It'd be good to state publicly the oldest kernel and glibc (or even other
> > libc
> > versions) we support.  This would allow us to remove some legacy code or
> > force
> > support for legacy code.


> Maybe we could also state the oldest GCC version too? Though I haven't seen
> any conflict or supporting issue from my side, it helps avoid some
> potential error in cross-compilation I guess.
+1
Not sure if we want to specify also clang.

>     i.e.  kernel-3.10.0 / glibc-2.17 / gcc-4.8.0
This is for RHEL7 I guess.

The oldest system in travis we have CentOS 6: kernel-2.6.32 / glibc-2.12 /
gcc-4.4.7 (clang-3.4.2, but we don't test it with clang). I'm ok to have this
older dependency, just to make sure it builds.  But code would be cleaner for
sure if we drop it.

BTW I also occasionally test build on SLES 11-SP3 (kernel 3.0 / glibc-2.11.3 /
gcc-4.3.4 - older glibc and gcc), but this is not even in travis.
But for testing these distros we use older releases (the same mentioned Jan [1]).
I wonder if there is really somebody using 2.6.x or 3.x < 3.10 on master.
If not, we can drop some lapi files which mention 2.6.

Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2019-May/011991.html
