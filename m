Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C005FC433F5
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 16:39:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3971B3C8D11
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 17:39:37 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE4593C8C7F
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 17:39:26 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8C9AE2001DA
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 17:39:25 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id B83292113D;
 Mon, 22 Nov 2021 16:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637599164;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rFbgotLDjj2bnWeenCxPQlMM9vE/qyMXJqYvW+mvA9Q=;
 b=YUHiCS7tvM6gv1u1GEukm3EPjTQYqq6HwGuG4L0+MwHC9gvi4fYX3OKsgubwrEwwUr+7qi
 tq8QWVtu296KC2eOLNQ/V7qsMDE2uHp/MFl/jIizsxSL+aHpCOpVJIQgRR8mXCn+Ut+mS9
 gDH2WXzdd89dpMfBRRdwW0a+A1GgSCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637599164;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rFbgotLDjj2bnWeenCxPQlMM9vE/qyMXJqYvW+mvA9Q=;
 b=DRDQexX45rnpdUOh+dM1VeYaeIpIXlbPxKBvqAXrIxYPge+F2L9gmFvbDw6bthgrZ/b7w+
 A5gWu2r19Ak7+6Aw==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 5B986A3B83;
 Mon, 22 Nov 2021 16:39:24 +0000 (UTC)
References: <20211122141355.299621-1-lkml@jv-coder.de>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 22 Nov 2021 15:09:28 +0000
In-reply-to: <20211122141355.299621-1-lkml@jv-coder.de>
Message-ID: <877dd0m9fq.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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

> From: Joerg Vehlow <joerg.vehlow@aox-tech.de>
>
> Fix three errors:
>  1. read -d is not posix, but not even required,
>     because find and read work  line-based
>  2. Setting cpuset.cpus to an empty string is not allowed.
>     -> If there are cpuset groups defined already, we need at least to
> cpus.

two* cpus
>     One is used for the test, the other one is used for existing groups.
>  3. Existing cgroup hierarchies were not handled correctly.
>     When setting  the cpuset.cpus, it must be done breadth-first, otherwise
>     cpu constraints for parent groups can be violated.
>
> Fixes: 6950e96eabb2 ("cpuset_regression_test: Allow running, if groups exist")
> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> ---
>
> @Richard Sorry for so many bugs in the patch... I guess I way a bit
> tired

I'm not surprised that there are issues saving a restoring these
settings :-p. OTOH the solution looks OK overall, but please see
comments below.

>
>
>  .../cpuset/cpuset_regression_test.sh          | 84 ++++++++++++++++---
>  1 file changed, 72 insertions(+), 12 deletions(-)
>
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> index cc6bfdc64..f6447a656 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> @@ -21,32 +21,80 @@ TST_MIN_KVER="3.18"
>  LOCAL_MOUNTPOINT="cpuset_test"
>  BACKUP_DIRECTORY="cpuset_backup"
>  
> +cpu_num=
>  root_cpuset_dir=
>  cpu_exclusive="cpuset.cpu_exclusive"
>  cpus="cpuset.cpus"
>  old_cpu_exclusive_value=1
>  
> -# cpuset_backup_and_update <backup_dir> <what> <value>
> +# Check if there are cpuset groups
> +cpuset_has_groups()
> +{
> +	local old_dir=$PWD
> +	local result=0

Why are these set as local here?

> +
> +	find ${root_cpuset_dir} -mindepth 1 -type d -exec echo 1 \;
> -quit
> +}
> +
> +# cpuset_find_breadth_first <what>
> +# Do a breath first find of <what>
> +cpuset_find_breadth_first()
> +{
> +	local what=$1
> +
> +	# Breath first find implementation:
> +	# Use awk to prepend the length of the path, sort it
> +	# and remove the length again.
> +	# Since all commands work line-based,
> +	# this works with meta characters and spaces.
> +	find . -mindepth 2 -name ${what} | 
> +	    awk '{print length($0) " " $0}' |

This is the length of the path in characters. I think you want to count
the path components instead. The below is from my system

find /sys/fs/cgroup  -type d | awk '{print length($0) " " $0}' | sort -n
...
43 /sys/fs/cgroup/system.slice/wickedd.service
44 /sys/fs/cgroup/sys-fs-fuse-connections.mount
...

sys-fs-fuse-connections.mount should come first in a breadth first
search.


> +	    sort -n | cut -d " " -f 2-
> +}
> +
> +# cpuset_backup_and_update <backup_dir> <what>
>  # Create backup of the values of a specific file (<what>)
> -# in all cpuset groups and set the value to <value>
> +# in all cpuset groups and set the value to 1
>  # The backup is written to <backup_dir> in the same structure
>  # as in the cpuset filesystem
>  cpuset_backup_and_update()
>  {
>  	local backup_dir=$1
>  	local what=$2
> -	local value=$3
>  	local old_dir=$PWD
> +	local cpu_max=$((cpu_num - 1))
> +	local res
>  
>  	cd ${root_cpuset_dir}
> -	find . -mindepth 2 -name ${what} -print0 |
> -	while IFS= read -r -d '' file; do
> +
> +	# First do breath-first search and set all groups to use all cpus.
> +	# Breath-first is important, because the parent groups
> +	# must have all cpus assigned to a child group first

This is confusing. Inline comments are not encouraged either. IMO the
commit message is enough or else you can add a brief explanation of the
saving and restore procedure at the top.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
