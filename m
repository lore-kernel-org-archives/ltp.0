Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1PGr5G-0000RO-UV
	for ltp-list@lists.sourceforge.net; Fri, 12 Nov 2010 10:42:18 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PGr5F-0002xa-SN
	for ltp-list@lists.sourceforge.net; Fri, 12 Nov 2010 10:42:18 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oACAKlZR016981
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Nov 2010 05:20:47 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oACAgCtB394890
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Nov 2010 05:42:12 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oACAgB8S019336
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Nov 2010 08:42:12 -0200
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <AANLkTi=i0QWb616WG=FsD5aQh5kjeFjggzj3mKJV-d2-@mail.gmail.com>
References: <1289458673.5622.19.camel@subratamodak.linux.ibm.com>
	<OF7E98D2D1.7AEC88E3-ON652577D8.002CB466-652577D8.0030671A@LocalDomain>
	<OF0CF663E4.3DA7EB94-ON652577D8.0037CCDB-652577D8.00391B71@in.ibm.com>
	<AANLkTi=i0QWb616WG=FsD5aQh5kjeFjggzj3mKJV-d2-@mail.gmail.com>
Date: Fri, 12 Nov 2010 16:11:31 +0530
Message-Id: <1289558494.13890.3.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [RFC] Remove testcases/pounder21
Reply-To: subrata@linux.vnet.ibm.com
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: Iranna D Ankad <iranna.ankad@in.ibm.com>, Shubham Goyal <shubgoya@in.ibm.com>, takahash <takahash@us.ibm.com>, LTP list <ltp-list@lists.sourceforge.net>

On Thu, 2010-11-11 at 09:18 -0800, Garrett Cooper wrote:
> On Thu, Nov 11, 2010 at 2:23 AM, Shubham Goyal <shubgoya@in.ibm.com> wrote:
> > Yes Iranna I agree with you and I also feel that "pounder21" tree should
> > not be removed from LTP. As you correctly said currently its difficult to
> > run LTP's pounder on stand alone systems due to some other helper files
> > dependency. I will try to address this problem ASAP and try to make pounder
> > run on stand alone systems without any other dependencies.  I have it in my
> > TODO list.
> 
>     Should it be moved to a separate module under LTP CVS?

I would prefer to keep it in git for the time being. Let it be where it is. We will not try to integrate it inside LTP root Makefile, so, configure/make/make install will not interfere with pounder21 directory. Once Subham comes wiht the patch for generic build/install we can integrate it to LTP Makefile then.

Since, the IBM distro test teams use both LTP and Pounder21, it would be much easier for them to access them from a single tarball :-)

Regards--
Subrata

> Thanks,
> -Garrett


------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
