From: Li Wang <liwang@redhat.com>
Date: Wed, 8 Aug 2018 14:08:18 +0800
Subject: [LTP] [PATCH] ltp: replace the retry loops by new exponential
 backoff macro
In-Reply-To: <dbeb13e1-adae-2231-6936-567098ec8867@oracle.com>
References: <20180517062943.13178-1-liwang@redhat.com>
 <20180612155652.mhu2sycbwd5gbu5e@dell5510>
 <dbeb13e1-adae-2231-6936-567098ec8867@oracle.com>
Message-ID: <CAEemH2ebjH3BJwXEhmKgkL+0+im-0eQhrCQFczU3WLKHi9m1dg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Shuang,

Which LTP version do you use?

If I remember correctly, YANG Xiao has already reported this issue and
fixed in:

commit 72c52581747301939340af5b1971dea569248226
Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date:   Sun Jun 24 13:59:43 2018 +0800

    commands/mkswap01.sh: Fix unexisted "/dev/disk/by-*" files on old
kernels


On Wed, Aug 8, 2018 at 5:35 AM, Shuang Qiu <shuang.qiu@oracle.com> wrote:

> Hi,
>
> Referring to commit 8435d0c7283,some version of swapon will not create the
> symlink of the device.
> So it changed TWARN to TINFO so that the test will not break by it.
> We need to handler such situation in the new patch,or revert the change
> for swap01.sh.
>
> Thanks
> Shuang
>
>
> On 06/12/2018 11:56 PM, Petr Vorel wrote:
>
>> Hi Li,
>>
>> Signed-off-by: Li Wang <liwang@redhat.com>
>>> Cc: Petr Vorel <pvorel@suse.cz>
>>> Cc: Cyril Hrubis <chrubis@suse.cz>
>>> ---
>>>   testcases/commands/mkswap/mkswap01.sh | 17 ++++------
>>>   testcases/kernel/numa/numa01.sh       | 58
>>> +++++++++++++++--------------------
>>>
>> Thanks for your patch, applied with diff bellow.
>>
>> I changed:
>> * fix mixing quotes when calling check_for_file. This was also broken on
>> dash
>>    (testing with /bin/sh as symlink to /bin/dash and using
>> checkbashisms.pl
>>    script helps).
>> * simplify check_for_file + remove TINFO message as it was unnecessarily
>> verbose
>>    (see bellow)
>>
>> Kind regards,
>> Petr
>>
>> tst_device.c:83: INFO: Found free device '/dev/loop0'
>> mkswap01 1 TPASS: 'mkswap   /dev/loop0 ' passed.
>> mkswap01 2 TPASS: 'mkswap   /dev/loop0 262140' passed.
>> mkswap01 3 TINFO: Can not do swapon on /dev/loop0.
>> mkswap01 3 TINFO: Device size specified by 'mkswap' greater than real
>> size.
>> mkswap01 3 TINFO: Swapon failed expectedly.
>> mkswap01 3 TPASS: 'mkswap -f  /dev/loop0 262148' passed.
>> mkswap01 4 TPASS: 'mkswap -c  /dev/loop0 ' passed.
>> mkswap01 5 TINFO: Can not do swapon on /dev/loop0.
>> mkswap01 5 TINFO: Page size specified by 'mkswap -p' is not equal to
>> system's page size.
>> mkswap01 5 TINFO: Swapon failed expectedly.
>> mkswap01 5 TPASS: 'mkswap -p 2048 /dev/loop0 ' passed.
>> mkswap01 6 TINFO: The file /dev/disk/by-label/ltp_testswap haven't
>> appeared
>> mkswap01 6 TINFO: The file /dev/disk/by-label/ltp_testswap haven't
>> appeared
>> mkswap01 6 TINFO: The file /dev/disk/by-label/ltp_testswap haven't
>> appeared
>> mkswap01 6 TINFO: The file /dev/disk/by-label/ltp_testswap haven't
>> appeared
>> mkswap01 6 TINFO: The file /dev/disk/by-label/ltp_testswap haven't
>> appeared
>> mkswap01 6 TINFO: The file /dev/disk/by-label/ltp_testswap haven't
>> appeared
>> mkswap01 6 TINFO: The file /dev/disk/by-label/ltp_testswap haven't
>> appeared
>> mkswap01 6 TINFO: The file /dev/disk/by-label/ltp_testswap haven't
>> appeared
>> mkswap01 6 TINFO: The file /dev/disk/by-label/ltp_testswap haven't
>> appeared
>> mkswap01 6 TINFO: The file /dev/disk/by-label/ltp_testswap haven't
>> appeared
>> mkswap01 6 TINFO: The file /dev/disk/by-label/ltp_testswap haven't
>> appeared
>> mkswap01 6 TINFO: The file /dev/disk/by-label/ltp_testswap haven't
>> appeared
>> mkswap01 6 TINFO: The file /dev/disk/by-label/ltp_testswap haven't
>> appeared
>> mkswap01 6 TPASS: 'mkswap -L ltp_testswap /dev/loop0 ' passed.
>> mkswap01 7 TPASS: 'mkswap -v1  /dev/loop0 ' passed.
>> mkswap01 8 TINFO: The file /dev/disk/by-uuid/b20a69ef-cf9d-49fb-a313-284df6ddd794
>> haven't appeared
>> mkswap01 8 TINFO: The file /dev/disk/by-uuid/b20a69ef-cf9d-49fb-a313-284df6ddd794
>> haven't appeared
>> mkswap01 8 TINFO: The file /dev/disk/by-uuid/b20a69ef-cf9d-49fb-a313-284df6ddd794
>> haven't appeared
>> mkswap01 8 TINFO: The file /dev/disk/by-uuid/b20a69ef-cf9d-49fb-a313-284df6ddd794
>> haven't appeared
>> mkswap01 8 TINFO: The file /dev/disk/by-uuid/b20a69ef-cf9d-49fb-a313-284df6ddd794
>> haven't appeared
>> mkswap01 8 TINFO: The file /dev/disk/by-uuid/b20a69ef-cf9d-49fb-a313-284df6ddd794
>> haven't appeared
>> mkswap01 8 TINFO: The file /dev/disk/by-uuid/b20a69ef-cf9d-49fb-a313-284df6ddd794
>> haven't appeared
>> mkswap01 8 TINFO: The file /dev/disk/by-uuid/b20a69ef-cf9d-49fb-a313-284df6ddd794
>> haven't appeared
>> mkswap01 8 TINFO: The file /dev/disk/by-uuid/b20a69ef-cf9d-49fb-a313-284df6ddd794
>> haven't appeared
>> mkswap01 8 TINFO: The file /dev/disk/by-uuid/b20a69ef-cf9d-49fb-a313-284df6ddd794
>> haven't appeared
>> mkswap01 8 TINFO: The file /dev/disk/by-uuid/b20a69ef-cf9d-49fb-a313-284df6ddd794
>> haven't appeared
>> mkswap01 8 TINFO: The file /dev/disk/by-uuid/b20a69ef-cf9d-49fb-a313-284df6ddd794
>> haven't appeared
>> mkswap01 8 TPASS: 'mkswap -U b20a69ef-cf9d-49fb-a313-284df6ddd794
>> /dev/loop0 ' passed.
>> mkswap01 9 TPASS: 'mkswap -V  /dev/loop0 ' passed.
>> mkswap01 10 TPASS: 'mkswap -h  /dev/loop0 ' passed.
>>
>> diff --git testcases/commands/mkswap/mkswap01.sh
>> testcases/commands/mkswap/mkswap01.sh
>> index fc07933ae..5ead4cdc5 100755
>> --- testcases/commands/mkswap/mkswap01.sh
>> +++ testcases/commands/mkswap/mkswap01.sh
>> @@ -41,15 +41,9 @@ check_for_file()
>>   {
>>         local path="$1"
>>   -     if [ -z "$path" ]; then
>> +       if [ -z "$path" -o -e "$path" ]; then
>>                 return
>>         fi
>> -
>> -       if [ -e "$path" ]; then
>> -               return 0
>> -       fi
>> -
>> -       tst_res TINFO "The file $path haven't appeared"
>>         return 1
>>   }
>>   @@ -70,7 +64,7 @@ mkswap_verify()
>>                 local pagesize=$PAGE_SIZE
>>         fi
>>   -     TST_RETRY_FUNC "check_for_file "$dev_file"" 0
>> +       TST_RETRY_FUNC "check_for_file $dev_file" 0
>>         swapon $swapfile 2>/dev/null
>>   diff --git testcases/kernel/numa/numa01.sh
>> testcases/kernel/numa/numa01.sh
>> index f8d8f303c..da2f80ddd 100755
>> --- testcases/kernel/numa/numa01.sh
>> +++ testcases/kernel/numa/numa01.sh
>> @@ -302,11 +302,7 @@ test7()
>>     check_ltp_numa_test8_log()
>>   {
>> -       if grep -m1 -q '.' ltp_numa_test8.log; then
>> -               return 0
>> -       fi
>> -
>> -       return 1
>> +       grep -m1 -q '.' ltp_numa_test8.log
>>   }
>>     # Verification of memhog with interleave policy
>>
>>
>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180808/fb78323e/attachment.html>
