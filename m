Return-Path: <SRS0=J9GY=QC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38D9C433F5
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 09:24:03 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 675E763211
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 09:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 675E763211
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81FF83C817C
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 10:24:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32D3D3C1C46
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 10:23:52 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E470E200923
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 10:23:50 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 2B5662170C;
 Mon, 15 Nov 2021 09:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636968230;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GH/NU0naTwfUBvEoP/4JKiumaGTw/XWiScwWhPqQMp8=;
 b=K1bEvw9EqsJVWilY5bFdRx4EROqLSavK7XtVjLgjiLUlyk7ccN9C83f3RV30a2nHXozbK1
 5jwDpGaA3MiqMIoZt8m46ezSoUv/pqcD8xzGpZAdTX5EmLS8BJMDr8Wc4GE3PIYaL07lsL
 hIb35UIfxuSb5mGnrfjt1PSsxy23h9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636968230;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GH/NU0naTwfUBvEoP/4JKiumaGTw/XWiScwWhPqQMp8=;
 b=HcPGidNq3ZLQmWcdjO/Nd4MMN8O1kst0uDbQ0/Opaa0+Sss5GWmwd8fmoAs1J7i49MTGy/
 Rk1sKB1dOpbWUqCA==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id C32F9A3B83;
 Mon, 15 Nov 2021 09:23:49 +0000 (UTC)
References: <20210623071543.171021-1-lkml@jv-coder.de>
 <20210623071543.171021-2-lkml@jv-coder.de>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 15 Nov 2021 09:23:21 +0000
In-reply-to: <20210623071543.171021-2-lkml@jv-coder.de>
Message-ID: <87wnl9db6i.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] cpuset_regression_test: Convert to new api
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
Cc: ltp@lists.linux.it, Joerg Vehlow <joerg.vehlow@aox-tech.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Joerg Vehlow <lkml@jv-coder.de> writes:

> From: Joerg Vehlow <joerg.vehlow@aox-tech.de>
>
> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

