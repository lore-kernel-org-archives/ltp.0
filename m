Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1XwhqD-0004mF-L0
	for ltp-list@lists.sourceforge.net; Fri, 05 Dec 2014 01:37:53 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XwhqC-0005cj-FD
	for ltp-list@lists.sourceforge.net; Fri, 05 Dec 2014 01:37:53 +0000
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Thu, 4 Dec 2014 20:37:46 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
	[9.57.198.23])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id B9CB46E8040
	for <ltp-list@lists.sourceforge.net>;
	Thu,  4 Dec 2014 20:29:37 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	sB51bhTu28442750
	for <ltp-list@lists.sourceforge.net>; Fri, 5 Dec 2014 01:37:43 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	sB51bfSY003314
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Dec 2014 20:37:42 -0500
Received: from localhost.localdomain ([9.115.120.213])
	by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	sB51beao003209
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Dec 2014 20:37:41 -0500
Date: Sat, 29 Nov 2014 21:29:40 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20141129132940.GA2715@localhost.localdomain>
References: <20141031133917.GA3195@localhost.localdomain>
	<54608048.4000201@oracle.com>
	<20141113075747.GA19392@localhost.localdomain>
	<546C51BA.5060304@oracle.com>
	<20141121075923.GA2804@localhost.localdomain>
	<5473466C.2070409@oracle.com>
	<20141128083341.GD16235@localhost.localdomain>
	<5478972F.5030503@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5478972F.5030503@oracle.com>
Subject: Re: [LTP] [PATCH v2] fix some syscall tests for 16-bit
	compat	testing
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

On Fri, Nov 28, 2014 at 06:39:27PM +0300, Stanislav Kholmanskikh wrote:
> 
> 
> On 11/28/2014 11:33 AM, Han Pingtian wrote:
> > On Mon, Nov 24, 2014 at 05:53:32PM +0300, Stanislav Kholmanskikh wrote:
> >> Hi.
> >>
> >> In general, it looks good.
> >>
> >> I have only one comment, that it's possible that the uid/gid values we pass
> >> to the syscall may not fit into UID_T/GID_T. For example, when we get uid of
> >> nobody user in runtime and pass it to chown() or etc.
> >>
> >> Yes, it's more like an artificial case, but it's.
> >>
> >> We have UID16_CHECK and GID16_CHECK macros to check if the uid/gid fits the
> >> compat mode.
> >>
> >> What do you think about using it in test cases chown01, chown03, chown04,
> >> fchown01, fchown03, fchown04, setresgid*, setresuid* ?
> >>
> >> Thank you.
> >
> > Please review new patch which included UID16_CHECK and GID16_CHECK.
> >
> > Thanks.
> 
> Hi!
> 
> I pushed your patch with TCID_DEFINE added (overlooked it at that time), 
> and also pushed a follow-up patch which:
>   * fixes setresuid02_16, setresuid03_16, setresuid04_16 - they do 
> testing inside their children.
>   * explicitly declares setresuid(), setresgid() in compat_16.h. This is 
> to manage compilation warnings.
> 
> Tested in OL6 with 2.6.39-400.215.11.el6uek.x86_64 and 
> 2.6.39-400.214.5.el6uek.i686 kernels.
> 
> Thank you.
> 
Thanks!


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
