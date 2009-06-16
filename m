Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1MGbOP-0000PW-BC
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2009 16:20:13 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MGbOH-0005SQ-9g
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2009 16:20:06 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e39.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5GGFvfq001575
	for <ltp-list@lists.sourceforge.net>; Tue, 16 Jun 2009 10:15:57 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5GGJn4O183084
	for <ltp-list@lists.sourceforge.net>; Tue, 16 Jun 2009 10:19:52 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5GGJmgw021626
	for <ltp-list@lists.sourceforge.net>; Tue, 16 Jun 2009 10:19:48 -0600
Date: Tue, 16 Jun 2009 11:19:49 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20090616161949.GA32566@us.ibm.com>
References: <49b7c2350906151813r31a9fe24icee5b1244f560f7a@mail.gmail.com>
	<49b7c2350906151857yf972a90m78448ca70a89c468@mail.gmail.com>
	<20090616042450.GA26037@us.ibm.com>
	<49b7c2350906152243p4c970b1di74cc62badc85a2e7@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <49b7c2350906152243p4c970b1di74cc62badc85a2e7@mail.gmail.com>
Subject: Re: [LTP] Report - make error of ltp-full-20090531.tgz
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
To: GeunSik Lim <leemgs1@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Steve Grubb <sgrubb@redhat.com>, Andrew Morgan <morgan@kernel.org>

Quoting GeunSik Lim (leemgs1@gmail.com):
> On Tue, Jun 16, 2009 at 1:24 PM, Serge E. Hallyn<serue@us.ibm.com> wrote:
> > Quoting GeunSik Lim (leemgs1@gmail.com):
> >> I made patch file to solve below problem.
> >
> > well, NAK to the patch, but this is a real problem that needs to
> > be fixed. =A0I'll take a look in the morning, but Andrew do you know
> > offhand what the problem is with capability.h (in F11 I gather) that
> > would cause:
> Serge E. Hallyn,
> =

> Thanks for your opinion about  this report that I posted.
> Yes.  My below patch is private patch to solve  make error on Fedora 11
> distribution ( fedora11 2.6.29.4-167.fc11.i686).
> This means that my patch is not official patch file as you think.
> =

> For reference,
>  I used libcap 2.16 version
> at the  http://ftp.kernel.org/pub/linux/libs/security/linux-privs/kernel-=
2.6/  .

Are you sure?

With the libcap-2.16 from kernel.org, /usr/include/sys/capability.h
#includes <sys/types.h>.  The version that comes with Fedora 11's
libcap-devel-2.16-2.fc11.i586 #includes <linux/types.h> instead.
When I just fix that, my F11 system compiles cap_bound.c just fine.

Steve, do you know why that change is made?

It then moves on to the next F11-specific compile failure, namely
LTP's <test.h> ends up #including /usr/include/asm/sigcontext.h
causing the compile errors bc of undefined __u64 and __u32,
which I can fix by adding:

#define __u64 u_int64_t
#define __u32 u_int32_t

to <sys/types.h>.  So perhaps it would be prudent to add them
to the top of LTP's test.h?

It woudl be better to figure out why that's happening in the
first place...

thanks,
-serge

---------------------------------------------------------------------------=
---
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing =

server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
