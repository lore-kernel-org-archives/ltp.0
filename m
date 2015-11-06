From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Fri, 6 Nov 2015 13:17:10 +0800
Subject: [LTP] [PATCH] commands/mkswap: Added new testcase to test
	mkswap(8).
In-Reply-To: <563B404D.8040504@oracle.com>
References: <1446692628-12706-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <563B404D.8040504@oracle.com>
Message-ID: <563C37D6.1050707@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Thanks for your review!

On 2015/11/05 19:41, Alexey Kodanev wrote:
> Hi,
> On 11/05/2015 06:03 AM, Guangwen Feng wrote:
>> Test mkswap(8) command with some basic options.
>>
>> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
>> ---
>>   runtest/commands                      |   1 +
>>   testcases/commands/mkswap/Makefile    |  24 +++++
>>   testcases/commands/mkswap/mkswap01.sh | 196 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 221 insertions(+)
>>   create mode 100644 testcases/commands/mkswap/Makefile
>>   create mode 100755 testcases/commands/mkswap/mkswap01.sh
>>
>> diff --git a/runtest/commands b/runtest/commands
>> index 6c0485b..ab600dc 100644
>> --- a/runtest/commands
>> +++ b/runtest/commands
>> @@ -38,3 +38,4 @@ mkfs01_minix mkfs01.sh -f minix
>>   mkfs01_msdos mkfs01.sh -f msdos
>>   mkfs01_vfat mkfs01.sh -f vfat
>>   mkfs01_ntfs mkfs01.sh -f ntfs
>> +mkswap01 mkswap01.sh
>> diff --git a/testcases/commands/mkswap/Makefile b/testcases/commands/mkswap/Makefile
>> new file mode 100644
>> index 0000000..39651c0
>> --- /dev/null
>> +++ b/testcases/commands/mkswap/Makefile
>> @@ -0,0 +1,24 @@
>> +#
>> +#    commands/mkswap testcases Makefile.
> 
> There is no need for such a comment.
> 

OK, got it.

>> +#
>> +#
>> +
>> +setup()
>> +{
>> +    tst_require_root
>> +
>> +    tst_check_cmds losetup free mkswap
>> +
>> +    tst_tmpdir
>> +
>> +    TST_CLEANUP=cleanup
>> +
>> +    tst_acquire_device
>> +
>> +    local path=`losetup -a | grep "$TMPDIR"  | awk '{print $3}' | \
>> +        cut -d '(' -f2 | cut -d ')' -f1`
> 
> Isn't it easier to get path with $(losetup -l | grep tmp | awk '{print $6}')
> 

Yes, it's easier to use losetup -l, but RHEL5.11GA does not support -l option,
so I would use losetup -a here.

>> +    DEVICE_SIZE=$((`ls -l $path | awk '{print $5}'`/1024))
>> +
>> +    PAGE_SIZE=`getconf PAGE_SIZE`
>> +}
>> +
>> +cleanup()
>> +{
>> +    tst_release_device
>> +
>> +    tst_rmdir
>> +}
>> +
>> +mkswap_verify()
>> +{
>> +    local ret=0
>> +
>> +    local before=`free | grep "Swap" | awk '{print $2}'`
>> +
>> +    if [ -z "$4" ]; then
>> +        local swapsize=$DEVICE_SIZE
>> +    else
>> +        local swapsize=$4
>> +    fi
>> +
>> +    if [ "$1" = "-p" ]; then
>> +        local pagesize=$2
> 
> I would name each parameter ($1,$2,...) in the begining of the function as of make them more informative.
> Or use "while getopts; do".
> 

Indeed, it needs to be more informative.
I will name them, thanks.

>> +
>> +mkswap_test()
>> +{
>> +    local mkswap_op=$1
>> +    local op_arg=$2
>> +    local device=$3
>> +    local size=$4
>> +
>> +    local mkswap_cmd="mkswap $mkswap_op $op_arg $device $size"
>> +
>> +    ${mkswap_cmd} >temp 2>&1
>> +    if [ $? -ne 0 ]; then
>> +        grep -q -E "unknown option|invalid option|Usage" temp
>> +        if [ $? -eq 0 ]; then
>> +            tst_resm TCONF "'${mkswap_cmd}' not supported."
>> +            return
>> +        else
> 
> Don't need 'else' after return.
> 

OK, got it.

>> +            tst_resm TFAIL "'${mkswap_cmd}' failed."
>> +            cat temp
>> +            return
>> +        fi
>> +    fi
>> +
>> +    if [ -n "$device" ]; then
>> +        mkswap_verify "$mkswap_op" "$op_arg" "$device" "$size"
>> +        if [ $? -ne 0 ]; then
>> +            tst_resm TFAIL "'${mkswap_cmd}' failed, not expected."
>> +            return
>> +        fi
>> +    fi
>> +
>> +    tst_resm TPASS "'${mkswap_cmd}' passed."
>> +}
>> +
>> +test1()
>> +{
>> +    mkswap_test "" "" "$TST_DEVICE"
>> +}
> 
> May be it would be better to call mkswap_test() without such wrappers and the for loop in the end.
> 

Sorry, do you mean just call mkswap_test() straightforward with different arguments for all these tests?

Best Regards,
Guangwen Feng

> Best regards,
> Alexey
> .
> 
