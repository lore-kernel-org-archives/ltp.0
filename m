Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Njqs2-0007oT-Bc
	for ltp-list@lists.sourceforge.net; Tue, 23 Feb 2010 09:15:58 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Njqs0-0007IA-2Y
	for ltp-list@lists.sourceforge.net; Tue, 23 Feb 2010 09:15:58 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1N9BpLp018296
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Feb 2010 04:11:51 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1N9Fmcn1581086
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Feb 2010 04:15:48 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1N9FlED019916
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Feb 2010 04:15:48 -0500
Message-ID: <4B839CBB.8090500@linux.vnet.ibm.com>
Date: Tue, 23 Feb 2010 14:45:39 +0530
From: Subrata Modak <subrata@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <EB1A7C66AD0C92419BFFC785A947865A09EA8C4BD6@BLRINMSMBX01.bglrodc.lntinfotech.com>
In-Reply-To: <EB1A7C66AD0C92419BFFC785A947865A09EA8C4BD6@BLRINMSMBX01.bglrodc.lntinfotech.com>
Subject: Re: [LTP] Device Driver Test cases for LTP
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
To: Silesh Vellattu <Silesh.Vellattu@lntinfotech.com>
Cc: ltp-list@lists.sourceforge.net, Arun Sudhilal <Arun.Sudhilal@lntinfotech.com>, Mohamed Rasheed <Mohamed.Rasheed@lntinfotech.com>

Silesh Vellattu wrote:
> Hi Subrata ,
>
>      We have been using LTP to test our kernel releases.Thanks for integrating such a test suite.But we can see that there are only limited number of interfaces (usb and V4L2) covered in the device driver test cases. We have  some test cases covering Audio  and RTC  which we have been using along with LTP and  we would like to contribute them to the LTP community.We have already integrated them to the LTP framework in a very generic  way. We also have plans to work on some other interfaces to make our testing process better.We would like to contribute those tests also as and when they are ready. Suggestions on how these test cases have to be written/ organised and how they can be integrated with LTP?
>   

That's great. Just go ahead and submit a patch along with the test 
results. Make the documentation clear of how to build/install and run 
those tests. Rishi will help you in integrating the same to LTP.

Regards--
Subrata

> Thanks and Warm Regards,
> Silesh.
>
> This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.
>
> ______________________________________________________________________
>   



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
