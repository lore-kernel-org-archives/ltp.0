Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SrKY4-0000tW-Uu
	for ltp-list@lists.sourceforge.net; Wed, 18 Jul 2012 03:03:36 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SrKY3-0006za-7W
	for ltp-list@lists.sourceforge.net; Wed, 18 Jul 2012 03:03:36 +0000
Message-ID: <50062757.1000304@cn.fujitsu.com>
Date: Wed, 18 Jul 2012 11:02:47 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <500545CA.2020208@linux.vnet.ibm.com>
In-Reply-To: <500545CA.2020208@linux.vnet.ibm.com>
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
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi Preeti,

> Hi
> 
> The test case included is a simple case for cpu hotplug.It does offlines the cpus that are online and does an online of the offlined cpus in a loop
> 
> This stress test had failed on certain distros when the loop was run infinite times.This test is presented here for review of correctness and necessity,as this is the first attempt at contributing test cases to LTP from this end.
> 
> The test is meant to be included under the testcases/kernel/hotplug/cpu_hotplug/functional directory.

Why didn't you send this as a patch format?
Some comments below.

> 
> Regards
> Preeti
> ---
> 
> # File		:	stress_cpu_hotplug.sh
> # Description	:	Switches the online state of all the cpus in  a
> # 			loop to test the robustness of cpu hotplug
> #		:	The loop iteration of 20 is a randomly chosen number
> 
> #! /bin/bash
> 
> # Includes:
> LHCS_PATH=${LHCS_PATH:-$LTPROOT/testcases/bin/cpu_hotplug}
> . $LHCS_PATH/include/hotplug.fns
> . $LHCS_PATH/include/testsuite.fns
> 
> setup()
> {
> 	export TST_TOTAL=1
> 	export TCID="setup"
> 	export TST_COUNT=0
> 
> 	trap "cleanup" 0
> 	RC=0
> 
> 	return $RC
> 
> }
> cleanup()
> {
> 	set_all_cpu_state "$STATE"

I can't find the definition of "$STATE" in your test script.

> }
> 
> test01()
> {
> 
> 	TCID="stress_cpu_hotplug"
> 	TST_COUNT=1
> 	RC=0
> 
> 	NUMBER_OF_CPUS=`ls -d /sys/devices/system/cpu/cpu[0-9]* | wc -l`
> 
> 	cd /sys/devices/system/cpu
> 
> 	for ARRAY_INDEX in `seq 20`
> 	do
> 		for ((i=1; i < NUMBER_OF_CPUS; i++ ))
> 		do
> 			#skip the boot cpu;cannot offline it
> 			if [ $i -eq 0 ]
> 			then
> 				continue
> 			fi
> 
>         		state=`cat cpu$i/online`
> 		        if [ $state -eq 0 ]
>         		then
> 				RC=online_cpu $i
>         		else
>                 		RC=offline_cpu $i
>         		fi

Can it always success? I suppose that it need a bit sleep for the online/offline time delay.

> 
> 			if [ $RC -ne 0 ]
> 			then
> 				test_brkm TBROK NULL "stress_cpu_hotplug:
> 							cpu$i failed to hotplug"
> 				return $RC
> 			fi
> 		done
> 
> 		if [ `expr $ARRAY_INDEX % 10` == 0 ]
> 		then
> 			echo "stress test successfully completed
> 				"$ARRAY_INDEX" times">$LTPTMP/test_file.out

Every 10 times means a successful test?

> 		fi
> 	done
> 	test_res TPASS $LTPTMP/test_file.out "stress_cpu_hotplug:SUCCESS"
> 	return $RC
> }
> 
> #main
> 
> RC=0
> LTPTMP=${TMP}
> 
> #create output file to dump test results
> touch $LTPTMP/test_file.out || RC=$?
> 
> if [ $RC -ne 0 ]
> then
> 	test_resm TFAIL "Failed to create output file under temp directory"
> 	exit $RC
> fi
> 
> if ! get_all_cpus >/dev/null 2>$RC;
> then
> 	tst_brkm TCONF "system does not have required cpu hotplug support"
> 	exit $RC
> fi
> 
> setup || exit $RC
> 
> #capture the initial state of the cpus
> state=`cd /sys/devices/system/cpu/ && grep '' */online | sed -e
> 's/\/online//g' -e 's/\ /\n/g'`

This is the "STATE"?

Does the output of get_all_cpu_states() not suit the set_all_cpu_states()? 
if not, please fix it.

> 
> test01 || exit $RC

Don't you want to cleanup and reset the cpu state after the test?

Thanks,
Wanlong Gao

> 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and 
> threat landscape has changed and how IT managers can respond. Discussions 
> will include endpoint security, mobile security and the latest in malware 
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
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
