From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Thu, 5 Aug 2021 01:43:30 +0000
Subject: [LTP] [PATCH 1/1] doc: Specify linux-stable-git rule
In-Reply-To: <YQq3s+33ceaJmvR7@pevik>
References: <20210715065805.14086-1-pvorel@suse.cz> <YQq3s+33ceaJmvR7@pevik>
Message-ID: <610B425F.3080606@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr
> Hi all,
>
>> Signed-off-by: Petr Vorel<pvorel@suse.cz>
>> ---
>>   doc/c-test-api.txt | 4 ++++
>>   1 file changed, 4 insertions(+)
>
>> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
>> index 45784195b..9d26a483d 100644
>> --- a/doc/c-test-api.txt
>> +++ b/doc/c-test-api.txt
>> @@ -2205,6 +2205,10 @@ struct tst_test test = {
>>   };
>>   -------------------------------------------------------------------------------
>
>> +NOTE: We don't track all backports to stable kernel but just those which are
>> +      stable branch specific (unique), i.e. no commit in mainline. Example of
>> +      commits: c4a23c852e80, cac68d12c531.
>> +
>>   Glibc git commit in a regression test for a glibc bug:
>>   [source,c]
>>   -------------------------------------------------------------------------------
> Any comment on this? I should have marked it as [RFC].
Looks fine.
Acked-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>
> Kind regards,
> Petr
