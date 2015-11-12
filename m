From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 12 Nov 2015 11:27:24 +0800
Subject: [LTP] [PATCH] commands/mkswap: Added new testcase to test
	mkswap(8).
In-Reply-To: <BLU436-SMTP8601D757580F449BE1A80CF130@phx.gbl>
References: <1446692628-12706-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <BLU436-SMTP1923895FA6B242E57BC28CDCF150@phx.gbl>
 <5640430D.40903@cn.fujitsu.com>
 <BLU436-SMTP8601D757580F449BE1A80CF130@phx.gbl>
Message-ID: <5644071C.1060202@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 2015/11/11 11:45, Lei Li wrote:
>> Hi!
>> Thanks for review!
>>
>> On 2015/11/09 10:00, Lei Li wrote:
>>>> +setup()
>>>> +{
>>>> +    tst_require_root
>>>> +
>>>> +    tst_check_cmds losetup free mkswap
>>>> +
>>>> +    tst_tmpdir
>>>> +
>>>> +    TST_CLEANUP=cleanup
>>>> +
>>>> +    tst_acquire_device
>>>> +
>>>> +    local path=`losetup -a | grep "$TMPDIR"  | awk '{print $3}' | \
>>>> +        cut -d '(' -f2 | cut -d ')' -f1`
>>>> +    DEVICE_SIZE=$((`ls -l $path | awk '{print $5}'`/1024))
>>> Hi!
>>>      This testcase uses a loop device instead of a block device, but tst_acquire_device may offer you a block device, /opt/ltp/runltp -b /dev/sdb1 for example, then, "path" may be invilidate, and syntax error occurs in the line :
>>>
>>> DEVICE_SIZE=$((`ls -l $path | awk '{print $5}'`/1024))
>>>
>>> So, examination whether the "path" is validate is necessary.
>>>
>>
>> Indeed, I missed the condition of block device.
>> I think I could use DEVICE_SIZE=$((`blockdev --getsize64 $TST_DEVICE`/1024)) instead of via path.
>>
>>>> +
>>>> +    PAGE_SIZE=`getconf PAGE_SIZE`
>>>> +}
>>>> +
>>>> +cleanup()
>>>> +{
>>>> +    tst_release_device
>>>> +
>>>> +    tst_rmdir
>>>> +}
>>>> +
>>>> +mkswap_verify()
>>>> +{
>>>> +    local ret=0
>>>> +
>>>> +    local before=`free | grep "Swap" | awk '{print $2}'`
>>>> +
>>>> +    if [ -z "$4" ]; then
>>>> +        local swapsize=$DEVICE_SIZE
>>>> +    else
>>>> +        local swapsize=$4
>>>> +    fi
>>>> +
>>>> +    if [ "$1" = "-p" ]; then
>>>> +        local pagesize=$2
>>>> +    else
>>>> +        local pagesize=$PAGE_SIZE
>>>> +    fi
>>>> +
>>>> +    if [ "$1" = "-L" ]; then
>>>> +        local swap_op="-L"
>>>> +        local swapfile=$2
>>>> +    elif [ "$1" = "-U" ]; then
>>>> +        local swap_op="-U"
>>>> +        local swapfile=$2
>>>> +    else
>>>> +        local swap_op=""
>>>> +        local swapfile=$3
>>>> +    fi
>>>> +
>>>> +    swapon $swap_op $swapfile 2>/dev/null
>>>> +    if [ $? -ne 0 ]; then
>>>> +        tst_resm TINFO "can not do swapon on $swapfile."
>>>> +        if [ $pagesize -ne $PAGE_SIZE ]; then
>>>> +            return $ret
>>>> +        fi
>>>> +
>>>> +        if [ $swapsize -gt $DEVICE_SIZE ]; then
>>>> +            return $ret
>>>> +        fi
>>>> +    fi
>>>> +
>>>> +    local after=`free | grep "Swap" | awk '{print $2}'`
>>>> +
>>>> +    local est=16
>>>> +    if [ $((after-before)) -lt $((swapsize-pagesize/1024-est)) ] || \
>>>> +        [ $((after-before)) -gt $((swapsize-pagesize/1024+est)) ]; then
>>>> +        ret=1
>>>> +    fi
>>>
>>> How do you get this formula? I'm a newbie here :-)
>>>
>>
>> I just compare device size used for swap with the actual increment of swap.
>> The increment should be equal to the device size minus a page size, but in some cases, the result fluctuates.
> 
> Hi
>   I read the code of mkswap, find nothing about the fluctuation but
> the exact value(as you mentioned above, device size minus a page size).
> And the fluctuation didn't show up in all of my test result.Would you
> please give me some proof about the fluctuation ?
> 

Yes, in most of my environment, there is no fluctuation but the exact value,
but for example, on my RHEL5.11GA, the result is not exactly equal to the value somehow,
maybe the result is slightly different in some kernels.

Best Regards,
Guangwen Feng

> Thanks.
