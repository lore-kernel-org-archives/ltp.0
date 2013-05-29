Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UhdsC-0006TW-N1
	for ltp-list@lists.sourceforge.net; Wed, 29 May 2013 10:44:52 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UhdsB-0005Ee-Az
	for ltp-list@lists.sourceforge.net; Wed, 29 May 2013 10:44:52 +0000
Date: Wed, 29 May 2013 06:44:43 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <577470418.347391.1369824283490.JavaMail.root@redhat.com>
In-Reply-To: <51A5D7A9.3070801@cn.fujitsu.com>
References: <51A5C347.4020202@cn.fujitsu.com>
	<1098836685.51729.1369819107988.JavaMail.root@redhat.com>
	<51A5D7A9.3070801@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] shmget/shmget01.c: cleanup and attach
 SHM_NORESERVE to shmflg
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>





----- Original Message -----
> From: "DAN LI" <li.dan@cn.fujitsu.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: "LTP list" <ltp-list@lists.sourceforge.net>
> Sent: Wednesday, 29 May, 2013 12:25:45 PM
> Subject: Re: [LTP] [PATCH] shmget/shmget01.c: cleanup and attach SHM_NORESERVE to shmflg
> 
> On 05/29/2013 05:18 PM, Jan Stancek wrote:
> > 
> > ----- Original Message -----
> >> From: "DAN LI" <li.dan@cn.fujitsu.com>
> >> To: "LTP list" <ltp-list@lists.sourceforge.net>
> >> Sent: Wednesday, 29 May, 2013 10:58:47 AM
> >> Subject: [LTP] [PATCH] shmget/shmget01.c: cleanup and attach SHM_NORESERVE
> >> to shmflg
> >>
> >>
> >> 1. Remove useless comments
> >>
> >> 2. Revise code to follow ltp-code-style
> >>
> >> 3. Add SHM_NORESERVE to shmflg to test
> > 
> > Can you add some description why you are adding this flag?
> 
> Actually, we are trying to complete test cases and expand
> the test scope of LTP.
> 
> So, it is just for completeness of this case.

My concern here is:
So if we add this flag, we cover SHM_NORESERVE path.
Do we have a testcase which still covers current non-SHM_NORESERVE path?

Regards,
Jan

> 
> Regards,
> DAN LI
> 
> > 
> >>
> >> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
> >> ---
> > 
> > 
> 
> 
> 

------------------------------------------------------------------------------
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
Get 100% visibility into your production application - at no cost.
Code-level diagnostics for performance bottlenecks with <2% overhead
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
