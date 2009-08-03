Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MXvdz-0003xb-VW
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 11:23:55 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MXvdt-0001aJ-Qv
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 11:23:55 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n73BGAU5032703
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 07:16:10 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n73BNiKC229244
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 07:23:44 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n73BNhOO012512
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 07:23:44 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1249298378.7460.22.camel@subratamodak.linux.ibm.com>
References: <20090720110521.GA3594@linux.vnet.ibm.com>
	<1249298378.7460.22.camel@subratamodak.linux.ibm.com>
Date: Mon, 03 Aug 2009 16:53:36 +0530
Message-Id: <1249298616.7460.38.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [RFC] Making Testcases aware that they are running in
	a	virtualization environment
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
To: Sudhir Kumar <skumar@linux.vnet.ibm.com>
Cc: Poornima Nayak <Poornima.Nayak@in.ibm.com>, ltp-list <ltp-list@lists.sourceforge.net>, Supriya Kaneri <supriyak@linux.vnet.ibm.com>, mrodrigu@redhat.com, mbligh@google.com, Yogananth <anantyog@linux.vnet.ibm.com>, smalik <smalikphy@gmail.com>

An incomplete mail sent out. Sorry.

On Mon, 2009-08-03 at 16:49 +0530, Subrata Modak wrote:
> Hi Sudhir,
> 
> Thanks for your suggestion. Let us suppose
> On Mon, 2009-07-20 at 16:35 +0530, Sudhir Kumar wrote: 
> > Hi LTP users and developers,
> > This is a discussion which needs the comments and thoughts from
> > everyone. Currently we see a major focus on operating system
> > virtualization. There are many hypervisors, KVM being one of the latest
> > ones. LTP has been executed on a variety of OSes on different hardware
> > plateforms. However the envronment for an application(or say LTP itslef)
> > running in the host OS vs in the guest OS might not be same in all
> > respects. Though the goal of virtualization is to make the two
> > environments almost exact, but for some tools like LTP this may not be
> > 100% possible. For example, If I am calculating cpu time under a guest OS
> > I can not normalize it to the total cpu time in the system as it all
> > depends on the guest scheduling.(different hypervisors have their own
> > mechanism). Other example can be cpu consolidation testcases which can
> > not be executed under a kvm test-bed. I think group scheduling may be
> > the next example. Similarly there can be more testcases or scenarios
> > which need them be aware that they are running under a virtualization
> > environment and should be able to handle the test execution accordingly.
> > Thus in some cases the test should either run with proper care or should
> > not execute or should break instead of failing due to improper
> > configuration.
> > 
> > The outcome of this discussion should be able to provide:
> > 
> > 1. What are the thoughts of the community on this concern of LTP.
> > 
> > 2. To collect the existing testcases in LTP which need this
> > modification.
> > 
> > 3. Taking care that all the future cases which are virtualization
> > sensitive should be able to handle it well.
> > 
> > 4. In what all ways we can come to know which hypervisor is the guest
> > running on. For KVM we can do something like
> > if [ `cat /proc/cpuinfo | grep -w "model name" | cut -f3 -d " " | head
> > -n 1` == "QEMU" ]; then echo "KVM Guest"; else echo "Non KVM Guest"; fi
> > 
> > 5. Test developers can send quick patches if the testcases developed by
> > them need to have this feature.
> > 
> > 6. Modify the LTP How-To to include the virtualization awareness warning
> > for testcases.
> > 
> > Please provide your valuable comments and the name of tescases which you
> > know do need such a modification. If people do not have time we may try to
> > modify them or put at least in the TODO on the wiki.

Send a sample patch to exemplify this.

Regards--
Subrata

> > 


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
