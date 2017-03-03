From: Li Wang <liwang@redhat.com>
Date: Fri, 3 Mar 2017 11:22:37 +0800
Subject: [LTP] [PATCH v2] ltp/numa: add new test11
In-Reply-To: <20170302151403.GE27525@rei.lan>
References: <1486371038-24332-1-git-send-email-liwang@redhat.com>
 <20170302151403.GE27525@rei.lan>
Message-ID: <CAEemH2ecyww=ghONOvLmFaN6SpXCD-8iYg9sCOu1qU0w-OeHuA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Mar 2, 2017 at 11:14 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
>>  TST_ID="numa01"
>> -TST_CNT=10
>> +TST_CNT=11
>>  TST_SETUP=setup
>>  TST_TESTFUNC=test
>>  TST_NEEDS_TMPDIR=1
>> @@ -83,11 +84,13 @@ setup()
>>  {
>>       export MB=$((1024*1024))
>>       export PAGE_SIZE=$(getconf PAGE_SIZE)
>> +     export HPAGE_SIZE=$(cat /proc/meminfo  |grep "Hugepagesize:" |awk '{print $2}')
>
> awk '/Hugepagesize:/ {print $2}' /proc/meminfo
>
> And we should fix the rest of the awk statements in the script as well
> (in a separate patch).

Sure.

>
>>       # arguments to memory exercise program support_numa.c
>>       ALLOC_1MB=1
>>       SHARE_1MB=2
>> -     PAUSE=3
>> +     HUGE_PAGE=3
>> +     PAUSE=4
>>
>>       total_nodes=0
>>
>> @@ -399,4 +402,45 @@ test10()
>>       tst_res TPASS "NUMA MIGRATEPAGES policy"
>>  }
>>
>> +# Verification of hugepage memory allocated on a node
>> +test11()
>> +{
>> +     Mem_huge=0
>> +
>> +     if [ ! -d "/sys/kernel/mm/hugepages/" ]; then
>> +             tst_res TCONF "hugepage is not supported"
>> +             return
>> +     fi
>> +
>> +     for node in $nodes_list; do
>> +             Ori_hpgs=$(cat /sys/devices/system/node/node${node}/hugepages/hugepages-${HPAGE_SIZE}kB/nr_hugepages)
>> +             New_hpgs=$((Ori_hpgs + 1))
>> +             echo $New_hpgs >/sys/devices/system/node/node${node}/hugepages/hugepages-${HPAGE_SIZE}kB/nr_hugepages
>> +
>> +             Chk_hpgs=$(cat /sys/devices/system/node/node${node}/hugepages/hugepages-${HPAGE_SIZE}kB/nr_hugepages)
>> +             if [ "$Chk_hpgs" -ne "$New_hpgs" ]; then
>> +                     tst_res TCONF "hugepage is not enough to test"
>> +                     return
>> +             fi
>> +
>> +             numactl --cpunodebind=$node --membind=$node support_numa $HUGE_PAGE &
>> +             pid=$!
>> +             wait_for_support_numa $pid
>> +
>> +             Mem_huge=$(echo $(numastat -p $pid |grep '^Huge' |awk '{print $'$((node+2))'}'))
>
> Here as well, no need to use grep.

Sure.

>
>> +             Mem_huge=$((${Mem_huge%.*} * 1024))
>> +
>> +             if [ "$Mem_huge" -lt "$HPAGE_SIZE" ]; then
>> +                     tst_res TFAIL \
>> +                             "NUMA memory allocated in node$node is less than expected"
>
> We should restore the /sys/ file and kill the support_numa process here
> as well.

Good point. The remains of testcase have not do that too, let me add
all of that in a new patch.

-- 
Regards,
Li Wang
Email: liwang@redhat.com
