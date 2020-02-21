From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 21 Feb 2020 10:08:30 +0800
Subject: [LTP] [PATCH v2] syscalls/quotactl07: add regresstion test for
 Q_XQTUOTARM
In-Reply-To: <20200220124821.GB11142@rei>
References: <1575526664-25738-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200220124821.GB11142@rei>
Message-ID: <eb73f177-9e2b-7a35-cf1a-e36c1a5ce19e@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi> Hi!
>> This is a regresstion test to check Q_XQUOTARM  whether has
>> quota flags check.
>>
>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>>
>> ---------------------
>> 1.Simplify test code
>> 2.add comment for invalid_type,
>> ---------------------
>    ^
>    Btw this belongs under the three dashes below, otherwise it ends up in
>    the commit message when applied.
> 
OK. I will notice this next time.
> ...
> 
>> +static void setup(void)
>> +{
>> +	TEST(quotactl(QCMD(Q_XQUOTAOFF, USRQUOTA), tst_device->dev, 0, (void *)&qflag_acct));
>> +	if (TST_RET == -1)
>> +		tst_brk(TBROK | TTERRNO, "quotactl with Q_XQUOTAOFF failed");
>> +
>> +	TEST(quotactl(QCMD(Q_XQUOTARM, USRQUOTA), tst_device->dev, 0, (void *)&valid_type));
>> +	if (TST_ERR == EINVAL) {
>> +		tst_res(TCONF, "current system doesn't support Q_XQUOTARM, skip it");
>> +		return;
> 
> I've changed this to tst_brk() because doing return from setup has no
> efect here, and pushed, thanks.
Thanks for pushing.
> 


