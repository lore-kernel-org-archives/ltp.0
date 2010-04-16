Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1O2bW5-0000c2-Ns
	for ltp-list@lists.sourceforge.net; Fri, 16 Apr 2010 02:42:49 +0000
Received: from out03.sjc.mx.trendmicro.com ([216.99.131.7])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O2bW4-00039G-Fa
	for ltp-list@lists.sourceforge.net; Fri, 16 Apr 2010 02:42:49 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000001cadad6$c061c590$412550b0$@co.jp>	<4BC487C9.9080300@xenotime.net>	<000901cadb78$a2d05080$e870f180$@co.jp>	<g2p364299f41004132317v539c2b02g3eea49dc830cea0f@mail.gmail.com>	<000601cadbb0$9fb8b5d0$df2a2170$@co.jp>
	<20100414081953.7356b407.rdunlap@xenotime.net>
In-Reply-To: <20100414081953.7356b407.rdunlap@xenotime.net>
Date: Fri, 16 Apr 2010 11:42:39 +0900
Message-ID: <000001cadd0e$7b35e250$71a1a6f0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] [PATCH] fix "hugetlb" several tests
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
To: 'Randy Dunlap' <rdunlap@xenotime.net>
Cc: ltp-list@lists.sourceforge.net


> -----Original Message-----
> From: Randy Dunlap [mailto:rdunlap@xenotime.net]
> Sent: Thursday, April 15, 2010 12:20 AM
> To: Mitani
> Cc: 'Garrett Cooper'; ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] [PATCH] fix "hugetlb" several tests
> 
> On Wed, 14 Apr 2010 17:58:17 +0900 Mitani wrote:
> 
> > Hi,
> >
> > I suggest new patch.
> >
> > Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
> 
> This one is OK with me also, but...
> 
> Is it possible to determine the difference between a kernel that does
> not support hugepages at all and a kernel that does support hugepages
> but just does not have enough of them allocated?
> 
> or maybe we don't care about this difference.  Do we?
> 


I cannot give a good opinion because I'm not a creator of these test 
programs, but ...
I think that the difference of test refusal reason isn't so important.
How about following message? :
------------
Not support Hugepages or not enough available Hugepages
------------

If users read above message, they will examine a reason by themselves 
and will do appropriate measures (set an enough hugepages value or 
gave up this test), I think.


Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
