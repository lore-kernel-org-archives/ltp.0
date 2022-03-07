Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05A5C433F5
	for <ltp@archiver.kernel.org>; Mon,  7 Mar 2022 11:23:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68D613C1BC9
	for <ltp@archiver.kernel.org>; Mon,  7 Mar 2022 12:23:40 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A83DE3C07BD
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 12:23:30 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D21396008AE
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 12:23:29 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 012F0210F4;
 Mon,  7 Mar 2022 11:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646652209;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l+nz98s/Lu4dorb/xuxVhGsoWODuBHrL//Ss8th/DHo=;
 b=AwTXxhulkmc2yHWLD6t4jd13iuizHiqsM1h6gpEe0jcSWkhbFa6h5fAnsvmRXlBEhZ/gCW
 7+RLLmlTUDwoHf4JsihTyQuBWSCbhlqhK6pOS4+WkH+OCNtshktIaHfTt8qpvFAL6XivPu
 Ppu0rsjiMqp5I1mzftfJypBr3DnARbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646652209;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l+nz98s/Lu4dorb/xuxVhGsoWODuBHrL//Ss8th/DHo=;
 b=fLkD1Oq4y5hzAK4P+iUNFh0f5ZZhrImRfQ0vW2/WFaPa+0BK5iA0vFEg49PrzN9v6fWj1+
 Wd2MR3H/wzra1tAQ==
