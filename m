Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sachinp@in.ibm.com>) id 1Nq0fe-0005o6-Sh
	for ltp-list@lists.sourceforge.net; Fri, 12 Mar 2010 08:56:38 +0000
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nq0fd-0007Yx-C6
	for ltp-list@lists.sourceforge.net; Fri, 12 Mar 2010 08:56:38 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp06.au.ibm.com (8.14.3/8.13.1) with ESMTP id o2C8uMrA020484
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Mar 2010 19:56:22 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2C8uR2p1863762
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Mar 2010 19:56:28 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2C8uR1u019649
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Mar 2010 19:56:27 +1100
Message-ID: <4B9A01B8.6040008@in.ibm.com>
Date: Fri, 12 Mar 2010 14:26:24 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
References: <4B97AA99.7050406@in.ibm.com>
	<364299f41003102015j42667189x9adbc23f48121e87@mail.gmail.com>
	<4B99CC90.90204@in.ibm.com>
	<364299f41003112333v3c9e5e7wb6160c2c59395b68@mail.gmail.com>
In-Reply-To: <364299f41003112333v3c9e5e7wb6160c2c59395b68@mail.gmail.com>
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
>> Hmm .. i am still not able to execute the test even after exporting the
>> PATH.
>>
>> lp5:/opt/ltp # export LTPROOT=/opt/ltp
>> lp5:/opt/ltp # export PATH=$PATH:$LTPROOT/testcases/bin
>> lp5:/opt/ltp # ./runltp -f containers
>> ........<SNIP>..........
>> <<<test_start>>>
>> tag=Containers stime=1268369850
>> cmdline="container_test.sh"
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> incrementing stop
>> Running netns tests.
>> --: childns.sh '/opt/ltp': No such file or directory
>>
>> I feel the problem is: the code is searching childns.sh in LTPROOT
>> directory instead of LTPROOT/testcases/bin
>>     
>
>     Please test your claim by calling env in the script -- what happens?
>     Something doesn't necessarily add up with the claim.
>   
You meant calling env from childns.sh or some other script ?

I printed env o/p (just before calling netns tests) from container_test.sh

contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
--- Start env o/p ---
LESSKEY=/etc/lesskey.bin
NNTPSERVER=news
.... SNIP ...
MAIL=/var/mail/root
PATH=/sbin:/usr/sbin:/usr/local/sbin:/root/bin:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/X11R6/bin:/usr/games:/usr/lib/mit/bin:/usr/lib/mit/sbin:/opt/ltp/testcases/bin:/opt/ltp/testcases/bin
CPU=ppc64
_=/usr/bin/env
SSH_SENDS_LOCALE=yes
INPUTRC=/etc/inputrc
PWD=/opt/ltp/testcases/bin
LANG=en_US.UTF-8
PYTHONSTARTUP=/etc/pythonstart
LTPROOT=/opt/ltp
.... SNIP ...

So the values look okay, but the run still fails.

Thanks
-Sachin

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
