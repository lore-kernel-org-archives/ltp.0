Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SrN0t-0005z5-6r
	for ltp-list@lists.sourceforge.net; Wed, 18 Jul 2012 05:41:31 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SrN0r-0000gI-Iv
	for ltp-list@lists.sourceforge.net; Wed, 18 Jul 2012 05:41:31 +0000
Message-ID: <50064C5C.3010509@cn.fujitsu.com>
Date: Wed, 18 Jul 2012 13:40:44 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <500545CA.2020208@linux.vnet.ibm.com>
	<50062757.1000304@cn.fujitsu.com>
	<50063075.80905@linux.vnet.ibm.com>
	<5006308A.7050206@cn.fujitsu.com>
	<50064CA3.6070003@linux.vnet.ibm.com>
In-Reply-To: <50064CA3.6070003@linux.vnet.ibm.com>
Subject: Re: [LTP] [RFC] cpu_hotplug: Adding a cpu hotplug stress test
Reply-To: gaowanlong@cn.fujitsu.com
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
To: preeti <preeti@linux.vnet.ibm.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, Mailing list for the Energy Management India Team <ltc-india-em@lists.linux.ibm.com>

On 07/18/2012 01:41 PM, preeti wrote:
> On 07/18/2012 09:12 AM, Wanlong Gao wrote:
>> On 07/18/2012 11:41 AM, preeti wrote:
>>> On 07/18/2012 08:32 AM, Wanlong Gao wrote:
>>>> Hi Preeti,
>>>>
>>>>> Hi
>>>>>
>>>>> The test case included is a simple case for cpu hotplug.It does offlines the cpus that are online and does an online of the offlined cpus in a loop
>>>>>
>>>>> This stress test had failed on certain distros when the loop was run infinite times.This test is presented here for review of correctness and necessity,as this is the first attempt at contributing test cases to LTP from this end.
>>>>>
>>>>> The test is meant to be included under the testcases/kernel/hotplug/cpu_hotplug/functional directory.
>>>>
>>>> Why didn't you send this as a patch format?
>>>
>>> This was a frst attempt at sending test cases to LTP,so thought would get it
>>> reviewed as an RFC first.
>>
>> Yeah, but you can also send a patch titled like [RFC PATCH] xxx.
> 
> Ok.
>>
>>>
>>>> Some comments below.
>>>>
>>>>>
>>>>> Regards
>>>>> Preeti
>>>>> ---
>>>>>
>>>>> # File		:	stress_cpu_hotplug.sh
>>>>> # Description	:	Switches the online state of all the cpus in  a
>>>>> # 			loop to test the robustness of cpu hotplug
>>>>> #		:	The loop iteration of 20 is a randomly chosen number
>>>>>
>>>>> #! /bin/bash
>>>>>
>>>>> # Includes:
>>>>> LHCS_PATH=${LHCS_PATH:-$LTPROOT/testcases/bin/cpu_hotplug}
>>>>> . $LHCS_PATH/include/hotplug.fns
>>>>> . $LHCS_PATH/include/testsuite.fns
>>>>>
>>>>> setup()
>>>>> {
>>>>> 	export TST_TOTAL=1
>>>>> 	export TCID="setup"
>>>>> 	export TST_COUNT=0
>>>>>
>>>>> 	trap "cleanup" 0
>>>>> 	RC=0
>>>>>
>>>>> 	return $RC
>>>>>
>>>>> }
>>>>> cleanup()
>>>>> {
>>>>> 	set_all_cpu_state "$STATE"
>>>>
>>>> I can't find the definition of "$STATE" in your test script.
>>>
>>> I apologise for this typo.It needs to be $state as you have pointed out
>>> below.
>>>>
>>>>> }
>>>>>
>>>>> test01()
>>>>> {
>>>>>
>>>>> 	TCID="stress_cpu_hotplug"
>>>>> 	TST_COUNT=1
>>>>> 	RC=0
>>>>>
>>>>> 	NUMBER_OF_CPUS=`ls -d /sys/devices/system/cpu/cpu[0-9]* | wc -l`
>>>>>
>>>>> 	cd /sys/devices/system/cpu
>>>>>
>>>>> 	for ARRAY_INDEX in `seq 20`
>>>>> 	do
>>>>> 		for ((i=1; i < NUMBER_OF_CPUS; i++ ))
>>>>> 		do
>>>>> 			#skip the boot cpu;cannot offline it
>>>>> 			if [ $i -eq 0 ]
>>>>> 			then
>>>>> 				continue
>>>>> 			fi
>>>>>
>>>>>         		state=`cat cpu$i/online`
>>>>> 		        if [ $state -eq 0 ]
>>>>>         		then
>>>>> 				RC=online_cpu $i
>>>>>         		else
>>>>>                 		RC=offline_cpu $i
>>>>>         		fi
>>>>
>>>> Can it always success? I suppose that it need a bit sleep for the online/offline time delay.
>>>
>>> It does not need a sleep because we are doing an online and offline of
>>> different cpus in one loop.i.e.for example:cpu1->1,cpu2->0,cpu3->1. so it
>>> takes one complete loop for cpu1->0 to occur which is enough time for an
>>> online or an offline operation for a cpu.
>>>
>>> Besides this,the test has been carried out on RHEL distros before and they have
>>> succeeded.Only the snapshot 5 of RHEL 6.3 is failing after running for a few seconds which
>>> is equivalent to nearly two loops.
>>
>> Did you investigate this problem? Why does it fail? Kernel problem or any others?
> 
> Yes,it is a kernel problem.The dmesg output showed that the cpu hotplug operation hangs at
> synchronize_sched().The scheduler is waiting for some rcu read side critical
> section to complete,and is either not notified of the completion of the task
> or there is some rcu section which is actually not completed.
> 
> The machine is responsive,in the sense that it responds to the ping
> packets,but is too slow to perform any operation on.But slowly recovers back
> to the original state.We have opened a bug on this.

Ok, thank you.


Wanlong Gao

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
