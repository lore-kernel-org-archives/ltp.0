Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1XwlaR-0007W3-Ly
	for ltp-list@lists.sourceforge.net; Fri, 05 Dec 2014 05:37:51 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XwlaQ-0003De-Oy
	for ltp-list@lists.sourceforge.net; Fri, 05 Dec 2014 05:37:51 +0000
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Fri, 5 Dec 2014 00:37:45 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
	[9.57.198.25])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 3DF1C6E8046
	for <ltp-list@lists.sourceforge.net>;
	Fri,  5 Dec 2014 00:29:03 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	sB55b8mA25100290
	for <ltp-list@lists.sourceforge.net>; Fri, 5 Dec 2014 05:37:08 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	sB55b83s025565
	for <ltp-list@lists.sourceforge.net>; Fri, 5 Dec 2014 00:37:08 -0500
Received: from localhost.localdomain ([9.115.120.213])
	by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	sB55b78s025517
	for <ltp-list@lists.sourceforge.net>; Fri, 5 Dec 2014 00:37:07 -0500
Date: Fri, 5 Dec 2014 13:37:05 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20141205053705.GC2923@localhost.localdomain>
References: <20141204083400.GA2704@localhost.localdomain>
	<20141204101741.GB15326@rei.suse.de>
	<20141205014513.GB2923@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141205014513.GB2923@localhost.localdomain>
Subject: Re: [LTP] [PATCH v3] syscalls/getgroups/getgroups01: set
 supplementary groups to prevent TCONF
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

On Fri, Dec 05, 2014 at 09:45:13AM +0800, Han Pingtian wrote:
> On Thu, Dec 04, 2014 at 11:17:41AM +0100, Cyril Hrubis wrote:
> > Hi!
> > > Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
> > > ---
> > >  testcases/kernel/syscalls/getgroups/getgroups01.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/testcases/kernel/syscalls/getgroups/getgroups01.c b/testcases/kernel/syscalls/getgroups/getgroups01.c
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
> > >  	tst_sig(FORK, DEF_HANDLER, cleanup);
> > >  
> > >  	TEST_PAUSE;
> > > +
> > > +	GID_T init_gidset[3] = {0, 1, 2};
> > 
> > This should be gid_t instead of GID_T. The uppercase prototypes are for
> > raw syscalls only. The setgroups() you call is glibc wrapper instead.
> > 
> > > +	setgroups(3, init_gidset);
> > 
> > Otherwise it looks good to me.
> 
> Thanks, this is the new patch for review.

I'm sorry that there is a typo in V2. Please have a look at this:


From 1f260f261266ccddf16854c87dd72b4cf91bd745 Mon Sep 17 00:00:00 2001
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Thu, 4 Dec 2014 16:07:25 +0800
Subject: [PATCH] set supplementary groups instead of relying on system setting

On a system where root belongs to only one group, the 3# test of
getgroups01 will fail by TCONF. But if we call setgroups() to set
supplementary groups, the test can succeed if run as privileged user.

With this patch, it'll still fail by TCONF when being run by
unprivileged user.

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/getgroups/getgroups01.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/getgroups/getgroups01.c b/testcases/kernel/syscalls/getgroups/getgroups01.c
index 9fb4c98..2c1407b 100644
--- a/testcases/kernel/syscalls/getgroups/getgroups01.c
+++ b/testcases/kernel/syscalls/getgroups/getgroups01.c
@@ -74,8 +74,6 @@ int main(int ac, char **av)
 	int i;
 	int entries;
 
-	initgroups("root", 0);
-
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
@@ -183,6 +181,9 @@ static void setup(void)
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
+
+	gid_t init_gidset[3] = {0, 1, 2};
+	setgroups(3, init_gidset);
 }
 
 static void cleanup(void)
-- 
1.9.3


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
