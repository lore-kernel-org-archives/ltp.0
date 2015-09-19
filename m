From: Takeshi Misawa <jeantsuru@icloud.com>
Date: Sat, 19 Sep 2015 16:57:14 +0900
Subject: [LTP] settimeofday01:TFAIL in Kernel 4.2.0
In-Reply-To: <20150915085125.GB3351@rei.suse.cz>
References: <55F587CE.1070904@iCloud.com> <20150915085125.GB3351@rei.suse.cz>
Message-ID: <55FD155A.5020102@iCloud.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
>> This is a my first mail to LTP mailing list.
>>
>> I'm testing Linux Kernel 4.2.0 by LTP. I saw a following Error.
>> -----
>> settimeofday01    1  TFAIL  :  settimeofday01.c:98: Error Setting Time,
>> errno=22
>> settimeofday01    2  TFAIL  :  settimeofday01.c:120: Test condition 1 failed
>> settimeofday01    3  TPASS  :  Test condition 2 successful
>> -----
>>
>> In commit of Linux Kernel:
>> e1d7ba8735551ed79c7a0463a042353574b96da3 "time: Always make sure
>> wall_to_monotonic isn't positive"
>> add a new check to do_settimeofday64().
>>
>> This commit said:
>> "As a result one can't set the CLOCK_REALTIME time prior to (1970 +
>> system uptime)."
>>
>> In settimeofday01 test case, parameter of first settimeofday() is
>> 100s100??s. A lot of cases, TEST_RETURN is -1.
>>
>> I'd better to modify settimeofday01 test case.
>>
>> To meet that requirement, I made following changes.(I have less
>> confidence that it is correct...)
>
> The patch looks good but does not apply since the the whitespaces are
> corrupted. Can you please resend correct one with a better changelog and
> Signed-off-by line? (set you name and email in git, then use git commit
> -s and git format-patch -1 and send the result)
>
> Also the mailing list has moved to ltp@lists.linux.it, please use that
> one from now on.
>

Thank you for reply and kindly advice.

I resent a patch. (Sorry for my late reply.)

Thanks
-------------- next part --------------
A non-text attachment was scrubbed...
Name: settimeofday01-fix-settimeofday-argument-4.2.patch
Type: text/x-patch
Size: 1371 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20150919/a0536233/attachment.bin>
