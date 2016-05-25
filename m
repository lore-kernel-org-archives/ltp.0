From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 25 May 2016 10:05:41 +0300
Subject: [LTP] [PATCH v1 1/1] test_robind: add "-f" mkfs option for xfs
 and btrfs
In-Reply-To: <977252429.1084123.1464157861719.JavaMail.zimbra@redhat.com>
References: <20160524074936.11253-1-bxue@redhat.com>
 <882847003.325886.1464098472012.JavaMail.zimbra@redhat.com>
 <20160524152621.GB12920@rei.suse.cz>
 <977252429.1084123.1464157861719.JavaMail.zimbra@redhat.com>
Message-ID: <57454EC5.7050700@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 05/25/2016 09:31 AM, Jan Stancek wrote:
>
>
>
>
> ----- Original Message -----
>> From: "Cyril Hrubis" <chrubis@suse.cz>
>> To: "Jan Stancek" <jstancek@redhat.com>
>> Cc: "Boyang Xue" <bxue@redhat.com>, "stanislav kholmanskikh" <stanislav.kholmanskikh@oracle.com>, ltp@lists.linux.it
>> Sent: Tuesday, 24 May, 2016 5:26:22 PM
>> Subject: Re: [LTP] [PATCH v1 1/1] test_robind: add "-f" mkfs option for xfs and	btrfs
>>
>> Hi!
>>> Alternative would be to zero-erase first blocks of LTP_BIG_DEV
>>> in runltp, but I'm not sure we want to assume that all tests
>>> are going to write over it.
>>>
>>> I found only 3 tests using LTP_BIG_DEV, this is the only
>>> one that is using xfs/btrfs, the other two are ext3/4.
>>
>> Or we can move the dd that erases first blocks from tst_acquire_device()
>> to tst_mkfs().
>
> I went to re-read why we are avoiding -f, and this does sound better
> than adding -f back.

If we move 'dd' to tst_mkfs(), then tst_acquire_device will return 
"uncleared" devices, and mkfs_ext* test cases from runtest/commands will 
start failing in our environment, i.e. we revert f79021c5d168256.

I'd ack the patch, since it affects only one test case.



>
> Regards,
> Jan
>
>>
>> Or we can create an API function to get the path to big device and erase
>> it there...
>>
>> --
>> Cyril Hrubis
>> chrubis@suse.cz
>>
