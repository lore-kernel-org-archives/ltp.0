Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Jin.Li@windriver.com>) id 1TYXKC-0007IJ-6l
	for ltp-list@lists.sourceforge.net; Wed, 14 Nov 2012 07:23:52 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TYXK8-0007tO-6o
	for ltp-list@lists.sourceforge.net; Wed, 14 Nov 2012 07:23:52 +0000
Message-ID: <50A346F6.8030305@windriver.com>
Date: Wed, 14 Nov 2012 15:23:34 +0800
From: "Li, Jin" <Jin.Li@windriver.com>
MIME-Version: 1.0
References: <1352705641-27644-1-git-send-email-jin.li@windriver.com>
	<1352705641-27644-3-git-send-email-jin.li@windriver.com>
	<50A33A4C.4090206@cn.fujitsu.com> <50A341D6.5050409@windriver.com>
	<50A34576.9060109@cn.fujitsu.com>
In-Reply-To: <50A34576.9060109@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/3] Fix cpuhotplug test case cpuhotplug03
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
Cc: ltp-list@lists.sourceforge.net



On 11/14/2012 03:17 PM, Wanlong Gao wrote:
> On 11/14/2012 03:01 PM, Li, Jin wrote:
>>
>>
>> On 11/14/2012 02:29 PM, Wanlong Gao wrote:
>>> On 11/12/2012 03:34 PM, jin.li@windriver.com wrote:
>>>> From: Jin Li<jin.li@windriver.com>
>>>>
>>>> Fix test case cpuhotplug03 as follows:
>>>> 1. Avoid to check whether the cpu0 is on.
>>>> 2. Check the cpu before turn it on
>>>>
>>>> Signed-off-by: Jin Li<jin.li@windriver.com>
>>>> ---
>>>>    .../hotplug/cpu_hotplug/functional/cpuhotplug03.sh  | 21 ++++++++++++++-------
>>>>    1 file changed, 14 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
>>>> index ca636d1..516a21f 100755
>>>> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
>>>> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
>>>> @@ -60,15 +60,22 @@ until [ $TST_COUNT -gt $TST_TOTAL ]; do
>>>>
>>>>        # Turns on all CPUs and saves their states
>>>>        for i in $( get_all_cpus ); do
>>>> -        if ! online_cpu $1; then
>>>> -            : $(( cpu += 1 ))
>>>> -            eval "on_${cpu}=$i"
>>>> -        fi
>>>> +            if [ "$i" = "cpu0" ]; then
>>>> +                continue
>>>> +            fi
>>>> +            if ! cpu_is_online $i; then
>>>> +        if ! online_cpu $i; then
>>>> +                    tst_resm TFAIL "Could not online cpu $i"
>>>> +                    exit_clean 1
>>>> +                fi
>>>> +                : $(( cpu += 1 ))
>>>> +                eval "on_${cpu}=$i"
>>>> +            fi
>>>>            : $(( number_of_cpus += 1 ))
>>>>        done
>>>>
>>>>        if ! offline_cpu ${CPU_TO_TEST} ; then
>>>> -        tst_resm TBAIL "CPU${CPU_TO_TEST} cannot be offlined"
>>>> +        tst_resm TFAIL "CPU${CPU_TO_TEST} cannot be offlined"
>>>>            exit_clean 1
>>>>        fi
>>>>
>>>> @@ -90,7 +97,7 @@ until [ $TST_COUNT -gt $TST_TOTAL ]; do
>>>>        tst_resm TINFO "Onlining CPU ${CPU_TO_TEST}"
>>>>        online_cpu ${CPU_TO_TEST}
>>>>        RC=$?
>>>> -    if [ $RC -eq 0 ]; then
>>>> +    if [ $RC -ne 0 ]; then
>>>>            tst_resm TFAIL "CPU${CPU_TO_TEST} cannot be onlined"
>>
>> Looks strange. It's just what I fixed.
>>
>> Could you please help to confirm that the 0002-patch is applied correctly?
>
> I tested again and it passed. Maybe caused by some cache.
> So, can you resend your 1/3 patch and I can apply all these three.

Get it. V2 will come up soon.

