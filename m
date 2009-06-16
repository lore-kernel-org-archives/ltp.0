Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1MGdcG-0005u7-4T
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2009 18:42:40 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MGdba-0001L0-GZ
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2009 18:42:40 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5GIeNSB029139
	for <ltp-list@lists.sourceforge.net>; Tue, 16 Jun 2009 12:40:23 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5GIflBh208948
	for <ltp-list@lists.sourceforge.net>; Tue, 16 Jun 2009 12:41:48 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5GIfliT002564
	for <ltp-list@lists.sourceforge.net>; Tue, 16 Jun 2009 12:41:47 -0600
Date: Tue, 16 Jun 2009 13:41:48 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20090616184148.GA3043@us.ibm.com>
References: <49b7c2350906151813r31a9fe24icee5b1244f560f7a@mail.gmail.com>
	<49b7c2350906152243p4c970b1di74cc62badc85a2e7@mail.gmail.com>
	<20090616161949.GA32566@us.ibm.com>
	<200906161245.35932.sgrubb@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200906161245.35932.sgrubb@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Steve Grubb <sgrubb@redhat.com>
Cc: ltp-list@lists.sourceforge.net, GeunSik Lim <leemgs1@gmail.com>, Andrew Morgan <morgan@kernel.org>

Quoting Steve Grubb (sgrubb@redhat.com):
> On Tuesday 16 June 2009 12:19:49 pm Serge E. Hallyn wrote:
> > Quoting GeunSik Lim (leemgs1@gmail.com):
> > > On Tue, Jun 16, 2009 at 1:24 PM, Serge E. Hallyn<serue@us.ibm.com> wrote:
> > > > Quoting GeunSik Lim (leemgs1@gmail.com):
> > > >> I made patch file to solve below problem.
> > > >
> > > > well, NAK to the patch, but this is a real problem that needs to
> > > > be fixed.  I'll take a look in the morning, but Andrew do you know
> > > > offhand what the problem is with capability.h (in F11 I gather) that
> > > > would cause:
> > >
> > > Serge E. Hallyn,
> > >
> > > Thanks for your opinion about  this report that I posted.
> > > Yes.  My below patch is private patch to solve  make error on Fedora 11
> > > distribution ( fedora11 2.6.29.4-167.fc11.i686).
> > > This means that my patch is not official patch file as you think.
> > >
> > > For reference,
> > >  I used libcap 2.16 version
> > > at the 
> > > http://ftp.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.6/  .
> >
> > Are you sure?
> >
> > With the libcap-2.16 from kernel.org, /usr/include/sys/capability.h
> > #includes <sys/types.h>.  The version that comes with Fedora 11's
> > libcap-devel-2.16-2.fc11.i586 #includes <linux/types.h> instead.
> > When I just fix that, my F11 system compiles cap_bound.c just fine.
> >
> > Steve, do you know why that change is made?
> 
> Offhand I do not. I see in Fedora 11 cvs:  libcap-2.16-4. It looks fixed to me.
> 
> Here it was built:
> http://koji.fedoraproject.org/koji/buildinfo?buildID=106251
> 
> Here it was pushed to testing repo:
> https://admin.fedoraproject.org/updates/libcap-2.16-4.fc11
> 
> So, I'd enable the testing repo for F-11 to download the update. See if that 
> doesn't work better.

enabling testing still gave me only libcap-2.16-2, but
I downloaded and installed libcap-devel-2.16-4.fc11.i586.rpm
after which all compiled fine.

GeunSik, please give that a shot.

thanks,
-serge

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
