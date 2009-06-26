Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MK9jf-0006yU-Li
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2009 11:36:51 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MK9je-0005Tw-RR
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2009 11:36:51 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5QBTORF003865
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Jun 2009 05:29:24 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5QBan5O223094
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Jun 2009 05:36:49 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5QBanqv008803
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Jun 2009 05:36:49 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A4457BB.9090304@tataelxsi.co.in>
References: <4A4457BB.9090304@tataelxsi.co.in>
Date: Fri, 26 Jun 2009 17:03:11 +0530
Message-Id: <1246015991.6196.23.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] LTP Tests Coverage
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
To: ananthakrishnan@tataelxsi.co.in
Cc: ltp-list@lists.sourceforge.net

On Fri, 2009-06-26 at 10:38 +0530, Ananthakrishnan wrote: 
> Hi
>  From my understanding of LTP , i could imagine that the LTP performs 
> tests on the filesystem,Schedulers,Memory Management,IPC Mechanisms 
> etc... Is my understanding correct?Kindly correct me if i am wrong. If i 

Yes, it is correct. And it tests much more than that.

> am right can you brief me about the various tests LTP performs on the 
> filesystem , Schedulers,Memory Management , IPC Mechanisms.

No, direct documentation. However, you can scan:
1) ltp source code and the directories/sub-directories in it,
http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/,
2) LTP home page for more technical papers, etc.
http://ltp.sourceforge.net/,

Regards--
Subrata

> 
> With Regards
> Ananth
> 
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
