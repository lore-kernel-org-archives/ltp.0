From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 May 2020 09:54:04 +0200
Subject: [LTP] [PATCH 2/4] INSTALL: Document 32bit and cross-compilation
 setup
In-Reply-To: <CAEemH2etn2mSJbV=a=xpVMnUOjKdKrp0C5Cch2JYtbZ2pDkRyw@mail.gmail.com>
References: <20200514184904.4537-1-pvorel@suse.cz>
 <20200514184904.4537-3-pvorel@suse.cz>
 <20200514193441.GA11518@dell5510>
 <CAEemH2etn2mSJbV=a=xpVMnUOjKdKrp0C5Cch2JYtbZ2pDkRyw@mail.gmail.com>
Message-ID: <20200515075404.GA1751673@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> On Fri, May 15, 2020 at 3:34 AM Petr Vorel <pvorel@suse.cz> wrote:

> > ...

> > > +32 bit build on 64 bit machine
> > > +------------------------------
> > > +You need to set CFLAGS=-m32 LDFLAGS=-m32 and PKG_CONFIG_LIBDIR
> > > +
> > > +* RPM based distributions (openSUSE, Fedora, etc.)
> > > +PKG_CONFIG_LIBDIR=/usr/lib/pkgconfig CFLAGS=-m32 LDFLAGS=-m32
> > ./configure
> > > +
> > > +* Debian / Ubuntu and derivates
> > > +PKG_CONFIG_LIBDIR=/usr/lib/i386-linux-gnu/pkgconfig CFLAGS=-m32
> > LDFLAGS=-m32 ./configure


> I occationally build 32bit LTP on my RHEL8(x86_64) platform
> via: CFLAGS="-m32" CXXFLAGS="-m32" LDFLAGS="-m32" ./configure, it works for
> me awalys.

> May I ask why we need the PKG_CONFIG_LIBDIR?
To correctly correctly detect 32 bit version of libtirpc-devel and libmnl-devel

If you have libtirpc-devel (64bit version) and don't have 32bit version,
without it it detect 64bit version and fail in link phase
https://linux.die.net/man/1/pkg-config
https://autotools.io/pkgconfig/cross-compiling.html

BTW there other fix for TI-RPC tests (detection of old glibc support)
https://patchwork.ozlabs.org/project/ltp/patch/20200515070022.16407-1-pvorel@suse.cz/


> > I guess, we should set this variable in 32 bit build in travis CI (we have
> > only 1
> > job, which uses Debian). It's not failing now, because it's not a minimal
> > build.
> > Therefore we should have minimal 32 bit build (easiest way is to use
> > openSUSE or
> > Fedora/CentOS as they don't install libtirpc 32bit).


> Good suggestion! I think at least for CentOS/RHEL has no problem with this.
After release I'd propose to add Arch Linux and move CentOS 6 to CentOS 7.
One of them could be 32 bit build.

Kind regards,
Petr
