Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Xwnec-0000iN-IK
	for ltp-list@lists.sourceforge.net; Fri, 05 Dec 2014 07:50:18 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xwnea-00024z-Nh
	for ltp-list@lists.sourceforge.net; Fri, 05 Dec 2014 07:50:18 +0000
Date: Fri, 5 Dec 2014 02:50:05 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <2030725285.13714260.1417765805467.JavaMail.zimbra@redhat.com>
In-Reply-To: <20141205013722.GA2923@localhost.localdomain>
References: <20141204083400.GA2704@localhost.localdomain>
	<20141204101741.GB15326@rei.suse.de>
	<390870174.13092868.1417689854590.JavaMail.zimbra@redhat.com>
	<20141205013722.GA2923@localhost.localdomain>
MIME-Version: 1.0
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
To: Han Pingtian <hanpt@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Han Pingtian" <hanpt@linux.vnet.ibm.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Friday, 5 December, 2014 2:37:22 AM
> Subject: Re: [LTP] [PATCH] syscalls/getgroups/getgroups01: set supplementary groups to prevent TCONF
> 
> On Thu, Dec 04, 2014 at 05:44:14AM -0500, Jan Stancek wrote:
> > ----- Original Message -----
> > > From: "Cyril Hrubis" <chrubis@suse.cz>
> > > To: ltp-list@lists.sourceforge.net
> > > Sent: Thursday, 4 December, 2014 11:17:41 AM
> > > Subject: Re: [LTP] [PATCH] syscalls/getgroups/getgroups01: set
> > > supplementary groups to prevent TCONF
> > > 
> > > Hi!
> > > > Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
> > > > ---
> > > >  testcases/kernel/syscalls/getgroups/getgroups01.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/testcases/kernel/syscalls/getgroups/getgroups01.c
> > > > b/testcases/kernel/syscalls/getgroups/getgroups01.c
> > > > index 9fb4c98..28559d3 100644
> > > > --- a/testcases/kernel/syscalls/getgroups/getgroups01.c
> > > > +++ b/testcases/kernel/syscalls/getgroups/getgroups01.c
> > > > @@ -74,8 +74,6 @@ int main(int ac, char **av)
> > > >  	int i;
> > > >  	int entries;
> > > >  
> > > > -	initgroups("root", 0);
> > > > -
> > > >  	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
> > > >  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> > > >  
> > > > @@ -183,6 +181,9 @@ static void setup(void)
> > 
> > I'd add tst_require_root() to setup, since setgroups() requires CAP_SETGID.
> 
> I think getgroups() doesn't need privileged power, so we shouldn't limit
> this case with tst_require_root, because this case is testing
> getgroups(). With this patch applied, if run by unprivileged user, 3#
> will fail by TCONF, but other tests will pass.

OK, looks like initgroups is implemented via setgroups, so this
was failing silently before as well.

Regards,
Jan

> 
> Thanks.
> 
> 
> ------------------------------------------------------------------------------
> Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
> from Actuate! Instantly Supercharge Your Business Reports and Dashboards
> with Interactivity, Sharing, Native Excel Exports, App Integration & more
> Get technology previously reserved for billion-dollar corporations, FREE
> http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

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
