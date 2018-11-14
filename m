From: Cristian Marussi <cristian.marussi@arm.com>
Date: Wed, 14 Nov 2018 14:39:14 +0000
Subject: [LTP] [PATCH 1/2] [PATCH] cpuset_hotplug: fix
	cpuset_list_compute
In-Reply-To: <20181114143241.GA23777@rei>
References: <20181114142147.38221-1-cristian.marussi@arm.com>
 <20181114143241.GA23777@rei>
Message-ID: <51ecf07e-0a33-1b9a-62dd-842bb834381e@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

On 14/11/2018 14:32, Cyril Hrubis wrote:
> Hi!
>> cpuset_hotplug failed with:
>>
>> Usage : cpuset_list_compute [-a|s] list1 [list2]
>>
>>          -a|s   list1 add/subtract list2.[default: -a]
>>
>>          -h     Help.
>> cpuset_hotplug 1 TFAIL: root group's cpus isn't expected(Result: 0,2-5, Expect: ).
>>
>> It turned out that helper cpuset_list_compute was always failing because it was
>> improperly handling getopt retval.
> 
> It's working on intel, but I suppose that it overflows on arm since char
> is smaller than int there. It would be a bit better if something along
> these lines was written here. Otherwise the patch itself looks good.
> 

Fine I will add some more explanation.

Thanks

Cristian

>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>>   .../cpuset/cpuset_hotplug_test/cpuset_list_compute.c           | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_list_compute.c b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_list_compute.c
>> index 1b55f4b30..b9f176af4 100644
>> --- a/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_list_compute.c
>> +++ b/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/cpuset_list_compute.c
>> @@ -29,8 +29,7 @@ static void usage(char *prog_name, int status)
>>   
>>   static void checkopt(int argc, char **argv)
>>   {
>> -	char c = '\0';
>> -	int optc = 0;
>> +	int c, optc = 0;
>>   
>>   	while ((c = getopt(argc, argv, "ahs")) != -1) {
>>   		switch (c) {
>> -- 
>> 2.17.1
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> 

