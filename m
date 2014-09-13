Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1XSd19-00074Y-E1
	for ltp-list@lists.sourceforge.net; Sat, 13 Sep 2014 02:24:51 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XSd0u-0003pU-11
	for ltp-list@lists.sourceforge.net; Sat, 13 Sep 2014 02:24:51 +0000
Received: from /spool/local
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Fri, 12 Sep 2014 20:24:30 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
	(b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id B4C2119D803F
	for <ltp-list@lists.sourceforge.net>;
	Fri, 12 Sep 2014 20:24:13 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id s8D2OQak52428954
	for <ltp-list@lists.sourceforge.net>; Sat, 13 Sep 2014 04:24:26 +0200
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP
	id s8D2OQZn009960
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Sep 2014 20:24:26 -0600
Received: from localhost.localdomain ([9.125.1.216])
	by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	s8D2OPmS009893
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Sep 2014 20:24:26 -0600
Date: Sat, 13 Sep 2014 10:24:22 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20140913022422.GA3401@localhost.localdomain>
References: <20140911022709.GA16027@localhost.localdomain>
	<5411B499.8020309@redhat.com>
	<20140912072845.GA3585@localhost.localdomain>
	<1324550878.22071909.1410509701094.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1324550878.22071909.1410509701094.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] ldd01: using 'ppc' to check powerpc arch
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
To: ltp-list@lists.sourceforge.net

On Fri, Sep 12, 2014 at 04:15:01AM -0400, Jan Stancek wrote:
> 
> 
> 
> ----- Original Message -----
> > From: "Han Pingtian" <hanpt@linux.vnet.ibm.com>
> > To: ltp-list@lists.sourceforge.net
> > Sent: Friday, 12 September, 2014 9:28:45 AM
> > Subject: Re: [LTP] [PATCH] ldd01: using 'ppc' to check powerpc arch
> > 
> > On Thu, Sep 11, 2014 at 04:41:29PM +0200, Jan Stancek wrote:
> > > Would you be willing to try attached patch, which moves the build
> > > of .so and a.out into Makefile?
> > I have tested your patch but ldd cannot find the lib files:
> > 
> 
> That's only matter of setting correct LD_LIBRARY_PATH:
> 
> $ env LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH ./ldd01 
Yes, it works after setting LD_LIBRARY_PATH like this on our systems.
> > 
> > > Or alternatively, can you describe
> > > the ppc system where this is failing, so I could try to reproduce
> > > it myself?
> > This is a power 6 system, which running a beta version rhel5.11. Without
> > my patch, it failed with those messages:
> 
> It also fails (with or without your patch) when built as 32-bit on RHEL7 ppc64:
> 
I have tested your patch with 32bit on the system, it works fine.



------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
