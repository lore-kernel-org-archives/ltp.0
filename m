Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1ME60C-0006RR-MR
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2009 18:24:52 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1ME60B-0001TJ-Pw
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2009 18:24:52 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <d51f89b0906020533j7881c042k1a7e43270f0aeec@mail.gmail.com>
References: <20090526142706.20166.3813.sendpatchset@subratamodak.linux.ibm.com>
	<522C1DF17AF50042AD8AE87F7887BD3D0158B359A4@exch.hq.tensilica.com>
	<d51f89b0905262344h46722756vb255541a47904dbe@mail.gmail.com>
	<522C1DF17AF50042AD8AE87F7887BD3D0158B35AB4@exch.hq.tensilica.com>
	<1243434255.10447.19.camel@subratamodak.linux.ibm.com>
	<522C1DF17AF50042AD8AE87F7887BD3D0158B35ACE@exch.hq.tensilica.com>
	<1243601687.5188.34.camel@subratamodak.linux.ibm.com>
	<d51f89b0906010547r675533b2v2a2d36a7c07beba9@mail.gmail.com>
	<d51f89b0906020533j7881c042k1a7e43270f0aeec@mail.gmail.com>
Date: Tue, 09 Jun 2009 23:54:34 +0530
Message-Id: <1244571876.5497.16.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Detect test results more accurately
	when	generating HTML
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
To: rohit verma <rohit.170309@gmail.com>
Cc: Ltp-List <ltp-list@lists.sf.net>

On Tue, 2009-06-02 at 18:03 +0530, rohit verma wrote: 
> Patch file attached.

Thanks.

Regards--
Subrata

> 
> On Mon, Jun 1, 2009 at 6:17 PM, rohit verma <rohit.170309@gmail.com> wrote:
> > Hi Subrata,
> >
> > PFA the patch for the changes to pan driver for a possible fix to the
> > report generation issue.
> >
> > I have modified genhtml.pl script to reflect changes in pan driver.
> >
> > Note: The 'Initiation-status' column is now present after Test-output column.
> >
> > Please check the same and provide your feedback.
> >
> > Regards,
> > Rohit.
> >
> > On Fri, May 29, 2009 at 6:24 PM, Subrata Modak
> > <subrata@linux.vnet.ibm.com> wrote:
> >> On Wed, 2009-05-27 at 07:58 -0700, Marc Gauthier wrote:
> >>> Subrata Modak wrote:
> >>> > On Wed, 2009-05-27 at 05:05 -0700, Marc Gauthier wrote:
> >>> > > Just so you know, the updated genhtml.pl script recently submitted
> >>> > > should work just fine without changes, when moving status after
> >>> > > <<<execution_status>>> (it only looks at tag names, not positions).
> >>> >
> >>> > Be careful, it looks for <<<execution_status>>> only in between
> >>> > <<test_start>> & <<test_output>>.
> >>>
> >>> You mean, between <<<test_start>>> and <<<test_end>>> ?
> >>> (the script I submitted recently that is, was careful about this)
> >>
> >> You made changes in genhtml.pl. I want the change(s) in ltp-pan.c.
> >>
> >> Regards--
> >> Subrata
> >>
> >>>
> >>> -Marc
> >>
> >>
> >


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
