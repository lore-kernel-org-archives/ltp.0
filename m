Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9F8C433F5
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 05:46:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40B783C8DB4
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 06:46:31 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5ABCA3C25EC
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 06:46:20 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0FC891000ED7
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 06:46:19 +0100 (CET)
Received: from [192.168.178.40] (unknown [188.195.115.12])
 by mail.jv-coder.de (Postfix) with ESMTPSA id A139F9F757;
 Tue, 23 Nov 2021 05:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1637646378; bh=/6IKY5+FxlKJnq6TL7ehh1n1V57jOE+QhPrScdforIo=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=hzuMBAZXe85h8yM6kR+sb6KWMOn3vnNbiLMAfX18Prg1hOigCTQNSjyJHXe07hpb+
 9O00+yoN3M4KfgkUk9cMKhZaSp8Yrck4TlgpO6ep/Mntm0vkc3L4bg75hTf7/Yj/If
 4R1CfbeNpOqQ+1J8yy/WpdA8JiYV5GHbL/INvpwI=
Message-ID: <e4927b0b-6b26-af58-0f7a-3f490c5fbff8@jv-coder.de>
Date: Tue, 23 Nov 2021 06:46:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-US
To: rpalethorpe@suse.de
References: <20211122141355.299621-1-lkml@jv-coder.de> <877dd0m9fq.fsf@suse.de>
From: Joerg Vehlow <lkml@jv-coder.de>
In-Reply-To: <877dd0m9fq.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cpuset_regression_test: Fix test,
 if cpuset groups exist already
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richard,

On 11/22/2021 4:09 PM, Richard Palethorpe wrote:
> Hello Joerg,
>
> Joerg Vehlow <lkml@jv-coder.de> writes:
>
>> From: Joerg Vehlow <joerg.vehlow@aox-tech.de>
>>
>> Fix three errors:
>>   1. read -d is not posix, but not even required,
>>      because find and read work  line-based
>>   2. Setting cpuset.cpus to an empty string is not allowed.
>>      -> If there are cpuset groups defined already, we need at least to
>> cpus.
> two* cpus
Right I'll fix it.
>>      One is used for the test, the other one is used for existing groups.
>>   3. Existing cgroup hierarchies were not handled correctly.
>>      When setting  the cpuset.cpus, it must be done breadth-first, otherwise
>>      cpu constraints for parent groups can be violated.
>>
>> Fixes: 6950e96eabb2 ("cpuset_regression_test: Allow running, if groups exist")
>> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
>> ---
>>
>> @Richard Sorry for so many bugs in the patch... I guess I way a bit
>> tired
> I'm not surprised that there are issues saving a restoring these
> settings :-p. OTOH the solution looks OK overall, but please see
> comments below.
Yeah some issues would have been ok, but a total failure not ;)
>
>>
>>   .../cpuset/cpuset_regression_test.sh          | 84 ++++++++++++++++---
>>   1 file changed, 72 insertions(+), 12 deletions(-)
>>
>> diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
>> index cc6bfdc64..f6447a656 100755
>> --- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
>> +++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
>> @@ -21,32 +21,80 @@ TST_MIN_KVER="3.18"
>>   LOCAL_MOUNTPOINT="cpuset_test"
>>   BACKUP_DIRECTORY="cpuset_backup"
>>   
>> +cpu_num=
>>   root_cpuset_dir=
>>   cpu_exclusive="cpuset.cpu_exclusive"
>>   cpus="cpuset.cpus"
>>   old_cpu_exclusive_value=1
>>   
>> -# cpuset_backup_and_update <backup_dir> <what> <value>
>> +# Check if there are cpuset groups
>> +cpuset_has_groups()
>> +{
>> +	local old_dir=$PWD
>> +	local result=0
> Why are these set as local here?
Sorry forgot to delete them
>
>> +
>> +	find ${root_cpuset_dir} -mindepth 1 -type d -exec echo 1 \;
>> -quit
>> +}
>> +
>> +# cpuset_find_breadth_first <what>
>> +# Do a breath first find of <what>
>> +cpuset_find_breadth_first()
>> +{
>> +	local what=$1
>> +
>> +	# Breath first find implementation:
>> +	# Use awk to prepend the length of the path, sort it
>> +	# and remove the length again.
>> +	# Since all commands work line-based,
>> +	# this works with meta characters and spaces.
>> +	find . -mindepth 2 -name ${what} |
>> +	    awk '{print length($0) " " $0}' |
> This is the length of the path in characters. I think you want to count
> the path components instead. The below is from my system
>
> find /sys/fs/cgroup  -type d | awk '{print length($0) " " $0}' | sort -n
> ...
> 43 /sys/fs/cgroup/system.slice/wickedd.service
> 44 /sys/fs/cgroup/sys-fs-fuse-connections.mount
> ...
>
> sys-fs-fuse-connections.mount should come first in a breadth first
> search.
Actually it doesn't matter. The only thing, that matters here is that 
parent groups
are handled before child groups. That is ensured, because the prefix of 
a child group is
always the parent group and so the child is longer.
At first I had it named "somewhat breadth-first" ;)
Counting path components is not a trivial task, because there may be 
escaped slashes.
Maybe not calling it breadth first, but parent-first would be a solution?
>
>
>> +	    sort -n | cut -d " " -f 2-
>> +}
>> +
>> +# cpuset_backup_and_update <backup_dir> <what>
>>   # Create backup of the values of a specific file (<what>)
>> -# in all cpuset groups and set the value to <value>
>> +# in all cpuset groups and set the value to 1
>>   # The backup is written to <backup_dir> in the same structure
>>   # as in the cpuset filesystem
>>   cpuset_backup_and_update()
>>   {
>>   	local backup_dir=$1
>>   	local what=$2
>> -	local value=$3
>>   	local old_dir=$PWD
>> +	local cpu_max=$((cpu_num - 1))
>> +	local res
>>   
>>   	cd ${root_cpuset_dir}
>> -	find . -mindepth 2 -name ${what} -print0 |
>> -	while IFS= read -r -d '' file; do
>> +
>> +	# First do breath-first search and set all groups to use all cpus.
>> +	# Breath-first is important, because the parent groups
>> +	# must have all cpus assigned to a child group first
> This is confusing. Inline comments are not encouraged either. IMO the
> commit message is enough or else you can add a brief explanation of the
> saving and restore procedure at the top.
Ok, I thought a bit of documentation why this is done would be a good 
idea, because it is not very obvious.

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
