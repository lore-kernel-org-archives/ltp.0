Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sachinp@in.ibm.com>) id 1Npx8A-0002Ze-Ro
	for ltp-list@lists.sourceforge.net; Fri, 12 Mar 2010 05:09:50 +0000
Received: from e23smtp03.au.ibm.com ([202.81.31.145])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Npx88-0005qW-3a
	for ltp-list@lists.sourceforge.net; Fri, 12 Mar 2010 05:09:50 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp03.au.ibm.com (8.14.3/8.13.1) with ESMTP id o2C56Va5025643
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Mar 2010 16:06:31 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2C59cIS1818700
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Mar 2010 16:09:38 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2C59bsD024980
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Mar 2010 16:09:38 +1100
Message-ID: <4B99CC90.90204@in.ibm.com>
Date: Fri, 12 Mar 2010 10:39:36 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
References: <4B97AA99.7050406@in.ibm.com>
	<364299f41003102015j42667189x9adbc23f48121e87@mail.gmail.com>
In-Reply-To: <364299f41003102015j42667189x9adbc23f48121e87@mail.gmail.com>
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
> On Wed, Mar 10, 2010 at 6:20 AM, Sachin Sant <sachinp@in.ibm.com> wrote:
>   
>> NETNS tests from containers fails to execute with following
>> message
>>
>> Running netns tests.
>> --: childns.sh '/opt/ltp': No such file or directory
>>
>> Looking at the code the problem could be with create_net_namespace()
>> within netns/common.c
>>
>> If i make the following changes the first subtest works fine but then
>> i ran into other failures related to other sub tests.
>>
>> @@ -92,7 +92,7 @@ int create_net_namespace(char *p1, char
>>       }
>>
>>       /* We need to pass the child pid to the parentns.sh script */
>> -       sprintf(par, "parentns.sh '%s' %s %" PRId32 , ltproot, p1, pid);
>> +       sprintf(par, "%s/testcases/bin/parentns.sh %s %" PRId32 , ltproot,
>> p1, pid);
>>
>>       ret = system(par);
>>       status = WEXITSTATUS(ret);
>> @@ -141,7 +141,7 @@ int child_fn(void *c1)
>>               exit(1);
>>       }
>>
>> -       sprintf(child, "childns.sh '%s'", ltproot);
>> +       sprintf(child, "%s/testcases/bin/childns.sh", ltproot);
>>
>> As i don't know the code too much .. i am not sure how to fix it.
>>     
>
> export PATH=$PATH:$LTPROOT/testcases/bin ; parentns.sh ?
>
> Why are you overcomplicating things by hardcoding the path again?
> That's the exact reason why it was removed in the first place...
>   
Hmm .. i am still not able to execute the test even after exporting the
PATH.

lp5:/opt/ltp # export LTPROOT=/opt/ltp
lp5:/opt/ltp # export PATH=$PATH:$LTPROOT/testcases/bin
lp5:/opt/ltp # ./runltp -f containers
 ........<SNIP>..........
<<<test_start>>>
tag=Containers stime=1268369850
cmdline="container_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
Running netns tests.
--: childns.sh '/opt/ltp': No such file or directory

I feel the problem is: the code is searching childns.sh in LTPROOT
directory instead of LTPROOT/testcases/bin

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
