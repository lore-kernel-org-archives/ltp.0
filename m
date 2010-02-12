Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1Ng1Ka-0007RW-So
	for ltp-list@lists.sourceforge.net; Fri, 12 Feb 2010 19:37:36 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ng1KY-0004nI-LD
	for ltp-list@lists.sourceforge.net; Fri, 12 Feb 2010 19:37:36 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1CJY1J3027910
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Feb 2010 12:34:01 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1CJbQFe118220
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Feb 2010 12:37:26 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o1CJbPh5011772
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Feb 2010 12:37:26 -0700
Date: Fri, 12 Feb 2010 13:37:24 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100212193724.GA23537@us.ibm.com>
References: <000001caabb7$fe895b60$fb9c1220$@co.jp>
	<20100212175125.GC15333@us.ibm.com>
	<364299f41002121117i4fcc7b5bua47579a6ee2d661a@mail.gmail.com>
	<364299f41002121123t25450771i262fd5a2250ed20a@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f41002121123t25450771i262fd5a2250ed20a@mail.gmail.com>
Subject: Re: [LTP] "pidns17" problem in "2010-02-11" cvs
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
Cc: ltp-list@lists.sourceforge.net, Mitani <mitani@ryobi.co.jp>

Quoting Garrett Cooper (yanegomi@gmail.com):
> On Fri, Feb 12, 2010 at 11:17 AM, Garrett Cooper <yanegomi@gmail.com> wro=
te:
> > On Fri, Feb 12, 2010 at 9:51 AM, Serge E. Hallyn <serue@us.ibm.com> wro=
te:
> >> Right, the test is checking whether kill -1 inside a private pidns
> >> kills all processes besides init in the pid namespace.
> >
> > Yeah, that's just not smart...
> >
> >>> Therefore, not only the "sshd" but also the other processes were
> >>> affected, I think.
> >>
> >> sshd is not in the private pid namespace and should not be killed.
> >> If it is being killed by the pid -1 inside the container, then there
> >> is a kernel bug.
> >
> > No, it isn't. If the test is being run as root it'll force a reboot on =
the box:
> >
> > =A0 =A0 If pid is -1:
> > =A0 =A0 =A0 =A0 =A0 =A0 If the user has super-user privileges, the sign=
al is sent to all
> > =A0 =A0 =A0 =A0 =A0 =A0 processes excluding system processes (with P_SY=
STEM flag set),
> > =A0 =A0 =A0 =A0 =A0 =A0 process with ID 1 (usually init(8)), and the pr=
ocess sending the
> > =A0 =A0 =A0 =A0 =A0 =A0 signal. =A0If the user is not the super user, t=
he signal is sent to
> > =A0 =A0 =A0 =A0 =A0 =A0 all processes with the same uid as the user exc=
luding the process
> > =A0 =A0 =A0 =A0 =A0 =A0 sending the signal. =A0No error is returned if =
any process could be
> > =A0 =A0 =A0 =A0 =A0 =A0 signaled.
> =

> Oh wait.. containers isolate PIDs and resources, correct (a weak form

weak?  :)

> of BSD jails or Solaris zones)? If so, then I'd watch the console //
> /var/log/messages, etc and see whether or not things stay alive after
> the signal is tossed...

Right.  To approximate this testcase by hand I just tried on today's
fresh kernel git pull

	ns_exec -cp /bin/bash
	for i in `seq 1 100`; do sleep 30 & done
	kill -USR1 -1

and only the sleeps were killed.

thanks,
-serge

---------------------------------------------------------------------------=
---
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
