Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F80C433EF
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 10:54:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4515A3C8DFA
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 11:54:48 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43AF63C8D70
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 11:54:39 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8323B1400254
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 11:54:38 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id C6AED1FD58;
 Tue, 23 Nov 2021 10:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637664877;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2DkMOdDbUf95TwmnBicQFE2Zz6JQ20P/sMkuAsfe0ic=;
 b=d4bp3oInJpqkh/hEBczafncNI7DYl5Qg2AN25lWhvzHM9KU24HObFEpNHnFlGfUR2nVBBc
 2C6nrGenMkwn+OuESZizhEt/8HcFQwmm0yW3CXCAi9jqk+12Sguwk1OcKlv+eFJS4B132f
 n9k2rXy3gCTvDIMorjIFMJJk/nNL6sU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637664877;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2DkMOdDbUf95TwmnBicQFE2Zz6JQ20P/sMkuAsfe0ic=;
 b=q0yh+0m2DRHxuXve0SPbe18XhV0e+BuZJmH9/atGvUVA5G6QdcTShPu1PQed7XgtEuiecD
 X9ia2NpbRQ7xB3Bw==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 82940A3B83;
 Tue, 23 Nov 2021 10:54:37 +0000 (UTC)
References: <20211122141355.299621-1-lkml@jv-coder.de> <877dd0m9fq.fsf@suse.de>
 <e4927b0b-6b26-af58-0f7a-3f490c5fbff8@jv-coder.de>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 23 Nov 2021 09:46:21 +0000
In-reply-to: <e4927b0b-6b26-af58-0f7a-3f490c5fbff8@jv-coder.de>
Message-ID: <8735nnm9au.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
Reply-To: rpalethorpe@suse.de
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Joerg,

Joerg Vehlow <lkml@jv-coder.de> writes:

>>> +cpuset_find_breadth_first()
>>> +{
>>> +	local what=$1
>>> +
>>> +	# Breath first find implementation:
>>> +	# Use awk to prepend the length of the path, sort it
>>> +	# and remove the length again.
>>> +	# Since all commands work line-based,
>>> +	# this works with meta characters and spaces.
>>> +	find . -mindepth 2 -name ${what} |
>>> +	    awk '{print length($0) " " $0}' |
>> This is the length of the path in characters. I think you want to count
>> the path components instead. The below is from my system
>>
>> find /sys/fs/cgroup  -type d | awk '{print length($0) " " $0}' | sort -n
>> ...
>> 43 /sys/fs/cgroup/system.slice/wickedd.service
>> 44 /sys/fs/cgroup/sys-fs-fuse-connections.mount
>> ...
>>
>> sys-fs-fuse-connections.mount should come first in a breadth first
>> search.
> Actually it doesn't matter. The only thing, that matters here is that
> parent groups
> are handled before child groups. That is ensured, because the prefix
> of a child group is
> always the parent group and so the child is longer.
> At first I had it named "somewhat breadth-first" ;)
> Counting path components is not a trivial task, because there may be
> escaped slashes.
> Maybe not calling it breadth first, but parent-first would be a
> solution?

Sounds good, +1

>>
>>
>>> +	    sort -n | cut -d " " -f 2-
>>> +}
>>> +
>>> +# cpuset_backup_and_update <backup_dir> <what>
>>>   # Create backup of the values of a specific file (<what>)
>>> -# in all cpuset groups and set the value to <value>
>>> +# in all cpuset groups and set the value to 1
>>>   # The backup is written to <backup_dir> in the same structure
>>>   # as in the cpuset filesystem
>>>   cpuset_backup_and_update()
>>>   {
>>>   	local backup_dir=$1
>>>   	local what=$2
>>> -	local value=$3
>>>   	local old_dir=$PWD
>>> +	local cpu_max=$((cpu_num - 1))
>>> +	local res
>>>     	cd ${root_cpuset_dir}
>>> -	find . -mindepth 2 -name ${what} -print0 |
>>> -	while IFS= read -r -d '' file; do
>>> +
>>> +	# First do breath-first search and set all groups to use all cpus.
>>> +	# Breath-first is important, because the parent groups
>>> +	# must have all cpus assigned to a child group first
>> This is confusing. Inline comments are not encouraged either. IMO the
>> commit message is enough or else you can add a brief explanation of the
>> saving and restore procedure at the top.
> Ok, I thought a bit of documentation why this is done would be a good
> idea, because it is not very obvious.

The main thing is that the comment doesn't make sense to me. In
particular the last sentence. Inline comments are also discouraged in
the style guide.

Also you can handle this depth-first, you just need to lift restrictions
before descending into the tree. So breadth-first is not really
important.

I think it's enough to explain at the top that descendents are bounded
by their ancestors. Then it's down to the reviewer or future developers
to figure out how the shell code handles that.

>
> Joerg


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
