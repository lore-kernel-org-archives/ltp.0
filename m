Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shiwh@cn.fujitsu.com>) id 1MgSVp-0003Dw-Ko
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 00:06:45 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MgSVh-0000g7-JF
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 00:06:45 +0000
Message-ID: <4A95CDEE.2040103@cn.fujitsu.com>
Date: Thu, 27 Aug 2009 08:06:06 +0800
From: Shi Weihua <shiwh@cn.fujitsu.com>
MIME-Version: 1.0
References: <4A947C25.5090809@cn.fujitsu.com>
	<20090826152844.GL8078@count0.beaverton.ibm.com>
In-Reply-To: <20090826152844.GL8078@count0.beaverton.ibm.com>
Subject: Re: [LTP] [PATCH] Add new testcases for cgroup
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
To: Matt Helsley <matthltc@us.ibm.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Matt Helsley wrote:
> On Wed, Aug 26, 2009 at 08:04:53AM +0800, Shi Weihua wrote:
>> We has created some testcases for cgroup in the last year. 
>> There are total 194 testcases that have been added. These testcases contain 
>> the basis operation test, part functionality test and stress test of cgroup.
>>
>> How to run this test:
>> 	# runltp -f controllers
>>
>> Result:
>> Now, we start the test for cgroup...
>> cgroup_test_fj    1  TPASS  :  case1(function   1 1 1 1 1 2 3 2 1)    PASS
>> cgroup_test_fj    1  TPASS  :  case2(function   1 2 1 1 1 2 3 2 1)    PASS
> 
> <snip>
> 
>> cgroup_test_fj    1  TPASS  :  case93(function  12 1 1 8 1 2 3 2 1)    PASS
> 
> <snip>
> 
>> diff -urpN ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh ltp-full-20090731.cg/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
>> --- ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh	1969-12-31 19:00:00.000000000 -0500
>> +++ ltp-full-20090731.cg/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh	2009-08-23 10:15:08.000000000 -0400
>> @@ -0,0 +1,269 @@
>> +#! /bin/sh
>> +
>> +################################################################################
>> +##                                                                            ##
>> +## Copyright (c) 2009 FUJITSU LIMITED                                         ##
>> +##                                                                            ##
>> +## This program is free software;  you can redistribute it and#or modify      ##
>> +## it under the terms of the GNU General Public License as published by       ##
>> +## the Free Software Foundation; either version 2 of the License, or          ##
>> +## (at your option) any later version.                                        ##
>> +##                                                                            ##
>> +## This program is distributed in the hope that it will be useful, but        ##
>> +## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
>> +## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
>> +## for more details.                                                          ##
>> +##                                                                            ##
>> +## You should have received a copy of the GNU General Public License          ##
>> +## along with this program;  if not, write to the Free Software               ##
>> +## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
>> +##                                                                            ##
>> +## Author: Shi Weihua <shiwh@cn.fujitsu.com>                                  ##
>> +##                                                                            ##
>> +################################################################################
>> +
>> +subsystem=$1
>> +remount_use=$2
>> +noprefix_use=$3	
>> +release_agent_para=$4
>> +subgroup_exist=$5
>> +attach_operation=$6
>> +remove_operation=$7
>> +notify_on_release=$8
>> +release_agent_echo=$9
>> +
>> +subsystem_str="";
>> +remount_use_str="";
>> +noprefix_use_str="";
>> +release_agent_para_str="";
>> +notify_on_release_str="";
>> +release_agent_str="";
>> +
>> +expectted=1;
>> +
>> +# Create some processes and move them to cgroups
>> +pid=0;
>> +pid2=0;
>> +
>> +# not output debug info
>> +no_debug=0
>> +
>> +usage()
>> +{
>> +	echo "usage of cgroup_fj_function.sh: "
>> +	echo "  ./cgroup_fj_function.sh -subsystem -remount_use -noprefix_use -release_agent_para"
>> +	echo "                          -subgroup_exist -attach_operation -remove_operation"
>> +	echo "                          -notify_on_release -release_agent_echo"
>> +	echo "    subsystem's usable number"
>> +	echo "      1: debug"
>> +	echo "      2: cpuset"
>> +	echo "      3: ns"
>> +	echo "      4: cpu"
>> +	echo "      5: cpuacct"
>> +	echo "      6: memory"
>> +	echo "      7: all"
>> +	echo "      8: (none)"
>> +	echo "      9: debug,debug"
>> +	echo "      10: (nonexistent subsystem), e.g. abc"
>> +	echo "      11: freezer"
>> +	echo "      11: devices"
> 
> Looks like this should be 12.

Yes, here should be 12. Sorry for it.
The following small patch fixed it.

Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
---
diff -urpN ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh ltp-full-20090731/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
--- ltp-full-20090731.orig/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh	2009-08-27 04:09:41.000000000 -0400
+++ ltp-full-20090731/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh	2009-08-27 04:11:07.000000000 -0400
@@ -66,7 +66,7 @@ usage()
 	echo "      9: debug,debug"
 	echo "      10: (nonexistent subsystem), e.g. abc"
 	echo "      11: freezer"
-	echo "      11: devices"
+	echo "      12: devices"
 	echo "    remount_use's usable number"
 	echo "      1: do not use remount in "-o"'s parameter"
 	echo "      2: use it"


> 
> Why not just use the subsystem names both to iterate over and to print
> out? Then it will be a little clearer what test has[n't] passed.
> e.g.:
> 
> SUBSYSTEMS=( debug cpuset ns cpu cpuacct memory debug,debug freezer \
> 		devices nonexistent none all )
> 
> Then when you're running the test cases or printing usage you could do:
> 
> for SUBSYS in "${SUBSYSTEMS[@]}" ; do
> 	...
> done
> 
> Sadly I didn't have a close enough look at all of the code to tell if
> this is do-able. Is it? If you could similarly map the other numbers
> it may be easier to read the output and the code.

Thanks for your advice. Basically, I agree.
But using strings to instead of number will need one or more weeks, I will 
do this improvement work base on August Release.
 
> 
> Cheers,
> 	-Matt Helsley
> 
> 
> 

-- 
Shi Weihua
79955-852


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
