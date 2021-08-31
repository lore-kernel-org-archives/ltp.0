From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 31 Aug 2021 11:26:11 +0200
Subject: [LTP] [PATCH 1/2] cfs_bandwidth01: Fix cleanup on failure in
 set_cpu_quota
In-Reply-To: <87eeaakm4y.fsf@suse.de>
References: <20210831090002.1431298-1-lkml@jv-coder.de>
 <87eeaakm4y.fsf@suse.de>
Message-ID: <2278cad7-66ab-d014-ca2b-ab3081f1284d@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

On 8/31/2021 11:18 AM, Richard Palethorpe wrote:
> Hello Joerg,
>
> Joerg Vehlow <lkml@jv-coder.de> writes:
>
>> From: Joerg Vehlow <joerg.vehlow@aox-tech.de>
>>
>> If set_cpu_quota failed, mk_cpu_cgroup did not return
>> and cg_workers[n] was not set. This lead to a failure during
>> cleanup, because the worker cgroups were not deleted.
>>
>> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
>> ---
>>   .../sched/cfs-scheduler/cfs_bandwidth01.c       | 17 +++++++----------
>>   1 file changed, 7 insertions(+), 10 deletions(-)
>>
>> diff --git a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
>> index 9301ee458..e8032d65a 100644
>> --- a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
>> +++ b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
>> @@ -57,17 +57,14 @@ static void set_cpu_quota(const struct tst_cgroup_group *const cg,
>>   		tst_cgroup_group_name(cg), quota_us, period_us);
>>   }
>>   
>> -static struct tst_cgroup_group *
>> -mk_cpu_cgroup(const struct tst_cgroup_group *const cg_parent,
>> +static void mk_cpu_cgroup(struct tst_cgroup_group **cg,
>> +          const struct tst_cgroup_group *const cg_parent,
> Seems like there are spaces instead of a tab at the start.
Right, I wanted to keep the same format you had, but did not realize it 
was one tab and 5 spaces instead of 9 spaces.
I guess this can be fixed during merging.

>
> Otherwise LGTM, thanks.
>
> Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
Thanks

Joerg

