From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Mon, 21 Jun 2021 11:03:50 +0000
Subject: [LTP] [PATCH] cpuset_hotplug_test/cpuset_hotplug: Fix bug for
 obtaining task_cpus value in root_cpu_hotplug_test
In-Reply-To: <ab163aab-a045-30ec-2120-94a07b5a610d@huawei.com>
References: <1617701249-62196-1-git-send-email-zou_wei@huawei.com>
 <437bb60b-4f97-4884-8713-c7b619dab211@huawei.com>
 <60CB2CF8.6090108@fujitsu.com> <60D05460.5060903@fujitsu.com>
 <91f24077-493e-dcad-e537-6b8559222439@huawei.com>
 <60D061B9.9070904@fujitsu.com>
 <ab163aab-a045-30ec-2120-94a07b5a610d@huawei.com>
Message-ID: <60D07235.60005@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Zou

Thanks for your patch! Merged.

Best Regards
Yang Xu
> Hi Xu,
>
> Please push it directly, thanks a lot :)
>
> On 2021/6/21 17:53, xuyang2018.jy@fujitsu.com wrote:
>> Hi Zou
>> Do you want to send a v2 patch? Or I modify this patch and push it
>> directly.
>>
>> Best Regards
>> Yang Xu
>>> Hi Xu,
>>>
>>> You'are right, I miss to get task_cpus value in
>>> general_cpu_hotplug_test().
>>> Thanks for your review and agree with your modification.
>>>
>>>
>>> On 2021/6/21 16:56, xuyang2018.jy@fujitsu.com wrote:
>>>> Hi Zou
>>>>
>>>> It looks like this patch also miss to get task_cpus value
>>>> intgeneric_cpu_hotplug_test when expect cpu value is EMPTY.
>>>>
>>>> I can reproduce this easily by increasing the possible_cpus value in
>>>> cmdline. Merge your patch, this case still fails as below:
>>>> cpuset_hotplug 1 TINFO: CPUs are numbered continuously starting at 0
>>>> (0-3)
>>>> cpuset_hotplug 1 TINFO: Nodes are numbered continuously starting at 0
>>>> (0-3)
>>>> /opt/ltp/testcases/bin/cpuset_funcs.sh: line 179: 5676 Killed
>>>> /bin/cat /dev/zero > /dev/null 2>&1
>>>> cpuset_hotplug 1 TPASS: Cpuset vs CPU hotplug test succeeded.
>>>> /opt/ltp/testcases/bin/cpuset_funcs.sh: line 179: 5714 Killed
>>>> /bin/cat /dev/zero > /dev/null 2>&1
>>>> cpuset_hotplug 3 TPASS: Cpuset vs CPU hotplug test succeeded.
>>>> /opt/ltp/testcases/bin/cpuset_funcs.sh: line 179: 5750 Killed
>>>> /bin/cat /dev/zero > /dev/null 2>&1
>>>> cpuset_hotplug 5 TPASS: Cpuset vs CPU hotplug test succeeded.
>>>> cpuset_hotplug 7 TFAIL: task's cpu present list isn't expected(Result:
>>>> 0-7, Expect: 0-3).
>>>> /opt/ltp/testcases/bin/cpuset_funcs.sh: line 179: 5795 Killed
>>>> /bin/cat /dev/zero > /dev/null 2>&1
>>>> /opt/ltp/testcases/bin/cpuset_funcs.sh: line 179: 5846 Killed
>>>> /bin/cat /dev/zero > /dev/null 2>&1
>>>> cpuset_hotplug 9 TPASS: Cpuset vs CPU hotplug test succeeded.
>>>> /opt/ltp/testcases/bin/cpuset_funcs.sh: line 179: 5894 Killed
>>>> /bin/cat /dev/zero > /dev/null 2>&1
>>>> cpuset_hotplug 11 TPASS: Cpuset vs CPU hotplug test succeeded.
>>>>
>>>>
>>>> Also since we have use present value, we shoud adjust output to match
>>>> it. I modify this patch as below, What do you think about it?
>>>>
>>>> ---
>>>> a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
>>>>
>>>>
>>>> +++
>>>> b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
>>>>
>>>>
>>>> @@ -93,9 +93,7 @@ root_cpu_hotplug_test()
>>>>
>>>> root_cpus="`cat $CPUSET/cpuset.cpus`"
>>>>
>>>> - task_cpus="`cat /proc/$tst_pid/status | grep Cpus_allowed_list`"
>>>> - task_cpus="`echo $task_cpus | sed -e 's/Cpus_allowed_list: //'`"
>>>> -
>>>> + task_cpus="`cat /sys/devices/system/cpu/present`"
>>>> check_result "$root_cpus" "$expect_cpus"
>>>> ret=$?
>>>> if [ $ret -eq 0 ]
>>>> @@ -103,7 +101,7 @@ root_cpu_hotplug_test()
>>>> check_result "$task_cpus" "$expect_task_cpus"
>>>> ret=$?
>>>> if [ $ret -ne 0 ]; then
>>>> - tst_resm TFAIL "task's allowed list isn't
>>>> expected.(Result: $task_cpus, Expect: $expect_task_cpus)"
>>>> + tst_resm TFAIL "task's present list isn't
>>>> expected.(Result: $task_cpus, Expect: $expect_task_cpus)"
>>>> fi
>>>> else
>>>> tst_resm TFAIL "root group's cpus isn't
>>>> expected(Result: $root_cpus, Expect: $expect_cpus)."
>>>> @@ -166,7 +164,6 @@ general_cpu_hotplug_test()
>>>> sleep 1
>>>>
>>>> cpus="`cat $path/cpuset.cpus`"
>>>> -
>>>> task_cpus="`cat /proc/$tst_pid/status | grep Cpus_allowed_list`"
>>>> task_cpus="`echo $task_cpus | sed -e 's/Cpus_allowed_list: //'`"
>>>>
>>>> @@ -186,6 +183,7 @@ general_cpu_hotplug_test()
>>>> /bin/kill -s SIGKILL $tst_pid
>>>> return 1
>>>> fi
>>>> + task_cpus="`cat /sys/devices/system/cpu/present`"
>>>> fi
>>>>
>>>> check_result "$cpus" "$expect_cpus"
>>>> @@ -194,7 +192,7 @@ general_cpu_hotplug_test()
>>>> check_result $task_cpus $expect_task_cpus
>>>> ret=$?
>>>> if [ $ret -ne 0 ]; then
>>>> - tst_resm TFAIL "task's cpu allowed list isn't
>>>> expected(Result: $task_cpus, Expect: $expect_task_cpus)."
>>>> + tst_resm TFAIL "task's cpu present list isn't
>>>> expected(Result: $task_cpus, Expect: $expect_task_cpus)."
>>>> fi
>>>> else
>>>> if [ "$cpus" = "" ]; then
>>>>
>>>>
>>>> Best Regards
>>>> Yang XU
>>>>> Hi Samuel, Zou
>>>>>> Hi,
>>>>>>
>>>>>> A friendly reminder for the two patchs in:
>>>>>>
>>>>>> https://patchwork.ozlabs.org/project/ltp/patch/1617707717-63693-1-git-send-email-zou_wei@huawei.com/
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> https://patchwork.ozlabs.org/project/ltp/patch/1617701249-62196-1-git-send-email-zou_wei@huawei.com/
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> Can someone please review the patchs, comment, and if appropriate
>>>>>> commit
>>>>>> them?
>>>>>>
>>>>>> Regards,
>>>>>> Zou Wei
>>>>>>
>>>>>> On 2021/4/6 17:27, Zou Wei wrote:
>>>>>>> --------------------------
>>>>>>>
>>>>>>> 1. The method of obtaining $task_cpus from root_cpu_hotplug_test is
>>>>>>> incorrect, because the value of Cpus_allowed_list is related
>>>>>>> to /sys/devices/system/cpu/possible and
>>>>>>> /sys/devices/system/cpu/isolated.
>>>>>>>
>>>>>>> 2. If isolcpus is configured in cmdline, the value of
>>>>>>> Cpus_allowed_list is equal to /sys/devices/system/cpu/possible minus
>>>>>>> /sys/devices/system/cpu/isolated. In this case, $task_cpus is
>>>>>>> inconsistent
>>>>>>> with $expect_task_cpus, test will be failed.
>>>>>>>
>>>>>>> 3. Need to change the method of obtaining $task_cpu
>>>>>>> from /sys/devices/system/cpu/present.
>>>>> Thanks for your patch, I also met the same problem when
>>>>> /sys/devices/system/cpu/possible is not equal
>>>>> to/sys/devices/system/cpu/possible/present .
>>>>> Cpus_allowed_list: 0-511
>>>>> but my present cpu is 0-103
>>>>>
>>>>> Then I use possible_cpus==104 in /etc/defaut/grub, cpu_hotplug case
>>>>> then
>>>>> pass.
>>>>>
>>>>> According to kernel documentation[1] and kernel fs/proc/array
>>>>> code[2](It
>>>>> just print cpu mask instead of present cpu), So using
>>>>> /sys/devices/system/cpu/present is right instead of getting
>>>>> cpu_allow_list.
>>>>>
>>>>> possible: cpus that have been allocated resources and can be
>>>>> brought online if they are present.
>>>>>
>>>>> present: cpus that have been identified as being present in
>>>>> the system.
>>>>>
>>>>>
>>>>> Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>>>>>
>>>>> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>>
>>>>>
>>>>>
>>>>> [2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/proc/array.c#n418
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> ps:
>>>>> Also find a kernel documentation problem and have sent a patch to
>>>>> remove
>>>>> non-existed cpu-hotplug.txt in admin-guide/cputopology.rst.
>>>>>
>>>>>
>>>>> Best Regards
>>>>> Yang Xu
>>>>>>>
>>>>>>> 4. The description of cpu_present_mask:
>>>>>>> Bitmap of CPUs currently present in the system.
>>>>>>> Not all of them may be online. When physical hotplug is processed
>>>>>>> by the relevant subsystem (e.g ACPI) can change and new bit
>>>>>>> either be
>>>>>>> added or removed from the map depending on the event is
>>>>>>> hot-add/hot-remove. There are currently no locking rules as of now.
>>>>>>> Typical usage is to init topology during boot,
>>>>>>> at which time hotplug is disabled.
>>>>>>>
>>>>>>> Signed-off-by: Zou Wei <zou_wei@huawei.com>
>>>>>>> ---
>>>>>>> .../controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
>>>>>>> | 3
>>>>>>> +--
>>>>>>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git
>>>>>>> a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> index 155e536..2c6993a 100755
>>>>>>> ---
>>>>>>> a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> +++
>>>>>>> b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_hotplug_test.sh
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> @@ -93,8 +93,7 @@ root_cpu_hotplug_test()
>>>>>>> root_cpus="`cat $CPUSET/cpuset.cpus`"
>>>>>>> - task_cpus="`cat /proc/$tst_pid/status | grep Cpus_allowed_list`"
>>>>>>> - task_cpus="`echo $task_cpus | sed -e 's/Cpus_allowed_list: //'`"
>>>>>>> + task_cpus="`cat /sys/devices/system/cpu/present`"
>>>>>>> check_result "$root_cpus" "$expect_cpus"
>>>>>>> ret=$?
>>>>>>>
>>>>>>
