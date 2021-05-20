From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 20 May 2021 09:40:13 +0100
Subject: [LTP] [PATCH 5/6] API/cgroups: Auto add controllers to
 subtree_control in new subgroup
In-Reply-To: <YKT5ZHrFW0/tCIhu@yuki>
References: <20210513152125.25766-1-rpalethorpe@suse.com>
 <20210513152125.25766-6-rpalethorpe@suse.com> <YKT5ZHrFW0/tCIhu@yuki>
Message-ID: <874kexlrwy.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> -	if (dir->dir_root->ver == TST_CGROUP_V2)
>> +	if (dir->dir_root->ver != TST_CGROUP_V1)
>>  		cg->dirs_by_ctrl[0] = dir;
>
> This change is useless, isn't it?

Hopefully there will be no V3, but if there is it will most likely be a
unified hierarchy like V2.

Maybe this should have been in a seperate patch though?

>
>>  	for_each_ctrl(ctrl) {
>> -		if (has_ctrl(dir->ctrl_field, ctrl))
>> -			cg->dirs_by_ctrl[ctrl->ctrl_indx] = dir;
>> +		if (!has_ctrl(dir->ctrl_field, ctrl))
>> +			continue;
>> +
>> +		cg->dirs_by_ctrl[ctrl->ctrl_indx] = dir;
>> +
>> +		if (!parent || dir->dir_root->ver == TST_CGROUP_V1)
>> +			continue;
>> +
>> +		SAFE_CGROUP_PRINTF(parent, "cgroup.subtree_control",
>> +				   "+%s", ctrl->ctrl_name);
>>  	}
>
> Looks good. Agree that we should copy the controllers from parent here
> for V2.

Yup, as suggested by Li Wang.

>
>>  	for (i = 0; cg->dirs[i]; i++);
>> @@ -876,7 +885,7 @@ tst_cgroup_group_mk(const struct tst_cgroup_group *const parent,
>>  	for_each_dir(parent, 0, dir) {
>>  		new_dir = SAFE_MALLOC(sizeof(*new_dir));
>>  		cgroup_dir_mk(*dir, group_name, new_dir);
>> -		cgroup_group_add_dir(cg, new_dir);
>> +		cgroup_group_add_dir(parent, cg, new_dir);
>>  	}
>>  
>>  	return cg;
>> @@ -1029,7 +1038,7 @@ static struct tst_cgroup_group *cgroup_group_from_roots(const size_t tree_off)
>>  		dir = (typeof(dir))(((char *)root) + tree_off);
>>  
>>  		if (dir->ctrl_field)
>> -			cgroup_group_add_dir(cg, dir);
>> +			cgroup_group_add_dir(NULL, cg, dir);
>>  	}
>>  
>>  	if (cg->dirs[0]) {
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>


-- 
Thank you,
Richard.
