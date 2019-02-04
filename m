From: Sandeep Patil <sspatil@android.com>
Date: Mon, 4 Feb 2019 11:20:04 -0800
Subject: [LTP] [PATCH 0/3] Build android fixes
In-Reply-To: <20190202172245.GA979@x230>
References: <20190130112826.7157-1-petr.vorel@gmail.com>
 <56309f29-d63c-2975-eb2c-1294f55e37e8@google.com>
 <20190202172245.GA979@x230>
Message-ID: <20190204192004.GB222456@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, Feb 02, 2019 at 06:22:46PM +0100, Petr Vorel wrote:
> Hi Steve,
> 
> > How did you come across these issues? We have yet to see them. Did you merge
> > tip of LTP into an Android AOSP tree and build it that way?
> Any sane person who wants to tests Android kernel uses LTP build inside of AOSP
> to get all your custom (not yet upstreamed) fixes, skip non relevant test etc.
> But I don't want to store whole AOSP on my disc, so I tried to cross compile
> upstream LTP with android standalone toolchain (with make ANDROID=1).

That is correct and I really want to be able to do the same. Admittedly the
current AOSP LTP build is "meant for the harness it normally runs under". It
really should not be the case and we'd love for AOSP LTP to build standalone.

I think I asked about the "make ANDROID" option a while ago and my
understanding was that its building LTP against the Android NDK. Steve, may
be this is the path we go? I do remember however that with that build, the
number of tests that we can build against Android was far less than what we
do right now (haven't tried in a while though).

Also, FWIW, there are almost zero non-upstream tests in AOSP LTP. I can only
think of one test suite but that is just very *android specific* and still
being worked on.

- ssp
