Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1XwhqA-0004Tz-N8
	for ltp-list@lists.sourceforge.net; Fri, 05 Dec 2014 01:37:50 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xwhq9-0006Fr-Mu
	for ltp-list@lists.sourceforge.net; Fri, 05 Dec 2014 01:37:50 +0000
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Thu, 4 Dec 2014 20:37:44 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
	[9.57.198.29])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 43E746E803F
	for <ltp-list@lists.sourceforge.net>;
	Thu,  4 Dec 2014 20:29:37 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	sB51bgbP24772768
	for <ltp-list@lists.sourceforge.net>; Fri, 5 Dec 2014 01:37:42 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	sB51bg6n005423
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Dec 2014 20:37:42 -0500
Received: from localhost.localdomain ([9.115.120.213])
	by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	sB51bfe3005352
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Dec 2014 20:37:42 -0500
Date: Fri, 5 Dec 2014 09:37:22 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20141205013722.GA2923@localhost.localdomain>
References: <20141204083400.GA2704@localhost.localdomain>
	<20141204101741.GB15326@rei.suse.de>
	<390870174.13092868.1417689854590.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <390870174.13092868.1417689854590.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] syscalls/getgroups/getgroups01: set supplementary
 groups to prevent TCONF
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

On Thu, Dec 04, 2014 at 05:44:14AM -0500, Jan Stancek wrote:
> ----- Original Message -----
> > From: "Cyril Hrubis" <chrubis@suse.cz>
> > To: ltp-list@lists.sourceforge.net
> > Sent: Thursday, 4 December, 2014 11:17:41 AM
> > Subject: Re: [LTP] [PATCH] syscalls/getgroups/getgroups01: set supplementary groups to prevent TCONF
> > 
> > Hi!
> > > Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
> > > ---
> > >  testcases/kernel/syscalls/getgroups/getgroups01.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/testcases/kernel/syscalls/getgroups/getgroups01.c
> > > b/testcases/kernel/syscalls/getgroups/getgroups01.c
> > > index 9fb4c98..28559d3 100644
> > > --- a/testcases/kernel/syscalls/getgroups/getgroups01.c
> > > +++ b/testcases/kernel/syscalls/getgroups/getgroups01.c
> > > @@ -74,8 +74,6 @@ int main(int ac, char **av)
> > >  	int i;
> > >  	int entries;
> > >  
> > > -	initgroups("root", 0);
> > > -
> > >  	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
> > >  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> > >  
> > > @@ -183,6 +181,9 @@ static void setup(void)
> 
> I'd add tst_require_root() to setup, since setgroups() requires CAP_SETGID.

I think getgroups() doesn't need privileged power, so we shouldn't limit
this case with tst_require_root, because this case is testing
getgroups(). With this patch applied, if run by unprivileged user, 3#
will fail by TCONF, but other tests will pass.

Thanks.


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