Jin

>
> Thanks,
> Wanlong Gao
>
>>
>> Thanks,
>>
>> Jin
>>
>>>
>>> I test with your patch and always failed here,
>>> Running tests.......
>>> <<<test_start>>>
>>> tag=cpuhotplug03 stime=1352874488
>>> cmdline="export CPU_TO_TEST=1; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug03.sh"
>>> contacts=""
>>> analysis=exit
>>> <<<test_output>>>
>>> incrementing stop
>>> Name:   cpuhotplug03
>>> Date:   Wed Nov 14 14:28:08 CST 2012
>>> Desc:   Do tasks get scheduled to a newly on-lined CPU?
>>>
>>> CPU is 1
>>> USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
>>> root     31631  3.0  0.0 134116  1556 pts/1    R    14:28   0:00 /bin/sh /opt/ltp/testcases/bin/cpu_hotplug/tools/do_spin_loop
>>> root     31632  0.0  0.0 134116  1560 pts/1    R    14:28   0:00 /bin/sh /opt/ltp/testcases/bin/cpu_hotplug/tools/do_spin_loop
>>> root     31634  0.0  0.0 134116  1560 pts/1    R    14:28   0:00 /bin/sh /opt/ltp/testcases/bin/cpu_hotplug/tools/do_spin_loop
>>> root     31635  0.0  0.0 134116  1560 pts/1    R    14:28   0:00 /bin/sh /opt/ltp/testcases/bin/cpu_hotplug/tools/do_spin_loop
>>> root     31636  0.0  0.0 134116  1560 pts/1    R    14:28   0:00 /bin/sh /opt/ltp/testcases/bin/cpu_hotplug/tools/do_spin_loop
>>> root     31637  0.0  0.0 134116  1560 pts/1    R    14:28   0:00 /bin/sh /opt/ltp/testcases/bin/cpu_hotplug/tools/do_spin_loop
>>> root     31638  2.0  0.0 134116  1560 pts/1    R    14:28   0:00 /bin/sh /opt/ltp/testcases/bin/cpu_hotplug/tools/do_spin_loop
>>> root     31639  1.0  0.0 134116  1560 pts/1    R    14:28   0:00 /bin/sh /opt/ltp/testcases/bin/cpu_hotplug/tools/do_spin_loop
>>> root     31643  0.0  0.0 133488  1304 pts/1    S    14:28   0:00 grep do_spin_loop
>>> cpuhotplug03    0  TINFO  :  Onlining CPU 1
>>> cpuhotplug03    1  TFAIL  :  CPU1 cannot be onlined
>>> Wed Nov 14 14:28:08 CST 2012
>>> <<<execution_status>>>
>>> initiation_status="ok"
>>> duration=0 termination_type=exited termination_id=1 corefile=no
>>> cutime=37 cstime=4
>>> <<<test_end>>>
>>> INFO: ltp-pan reported some tests FAIL
>>> LTP Version: 20120903-133-gb631790
>>>
>>>          ###############################################################
>>>
>>>               Done executing testcases.
>>>               LTP Version:  20120903-133-gb631790
>>>          ###############################################################
>>>
>>>
>>> Thanks,
>>> Wanlong Gao
>>>
>>>>            exit_clean 1
>>>>        fi
>>>> @@ -101,7 +108,7 @@ until [ $TST_COUNT -gt $TST_TOTAL ]; do
>>>>        ps -o psr -o command --no-headers -C do_spin_loop
>>>>        RC=$?
>>>>        NUM=`ps -o psr -o command --no-headers -C do_spin_loop | sed -e "s/^ *//" | cut -d' ' -f 1 | grep "^${CPU_TO_TEST}$" | wc -l`
>>>> -    if [ $RC -eq 0 ]; then
>>>> +    if [ $RC -ne 0 ]; then
>>>>            tst_resm TBROK "No do_spin_loop processes found on any processor"
>>>>        elif [ $NUM -lt 1 ]; then
>>>>            tst_resm TFAIL "No do_spin_loop processes found on CPU${CPU_TO_TEST}"
>>>>
>>>
>>
>

------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
