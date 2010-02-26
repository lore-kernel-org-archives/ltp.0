Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NkvvJ-0006R4-Oh
	for ltp-list@lists.sourceforge.net; Fri, 26 Feb 2010 08:51:49 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NkvvI-0000Lw-Cm
	for ltp-list@lists.sourceforge.net; Fri, 26 Feb 2010 08:51:49 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1Q8lfV6019765
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Feb 2010 03:47:41 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1Q8pfT7119132
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Feb 2010 03:51:41 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1Q8pfX1019781
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Feb 2010 03:51:41 -0500
Date: Fri, 26 Feb 2010 14:21:36 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100226085136.GA9407@linux.vnet.ibm.com>
References: <364299f41002241314u28cec7e9h7334685f6f82a8a@mail.gmail.com>
	<41c7690d1002242240m787a1e8bj4640341ec09ff61c@mail.gmail.com>
	<364299f41002242307i6256a0f1v9fbc4a2197049270@mail.gmail.com>
	<364299f41002242311j2c97cf8fm2894f00b3640d1ef@mail.gmail.com>
	<41c7690d1002250109r5e35b35cw2b10c0e270bc273a@mail.gmail.com>
	<20100225093304.GA23984@linux.vnet.ibm.com>
	<364299f41002250148q42f2d468y5c21919eeed3ce51@mail.gmail.com>
	<41c7690d1002251906w7b54d7a8w13fa60dcea22a4b3@mail.gmail.com>
	<41c7690d1002252055t5956a652ta173641c1860eedd@mail.gmail.com>
	<20100226053452.GA3800@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100226053452.GA3800@linux.vnet.ibm.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Silesh C V <saileshcv@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Arun.sudhilal@lntinfotech.com, Mohamed.Rasheed@lntinfotech.com

On Fri, Feb 26, 2010 at 11:04:52AM +0530, Rishikesh K Rajak wrote:
> On Fri, Feb 26, 2010 at 10:25:17AM +0530, Silesh C V wrote:
> >Hi, =

> >Here is the new version of the RTC device driver tests.Although it does
> >not fall under the new Make infrastructure,=A0 I have used tst_res APIs.=
 So it
> >should be easy to port these tests to the new infrastructure without tou=
ching the C
> >file. Thanks again for the suggestions and review.
> =

> Hi Silesh,
> =

> Thanks for your patch, let's wait to hear and Acked from Garret, then we
> will apply this in our tree.

Hi Silesh,

I got a chance to test your patch on RHEL5.4GA and i was having device
as /dev/rtc .

But when i run your testcase on this device i get following :

[root@mx3655 rtc]# ./rtc-test /dev/rtc
rtc01       0  TINFO  :  RTC READ TEST:
rtc01       1  TPASS  :  RTC READ TEST Passed
rtc01       0  TINFO  :  Current Date/time is  02/26/10 08:40:17 AM
rtc01       0  TINFO  :  RTC ALARM TEST :
rtc01       0  TINFO  :  Alarm time set to 08:40:22.
rtc01       0  TINFO  :  Waiting 5 seconds for the alarm...
<------ Stuck forever :(

Looks like some issue with your code, can you please relook once again ?

Thanks for your patch.
-Rishi

> =

> -- =

> Thanks & Regards
> Rishi
> LTP Maintainer
> IBM, LTC, Bangalore
> Please join IRC #ltp @ irc.freenode.net
> =

> -------------------------------------------------------------------------=
-----
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- =

Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
