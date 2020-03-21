From: Petr Vorel <pvorel@suse.cz>
Date: Sat, 21 Mar 2020 07:46:41 +0100
Subject: [LTP] [RFC] Define minimal supported kernel and (g)libc version
In-Reply-To: <2016207059.2611128.1584622138390.JavaMail.zimbra@redhat.com>
References: <20200313141458.GB21248@dell5510>
 <CAEemH2cNc7pCc-wB=4hGVquJT1Y5NCeZ_z8nH6D9V+J_5o_TWw@mail.gmail.com>
 <20200317081547.GA15989@dell5510>
 <2016207059.2611128.1584622138390.JavaMail.zimbra@redhat.com>
Message-ID: <20200321064641.GA3196159@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Correct, it's still active (though in less extent than RHEL8). But
> I still see value of running/supporting LTP here.

> As I said in previous thread, if we want to draw a line somewhere,
> e.g. say anything older 10 years is too old, RHEL6/Centos6 would
> fall in that. For regression tests it should be OK to use older
> stable release.

OK. We can remove CentOS 6 (or probably replace with CentOS 7) now or after next
release. I don't have a strong opinion about it.
After it's removal all that 2.6.x fixes in m4/ should be deleted.

I'd be for putting supported versions in README.md.

> > The oldest system in travis we have CentOS 6: kernel-2.6.32 / glibc-2.12 /
> > gcc-4.4.7 (clang-3.4.2, but we don't test it with clang). I'm ok to have this
> > older dependency, just to make sure it builds.  But code would be cleaner for
> > sure if we drop it.

> > BTW I also occasionally test build on SLES 11-SP3 (kernel 3.0 / glibc-2.11.3
> > /
> > gcc-4.3.4 - older glibc and gcc), but this is not even in travis.
> > But for testing these distros we use older releases (the same mentioned Jan
> > [1]).
> > I wonder if there is really somebody using 2.6.x or 3.x < 3.10 on master.
> > If not, we can drop some lapi files which mention 2.6.

> There are some, since LTP didn't reject such patches yet. But updates to
> those old kernels are few and far between, so it might be not be worth
> the trouble from LTP point of view.

No strong opinion. I wouldn't be against asking these people directly
(which would lead to postpone deleting legacy support after next release).

Kind regards,
Petr
