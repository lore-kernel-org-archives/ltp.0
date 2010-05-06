Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1OA5zR-0004Fb-Rw
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 18:40:05 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OA5zP-0007io-Kr
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 18:40:05 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o46IcJf5003052
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 12:38:19 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o46IdqLx081090
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 12:39:55 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o46Bdmsn017416
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 05:39:48 -0600
Date: Thu, 6 May 2010 13:39:47 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100506183947.GA14900@us.ibm.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
	<20100506065657.23879.72093.sendpatchset@subratamodak.linux.ibm.com>
	<0B5AF9FC-8DAA-4995-9166-8EB0FE42F98C@gmail.com>
	<20100506135312.GA12072@us.ibm.com>
	<j2v364299f41005061038ucdbdaf19hcdad19491344e76d@mail.gmail.com>
	<20100506175512.GA25514@us.ibm.com>
	<k2v364299f41005061059rf51273ffk7c8c9755b92427e5@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <k2v364299f41005061059rf51273ffk7c8c9755b92427e5@mail.gmail.com>
Subject: Re: [LTP] [04/12 FAILURE] LTP? sysctl03 test fails
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
Cc: Linus Test Project <ltp-list@lists.sourceforge.net>, Michael Kerrisk <mtk.manpages@gmail.com>

Quoting Garrett Cooper (yanegomi@gmail.com):
> On Thu, May 6, 2010 at 10:55 AM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> > Quoting Garrett Cooper (yanegomi@gmail.com):
> > So since we're all member of the doc team, send a patch for sysctl(2)
> > manpage ERRORS section :)
> >
> > (mtk cc:d as this is probably news to him)
> =

> I already have a bug outstanding for it:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D15446

That's not what I said :)

> >> > An LSM could choose to return -EPERM
> >> > after all, or perhaps even something different. =A0The thing that
> >> > should scare us is if the call succeeds. =A0If we give any false
> >> > positives, then true positives will seem less scary.
> >>
> >> This will fail on older kernels as sysctl(2) always returned EPERM due
> >
> > Sorry - what will fail?
> =

> Read through the link, and you will understand why your new proposed
> patch with fail with a false negative.

I'm not sure that thread means what you think it does.

But look, just trying to help.  And no time for it really.  I'll drop
this.

-serge

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
