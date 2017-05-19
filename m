From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 19 May 2017 11:36:48 +0200
Subject: [LTP] LTP release
In-Reply-To: <003f01d2d058$1c828160$55878420$@toshiba.co.jp>
References: <20170424162534.GA13616@rei.lan>
 <20170428154714.GB4741@rei.suse.de>
 <20170505144116.GE16729@rei.suse.de>
 <1639910547.7946506.1493998892960.JavaMail.zimbra@redhat.com>
 <003f01d2d058$1c828160$55878420$@toshiba.co.jp>
Message-ID: <20170519093648.GB6940@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > From: ltp [mailto:ltp-bounces+daniel.sangorrin=toshiba.co.jp@lists.linux.it] On Behalf Of Jan Stancek
> > Sent: Saturday, May 06, 2017 12:42 AM
> > > Hi!
> > > > * utimensat01 - We reverted the fix before the last release and started
> > > >                 discussion on LKML but it seems that nobody cares so I
> > > > 		guess that we should reapply the patch and forget.
> > >
> > > Jan will you reapply the patch?
> > 
> > Tested on 4.11 and pushed.
> 
> I read your conversation here
> http://www.spinics.net/lists/linux-fsdevel/msg106449.html
> and it seems that the final conclusion was that EPERM was the right return 
> value (that's the reason you reapplied this patch I suppose). 

It seems that nobody cares enough to actually work on the issue.

> Q1: Does the man page for utimensat need an update then?
> Ref: https://github.com/mkerrisk/man-pages/blob/master/man2/utimensat.2

I guess that this is what we will have to do in the end. There is
practically no chance that the kernel patch will be reverted now.

> This LTP patch introduces a kernel version check (if tst_kvcmp -lt "4.8.0"; then). 
> Patch: https://github.com/linux-test-project/ltp/commit/b9157aee8fdeed1ef808fb490e5910e8750d7587
> 
> That seems fine if you are testing vanilla kernels only. I was wondering what 
> happens with LTS or Distro kernels though, because they usually have many backported patches.
> In particular the linux-stable kernel branch "linux-4.4.y" does include 
> commit f2b20f6ee842313a0d681dbbf7f87b70291a6a3b and I confirmed that
> that patch alone causes the LTP utimensat to return EPERM instead of EACESS.
> # I tested it by reverting the patch and running LTP again
> 
> Q2: Is there any mechanism in LTP for taking care of these kernels?
> 
> I was thinking about it and I could only think of 2 solutions:
>   1) Add such support manually (e.g. test against kernel 4.4.27 as well).
>   2) Add an optional parameter to LTP with the location of the kernel git repository
>        and branch. This way LTP tests could test against the existence of specific commit ids.
> 
> The second solution would be very generic and work for any kernel but it's kind of 
> cumbersome. The first solution requires manual work so maybe too time consuming (I could help).
> What do you think?

We actually have a mechanism to specify distribution specific kernel
versions.

See:

commit 882f45a8e9d321ca108495517e25778a518eb58c
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Fri Apr 21 16:31:48 2017 +0200

    tst_kvcmp: Add support for extra kernel versions


I guess that this could be adjusted for matching against LTS kernels as well.


But in this case I guess that we may as well allow the test pass with
both EACESS and EPERM in case of slightly older kernels. I.e. kernels
that are older than oldest LTS kernel with that patch backported expect
EACCES, kernels newer than the vanilla version with that patch expect
EPERM and for kernels between this two test will work with both.

-- 
Cyril Hrubis
chrubis@suse.cz
