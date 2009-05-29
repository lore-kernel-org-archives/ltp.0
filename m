Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MA1bq-00036m-AV
	for ltp-list@lists.sourceforge.net; Fri, 29 May 2009 12:54:54 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MA1bp-0001uT-6O
	for ltp-list@lists.sourceforge.net; Fri, 29 May 2009 12:54:54 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <522C1DF17AF50042AD8AE87F7887BD3D0158B35ACE@exch.hq.tensilica.com>
References: <20090526142706.20166.3813.sendpatchset@subratamodak.linux.ibm.com>
	<522C1DF17AF50042AD8AE87F7887BD3D0158B359A4@exch.hq.tensilica.com>
	<d51f89b0905262344h46722756vb255541a47904dbe@mail.gmail.com>
	<522C1DF17AF50042AD8AE87F7887BD3D0158B35AB4@exch.hq.tensilica.com>
	<1243434255.10447.19.camel@subratamodak.linux.ibm.com>
	<522C1DF17AF50042AD8AE87F7887BD3D0158B35ACE@exch.hq.tensilica.com>
Date: Fri, 29 May 2009 18:24:46 +0530
Message-Id: <1243601687.5188.34.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Detect test results more
	accurately	when	generating HTML
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
To: Marc Gauthier <marc@tensilica.com>
Cc: rohit verma <rohit.170309@gmail.com>, Ltp-List <ltp-list@lists.sf.net>

On Wed, 2009-05-27 at 07:58 -0700, Marc Gauthier wrote: 
> Subrata Modak wrote:
> > On Wed, 2009-05-27 at 05:05 -0700, Marc Gauthier wrote:
> > > Just so you know, the updated genhtml.pl script recently submitted
> > > should work just fine without changes, when moving status after
> > > <<<execution_status>>> (it only looks at tag names, not positions).
> >
> > Be careful, it looks for <<<execution_status>>> only in between
> > <<test_start>> & <<test_output>>.
> 
> You mean, between <<<test_start>>> and <<<test_end>>> ?
> (the script I submitted recently that is, was careful about this)

You made changes in genhtml.pl. I want the change(s) in ltp-pan.c.

Regards--
Subrata

> 
> -Marc


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