Received: from g78 (unknown [10.163.24.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A21E1A3B81;
 Mon,  7 Mar 2022 11:23:28 +0000 (UTC)
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
 <ef5d94799195f00c6ab1fffe612e62bf1ee530a7.1646434670.git.luke.nowakowskikrijger@canonical.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Mon, 07 Mar 2022 11:00:09 +0000
In-reply-to: <ef5d94799195f00c6ab1fffe612e62bf1ee530a7.1646434670.git.luke.nowakowskikrijger@canonical.com>
Message-ID: <87wnh6m2fp.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 08/16] controllers: Expand cgroup_lib shell
 library
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Luke,

Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com> writes:

> Expand the cgroup_lib library by using the tst_cgctl binary
> utility to make calls to the Cgroup C API to simplify and centralize the
> mounting and cleanup process of Cgroups
>
> Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
> ---
> v2: Add "^" to propery grep the correct mountpoint.
>     Removed is_cgroup_enabled_and_available function and put the check
>     in cgroup_require().
>     Check if /proc/cgroups exists in cgroup_require().
>     Change to TCONF if controllers not available.
> v3: Add copyright.
>     Change awks to grab new config variables.
>     Change version from v2 to just 2 to match config variables.
>
>  testcases/kernel/controllers/cgroup_lib.sh | 129 +++++++++++++++++----
>  1 file changed, 109 insertions(+), 20 deletions(-)
>
> diff --git a/testcases/kernel/controllers/cgroup_lib.sh b/testcases/kernel/controllers/cgroup_lib.sh
> index 7918b5636..ed8549c70 100644
> --- a/testcases/kernel/controllers/cgroup_lib.sh
> +++ b/testcases/kernel/controllers/cgroup_lib.sh
> @@ -2,38 +2,127 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  # Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
>  # Copyright (c) 2018-2019 ARM Ltd. All Rights Reserved.
> +# Copyright (c) 2022 Canonical Ltd.
>  
>  . tst_test.sh
>  
> -# Find mountpoint to given subsystem
> -# get_cgroup_mountpoint SUBSYSTEM
> -# RETURN: 0 if mountpoint found, otherwise 1
> -get_cgroup_mountpoint()
> +_cgroup_state=
> +
> +# Find mountpoint of the given controller
> +# USAGE: cgroup_get_mountpoint CONTROLLER
> +# RETURNS: Prints the mountpoint of the given controller
> +# Must call cgroup_require before calling
> +cgroup_get_mountpoint()
> +{
> +	local ctrl=$1
> +	local mountpoint
> +
> +	[ $# -eq 0 ] && tst_brk TBROK "cgroup_get_mountpoint: controller not defined"
> +	[ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_get_mountpoint: No previous state found. Forgot to call cgroup_require?"
> +
> +	mountpoint=$(echo "$_cgroup_state" | grep -w "^$ctrl" | awk '{ print $4 }')
> +	echo "$mountpoint"
> +
> +	return 0
> +}
> +
> +# Get the test path of a given controller that has been created by the cgroup C API
> +# USAGE: cgroup_get_test_path CONTROLLER
> +# RETURNS: Prints the path to the test direcory
> +# Must call cgroup_require before calling
> +cgroup_get_test_path()
> +{
> +	local ctrl="$1"
> +	local mountpoint
> +	local test_path
> +
> +	[ $# -eq 0 ] && tst_brk TBROK "cgroup_get_test_path: controller not defined"
> +	[ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_get_test_path: No previous state found. Forgot to call cgroup_require?"
> +
> +	mountpoint=$(cgroup_get_mountpoint "$ctrl")
> +
> +	test_path="$mountpoint/ltp/test-$$"
> +
> +	[ ! -e "$test_path" ] && tst_brk TBROK "cgroup_get_test_path: No test path found. Forgot to call cgroup_require?"
> +
> +	echo "$test_path"
> +
> +	return 0
> +}
> +
> +# Gets the cgroup version of the given controller
> +# USAGE: cgroup_get_version CONTROLLER
> +# RETURNS: "1" if version 1 and "2" if version 2
> +# Must call cgroup_require before calling
> +cgroup_get_version()
> +{
> +	local ctrl="$1"
> +	local version
> +
> +	[ $# -eq 0 ] && tst_brk TBROK "cgroup_get_version: controller not defined"
> +	[ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_get_version: No previous state found. Forgot to call cgroup_require?"
> +
> +	version=$(echo "$_cgroup_state" | grep -w "^$ctrl" | awk '{ print $2 }')
> +	[ "$version" = "" ] && tst_brk TBROK "cgroup_get_version: Could not find controller $ctrl"
> +
> +	echo "$version"
> +
> +	return 0
> +}
> +
> +# Cleans up any setup done by calling cgroup_require.
> +# USAGE: cgroup_cleanup
> +# Can be safely called even when no setup has been done
> +cgroup_cleanup()
>  {
> -	local subsystem=$1
> -	local mntpoint
> +	[ "$_cgroup_state" = "" ] && return 0
>  
> -	[ $# -eq 0 ] && tst_brk TBROK "get_cgroup_mountpoint: subsystem not defined"
> +	tst_cgctl cleanup "$_cgroup_state"
>  
> -	mntpoint=$(grep cgroup /proc/mounts | grep -w $subsystem | awk '{ print $2 }')
> -	[ -z "$mntpoint" ] && return 1
> +	_cgroup_state=""
>  
> -	echo $mntpoint
>  	return 0
>  }
>  
> -# Check if given subsystem is supported and enabled
> -# is_cgroup_subsystem_available_and_enabled SUBSYSTEM
> -# RETURN: 0 if subsystem supported and enabled, otherwise 1
> -is_cgroup_subsystem_available_and_enabled()
> +# Get the task list of the given controller
> +# USAGE: cgroup_get_task_list CONTROLLER
> +# RETURNS: prints out "cgroup.procs" if version 2 otherwise "tasks"
> +# Must call cgroup_require before calling
> +cgroup_get_task_list()
>  {
> -	local val
> -	local subsystem=$1
> +	local ctrl="$1"
> +	local version
> +
> +	[ $# -eq 0 ] && tst_brk TBROK "cgroup_get_task_list: controller not defined"
>  
> -	[ $# -eq 0 ] && tst_brk TBROK "is_cgroup_subsystem_available_and_enabled: subsystem not defined"
> +	version=$(cgroup_get_version "$ctrl")
>  
> -	val=$(grep -w $subsystem /proc/cgroups | awk '{ print $4 }')
> -	[ "$val" = "1" ] && return 0
> +	if [ "$version" = "2" ]; then
> +		echo "cgroup.procs"
> +	else
> +		echo "tasks"
> +	fi
>  
> -	return 1
> +	return 0
> +}
> +
> +# Mounts and configures the given controller
> +# USAGE: cgroup_require CONTROLLER
> +cgroup_require()
> +{
> +	local ctrl="$1"
> +	local exists
> +
> +	[ $# -eq 0 ] && tst_brk TBROK "cgroup_require: controller not defined"
> +
> +	[ ! -f /proc/cgroups ] && tst_brk TCONF "Kernel does not support
> control groups"

The tst_cgroup lib can handle this. Also is it guaranteed that
/proc/cgroups exists if cgroups are enabled?

> +
> +	exists=$(grep -w $ctrl /proc/cgroups | awk '{ print $4 }')
> +	[ "$exists" != "1" ] && tst_brk TCONF "cgroup_require:
> Controller not available or not enabled"

For some reason this fails on my VM where no cgroups are mounted
already. Also it's redundant because tst_cgroup should handle it.

> +
> +	_cgroup_state=$(tst_cgctl require "$ctrl" $$)
> +
> +	[ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_require: No state was set after call. Controller '$ctrl' maybe does not exist?"
> +
> +	return 0
>  }


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
