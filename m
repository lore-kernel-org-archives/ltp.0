Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shubgoya@in.ibm.com>) id 1PGrBl-00077c-95
	for ltp-list@lists.sourceforge.net; Fri, 12 Nov 2010 10:49:01 +0000
Received: from e28smtp04.in.ibm.com ([122.248.162.4])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PGrBh-0007hX-0k
	for ltp-list@lists.sourceforge.net; Fri, 12 Nov 2010 10:49:01 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp04.in.ibm.com (8.14.4/8.13.1) with ESMTP id oACAmllo007489
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Nov 2010 16:18:47 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oACAmlkE675872
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Nov 2010 16:18:47 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oACAmkMW028340
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Nov 2010 21:48:47 +1100
In-Reply-To: <AANLkTi=i0QWb616WG=FsD5aQh5kjeFjggzj3mKJV-d2-@mail.gmail.com>
References: <1289458673.5622.19.camel@subratamodak.linux.ibm.com>	<OF7E98D2D1.7AEC88E3-ON652577D8.002CB466-652577D8.0030671A@LocalDomain>
	<OF0CF663E4.3DA7EB94-ON652577D8.0037CCDB-652577D8.00391B71@in.ibm.com>
	<AANLkTi=i0QWb616WG=FsD5aQh5kjeFjggzj3mKJV-d2-@mail.gmail.com>
Message-ID: <OFAA826A3D.B74F9335-ON652577D9.003A595F-652577D9.003B651E@in.ibm.com>
From: Shubham Goyal <shubgoya@in.ibm.com>
Date: Fri, 12 Nov 2010 16:18:30 +0530
MIME-Version: 1.0
Subject: Re: [LTP] [RFC] Remove testcases/pounder21
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
Cc: Iranna D Ankad <iranna.ankad@in.ibm.com>, takahash <takahash@us.ibm.com>, LTP list <ltp-list@lists.sourceforge.net>

Hi Garrett,
                  Our intention is that pounder21 tree should always be a
part of coming LTP tarball releases in the same directory where it is
sitting now. We have plans to use latest LTP for coming new distros and in
that case we will need pounder21 along with LTP.

So if you move pounder21 directory to a separate module under LTP CVS, will
it still fulfil our above requirement?

Thanks,
-Shubham



                                                                           =

             Garrett Cooper                                                =

             <yanegomi@gmail.c                                             =

             om>                                                        To =

                                       Shubham Goyal/India/IBM@IBMIN       =

             11/11/2010 10:48                                           cc =

             PM                        Iranna D Ankad/India/IBM@IBMIN, LTP =

                                       list                                =

                                       <ltp-list@lists.sourceforge.net>,   =

                                       Murlin Wenzel <mwenzel@novell.com>, =

                                       subrata@linux.vnet.ibm.com,         =

                                       takahash <takahash@us.ibm.com>      =

                                                                   Subject =

                                       Re: [LTP] [RFC] Remove              =

                                       testcases/pounder21                 =

                                                                           =

                                                                           =

                                                                           =

                                                                           =

                                                                           =

                                                                           =





On Thu, Nov 11, 2010 at 2:23 AM, Shubham Goyal <shubgoya@in.ibm.com> wrote:
> Yes Iranna I agree with you and I also feel that "pounder21" tree should
> not be removed from LTP. As you correctly said currently its difficult to
> run LTP's pounder on stand alone systems due to some other helper files
> dependency. I will try to address this problem ASAP and try to make
pounder
> run on stand alone systems without any other dependencies. =A0I have it in
my
> TODO list.

    Should it be moved to a separate module under LTP CVS?
Thanks,
-Garrett



---------------------------------------------------------------------------=
---
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
