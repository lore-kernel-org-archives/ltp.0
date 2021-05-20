From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 20 May 2021 09:35:35 +0100
Subject: [LTP] [PATCH 4/6] API/cgroups: Add cpu controller
In-Reply-To: <YKT27nlItfECLuYw@yuki>
References: <20210513152125.25766-1-rpalethorpe@suse.com>
 <20210513152125.25766-5-rpalethorpe@suse.com> <YKT27nlItfECLuYw@yuki>
Message-ID: <877djtls4o.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>>  lib/tst_cgroup.c | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>> 
>> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
>> index 54636fd7e..da177a1ad 100644
>> --- a/lib/tst_cgroup.c
>> +++ b/lib/tst_cgroup.c
>> @@ -82,7 +82,8 @@ struct cgroup_root {
>>  /* Controller sub-systems */
>>  enum cgroup_ctrl_indx {
>>  	CTRL_MEMORY = 1,
>> -	CTRL_CPUSET = 2,
>> +	CTRL_CPU,
>> +	CTRL_CPUSET,
>>  };
>>  #define CTRLS_MAX CTRL_CPUSET
>>  
>> @@ -162,6 +163,18 @@ static const files_t memory_ctrl_files = {
>>  	{ }
>>  };
>>  
>> +static const files_t cpu_ctrl_files = {
>> +	/* The V1 quota and period files were combined in the V2 max
>> +	 * file. The quota is in the first column and if we just print
>> +	 * a single value to the file, it will be treated as the
>> +	 * quota. To get or set the period we need to branch on the
>> +	 * API version.
>> +	 */
>
> I wonder if this is worth a helper function, something as:
>
> #define SAFE_CGROUP_CPU_SET_MAX(cg, quota_us, period_us) \
> 	tst_cgroup_cpu_set_max(__FILE__, __LINENO__, cg, quota_us, period_us)
>
> void tst_cgroup_cpu_set_max(const char *const file, const int lineno,
>                             const struct tst_cgroup_group *const cg,
>                             unsigned int quota_us, unsigned int period_us);
>
> #define SAFE_CGROUP_CPU_GET_MAX(cg, quota_us, period_us) \
> 	tst_cgroup_cpu_get_max(__FILE__, __LINENO__, cg, quota_us, period_us)
>
> void tst_cgroup_cpu_get_max(const char *const file, const int lineno,
>                             const struct tst_cgroup_group *const cg,
>                             unsigned int *quota_us, unsigned int *period_us);
>
> I guess that if we are going to add more tests we would end up with such
> functions somewhere anyways.

Yes, when we have more tests. Because there is an alternative that we
add a mapping/filter layer to transform V2 writes into V1 writes. e.g.

SAFE_CGROUP_PRINTF(cg, "cpu.max", "%d %d", "50 100");

When done on V1 it will write to a buffer with sprintf and then split
that into two writes to the V1 files.

This is much more complicated for this case, but there are hundreds of
these knobs. In some cases we just need to convert a string to an
integer e.g. "max" => "-1" or whatever memory.max takes.

In most cases it will just be a case of sprintf into a buffer and then
do something with that.

I can think of problems with both approaches. :-)

-- 
Thank you,
Richard.
