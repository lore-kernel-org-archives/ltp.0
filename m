Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nka5r-0006qq-26
	for ltp-list@lists.sourceforge.net; Thu, 25 Feb 2010 09:33:15 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nka5q-0004fw-3G
	for ltp-list@lists.sourceforge.net; Thu, 25 Feb 2010 09:33:15 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1P9MBME027441
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Feb 2010 04:22:11 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1P9X7DZ1847514
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Feb 2010 04:33:07 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1P9X7cV023578
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Feb 2010 04:33:07 -0500
Date: Thu, 25 Feb 2010 15:03:04 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100225093304.GA23984@linux.vnet.ibm.com>
References: <41c7690d1002240410y3f132792he5460c69891a0976@mail.gmail.com>
	<364299f41002241314u28cec7e9h7334685f6f82a8a@mail.gmail.com>
	<41c7690d1002242240m787a1e8bj4640341ec09ff61c@mail.gmail.com>
	<364299f41002242307i6256a0f1v9fbc4a2197049270@mail.gmail.com>
	<364299f41002242311j2c97cf8fm2894f00b3640d1ef@mail.gmail.com>
	<41c7690d1002250109r5e35b35cw2b10c0e270bc273a@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <41c7690d1002250109r5e35b35cw2b10c0e270bc273a@mail.gmail.com>
Subject: Re: [LTP] [PATCH][RESEND] RTC Device Driver Tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Silesh C V <saileshcv@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Arun.sudhilal@lntinfotech.com, Mohamed.Rasheed@lntinfotech.com

On Thu, Feb 25, 2010 at 02:39:37PM +0530, Silesh C V wrote:
> >>
> >>    The end goal is to have these tests fit directly into LTP without
> >> having to fudge around writing a secondary driver, thus maintaining
> >> two pieces of dependent code [which is of course more complicated than
> >> one piece of code], and thus is more of a pain to maintain longterm.
> >> There's a lot of code in the repository like this that was ported and
> >> subsequently not properly adapted to the existing infrastructure, thus
> >> creating additional headache for maintainers and end-users.
> >
> > Ok -- I take that back. I have no idea wtf is going on in this
> > directory nor the ultimate intent of the tests in here, apart from
> > being a lot of ad hoc pain in the arse-ness.
> 
> The README in testcases/kernel/device-drivers/ says that these tests
> should not be run with the other tests, and they have to be built
> separately. I agree that this is because they have a kernel space part
> also. But this prevents us from  building  device_driver tests that
> have only user space part (as in RTC tests), along with the overall
> build. And these tests does not belong in any other directory other
> than kernel/device-drivers. So as long as other tests are there we
> will have to live with building new device driver tests separately.I
> can re-send  the patch with Garrett's suggestions  incorporated.
> 
> Subrata, suggestions ?

Hi Silesh,

How about porting this on new makefile infrastructure ? I think this is
time where we can look back and can make one piece of code as garret
said is correct. Please see your fesibility. Let me know if you still
want this to be integrated. Before that can you please little more
descriptive with your patch e,g: what it is doing. 

And also it is always good if you include more documentation for each 
function as coding style suggests.

Thanks
Rishi
> 
> 
> Thanks,
> Silesh
> >
> > I've learned enough to keep my hands off this because it looks like a mess.
> >
> > Thanks,
> > -Garrett
> >

-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
