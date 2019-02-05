From: Steve Muckle <smuckle@google.com>
Date: Mon, 4 Feb 2019 16:06:58 -0800
Subject: [LTP] [PATCH 0/3] Build android fixes
In-Reply-To: <20190204192004.GB222456@google.com>
References: <20190130112826.7157-1-petr.vorel@gmail.com>
 <56309f29-d63c-2975-eb2c-1294f55e37e8@google.com> <20190202172245.GA979@x230>
 <20190204192004.GB222456@google.com>
Message-ID: <de590605-f11d-5617-b107-6456de3d0b7e@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02/04/2019 11:20 AM, Sandeep Patil wrote:
> I think I asked about the "make ANDROID" option a while ago and my
> understanding was that its building LTP against the Android NDK. Steve, may
> be this is the path we go? I do remember however that with that build, the
> number of tests that we can build against Android was far less than what we
> do right now (haven't tried in a while though).

Seems worth a try. Offhand I'm not sure why this should enable fewer 
tests than building it as part of aosp...

> Also, FWIW, there are almost zero non-upstream tests in AOSP LTP. I can only
> think of one test suite but that is just very *android specific* and still
> being worked on.

Is this by chance the eas test suite you're referring to? Despite the 
name there are eight or so generic scheduler/cpufreq tests that should 
be fairly upstream-ready, it's just blocked on me getting time to send 
them upstream for review and work on feedback. Other tests which are 
specific to EAS need some review to determine how applicable they are to 
the upstream kernel.

If anyone wants to poke around and look at these they are here:

https://android.googlesource.com/platform/external/ltp/+/master/testcases/kernel/sched/eas/

cheers,
Steve
