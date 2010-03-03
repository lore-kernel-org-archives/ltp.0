Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sachinp@in.ibm.com>) id 1NmqNl-0004ll-Dq
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 15:21:05 +0000
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NmqNi-0003jN-T7
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 15:21:05 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id o23FKtxH027318
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Mar 2010 02:20:55 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o23FFLYO1024110
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Mar 2010 02:15:21 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o23FKtjM011940
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Mar 2010 02:20:55 +1100
Received: from sachinp.in.ibm.com ([9.77.214.27])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o23FKrZh011931
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Mar 2010 02:20:54 +1100
Message-ID: <4B8E7E53.3010907@in.ibm.com>
Date: Wed, 03 Mar 2010 20:50:51 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
References: <4B8E3C08.2080901@in.ibm.com>
	<20100303105028.GC23601@linux.vnet.ibm.com>
In-Reply-To: <20100303105028.GC23601@linux.vnet.ibm.com>
Subject: Re: [LTP] Version file from Feb LTP release still contains 20100131
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
To: ltp-list@lists.sourceforge.net

Rishikesh K Rajak wrote:
> On Wed, Mar 03, 2010 at 04:08:00PM +0530, Sachin Sant wrote:
>   
>> Not a major issue, but noticed something with latest LTP tarball
>> from Feb.
>>     
>
> Actually the script design is like that, it will update the version file
> once you compiled and build, reading from Changelog.
>
> Can you confirm if you are not having Changelog starting from :
> LTP-20100228 .
>
> Mostly it will not be there as you would have extracted next branch. But
> it will be always available with master branch.
>   
Ah thanks for the explanation. I took a fresh copy of Feb LTP and the version
did show 20100228.

Thanks
-Sachin

> Thanks
> Rishi
>   
>> The Version file still contains 20100131.
>>
>> :/home/sachin/work # cat ltp-full-20100228/Version LTP-20100131
>> :/home/sachin/work #
>>
>> Should this be 20100228 ?
>>
>>     


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------


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
