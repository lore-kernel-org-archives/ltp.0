From: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Date: Fri, 19 May 2017 18:46:08 +0900
Subject: [LTP] LTP release
In-Reply-To: <20170519093648.GB6940@rei.lan>
References: <20170424162534.GA13616@rei.lan>
 <20170428154714.GB4741@rei.suse.de> <20170505144116.GE16729@rei.suse.de>
 <1639910547.7946506.1493998892960.JavaMail.zimbra@redhat.com>
 <003f01d2d058$1c828160$55878420$@toshiba.co.jp>
 <20170519093648.GB6940@rei.lan>
Message-ID: <007801d2d084$bdaa97e0$38ffc7a0$@toshiba.co.jp>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> -----Original Message-----
> From: Cyril Hrubis [mailto:chrubis@suse.cz]
> Sent: Friday, May 19, 2017 6:37 PM
...
> > Q2: Is there any mechanism in LTP for taking care of these kernels?
> >
> > I was thinking about it and I could only think of 2 solutions:
> >   1) Add such support manually (e.g. test against kernel 4.4.27 as well).
> >   2) Add an optional parameter to LTP with the location of the kernel git repository
> >        and branch. This way LTP tests could test against the existence of specific commit ids.
> >
> > The second solution would be very generic and work for any kernel but it's kind of
> > cumbersome. The first solution requires manual work so maybe too time consuming (I could help).
> > What do you think?
> 
> We actually have a mechanism to specify distribution specific kernel
> versions.
> 
> See:
> 
> commit 882f45a8e9d321ca108495517e25778a518eb58c
> Author: Cyril Hrubis <chrubis@suse.cz>
> Date:   Fri Apr 21 16:31:48 2017 +0200
> 
>     tst_kvcmp: Add support for extra kernel versions
> 
> 
> I guess that this could be adjusted for matching against LTS kernels as well.
> 
> 
> But in this case I guess that we may as well allow the test pass with
> both EACESS and EPERM in case of slightly older kernels. I.e. kernels
> that are older than oldest LTS kernel with that patch backported expect
> EACCES, kernels newer than the vanilla version with that patch expect
> EPERM and for kernels between this two test will work with both.

Thanks Cyril. I will prepare a patch then next week.

Thanks,
Daniel


