From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Tue, 14 Sep 2021 17:48:41 +0300
Subject: [LTP] [PATCH 1/2] runtest/smoketest: Remove intermittent failed
 test case route4-change-dst
In-Reply-To: <YUCah4R0SBDKZvPQ@pevik>
References: <20210914122425.85129-1-naresh.kamboju@linaro.org>
 <YUCah4R0SBDKZvPQ@pevik>
Message-ID: <e1873210-6d75-703d-f468-c4b826e20d54@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 14.09.2021 15:50, Petr Vorel wrote:
>> The test case route4-change-dst fails intermittently creating
>> the problem for smoketest results verdict. route4-change-dst
>> is a stress test should not be a part of smoketest. because of
>> these issues removing route4-change-dst from the smoketest.
> 
>> Suggested-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
>> Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> 
> Did 75184c30a ("lib/tst_net.sh: disable ipv6_dad work on test interfaces")
> fixed your problem? I'd actually like to route4-change-dst in smoketest to
> have it as a detection DAD issue is working.

75184c30a is fixing ipv6. From the log, it seems the error happens
in ping, when it once again tried to bind to 10.0.0.2 as a source
address (with -I option)...

> 
> Kind regards,
> Petr
> 
>> ---
>>  runtest/smoketest | 1 -
>>  1 file changed, 1 deletion(-)
> 
>> diff --git a/runtest/smoketest b/runtest/smoketest
>> index 7f395936e..dd689bd6f 100644
>> --- a/runtest/smoketest
>> +++ b/runtest/smoketest
>> @@ -12,5 +12,4 @@ stat04 symlink01 -T stat04
>>  utime01A symlink01 -T utime01
>>  rename01A symlink01 -T rename01
>>  splice02 splice02 -s 20
>> -route4-change-dst route-change-dst.sh
>>  shell_test01 echo "SUCCESS" | shell_pipe01.sh
> 

