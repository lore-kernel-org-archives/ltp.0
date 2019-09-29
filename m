From: Pengfei Xu <pengfei.xu@intel.com>
Date: Sun, 29 Sep 2019 17:00:56 +0800
Subject: [LTP] [PATCH] umip_basic_test.c: update umip basic test for new
 kernel v5.4
In-Reply-To: <CAEemH2dG-7vsULkUuJSDu8-e-z7abRpBJ88ARPuEqOwM4bt=tA@mail.gmail.com>
References: <20190927034635.28521-1-pengfei.xu@intel.com>
 <CAEemH2dGOcpSmD=BkvQZW=JTtbpkoUSN+tqffkDu+jV=vJsUqA@mail.gmail.com>
 <20190929063455.ympb34kmlmrgxbl2@xpf-desktop>
 <CAEemH2dG-7vsULkUuJSDu8-e-z7abRpBJ88ARPuEqOwM4bt=tA@mail.gmail.com>
Message-ID: <20190929090056.u34megeq5yen7j4i@xpf-desktop>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li Wang,


On 2019-09-29 at 15:13:35 +0800, Li Wang wrote:
> Hi Pengfei,
> 
> Pengfei Xu <pengfei.xu@intel.com> wrote:
> 
> ...
> > >
> > > My concern is that if an LTS distro backports the patch(commit
> > e86c2c8b93),
> > > then it will break this hardcode kernel-version comparing.
> > >
> > >
> >   Ok, let's wait to confirm umip patch merged into Linux kernel main line,
> >   and then merge the patch into LTP. :)
> >
> 
> Sorry, I'm not talking merge time. I mean we have to consider more kernel
> distros(RHEL, SLES, Ubuntu) when writing/amending LTP test.
> 
> Imagine that, if RHEL8(kernel base on v4.18) backports the kernel
> patch(x86/umip: Add emulation (spoofing) for UMIP covered instructions in
> 64-bit processes) and what will happen after applying your patch in
> this umip_basic_test.c test? It will fail since that kernel version is less
> than 5.4. We probably need to find a way to solve this issue.
> 
 Ok, got it, we need consider one better way for it. :)
 Thanks for advice!

> >
> > > > +               #endif
> > > > +       }
> > > > +
> > > >         if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
> > > > -               tst_res(TPASS, "Got SIGSEGV");
> > > > +               tst_res(TPASS, "Got SIGSEGV\n\n");
> > > >
> > >
> > > Why we need two '\n' here?
> > >
> >   Because it could help to split umip cases in LTP, there are 5 umip cases
> >   in LTP tests, and we could check each umip case easily in LTP log,
> >
> 
> It is unnecessary because each test shows TINFO before testing.
>   e.g  "umip_basic_test.c:41: INFO: TEST sgdt, sgdt result save at
> [0x7fff930bda8e]"
> 
 Ok thanks! :)

> -- 
> Regards,
> Li Wang
