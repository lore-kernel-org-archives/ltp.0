From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Tue, 11 Jul 2017 19:47:45 +0800
Subject: [LTP] [PATCH 3/3] commands/keyctl01: Enable this test for RHEL6
In-Reply-To: <20170707131344.GD28534@rei.lan>
References: <1494483656-15971-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1494483656-15971-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20170707131344.GD28534@rei.lan>
Message-ID: <df96436c-278c-8e91-6c64-9c1413f66d80@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi!

Thanks for your review.

在 07/07/2017 09:13 PM, Cyril Hrubis 写道:
> Hi!
>> diff --git a/testcases/commands/keyctl/keyctl01.sh b/testcases/commands/keyctl/keyctl01.sh
>> index 8ea2b25..40183b0 100644
>> --- a/testcases/commands/keyctl/keyctl01.sh
>> +++ b/testcases/commands/keyctl/keyctl01.sh
>> @@ -37,8 +37,9 @@ TST_NEEDS_CMDS="keyctl"
>>  
>>  setup()
>>  {
>> -	if tst_kvcmp -le 2.6.33; then
>> -		tst_brk TCONF "Kernel newer than 2.6.33 is needed"
>> +	if tst_kvcmp -le '2.6.33 RHEL6:2.6.32-254'; then
>> +		tst_brk TCONF \
>> +			"Kernel newer than 2.6.33 or 2.6.32-254.el6 is needed"
> 
> I would be a bit happier if we could check if keyctl operations we need
> for the test are supported (if that is reasonably easy to do) insetad of
> listing minimal kernel versions per distribution.

OK, I see.
I will check if they are supported and drop the tst_kvcmp, thanks.

Best Regards,
Guangwen Feng


