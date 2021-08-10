From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 10 Aug 2021 16:45:41 +0200
Subject: [LTP] [PATCH 1/1] doc: Specify linux-stable-git rule
In-Reply-To: <YQq3s+33ceaJmvR7@pevik>
References: <20210715065805.14086-1-pvorel@suse.cz> <YQq3s+33ceaJmvR7@pevik>
Message-ID: <90123400-26a0-706d-7bb4-e4a8e962f669@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 04. 08. 21 17:52, Petr Vorel wrote:
> Hi all,
> 
>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>> ---
>>  doc/c-test-api.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
> 
>> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
>> index 45784195b..9d26a483d 100644
>> --- a/doc/c-test-api.txt
>> +++ b/doc/c-test-api.txt
>> @@ -2205,6 +2205,10 @@ struct tst_test test = {
>>  };
>>  -------------------------------------------------------------------------------
> 
>> +NOTE: We don't track all backports to stable kernel but just those which are
>> +      stable branch specific (unique), i.e. no commit in mainline. Example of
>> +      commits: c4a23c852e80, cac68d12c531.
>> +
>>  Glibc git commit in a regression test for a glibc bug:
>>  [source,c]
>>  -------------------------------------------------------------------------------
> Any comment on this? I should have marked it as [RFC].

Looks good to me.

Acked-by: Martin Doucha <mdoucha@suse.cz>

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
