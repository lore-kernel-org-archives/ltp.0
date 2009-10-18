Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MzaOY-00008B-R9
	for ltp-list@lists.sourceforge.net; Sun, 18 Oct 2009 18:22:18 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MzaOT-0004MD-4L
	for ltp-list@lists.sourceforge.net; Sun, 18 Oct 2009 18:22:18 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9IIEnb4023902
	for <ltp-list@lists.sourceforge.net>; Sun, 18 Oct 2009 14:14:49 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9IIM7Cu230188
	for <ltp-list@lists.sourceforge.net>; Sun, 18 Oct 2009 14:22:07 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9IIM72v024028
	for <ltp-list@lists.sourceforge.net>; Sun, 18 Oct 2009 14:22:07 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40910162217w545c9108rbdac6e26fa0cf563@mail.gmail.com>
References: <8368651DACC1964480F951191B94A0780153D7BE@svexch01.mvista.com>
	<364299f40910162217w545c9108rbdac6e26fa0cf563@mail.gmail.com>
Date: Sun, 18 Oct 2009 23:51:57 +0530
Message-Id: <1255890117.5359.17.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [LTP{PATCH][fs tests] modify tests to honor tmp	directory
	passed into runltp, convert to LTP format
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
To: Henry Yei <hyei@mvista.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>


On Fri, 2009-10-16 at 22:17 -0700, Garrett Cooper wrote: 
> On Fri, Oct 16, 2009 at 1:31 PM, Henry Yei <hyei@mvista.com> wrote:
> > This is a set of patches for tests in the fs runtest file which make use of tst_tmpdir functions or alternatively, the base tmpdir set by the user. Some of the tests have been converted to LTP test format as well.
> >
> > Tests that are changed:
> > fs_di
> > fs_perms
> > lftest
> > linker01
> > quota_remount_test01
> > writetest
> 
> Note: linker01 is a bourne shell script now.

And as Garret said, and apart from that, the lftest.patch fails too:

patching file testcases/kernel/fs/lftest/lftest.c
patch: **** malformed patch at line 94: 

can't find file to patch at input line 3
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|--- ltp-20090531/testcases/kernel/fs/linktest/linktest.pl
2008-07-30 06:18:22.000000000 -0700
|+++ ltp-wdir/testcases/kernel/fs/linktest/linktest.pl  2009-07-27
20:59:55.370039414 -0700
--------------------------
File to patch: 

Regards--
Subrata

> HTH,
> -Garrett
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
