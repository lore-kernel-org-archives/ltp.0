Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1USOAp-0001Xv-1V
	for ltp-list@lists.sourceforge.net; Wed, 17 Apr 2013 08:57:03 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1USOAl-0001JI-BT
	for ltp-list@lists.sourceforge.net; Wed, 17 Apr 2013 08:57:03 +0000
Date: Wed, 17 Apr 2013 04:56:44 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <1121191719.1741118.1366189004522.JavaMail.root@redhat.com>
In-Reply-To: <516E5ED8.10909@gmail.com>
References: <516E2E6C.2000408@gmail.com>
	<849990288.1414874.1366184255066.JavaMail.root@redhat.com>
	<516E5ED8.10909@gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH V2] Fix short of nodemask array.
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
To: Lans Zhang <lans.zhang2008@gmail.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Lans Zhang" <lans.zhang2008@gmail.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: "Zhouping Liu" <zliu@redhat.com>, "Wanlong Gao" <gaowanlong@cn.fujitsu.com>, ltp-list@lists.sourceforge.net
> Sent: Wednesday, April 17, 2013 4:35:36 PM
> Subject: Re: [LTP][PATCH V2] Fix short of nodemask array.
> 
> On 04/17/2013 03:37 PM, Jan Stancek wrote:
> >
> >
> >
> >
> > ----- Original Message -----
> >> From: "Lans Zhang"<lans.zhang2008@gmail.com>
> >> To: "Zhouping Liu"<zliu@redhat.com>, "Jan Stancek"<jstancek@redhat.com>
> >> Cc: "Wanlong Gao"<gaowanlong@cn.fujitsu.com>,
> >> ltp-list@lists.sourceforge.net
> >> Sent: Wednesday, 17 April, 2013 7:09:00 AM
> >> Subject: [LTP][PATCH V2] Fix short of nodemask array.
> >>
> >> Changes since V1:
> >> 1. Enhance patch header.
> >> 2. Use BITS_PER_LONG and set_node() to simplify the logic.
> >>
> >> In kernel, if user specified more nodes, e.g, 512 nodes, than the
> >> supported, e.g, 4 nodes, kernel will check if the non supported
> >> part, e.g, 508 nodes, is all zeroed in node bitmap. Currently, we
> >> are overrunning "nmask", whose length is shorter than MAXNODES,
> >> and where the unsupported bits should be cleared to pass the check.
> >>
> >> Signed-off-by: Lans Zhang<lans.zhang2008@gmail.com>
> >
> > Hi,
> >
> > 'v' should be probably dropped here, since it's not used and rest
> > of patch uses 2 parameters anyway:
> >
> >> +static inline void set_node(unsigned long *array, unsigned int node,
> >> +                            unsigned int v)
> >> +{
> >> +	array[node / BITS_PER_LONG] |= 1UL<<  (node % BITS_PER_LONG);
> >> +}
> >>
> >
> > Other than that, it looks good to me.
> 
> I will send a V3 if Zhouping Liu also gatekeep V2 except this minor
> change.

I'm also fine for the rest.
just one reminder: commit 0b3419364 modified lib/mem.c, which caused conflicts
with your patch, please prepare a new patch based on the latest tree, in order
to push it easily for maintainer.

-- 
Thanks,
Zhouping

------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
