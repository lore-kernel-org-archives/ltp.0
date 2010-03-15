Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sachinp@in.ibm.com>) id 1Nr4LR-0007dW-Iu
	for ltp-list@lists.sourceforge.net; Mon, 15 Mar 2010 07:04:09 +0000
Received: from e28smtp02.in.ibm.com ([122.248.162.2])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nr4LP-0001XZ-9u
	for ltp-list@lists.sourceforge.net; Mon, 15 Mar 2010 07:04:09 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp02.in.ibm.com (8.14.3/8.13.1) with ESMTP id o2F73uKg005895
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Mar 2010 12:33:56 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2F73uog2625588
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Mar 2010 12:33:56 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2F73um6001520
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Mar 2010 12:33:56 +0530
Message-ID: <4B9DDBDB.7090801@in.ibm.com>
Date: Mon, 15 Mar 2010 12:33:55 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
References: <4B97AA99.7050406@in.ibm.com>
	<364299f41003102015j42667189x9adbc23f48121e87@mail.gmail.com>
	<4B99CC90.90204@in.ibm.com>
	<364299f41003112333v3c9e5e7wb6160c2c59395b68@mail.gmail.com>
	<4B9A01B8.6040008@in.ibm.com>
	<364299f41003120832g4efc1136sf430dd0bd8f831cd@mail.gmail.com>
In-Reply-To: <364299f41003120832g4efc1136sf430dd0bd8f831cd@mail.gmail.com>
Subject: Re: [LTP] LTP Containers netns test failure.
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Garrett Cooper wrote:
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> incrementing stop
>> --- Start env o/p ---
>> LESSKEY=/etc/lesskey.bin
>> NNTPSERVER=news
>> .... SNIP ...
>> MAIL=/var/mail/root
>> PATH=/sbin:/usr/sbin:/usr/local/sbin:/root/bin:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/X11R6/bin:/usr/games:/usr/lib/mit/bin:/usr/lib/mit/sbin:/opt/ltp/testcases/bin:/opt/ltp/testcases/bin
>> CPU=ppc64
>> _=/usr/bin/env
>> SSH_SENDS_LOCALE=yes
>> INPUTRC=/etc/inputrc
>> PWD=/opt/ltp/testcases/bin
>> LANG=en_US.UTF-8
>> PYTHONSTARTUP=/etc/pythonstart
>> LTPROOT=/opt/ltp
>> .... SNIP ...
>>
>> So the values look okay, but the run still fails.
>>     
>
>     Could you also add a check within childns.sh please?
>   
As the LTP framework is unable to locate childns.sh script(as per the error
message) i cannot print anything from within childns.sh. This script is
never invoked during the run.

Thanks
-Sachin

> Thanks,
> -Garrett
>
>   


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
