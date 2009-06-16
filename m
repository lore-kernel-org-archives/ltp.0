Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sgrubb@redhat.com>) id 1MGbuK-0004UT-AM
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2009 16:53:12 +0000
Received: from mx2.redhat.com ([66.187.237.31])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MGbuG-0001PB-G5
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2009 16:53:12 +0000
From: Steve Grubb <sgrubb@redhat.com>
Date: Tue, 16 Jun 2009 12:45:29 -0400
References: <49b7c2350906151813r31a9fe24icee5b1244f560f7a@mail.gmail.com>
	<49b7c2350906152243p4c970b1di74cc62badc85a2e7@mail.gmail.com>
	<20090616161949.GA32566@us.ibm.com>
In-Reply-To: <20090616161949.GA32566@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200906161245.35932.sgrubb@redhat.com>
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net, GeunSik Lim <leemgs1@gmail.com>, Andrew Morgan <morgan@kernel.org>

On Tuesday 16 June 2009 12:19:49 pm Serge E. Hallyn wrote:
> Quoting GeunSik Lim (leemgs1@gmail.com):
> > On Tue, Jun 16, 2009 at 1:24 PM, Serge E. Hallyn<serue@us.ibm.com> wrote:
> > > Quoting GeunSik Lim (leemgs1@gmail.com):
> > >> I made patch file to solve below problem.
> > >
> > > well, NAK to the patch, but this is a real problem that needs to
> > > be fixed.  I'll take a look in the morning, but Andrew do you know
> > > offhand what the problem is with capability.h (in F11 I gather) that
> > > would cause:
> >
> > Serge E. Hallyn,
> >
> > Thanks for your opinion about  this report that I posted.
> > Yes.  My below patch is private patch to solve  make error on Fedora 11
> > distribution ( fedora11 2.6.29.4-167.fc11.i686).
> > This means that my patch is not official patch file as you think.
> >
> > For reference,
> >  I used libcap 2.16 version
> > at the 
> > http://ftp.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.6/  .
>
> Are you sure?
>
> With the libcap-2.16 from kernel.org, /usr/include/sys/capability.h
> #includes <sys/types.h>.  The version that comes with Fedora 11's
> libcap-devel-2.16-2.fc11.i586 #includes <linux/types.h> instead.
> When I just fix that, my F11 system compiles cap_bound.c just fine.
>
> Steve, do you know why that change is made?

Offhand I do not. I see in Fedora 11 cvs:  libcap-2.16-4. It looks fixed to me.

Here it was built:
http://koji.fedoraproject.org/koji/buildinfo?buildID=106251

Here it was pushed to testing repo:
https://admin.fedoraproject.org/updates/libcap-2.16-4.fc11

So, I'd enable the testing repo for F-11 to download the update. See if that 
doesn't work better.

-Steve

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
