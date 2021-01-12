From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 12 Jan 2021 18:44:06 +0800
Subject: [LTP] [PATCH] cpuset_inherit: Use the original mem value
 instead of N_NODES
In-Reply-To: <5FFC14A6.3030408@cn.fujitsu.com>
References: <1606701966-1596-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <X/hdjNT81M9CxbaD@yuki.lan> <5FFC14A6.3030408@cn.fujitsu.com>
Message-ID: <5FFD7D76.6070301@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril

When I look these cpuset cases(cpuset_base_ops_test, 
cpuset_hierarchy_test, cpuset_inherit_test...), these cases seems all 
not consider the situation(cpus/memory are not numbered continously). If 
we want to modify them to be situable for not numbered continously, it 
will be complexd(especially cpuset_base_ops_test). AFAIK, I rarely see 
not numbered continously for memory node. IMO, we just check whether 
memory/cpu numbered continously, if not, we just report TCONF and remind 
user to change their system to meet environment, so their system can be 
fully tested.

For cpu, maybe we can use the following script to detect

cpu_string="`cat /sys/devices/system/cpu/online`"
offline_string="`cat /sys/devices/system/cpu/online`"
NR_CPUS=`tst_ncpus`
ALL_CPUS=`tst_ncpus_conf`
if [ $NR_CPUS -eq $ALL_CPUS ]; then
        tst_resm TINFO "All($ALL_CPUS) logical cpus on your environment"
else
       tst_brkm TCONF "Not all logical cpus on, 
online($cpu_string),offline($offline_string)"
fi

I wonder if it's worth changing the stable cpuset/memory cases for these 
rared situation(memory/cpu are not numbered continously).

What do you think about it?

ps:I have modify cpuset_inherit case, but when I modify 
cpuset_base_ops_test, I find it needs lots of changes because we need to 
distinguish cpu or memory  whether numbered continously.

the change for cpuset_inherit as attach

Best Regards
Yang Xu
> Hi Cyril
>> Hi!
>>> Since ltp commit cf33086a1ca, we add cgroup.clone_children switch for
>>> cpuset.cpus and mems, we used the original memory value to set in
>>> cpuset_inherit case.
>>>
>>> After ltp commit 6872ad15a, we improve the node number calculation
>>> for N_NODES,
>>> so it can calculate for N_NODES obtained from the file contains only
>>> "0,8".
>>>
>>> But it doesn't think about this patch will affect mem_string value,
>>> so this
>>> cpuset_inherit case will fail on 4 numa nodes pc, as below:
>>>
>>> cpuset_inherit 1 TPASS: cpus: Inherited information is right!
>>> cpuset_inherit 3 TPASS: cpus: Inherited information is right!
>>> cpuset_inherit 5 TPASS: cpus: Inherited information is right!
>>> cpuset_inherit 7 TPASS: cpus: Inherited information is right!
>>> cpuset_inherit 9 TPASS: cpus: Inherited information is right!
>>> cpuset_inherit 11 TPASS: cpus: Inherited information is right!
>>> cpuset_inherit 13 TPASS: mems: Inherited information is right!
>>> cpuset_inherit 15 TPASS: mems: Inherited information is right!
>>> cpuset_inherit 17 TPASS: mems: Inherited information is right!
>>> cpuset_inherit 19 TPASS: mems: Inherited information is right!
>>> cpuset_inherit 21 TPASS: mems: Inherited information is right!
>>> cpuset_inherit 23 TFAIL: mems: Test result - 0-3 Expected string - "4"
>>>
>>> Fix this by using original mem value.
>>>
>>> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>>> ---
>>> testcases/kernel/controllers/cpuset/cpuset_funcs.sh | 7 +++----
>>> .../cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh | 6 ++----
>>> 2 files changed, 5 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
>>> b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
>>> index f4365af2c..b469140ca 100755
>>> --- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
>>> +++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
>>> @@ -28,10 +28,11 @@
>>>
>>> NR_CPUS=`tst_ncpus`
>>> if [ -f "/sys/devices/system/node/has_high_memory" ]; then
>>> - N_NODES="`cat /sys/devices/system/node/has_high_memory | tr ',' ' '`"
>>> + mem_string="`cat /sys/devices/system/node/has_high_memory`"
>>> else
>>> - N_NODES="`cat /sys/devices/system/node/has_normal_memory | tr ',' '
>>> '`"
>>> + mem_string="`cat /sys/devices/system/node/has_normal_memory`"
>>> fi
>>> +N_NODES="`echo $mem_string | tr ',' ' '`"
>>> count=0
>>> for item in $N_NODES; do
>>> delta=1
>>> @@ -42,8 +43,6 @@ for item in $N_NODES; do
>>> done
>>> N_NODES=$count
>>>
>>> -mem_string="$N_NODES"
>>> -
>>> CPUSET="/dev/cpuset"
>>> CPUSET_TMP="/tmp/cpuset_tmp"
>>> CLONE_CHILDREN="/dev/cpuset/cgroup.clone_children"
>>>
>>> diff --git
>>> a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
>>> b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
>>>
>>> index 73eed2cb9..27ff19532 100755
>>> ---
>>> a/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
>>>
>>> +++
>>> b/testcases/kernel/controllers/cpuset/cpuset_inherit_test/cpuset_inherit_testset.sh
>>>
>>> @@ -31,10 +31,8 @@ export TST_COUNT=1
>>> check 1 1
>>>
>>> nr_cpus=$NR_CPUS
>>> -nr_mems=$N_NODES
>>>
>>> cpus_all="$(seq -s, 0 $((nr_cpus-1)))"
>>> -mems_all="$(seq -s, 0 $((nr_mems-1)))"
>>>
>>> exit_status=0
>>>
>>> @@ -134,10 +132,10 @@ test_mems()
>>> done<<- EOF
>>> 0 NULL EMPTY
>>> 0 0 EMPTY
>>> - 0 $mems_all EMPTY
>>> + 0 $mem_string EMPTY
>>> 1 NULL EMPTY
>>> 1 0 0
>>> - 1 $mems_all $mem_string
>>> + 1 $mems_string $mem_string
> here has a typo, mems_string->mem_string
>>> EOF
>>> # while read mems result
>>> }
>>
>> I guess that it looks okay to me. I guess that we can commit this before
>> the release, so acked.
>>
>> But don't we have the same problem for cpus_all? If we, for instance,
>> have a machine where cpus are not numbered continously we will fail as
>> well, right?
> Yes, it has the same problem for cpus_all.
>>
>> I guess that a proper fix would be to rewrite the tests to parse the
>> strings into a bitflag arrays and compare these arrays instead of the
>> string comparsion and hacks that keeps up pilling up.
> Will do it in v2.
>>
>



-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: diff.txt
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210112/c9f7e91e/attachment-0001.txt>
