Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1X42mK-0003d8-Ep
	for ltp-list@lists.sourceforge.net; Mon, 07 Jul 2014 06:51:56 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X42mI-0004n4-MB
	for ltp-list@lists.sourceforge.net; Mon, 07 Jul 2014 06:51:56 +0000
Received: from /spool/local
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Mon, 7 Jul 2014 00:51:48 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
	(b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 227A419D8026
	for <ltp-list@lists.sourceforge.net>;
	Mon,  7 Jul 2014 00:51:38 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by b03cxnp07029.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id s674mBEj11338190
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Jul 2014 06:48:11 +0200
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP
	id s676pl3K022988
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Jul 2014 00:51:47 -0600
Received: from localhost.localdomain ([9.125.26.118])
	by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	s676pkQq022941
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Jul 2014 00:51:46 -0600
Date: Mon, 7 Jul 2014 14:51:40 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20140707065140.GA4421@localhost.localdomain>
References: <20140704031641.GA20446@localhost.localdomain>
	<53BB90C6.9020101@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53BB90C6.9020101@cn.fujitsu.com>
Subject: Re: [LTP] [RFC PATCH] regression test for 64bit sendfile capped at
	2G
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
To: LTP <ltp-list@lists.sourceforge.net>

On Tue, Jul 08, 2014 at 02:33:42PM +0800, Xiaoguang Wang wrote:
> Hi,
> 
> On 07/04/2014 11:16 AM, Han Pingtian wrote:
> > Hi,
> > 
> > Please review this patch. Thanks.
> > 
> > There is a bug on 64bit sendfile() with large file, please see
> > https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-June/118128.html
> > for details.
> 
> I'd like to ask an irrelevant question about that where can we get such bug report or similar issues
> about syscalls from a stable place(url), or how did you found this issue, thanks.
> 
> Give that currently there are 1039 test cases about syscalls in LTP(cat runtest/syscalls | grep -v "^#" | sed -e '/^$/d' | wc -l),
> we can tell that syscalls is a very big test suite in LTP, so I'd like to add all similar regression test about
> syscalls to LTP, which will expand ltp's test coverage, thanks. 
> 
> Regards,
> Xiaoguang Wang
> 
Thanks for your reply. I knew this problem just by accidental. It wasn't
found by me, but someone else. We are asked why we couldn't find it at
first time though we had run ltp to test the syscalls. So I think it
would be better to include a regession test for it to ltp. I think we
can find out all those regressions by mointoring bug report web site and
kernel's mailing list and something like these.


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
