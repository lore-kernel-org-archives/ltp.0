Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1YnTWK-0006bN-7a
	for ltp-list@lists.sourceforge.net; Wed, 29 Apr 2015 15:03:28 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YnTWG-0008VN-LP
	for ltp-list@lists.sourceforge.net; Wed, 29 Apr 2015 15:03:28 +0000
Message-ID: <5540F2B3.1080904@oracle.com>
Date: Wed, 29 Apr 2015 18:03:15 +0300
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <cover.1430305546.git.jstancek@redhat.com>
	<c0241646d11b747c1fd00d583f350cc9d048ad5e.1430305546.git.jstancek@redhat.com>
	<5540D7F2.5050601@oracle.com>
	<1664154270.8253204.1430318485223.JavaMail.zimbra@redhat.com>
In-Reply-To: <1664154270.8253204.1430318485223.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH 3/4] cpu_hotplug: use hotplug/present cpus
	functions
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net



On 04/29/2015 05:41 PM, Jan Stancek wrote:
>
>
>
>
> ----- Original Message -----
>> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
>> To: "Jan Stancek" <jstancek@redhat.com>, ltp-list@lists.sourceforge.net
>> Sent: Wednesday, 29 April, 2015 3:09:06 PM
>> Subject: Re: [PATCH 3/4] cpu_hotplug: use hotplug/present cpus functions
>>
>> On 04/29/2015 02:18 PM, Jan Stancek wrote:
>>> Signed-off-by: Jan Stancek <jstancek@redhat.com>
>>> ---
>>>    testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh | 6
>>>    +++---
>>>    testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh | 2 +-
>>>    testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh | 4 ++--
>>>    testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh | 4 ++--
>>>    testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh | 2 +-
>>>    testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh | 2 +-
>>>    testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh | 2 +-
>>>    7 files changed, 11 insertions(+), 11 deletions(-)
>>>
>>> diff --git
>>> a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
>>> b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
>>> index 52598a9..8ae1379 100755
>>> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
>>> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
>>> @@ -111,7 +111,7 @@ LOOP_COUNT=1
>>>
>>>    tst_check_cmds perl
>>>
>>> -get_cpus_num
>>> +get_present_cpus_num
>>>    if [ $? -lt 2 ]; then
>>>    	tst_brkm TCONF "system doesn't have required CPU hotplug support"
>>>    fi
>>> @@ -148,7 +148,7 @@ do
>>>    	IRQ_START=$(cat /proc/interrupts)
>>>
>>>    	# Attempt to offline all CPUs
>>> -	for cpu in $( get_all_cpus ); do
>>> +	for cpu in $( get_hotplug_cpus ); do
>>>    		if [ "$cpu" = "cpu0" ]; then
>>>    			continue
>>>    		fi
>>> @@ -163,7 +163,7 @@ do
>>>    	done
>>>
>>>    	# Attempt to online all CPUs
>>> -	for cpu in $( get_all_cpus ); do
>>> +	for cpu in $( get_hotplug_cpus ); do
>>>    		if [ "$cpu" = "cpu0" ]; then
>>>    			continue
>>>    		fi
>>
>> Given that now this loop runs over hotpluggable cpus, it seems there is
>> no reason to treat cpu0 specially in cpuhotplug0{1, 3, 4}.sh.
>
> I'm not sure we can remove it in 01, because then it would try to bring
> all offline and if all are hotpluggable it's going to fail.
> I'd ignore 01 for now, it's broken anyway and disabled in runtest file.
>
> 03 looks like it can be removed, 04 is fixed by your patch.
>
> Also, I'd prefer if those testcases would find suitable cpu to test
> as part of test, instead of relying on passed parameters - but
> I don't want to inflate this patchset even more now.

ok.


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
