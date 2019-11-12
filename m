From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Nov 2019 11:10:54 +0100
Subject: [LTP] [PATCH v4] syscalls/prctl02: add more error tests
In-Reply-To: <43e4f419-0100-dc52-7159-2355e9de1639@cn.fujitsu.com>
References: <20191108142434.GA5913@rei>
 <1573462752-6679-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191111163144.GB16894@rei.lan>
 <43e4f419-0100-dc52-7159-2355e9de1639@cn.fujitsu.com>
Message-ID: <20191112101054.GA9373@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > 1) Add fallback definitions to lapi
> > 2) Ensure these tests does not fail on older kernels
> >
> >     We do expect EINVAL in these cases anyways, which is what we would
> >     get if the prctl() option is unknown to the kernel anyways, so here
> >     we can just get rid of these ifdefs and things should work fine.
> 
> For me, a fallback definitions into the lapi header is only for fixing undefined error on old kernel.
> 
> IMO, we only test options that kernel supports.
> If we test an unsupported option, our case reports EINVAL that will give user a false impression(kernel
> supports it, but argument or environment is bad). I think we should check they whether supported before run
> (ifdef is a way).

However using ifdefs to assert kernel features never worked at all. The
kernel headers usally lag behind the installed kernel in distribution
and it's even more wrong when you are testing latest kernel on any given
distro.

If you want to check for kernel support the best thing is to use the
tst_kvercmp() that checks the kernel version and even that does not work
100% reliably.

> ps: If we test EPERM error(cap is not in PI or PP) of PR_CAP_AMBIENT on old kernel,  they will report EINVAL.
> So, I think ifdef is needed.

No, ifdefs are never solution here. It will still fail if you compiled
the test on newer distro and booted it up with older kernel.

-- 
Cyril Hrubis
chrubis@suse.cz
