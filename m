Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NSo5F-0000FT-Ie
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 08:51:09 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NSo5E-0001uF-I8
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 08:51:09 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o078ngRU031457
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 01:49:42 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o078oxbO169740
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 01:50:59 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o078owKc031387
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 01:50:59 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <d270b4400912250122y371c4d4dq6fa729b60e03f8a5@mail.gmail.com>
References: <d270b4400912250122y371c4d4dq6fa729b60e03f8a5@mail.gmail.com>
Date: Thu, 07 Jan 2010 14:20:54 +0530
Message-Id: <1262854254.12213.9.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Testcase to validate the memory usage limit imposed
	by	the topmost memory cgroup
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
To: Mohamed Naufal <naufal11@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, 2009-12-25 at 14:52 +0530, Mohamed Naufal wrote:
> Hi
> 
> I am a student who attended the FOSS.IN LTP workout (Bangalore,
> India). I have attached one of the testcases we were working on.
> Thought I would get it reviewed before making a patch. More testcases
> to follow.
> 
> Comments appreciated.

Seems that the Script is trying to test some Memory Controllers.
However, i am not sure about the C program. Can you please try to
improve the documentation and see if you can fit you controller test
somewhere inside ltp/testcases/kernel/controllers/ ?

Regards--
Subrata

> 
> Naufal 
> ------------------------------------------------------------------------------
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast and easy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev 
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
