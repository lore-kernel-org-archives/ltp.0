From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 09 Mar 2021 15:46:27 +0000
Subject: [LTP] [RFC PATCH v2 5/7] docs: Update CGroups API
In-Reply-To: <YEeMKc9HO9lFv+r7@yuki.lan>
References: <20210302152510.15116-1-rpalethorpe@suse.com>
 <20210302152510.15116-6-rpalethorpe@suse.com> <YEeMKc9HO9lFv+r7@yuki.lan>
Message-ID: <8735x4gwj0.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> +static void setup(void)
>> +{
>> +	tst_cgroup_require(TST_CGROUP_MEMORY, NULL);
>> +	cg = tst_cgroup_get_default();
>> +	SAFE_CGROUP_PRINTF(&cg->cgroup.procs, "%d", getpid());
>> +	SAFE_CGROUP_PRINTF(&cg->memory.max, "%lu", MEMSIZE);
>
> I've been looking at the API for a while and I do not understand why we
> need to create the tst_cgroup_files for each supported controller and
> each node in the hierarchy. Why can't we make this more driver-like? All
> we need to know is the controller type, cgroup version and file we want
> to read/write.
>
> If I were designing the API I would have made these so that they take a
> pointer to a cgroup node, controller type and filename, then the
> printf-like formatting.
>
> So the end result would look like:
>
> 	SAFE_CGROUP_PRINTF(cg, TST_CGROUP_MEMORY, "memory.max", "%lu", MEMSIZE);

If we use V2 naming the controller is always specified in the file
name. So we can just write.

SAFE_CGROUP_PRINTF(cg, "memory.max", ...);

So both you and Li Wang think this is too complex and I wasn't sure, so
I will respin it with a lookup table instead.

>
> Which would be build on the top of:
>
> int tst_cgroup_open(struct tst_cgroup *cg, enum tst_cgroup_ctrl ctrl, const char *fname);
>
> And instead of storing the file structures into the tst_cgroup structure
> we would translate the v2 to v1 on the fly. We would have to open and
> close the files on each printf/scanf but I do not think that it's
> unreasonable given the simplification of the interface.
>
> We would end up with a simple translation tables for different
> controllers instead of the structures that are allocated for each node
> then, such as:
>
> static const struct cgroup_map cgroup_memory_map[] = {
> 	{"memory.usage_in_bytes", "memory.current"},
> 	{"memory.limit_in_bytes", "memory.max"},
> 	{"memory.memsw.usage_in_bytes", "memory.swap.current"},
> 	{"memory.memsw.limitin_bytes", "memory.swap.max"},
> 	{}
> };
>
> Or is there a reason why this cannot be done so?
>
> -- 
> Cyril Hrubis
> chrubis@suse.cz


-- 
Thank you,
Richard.
