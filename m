From: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Date: Fri, 19 May 2017 13:26:40 +0900
Subject: [LTP] LTP release
In-Reply-To: <1639910547.7946506.1493998892960.JavaMail.zimbra@redhat.com>
References: <20170424162534.GA13616@rei.lan>
 <20170428154714.GB4741@rei.suse.de> <20170505144116.GE16729@rei.suse.de>
 <1639910547.7946506.1493998892960.JavaMail.zimbra@redhat.com>
Message-ID: <003f01d2d058$1c828160$55878420$@toshiba.co.jp>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

This is my first e-mail to the list. My name is Daniel and I've been integrating LTP into
the Fuego test framework.

> -----Original Message-----
> From: ltp [mailto:ltp-bounces+daniel.sangorrin=toshiba.co.jp@lists.linux.it] On Behalf Of Jan Stancek
> Sent: Saturday, May 06, 2017 12:42 AM
> > Hi!
> > > * utimensat01 - We reverted the fix before the last release and started
> > >                 discussion on LKML but it seems that nobody cares so I
> > > 		guess that we should reapply the patch and forget.
> >
> > Jan will you reapply the patch?
> 
> Tested on 4.11 and pushed.

I read your conversation here
http://www.spinics.net/lists/linux-fsdevel/msg106449.html
and it seems that the final conclusion was that EPERM was the right return 
value (that's the reason you reapplied this patch I suppose). 

Q1: Does the man page for utimensat need an update then?
Ref: https://github.com/mkerrisk/man-pages/blob/master/man2/utimensat.2

This LTP patch introduces a kernel version check (if tst_kvcmp -lt "4.8.0"; then). 
Patch: https://github.com/linux-test-project/ltp/commit/b9157aee8fdeed1ef808fb490e5910e8750d7587

That seems fine if you are testing vanilla kernels only. I was wondering what 
happens with LTS or Distro kernels though, because they usually have many backported patches.
In particular the linux-stable kernel branch "linux-4.4.y" does include 
commit f2b20f6ee842313a0d681dbbf7f87b70291a6a3b and I confirmed that
that patch alone causes the LTP utimensat to return EPERM instead of EACESS.
# I tested it by reverting the patch and running LTP again

Q2: Is there any mechanism in LTP for taking care of these kernels?

I was thinking about it and I could only think of 2 solutions:
  1) Add such support manually (e.g. test against kernel 4.4.27 as well).
  2) Add an optional parameter to LTP with the location of the kernel git repository
       and branch. This way LTP tests could test against the existence of specific commit ids.

The second solution would be very generic and work for any kernel but it's kind of 
cumbersome. The first solution requires manual work so maybe too time consuming (I could help).
What do you think?

Thanks,
Daniel
















