From: Li Wang <liwang@redhat.com>
Date: Fri, 15 May 2020 15:45:21 +0800
Subject: [LTP] [PATCH 2/4] INSTALL: Document 32bit and cross-compilation
 setup
In-Reply-To: <20200514193441.GA11518@dell5510>
References: <20200514184904.4537-1-pvorel@suse.cz>
 <20200514184904.4537-3-pvorel@suse.cz>
 <20200514193441.GA11518@dell5510>
Message-ID: <CAEemH2etn2mSJbV=a=xpVMnUOjKdKrp0C5Cch2JYtbZ2pDkRyw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Fri, May 15, 2020 at 3:34 AM Petr Vorel <pvorel@suse.cz> wrote:

> ...
>
> > +32 bit build on 64 bit machine
> > +------------------------------
> > +You need to set CFLAGS=-m32 LDFLAGS=-m32 and PKG_CONFIG_LIBDIR
> > +
> > +* RPM based distributions (openSUSE, Fedora, etc.)
> > +PKG_CONFIG_LIBDIR=/usr/lib/pkgconfig CFLAGS=-m32 LDFLAGS=-m32
> ./configure
> > +
> > +* Debian / Ubuntu and derivates
> > +PKG_CONFIG_LIBDIR=/usr/lib/i386-linux-gnu/pkgconfig CFLAGS=-m32
> LDFLAGS=-m32 ./configure
>

I occationally build 32bit LTP on my RHEL8(x86_64) platform
via: CFLAGS="-m32" CXXFLAGS="-m32" LDFLAGS="-m32" ./configure, it works for
me awalys.

May I ask why we need the PKG_CONFIG_LIBDIR?


>
> I guess, we should set this variable in 32 bit build in travis CI (we have
> only 1
> job, which uses Debian). It's not failing now, because it's not a minimal
> build.
> Therefore we should have minimal 32 bit build (easiest way is to use
> openSUSE or
> Fedora/CentOS as they don't install libtirpc 32bit).
>

Good suggestion! I think at least for CentOS/RHEL has no problem with this.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200515/ea1166d4/attachment-0001.htm>
