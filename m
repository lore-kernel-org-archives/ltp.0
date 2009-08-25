Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mft10-00064H-Sp
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 10:12:34 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mft0v-0008CE-GM
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 10:12:34 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7PA4Apo030910
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 06:04:10 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7PACMWg248162
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 06:12:22 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7PACLV0027771
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 06:12:21 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A928BD0.4000508@canonical.com>
References: <20090824093204.31997.18175.sendpatchset@subratamodak.linux.ibm.com>
	<4A928BD0.4000508@canonical.com>
Date: Tue, 25 Aug 2009 15:42:19 +0530
Message-Id: <1251195139.5534.32.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 00/02] Integrate Valgrind Memory Check Tool to LTP
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
To: Paul Larson <paul.larson@canonical.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

On Mon, 2009-08-24 at 07:47 -0500, Paul Larson wrote:
> Subrata Modak wrote:
> > ./runltp -f <your-command-file> -M [1,2,3]
> Due to runltp already becoming fairly bloated, and the fact that this is

I Agree.

> really just to "test the tests", would it make sense to put it under
> /scratch or /testscripts as a separate script, rather than just include
> it as yet-another-option for runltp?

But, creating another script say under testscripts will be to duplicate
again runltp code, as the same script should be able to parse all the
options what we use with runltp. So, keeping it in runltp will just a
little overhead. And, may be we can introduce some longoptions or
manpage for ltp as suggested by people earlier !!

Regards--
Subrata

> 
> Thanks,
> Paul Larson
> 
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
