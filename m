Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mxh3T-0001JA-G9
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 13:04:43 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mxh3N-0002PB-8Q
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 13:04:43 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9DC9Kgn021753
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 06:09:20 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9DCDX6W190364
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 06:13:33 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9DCDWcv009121
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 06:13:32 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <73cd086a0909290032o7f60b80buf41f1426bf5b3013@mail.gmail.com>
References: <73cd086a0909290032o7f60b80buf41f1426bf5b3013@mail.gmail.com>
Date: Tue, 13 Oct 2009 17:43:29 +0530
Message-Id: <1255436009.8438.32.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] false success for exp test.
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
To: Pavel Kiryukhin <vksavl@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, 2009-09-29 at 11:32 +0400, Pavel Kiryukhin wrote: 
> Hi,
> if I get it right there is error in
> ltp-full-20090831/testcases/misc/math/float/exp_log/genexp.c (see
> genexp_resfile.patch)
> Resulting file exp_out.ref is wrong, but it is not catch by test -
> nan_compare.patch make correct nan comparison.

Thanks.

Regards--
Subrata

> --
> Regards,
> Pavel Kiryukhin
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
> http://p.sf.net/sfu/devconf
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


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
