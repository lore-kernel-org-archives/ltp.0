Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <preeti@linux.vnet.ibm.com>) id 1SrKzA-0007qF-M3
	for ltp-list@lists.sourceforge.net; Wed, 18 Jul 2012 03:31:36 +0000
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SrKz1-0007ng-OU
	for ltp-list@lists.sourceforge.net; Wed, 18 Jul 2012 03:31:36 +0000
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <preeti@linux.vnet.ibm.com>; 
	Wed, 18 Jul 2012 03:21:15 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	q6I3Ubq066322686
	for <ltp-list@lists.sourceforge.net>; Wed, 18 Jul 2012 13:30:37 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	q6I3UZjv015700
	for <ltp-list@lists.sourceforge.net>; Wed, 18 Jul 2012 13:30:36 +1000
Message-ID: <50063075.80905@linux.vnet.ibm.com>
Date: Wed, 18 Jul 2012 09:11:41 +0530
From: preeti <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <500545CA.2020208@linux.vnet.ibm.com>
	<50062757.1000304@cn.fujitsu.com>
In-Reply-To: <50062757.1000304@cn.fujitsu.com>
Subject: Re: [LTP] [RFC] cpu_hotplug: Adding a cpu hotplug stress test
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
To: gaowanlong@cn.fujitsu.com
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, Mailing list for the Energy Management India Team <ltc-india-em@lists.linux.ibm.com>

On 07/18/2012 08:32 AM, Wanlong Gao wrote:
> Hi Preeti,
> 
>> Hi
>>
>> The test case included is a simple case for cpu hotplug.It does offlines the cpus that are online and does an online of the offlined cpus in a loop
>>
>> This stress test had failed on certain distros when the loop was run infinite times.This test is presented here for review of correctness and necessity,as this is the first attempt at contributing test cases to LTP from this end.
>>
>> The test is meant to be included under the testcases/kernel/hotplug/cpu_hotplug/functional directory.
> 
> Why didn't you send this as a patch format?

This was a frst attempt at sending test cases to LTP,so thought would get it
reviewed as an RFC first.

> Some comments below.
> 
>>
>> Regards
>> Preeti
>> ---
>>
>> # File		:	stress_cpu_hotplug.sh
>> # Description	:	Switches the online state of all the cpus in  a
>> # 			loop to test the robustness of cpu hotplug
>> #		:	The loop iteration of 20 is a randomly chosen number
>>
>> #! /bin/bash
>>
>> # Includes:
>> LHCS_PATH=${LHCS_PATH:-$LTPROOT/testcases/bin/cpu_hotplug}
>> . $LHCS_PATH/include/hotplug.fns
>> . $LHCS_PATH/include/testsuite.fns
>>
>> setup()
>> {
>> 	export TST_TOTAL=1
>> 	export TCID="setup"
>> 	export TST_COUNT=0
>>
>> 	trap "cleanup" 0
>> 	RC=0
>>
>> 	return $RC
>>
>> }
>> cleanup()
>> {
>> 	set_all_cpu_state "$STATE"
> 
> I can't find the definition of "$STATE" in your test script.

I apologise for this typo.It needs to be $state as you have pointed out
below.
> 
>> }
>>
>> test01()
>> {
>>
>> 	TCID="stress_cpu_hotplug"
>> 	TST_COUNT=1
>> 	RC=0
>>
>> 	NUMBER_OF_CPUS=`ls -d /sys/devices/system/cpu/cpu[0-9]* | wc -l`
>>
>> 	cd /sys/devices/system/cpu
>>
>> 	for ARRAY_INDEX in `seq 20`
>> 	do
>> 		for ((i=1; i < NUMBER_OF_CPUS; i++ ))
>> 		do
>> 			#skip the boot cpu;cannot offline it
>> 			if [ $i -eq 0 ]
>> 			then
>> 				continue
>> 			fi
>>
>>         		state=`cat cpu$i/online`
>> 		        if [ $state -eq 0 ]
>>         		then
>> 				RC=online_cpu $i
>>         		else
>>                 		RC=offline_cpu $i
>>         		fi
> 
> Can it always success? I suppose that it need a bit sleep for the online/offline time delay.

It does not need a sleep because we are doing an online and offline of
different cpus in one loop.i.e.for example:cpu1->1,cpu2->0,cpu3->1. so it
takes one complete loop for cpu1->0 to occur which is enough time for an
online or an offline operation for a cpu.

Besides this,the test has been carried out on RHEL distros before and they have
succeeded.Only the snapshot 5 of RHEL 6.3 is failing after running for a few seconds which
is equivalent to nearly two loops.
> 
>>
>> 			if [ $RC -ne 0 ]
>> 			then
>> 				test_brkm TBROK NULL "stress_cpu_hotplug:
>> 							cpu$i failed to hotplug"
>> 				return $RC
>> 			fi
>> 		done
>>
>> 		if [ `expr $ARRAY_INDEX % 10` == 0 ]
>> 		then
>> 			echo "stress test successfully completed
>> 				"$ARRAY_INDEX" times">$LTPTMP/test_file.out
> 
> Every 10 times means a successful test?

Not really.This message is intended to tell us after how many runs of the cpu
hotplug operation on all the cpus, is the machine failing to withstand the
stress.It might fail after running the loop 100 times or fail within 50 times
itself. Also 20 is a very small number for this stress test.It should
typically run 100 times.

I have captured the state of the stress test for every 10 iterations,instead
of logging for every iteration.So for example if the test is meant to run 100
times,but fails on some distro after 30 loops,the above message logging tells
us that the distro withstood the test for 30 loops atleast if not for the
entire duration.
> 
>> 		fi
>> 	done
>> 	test_res TPASS $LTPTMP/test_file.out "stress_cpu_hotplug:SUCCESS"
>> 	return $RC
>> }
>>
>> #main
>>
>> RC=0
>> LTPTMP=${TMP}
>>
>> #create output file to dump test results
>> touch $LTPTMP/test_file.out || RC=$?
>>
>> if [ $RC -ne 0 ]
>> then
>> 	test_resm TFAIL "Failed to create output file under temp directory"
>> 	exit $RC
>> fi
>>
>> if ! get_all_cpus >/dev/null 2>$RC;
>> then
>> 	tst_brkm TCONF "system does not have required cpu hotplug support"
>> 	exit $RC
>> fi
>>
>> setup || exit $RC
>>
>> #capture the initial state of the cpus
>> state=`cd /sys/devices/system/cpu/ && grep '' */online | sed -e
>> 's/\/online//g' -e 's/\ /\n/g'`
> 
> This is the "STATE"?
Yes this is the one.
> 
> Does the output of get_all_cpu_states() not suit the set_all_cpu_states()? 
> if not, please fix it.

No, get_all_cpu_states(),simply echos the states of the cpus onto the screen in
a single line.while the set_all_cpu_states() requires it as a variable with
the cpu states printed on multiple lines.Sure will fix this up.
> 
>>
>> test01 || exit $RC
> 
> Don't you want to cleanup and reset the cpu state after the test?

yes that is done in the cleanup function,except that it should be
set_all_cpu_states "$state"
> 
> Thanks,
> Wanlong Gao
> 
>>
Thank you,
Preeti
>>
>> ------------------------------------------------------------------------------
>> Live Security Virtual Conference
>> Exclusive live event will cover all the ways today's security and 
>> threat landscape has changed and how IT managers can respond. Discussions 
>> will include endpoint security, mobile security and the latest in malware 
>> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>
> 
> 



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
