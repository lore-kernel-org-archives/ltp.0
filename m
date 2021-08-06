From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Fri, 6 Aug 2021 13:42:22 +0800
Subject: [LTP] [PATCH] lib/tst_tmpdir: tst_get_tmpdir() add error handing
In-Reply-To: <b208d879-0d31-ff16-4ef0-d363e9a65c51@jv-coder.de>
References: <20210806032131.25721-1-zhanglianjie@uniontech.com>
 <b208d879-0d31-ff16-4ef0-d363e9a65c51@jv-coder.de>
Message-ID: <d550840f-f0dc-0e9d-aa2a-54970ca7619e@uniontech.com>+661201FF716C5BBC
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
> On 8/6/2021 5:21 AM, zhanglianjie wrote:
>> Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>
>>
>> diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
>> index 0c39eb89f..f006e4893 100644
>> --- a/lib/tst_tmpdir.c
>> +++ b/lib/tst_tmpdir.c
>> @@ -108,12 +108,18 @@ int tst_tmpdir_created(void)
>>
>> ? char *tst_get_tmpdir(void)
>> ? {
>> +??? char *ret = NULL;
>> +
>> ????? if (TESTDIR == NULL) {
>> ????????? tst_brkm(TBROK, NULL, "you must call tst_tmpdir() first");
>> ????????? return NULL;
>> ????? }
>>
>> -??? return strdup(TESTDIR);
>> +??? ret = strdup(TESTDIR);
> Is a failing strdup here really a thing? The only reason strdup should 
> be able to fail is with ENOMEM.
> The only way tst_brkm will work, if strdup fails here is, if TESTDIR is 
> an extremely huge string (the NULL case is already handled above).
If don?t consider a very huge string, you don?t need to modify it here. 
This is a habitual judgment.
Thank you for your review.
>> +??? if (!ret)
>> +??????? tst_brkm(TBROK, NULL, "strdup() failed");
>> +
>> +??? return ret;
>> ? }
>>
>> ? const char *tst_get_startwd(void)
>> -- 
>> 2.20.1
>>
>>
> Joerg
> 

-- 
Regards,
Zhang Lianjie


