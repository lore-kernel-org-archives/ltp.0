Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1XwhxW-00053D-8A
	for ltp-list@lists.sourceforge.net; Fri, 05 Dec 2014 01:45:26 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XwhxV-0006T7-7e
	for ltp-list@lists.sourceforge.net; Fri, 05 Dec 2014 01:45:26 +0000
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Thu, 4 Dec 2014 18:45:19 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
	(b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 8E0743E4003F
	for <ltp-list@lists.sourceforge.net>;
	Thu,  4 Dec 2014 18:45:16 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id sB51jwpM48038086
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Dec 2014 18:45:58 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP
	id sB51jGQN026681
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Dec 2014 18:45:16 -0700
Received: from localhost.localdomain ([9.115.120.213])
	by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	sB51jFQl026587
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Dec 2014 18:45:15 -0700
Date: Fri, 5 Dec 2014 09:45:13 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20141205014513.GB2923@localhost.localdomain>
References: <20141204083400.GA2704@localhost.localdomain>
	<20141204101741.GB15326@rei.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141204101741.GB15326@rei.suse.de>
Subject: Re: [LTP] [PATCH v2] syscalls/getgroups/getgroups01: set
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

On Thu, Dec 04, 2014 at 11:17:41AM +0100, Cyril Hrubis wrote:
> Hi!
> > Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
> > ---
> >  testcases/kernel/syscalls/getgroups/getgroups01.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/testcases/kernel/syscalls/getgroups/getgroups01.c b/testcases/kernel/syscalls/getgroups/getgroups01.c
> > index 9fb4c98..28559d3 100644
> > --- a/testcases/kernel/syscalls/getgroups/getgroups01.c
> > +++ b/testcases/kernel/syscalls/getgroups/getgroups01.c
> > @@ -74,8 +74,6 @@ int main(int ac, char **av)
> >  	int i;
> >  	int entries;
> >  
> > -	initgroups("root", 0);
> > -
> >  	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
> >  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> >  
> > @@ -183,6 +181,9 @@ static void setup(void)
> >  	tst_sig(FORK, DEF_HANDLER, cleanup);
> >  
> >  	TEST_PAUSE;
> > +
> > +	GID_T init_gidset[3] = {0, 1, 2};
> 
> This should be gid_t instead of GID_T. The uppercase prototypes are for
> raw syscalls only. The setgroups() you call is glibc wrapper instead.
> 
> > +	setgroups(3, init_gidset);
> 
> Otherwise it looks good to me.

Thanks, this is the new patch for review.


From 261b475fe4ecf8572003b0c444394b67feb0c781 Mon Sep 17 00:00:00 2001
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
index 9fb4c98..02c8ce0 100644
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
+	git_t init_gidset[3] = {0, 1, 2};
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
