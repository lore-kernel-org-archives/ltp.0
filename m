Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NogaN-00047J-Sw
	for ltp-list@lists.sourceforge.net; Mon, 08 Mar 2010 17:17:43 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NogaM-00044W-TE
	for ltp-list@lists.sourceforge.net; Mon, 08 Mar 2010 17:17:43 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o28HDOTm007870
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Mar 2010 12:13:24 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o28HHakm149286
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Mar 2010 12:17:36 -0500
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o28HHDi2004099
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Mar 2010 10:17:14 -0700
Date: Mon, 8 Mar 2010 22:47:07 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100308171707.GA4999@linux.vnet.ibm.com>
References: <4B946761.8030301@cn.fujitsu.com>
	<364299f41003080753h78ddb8c0uc20027ccf2e3c990@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f41003080753h78ddb8c0uc20027ccf2e3c990@mail.gmail.com>
Subject: Re: [LTP] [BUG?] container_test.sh: should to delete
 check_for_unshare's source in cvs/git ?
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Mon, Mar 08, 2010 at 07:53:08AM -0800, Garrett Cooper wrote:
> On Sun, Mar 7, 2010 at 6:56 PM, Shi Weihua <shiwh@cn.fujitsu.com> wrote:
> > Tested the latest cvs version (about Mar 1) on my x86_64 (2.6.33).
> > The following message occured:
> > --------------------------------
> > <<<test_start>>>
> > tag=3DContainers stime=3D1267527554
> > cmdline=3D"container_test.sh"
> > contacts=3D""
> > analysis=3Dexit
> > <<<test_output>>>
> > /opt/ltp/testcases/bin/container_test.sh: line 13: check_for_unshare: c=
ommand not found
> > Running utsns tests.
> > unshare tests
> > test 1 (unshare)
> > test 2 (unshare)
> > ......
> > --------------------------------
> >
> > I noticed that check_for_unshare had been deleted in LTP-20091031.
> > In ./ChangeLog (from latest cvs version)
> > =A0 ...
> > =A0 2905 LTP-20091031
> > =A0 ...
> > =A0 3141 Removed Files:
> > =A0 3142 ltp/README.ltp-devel
> > =A0 3143 ltp/config.mk.in
> > =A0 3144 ltp/ltp-devel.spec
> > =A0 3145 ltp/testcases/kernel/containers/check_for_unshare.c
> > =A0 ...
> > =A0 3997 LTP-20090930
> >
> > Also, i noticed check_for_unshare commentted in container_test.sh in
> > release version of FEBRUARY 2010. pls check the diff between cvs version
> > and release version of Feb in attached file.
> >
> > Now, my question: should to delete check_for_unshare's source in cvs/gi=
t ?
> =

> There was some discussion and the check was reenabled post the February r=
elease.

I looked at a glance in sleep mode and found there is something need to
be fixed here as i am still not able to find check_for_unshare.c . Well
i will look and fix tomorrow.

Thanks
Rishi

> Thanks,
> -Garrett

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
