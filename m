From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 11 Nov 2019 11:50:07 +0100
Subject: [LTP] Verify LTP was compiled with specific kernel headers
In-Reply-To: <CALgnY2eHDnkoYLoC5TdFzecjpUb2AAJRadU30LofZxT2QG-fgg@mail.gmail.com>
References: <CALgnY2eHDnkoYLoC5TdFzecjpUb2AAJRadU30LofZxT2QG-fgg@mail.gmail.com>
Message-ID: <20191111105007.GA14824@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Not sure if this is the right place to ask, but I am trying to compile LTP
> with a specific kernel release.

What for? LTP compilation does not depend on a kernel version during
build.

All it depends on is glibc and a couple of devel libraries, but in most
of the cases we carry fallback definitions in a case that something is
missing.

> The source tarball was extracted. I make install the linux kernel headers:
> 
> make headers_install INSTALL_HDR_PATH=/tmp/test-kernel-h
> 
> Then I proceeded with:
> 
> make autotool
> ./configure --prefix=/tmp/out --includedir=/tmp/kernel-h/include/linux
> make
> make install
> 
> My question is how can I tell if it's really compiled with those headers?
> Is includedir the right one to use? I see oldincludedir is defaults to
> /usr/include.

LTP mostly avoids including kernel headers, it mostly uses libc and very
few kernel ones when necessary, but as said we carry fallback
definitions to carry on with compliation on older systems.

-- 
Cyril Hrubis
chrubis@suse.cz
