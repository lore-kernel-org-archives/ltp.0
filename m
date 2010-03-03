Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nmggp-0002uQ-2M
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 05:00:07 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nmggm-00066G-RL
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 05:00:07 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o234sIq0006239
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 21:54:18 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o234xudJ117002
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 21:59:56 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o22LxucV007594
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 14:59:56 -0700
Date: Wed, 3 Mar 2010 10:29:53 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100303045953.GC10185@linux.vnet.ibm.com>
References: <41c7690d1002250109r5e35b35cw2b10c0e270bc273a@mail.gmail.com>
	<20100225093304.GA23984@linux.vnet.ibm.com>
	<364299f41002250148q42f2d468y5c21919eeed3ce51@mail.gmail.com>
	<41c7690d1002251906w7b54d7a8w13fa60dcea22a4b3@mail.gmail.com>
	<41c7690d1002252055t5956a652ta173641c1860eedd@mail.gmail.com>
	<20100226053452.GA3800@linux.vnet.ibm.com>
	<20100226085136.GA9407@linux.vnet.ibm.com>
	<20100226091119.GB9407@linux.vnet.ibm.com>
	<20100301062917.GD3860@linux.vnet.ibm.com>
	<41c7690d1003020147l3811c35dl26306923c3420e18@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <41c7690d1003020147l3811c35dl26306923c3420e18@mail.gmail.com>
Subject: Re: [LTP] [PATCH-v2] RTC Device Driver Tests
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

On Tue, Mar 02, 2010 at 03:17:01PM +0530, Silesh C V wrote:
> On 3/1/10, Rishikesh K Rajak <risrajak@linux.vnet.ibm.com> wrote:
> > HI Silesh,
> >
> > Any input here, so that i can push this to upstream.
> 
> Hi Rishi,
> 
> Sorry for the late reply. I was out of the office for the past few
> days.AFAIK alarm not ringing usually happens because of the absence of
> an IRQ line from the RTC.I should be able to make the test report a
> FAIL when this happens by using select(2) so that a time out occurs. I
> will send another patch soon.

Thanks, can you please send your patch against next branch of ltp git
tree ?
#git clone -b next
git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git ltp

Thanks
-Rishi


> 
> 
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
