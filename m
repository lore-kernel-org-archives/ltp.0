Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N2PbM-00088Y-HR
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 13:27:12 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N2PbG-0007qn-G9
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 13:27:12 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9QDPQW5017717
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Oct 2009 09:25:27 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9QDR06w082488
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Oct 2009 09:27:00 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9QDR0c8027370
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Oct 2009 09:27:00 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4AE54F96.7060502@cn.fujitsu.com>
References: <4AE54BCA.7060104@cn.fujitsu.com> <4AE54F96.7060502@cn.fujitsu.com>
Date: Mon, 26 Oct 2009 18:56:55 +0530
Message-Id: <1256563615.4929.37.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Add new testcases for ext4 new features - V3
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
To: Miao Xie <miaox@cn.fujitsu.com>
Cc: LTP-ML <ltp-list@lists.sourceforge.net>, Bhaskar Rangaswamy <bharanga@in.ibm.com>, "iranna.ankad" <iranna.ankad@in.ibm.com>, pradeepkumars <pradeepkumars@in.ibm.com>, "santwana.samantray" <santwana.samantray@in.ibm.com>

On Mon, 2009-10-26 at 16:28 +0900, Miao Xie wrote: 
> Hi, Mr.Subrata
> 
> The patch that you made to fix the problem of ffsb was not merged into
> this patch. So if you want to run this testcases, you must applied your
> patch before compiling the testcases.
> 
> Regards.
> Miao
> 
> on 2009-10-26 16:12, Miao Xie wrote:
> > This is the patch of testcases for the ext4 new features test.
> > It contains multi-block alloc/delayed alloc test, inode version test,
> > journal checksumming test, nanosec timestamps test, online defrag test,
> > persist prealloc test, subdirectory limit test and uninit groups test
> > of ext4.
> > 
> > In this test suite, there is two FAIL in the subdirectory limit test.
> > It is because we cann't create more than 32000 subdirectory when block
> > size is small, such as 1024, and the name of every subdirectory is very
> > long, such as every name is 255 bytes. I think it is the bug of the ext4.
> > 
> > Note: Your MUST run configure in the directory
> >     testcases/kernel/fs/ext4-new-features
> >       to config the tool of ffsb, and specify a partition to be used for 
> > test
> >       before compiling the tool. The data on the specified partition 
> > would be
> >       DESTROYED.
> > 
> > Signed-off-by: Miao Xie <miaox@cn.fujitsu.com>

Thank you so much on making this effort to include the EXT4 test cases
in LTP. We were actually long searching for such tests which will test
only the specific features of EXT4. And now we have it. I have included
your tests in LTP which is readily available now in LTP repository.

I will soon send out a mail to some EXT4 experts regarding the
sub-directory tests failure and get some opinion of them.

Regards--
Subrata

> 
> 
> 
> 
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry(R) Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9 - 12, 2009. Register now!
> http://p.sf.net/sfu/devconference
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
