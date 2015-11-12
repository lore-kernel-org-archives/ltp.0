From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 12 Nov 2015 11:36:03 +0800
Subject: [LTP] [PATCH v2] commands/mkswap: Added new testcase to test
	mkswap(8).
In-Reply-To: <56430E00.1050708@oracle.com>
References: <563C94F5.9040803@oracle.com>
 <1447056173-8979-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <56430E00.1050708@oracle.com>
Message-ID: <56440923.8000609@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

I will modify the test case according to your suggestion, thanks!

Best Regards,
Guangwen Feng

On 2015/11/11 17:44, Alexey Kodanev wrote:
> Hi,
> On 11/09/2015 11:02 AM, Guangwen Feng wrote:
>> Test mkswap(8) command with some basic options.
>>
>> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
>> ---
>>   runtest/commands                      |   1 +
>>   testcases/commands/mkswap/Makefile    |  22 +++++
>>   testcases/commands/mkswap/mkswap01.sh | 155 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 178 insertions(+)
>>   create mode 100644 testcases/commands/mkswap/Makefile
>>   create mode 100755 testcases/commands/mkswap/mkswap01.sh
> ...
>> ...
>> +
>> +mkswap_verify()
>> +{
>> +    local mkswap_op=$1
>> +    local op_arg=$2
>> +    local device=$3
>> +    local size=$4
>> +
>> +    local ret=0
>> +
>> +    local before=`free | grep "Swap" | awk '{print $2}'`
>> +
>> +    if [ -z "$size" ]; then
>> +        local swapsize=$DEVICE_SIZE
>> +    else
>> +        local swapsize=$size
>> +    fi
> 
> No need to check it here if you define single variable, i.e. size=${4:-$DEVICE_SIZE}
> 
>> +
>> +    if [ "$mkswap_op" = "-p" ]; then
>> +        local pagesize=$op_arg
>> +    else
>> +        local pagesize=$PAGE_SIZE
>> +    fi
>> +
>> +    if [ "$mkswap_op" = "-L" ]; then
>> +        local swap_op="-L"
>> +        local swapfile=$op_arg
>> +    elif [ "$mkswap_op" = "-U" ]; then
>> +        local swap_op="-U"
> 
> 'swap_op' var is redundant, instead just set "mkswap_op=" in the else branch below.
> 
>> +        local swapfile=$op_arg
>> +    else
>> +        local swap_op=""
>> +        local swapfile=$device
>> +    fi
>> +
> 
>> +    swapon $swap_op $swapfile 2>/dev/null
>> +    if [ $? -ne 0 ]; then
>> +        tst_resm TINFO "can not do swapon on $swapfile."
>> +        if [ $pagesize -ne $PAGE_SIZE ]; then
>> +            return $ret
>> +        fi
>> +
>> +        if [ $swapsize -gt $DEVICE_SIZE ]; then
>> +            return $ret
>> +        fi
>> +    fi
>> +
> 
> There are two conditions that returns 0 when swapon command fails. If it is expected result, could you provide more informative tst_resm message in each case. Other cases should return 1, right? But the test proceeds further.
> 
> Thanks,
> Alexey
> .
> 
