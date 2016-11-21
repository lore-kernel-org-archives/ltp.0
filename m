From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 21 Nov 2016 17:07:03 +0300
Subject: [LTP] [PATCH 2/2] du01.sh: BTRFS fix for the symlink
In-Reply-To: <20161121124036.GD25334@rei.lan>
References: <20161110151248.GA13022@rei.suse.cz>
 <1479310748-14359-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1479310748-14359-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20161121124036.GD25334@rei.lan>
Message-ID: <5832FF87.2000701@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 11/21/2016 03:40 PM, Cyril Hrubis wrote:
> Hi!
>> By default, BTRFS reports symlinks to be of page size.
>>
>> Modify the corresponding check to verify if the symlink
>> is either 0 or page size.
>>
>> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
>> ---
>>  testcases/commands/du/du01.sh |    8 +++++++-
>>  1 files changed, 7 insertions(+), 1 deletions(-)
>>
>> diff --git a/testcases/commands/du/du01.sh b/testcases/commands/du/du01.sh
>> index 823c50a..7b17f6f 100755
>> --- a/testcases/commands/du/du01.sh
>> +++ b/testcases/commands/du/du01.sh
>> @@ -83,12 +83,18 @@ setup
>>  
>>  block_size=512
>>  
>> +page_size=$(getconf PAGESIZE)
>> +if [ "$page_size" -lt 1024 ]; then
>> +	tst_brkm TBROK "Page size < 1024"
>> +fi
> 
> I doubt that this will ever happen, but it does not do any harm anyway.
> 
> Both patches acked, thanks for fixing this.

Thank you. Pushed.


> 
>> +page_size=$(( page_size / 1024 ))
>> +
>>  # The output could be different in some systems, if we use du to
>>  # estimate file space usage with the same filesystem and the same size.
>>  # So we use the approximate value to check.
>>  check1="^10[2-3][0-9][0-9][[:space:]]\."
>>  check2="^10[2-3][0-9][0-9][[:space:]]testfile"
>> -check3="^[0-4][[:space:]]\.\/testdir\/testsymlink"
>> +check3="^\(0\|${page_size}\)[[:space:]]\.\/testdir\/testsymlink"
>>  check5="^20[4-6][0-9][0-9][[:space:]]\."
>>  check7="^10[4-5][0-9][0-9]\{4\}[[:space:]]\."
>>  check9="^10[2-3][0-9][0-9][[:space:]]total"
>> -- 
>> 1.7.1
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
