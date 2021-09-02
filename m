From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Thu, 2 Sep 2021 01:17:04 +0000
Subject: [LTP] [PATCH] syscalls/pread01: Convert to new API
In-Reply-To: <YS+JQLNhte4E3jxM@pevik>
References: <1629294657-28375-1-git-send-email-daisl.fnst@fujitsu.com>
 <YS+JQLNhte4E3jxM@pevik>
Message-ID: <61302619.2020203@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr
> Hi Dai,
>
>> diff --git a/testcases/kernel/syscalls/pwrite/pwrite01.c b/testcases/kernel/syscalls/pwrite/pwrite01.c
> ...
>> -/*
>> - * Test Name: pwrite01
>> +/*\
>> + * [Description]
>>    *
>> - * Test Description:
>>    *  Verify the functionality of pwrite() by writing known data using pwrite()
>>    *  to the file at various specified offsets and later read from the file from
>>    *  various specified offsets, comparing the data written aganist the data
>>    *  read using read().
>
> You kept 2 spaces between * and text. That'll lead in docparse formatting (which
> uses markdown) to formatted as code, which is wrong. It must be without space:
>
> /*\
>   * [Description]
>   *
>   * Verify the functionality of pwrite() by writing known data using pwrite()
>   * to the file at various specified offsets and later read from the file from
>   * various specified offsets, comparing the data written aganist the data
>   * read using read().
>   */
>
> Again, I have already prepared fixes, just wait for others to review.
In fact, I have reviewed these patches in internal before Dan sent these 
patches to ltp. So you can add my Reviewed-by tag for her pread and 
pwrite patches.

Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu
>
> Kind regards,
> Petr
>
