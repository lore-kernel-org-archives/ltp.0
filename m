From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 Feb 2019 02:22:52 +0100
Subject: [LTP] [PATCH 0/3] Build android fixes
In-Reply-To: <20190204192004.GB222456@google.com>
References: <20190130112826.7157-1-petr.vorel@gmail.com>
 <56309f29-d63c-2975-eb2c-1294f55e37e8@google.com>
 <20190202172245.GA979@x230> <20190204192004.GB222456@google.com>
Message-ID: <20190205012252.GA11738@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Sandeep,

> > > How did you come across these issues? We have yet to see them. Did you merge
> > > tip of LTP into an Android AOSP tree and build it that way?
> > Any sane person who wants to tests Android kernel uses LTP build inside of AOSP
> > to get all your custom (not yet upstreamed) fixes, skip non relevant test etc.
> > But I don't want to store whole AOSP on my disc, so I tried to cross compile
> > upstream LTP with android standalone toolchain (with make ANDROID=1).

> That is correct and I really want to be able to do the same. Admittedly the
> current AOSP LTP build is "meant for the harness it normally runs under". It
> really should not be the case and we'd love for AOSP LTP to build standalone.
Great :). I see your bionic-compat.h can handle some errors (e.g. missing
getdtablesize(void)). Since we have already some support, this could be probably
merged (assuming Cyril is not against).

That layer allows you to build more tests than it's currently allowed in our
Makefiles (we filter quite a lot syscalls).

> I think I asked about the "make ANDROID" option a while ago and my
> understanding was that its building LTP against the Android NDK. Steve, may
> be this is the path we go? I do remember however that with that build, the
> number of tests that we can build against Android was far less than what we
> do right now (haven't tried in a while though).
I do build with configure --host triplet add --with-sysroot and SYSROOT
+ add -I and -L flags to sysroot dirs to CFLAGS and LDFLAGS.
But this way autoconf does detect wrongly some options (at least HAVE_PREADV and
HAVE_PWRITEV).

BTW which compiler option allows you to ignore missing <string.h> and
<strings.h> ?

> Also, FWIW, there are almost zero non-upstream tests in AOSP LTP.
Great!
> I can only
> think of one test suite but that is just very *android specific* and still
> being worked on.

> - ssp

Kind regards,
Petr