> ---
>  .../cpuset/cpuset_regression_test.sh          | 147 +++++++-----------
>  1 file changed, 56 insertions(+), 91 deletions(-)
>
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> index dccfd91cd..1dda19704 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> @@ -1,82 +1,65 @@
>  #!/bin/sh
> -#
> +# SPDX-License-Identifier: GPL-2.0-or-later
>  # Copyright (c) 2015 Fujitsu Ltd.
>  # Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
>  #
> -# This program is free software; you can redistribute it and/or modify
> -# it under the terms of the GNU General Public License as published by
> -# the Free Software Foundation; either version 2 of the License, or
> -# (at your option) any later version.
> -#
> -# This program is distributed in the hope that it will be useful,
> -# but WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -# GNU General Public License for more details.
> -#
> -# You should have received a copy of the GNU General Public License
> -# along with this program; if not, write to the Free Software
> -# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> -#
>  # This is a regression test for commit:
> -# http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/
> -# ?id=bb2bc55
> +# http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=bb2bc55
>  #
> +# A newly created cpuset group crashed the kernel, if exclusive was set to 1,
> +# before a cpuset was set.
> +
> +TST_SETUP=setup
> +TST_CLEANUP=cleanup
> +TST_TESTFUNC=test
> +TST_NEEDS_ROOT=1
> +TST_NEEDS_TMPDIR=1
> +TST_MIN_KVER="3.18"
> +
> +. cgroup_lib.sh
> +
> +LOCAL_MOUNTPOINT="cpuset_test"
>  
> -TCID=cpuset_regression_test
> -TST_TOTAL=1
> -. test.sh
> +root_cpuset_dir=
> +cpu_exclusive="cpuset.cpu_exclusive"
> +cpus="cpuset.cpus"
> +old_cpu_exclusive_value=1
>  
>  setup()
>  {
> -	tst_require_root
> +	local cpu_num
>  
> -	if tst_kvcmp -lt "3.18"; then
> -		tst_brkm TCONF "Test must be run with kernel 3.18.0 or newer"
> -	fi
> -
> -	local cpu_num=$(tst_getconf _NPROCESSORS_ONLN)
> +	cpu_num=$(tst_getconf _NPROCESSORS_ONLN)
>  	if [ $cpu_num -lt 2 ]; then
> -		tst_brkm TCONF "We need 2 cpus at least to have test"
> +		tst_brk TCONF "We need 2 cpus at least to have test"
>  	fi
>  
> -	tst_tmpdir
> -
> -	TST_CLEANUP=cleanup
> +	if ! is_cgroup_subsystem_available_and_enabled "cpuset"; then
> +		tst_brk TCONF "Either kernel does not support cpuset controller or feature not enabled"
> +	fi
>  
>  	# We need to mount cpuset if it is not found.
> -	mount_flag=0
> -	grep -w cpuset /proc/mounts > tmpfile
> -	if [ $? -eq 0 ]; then
> -		root_cpuset_dir=$(cat tmpfile | awk '{print $2}')
> -	else
> -		root_cpuset_dir="cpuset_test"
> +	root_cpuset_dir=$(get_cgroup_mountpoint cpuset)
> +	if [ -z "$root_cpuset_dir" ]; then
> +		root_cpuset_dir="$LOCAL_MOUNTPOINT"
>  
>  		ROD_SILENT mkdir -p ${root_cpuset_dir}
> -
>  		ROD_SILENT mount -t cpuset cpuset ${root_cpuset_dir}
> -
> -		mount_flag=1
>  	fi
>  
> -	if [ -f ${root_cpuset_dir}/cpuset.cpu_exclusive ]; then
> -		cpu_exclusive=cpuset.cpu_exclusive
> -		cpus=cpuset.cpus
> -	elif [ -f ${root_cpuset_dir}/cpu_exclusive ]; then
> +	if ! [ -f ${root_cpuset_dir}/${cpu_exclusive} ]; then
>  		cpu_exclusive=cpu_exclusive
>  		cpus=cpus
> -	else
> -		tst_brkm TBROK "Both cpuset.cpu_exclusive and cpu_exclusive" \
> -			       "do not exist."
>  	fi
>  
> -	cpu_exclusive_value=$(cat ${root_cpuset_dir}/${cpu_exclusive})
> -	if [ "${cpu_exclusive_value}" != "1" ];then
> +	if ! [ -f ${root_cpuset_dir}/${cpu_exclusive} ]; then
> +		tst_brk TBROK "Both cpuset.cpu_exclusive and cpu_exclusive do not exist"
> +	fi
> +
> +	old_cpu_exclusive_value=$(cat ${root_cpuset_dir}/${cpu_exclusive})
> +	if [ "${old_cpu_exclusive_value}" != "1" ];then
>  		echo 1 > ${root_cpuset_dir}/${cpu_exclusive}
> -		if [ $? -ne 0 ]; then
> -			tst_brkm TBROK "'echo 1 >" \
> -				       "${root_cpuset_dir}/${cpu_exclusive}'" \
> -				       "failed"
> -		fi
> +		[ $? -ne 0 ] && tst_brk TBROK "'echo 1 > ${root_cpuset_dir}/${cpu_exclusive}' failed"
>  	fi
>  }
>  
> @@ -86,65 +69,47 @@ cleanup()
>  		rmdir ${root_cpuset_dir}/testdir
>  	fi
>  
> -	if [ "$cpu_exclusive_value" != 1 ]; then
> -		# Need to flush, or may be output:
> -		# "write error: Device or resource busy"
> +	if [ "$old_cpu_exclusive_value" != 1 ]; then
> +		# Need to flush, or write may fail with: "Device or resource busy"
>  		sync
> -
> -		echo ${cpu_exclusive_value} > \
> -		     ${root_cpuset_dir}/${cpu_exclusive}
> +		echo ${old_cpu_exclusive_value} > ${root_cpuset_dir}/${cpu_exclusive}
>  	fi
>  
> -	if [ "${mount_flag}" = "1" ]; then
> -		umount ${root_cpuset_dir}
> +	if [ -d "$LOCAL_MOUNTPOINT" ]; then
> +		umount ${LOCAL_MOUNTPOINT}
>  		if [ $? -ne 0 ]; then
> -			tst_resm TWARN "'umount ${root_cpuset_dir}' failed"
> +			tst_res TWARN "'umount ${LOCAL_MOUNTPOINT}' failed"
>  		fi
>  
> -		if [ -d "${root_cpuset_dir}" ]; then
> -			rmdir ${root_cpuset_dir}
> -		fi
> +		rmdir ${LOCAL_MOUNTPOINT}
>  	fi
> -
> -	tst_rmdir
>  }
>  
> -cpuset_test()
> +test()
>  {
> +	local cpu_exclusive_tmp cpus_value
> +
>  	ROD_SILENT mkdir ${root_cpuset_dir}/testdir
>  
>  	# Creat an exclusive cpuset.
>  	echo 1 > ${root_cpuset_dir}/testdir/${cpu_exclusive}
> -	if [ $? -ne 0 ]; then
> -		tst_brkm TFAIL "'echo 1 >" \
> -			       "${root_cpuset_dir}/testdir/${cpu_exclusive}'" \
> -			       "failed"
> -	fi
> -
> -	local cpu_exclusive_tmp=$(cat \
> -				  ${root_cpuset_dir}/testdir/${cpu_exclusive})
> +	[ $? -ne 0 ] && tst_brk TFAIL "'echo 1 > ${root_cpuset_dir}/testdir/${cpu_exclusive}' failed"
> +	
> +	cpu_exclusive_tmp=$(cat ${root_cpuset_dir}/testdir/${cpu_exclusive})
>  	if [ "${cpu_exclusive_tmp}" != "1" ]; then
> -		tst_brkm TFAIL "${cpu_exclusive} is '${cpu_exclusive_tmp}'," \
> -			       "expected '1'"
> +		tst_brk TFAIL "${cpu_exclusive} is '${cpu_exclusive_tmp}', expected '1'"
>  	fi
>  
> -	# ${cpus} is empty at the begin, that maybe make the system *crash*.
> +	# This may trigger the kernel crash
>  	echo 0-1 > ${root_cpuset_dir}/testdir/${cpus}
> -	if [ $? -ne 0 ]; then
> -		tst_brkm TFAIL "'echo 0-1 >" \
> -			       "${root_cpuset_dir}/testdir/${cpus}' failed"
> -	fi
> +	[ $? -ne 0 ] && tst_brk TFAIL "'echo 0-1 > ${root_cpuset_dir}/testdir/${cpus}' failed"
>  
> -	local cpus_value=$(cat ${root_cpuset_dir}/testdir/${cpus})
> +	cpus_value=$(cat ${root_cpuset_dir}/testdir/${cpus})
>  	if [ "${cpus_value}" != "0-1" ]; then
> -		tst_brkm TFAIL "${cpus} is '${cpus_value}', expected '0-1'"
> +		tst_brk TFAIL "${cpus} is '${cpus_value}', expected '0-1'"
>  	fi
>  
> -	tst_resm TPASS "Bug is not reproduced"
> +	tst_res TPASS "Bug is not reproducible"
>  }
>  
> -setup
> -
> -cpuset_test
> -
> -tst_exit
> +tst_run
> -- 
> 2.25.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
