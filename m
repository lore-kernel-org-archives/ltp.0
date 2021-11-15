Return-Path: <SRS0=J9GY=QC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14AFC433FE
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 09:24:44 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43AC461B95
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 09:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 43AC461B95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D628F3C814E
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 10:24:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC1D43C7F5A
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 10:24:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 29F371000F59
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 10:24:32 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 939B91FD58;
 Mon, 15 Nov 2021 09:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636968272;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ksul+hVK9qzxM/k8f/OQHZzGqX/N8nzk2k9yLzNRHm8=;
 b=gTeRUTIciNxxDDmcEdGg5sMNMuYJudkRvCK8UqzSodakakM66fF8bNam3L6GJ6eShcI1Ul
 kT3NDlJ1YWaFWosQqV9dRLRkUx5axAVNXzfRo+ktYzEHNCjNXig2BIjNd6wmvIXIXSU5nz
 99LWuU0hdutltsQx3xvN2blxV6O/kUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636968272;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ksul+hVK9qzxM/k8f/OQHZzGqX/N8nzk2k9yLzNRHm8=;
 b=7fzd7fV96FtjKXjXbIXaftMHjOhys3Jgbc9oj4JVyuwwyNNZDsnbWBbJhPL95jI7+/+RNs
 3bnqspgMOeQUSoDA==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4B42AA3B88;
 Mon, 15 Nov 2021 09:24:32 +0000 (UTC)
References: <20210623071543.171021-1-lkml@jv-coder.de>
 <20210623071543.171021-4-lkml@jv-coder.de>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 15 Nov 2021 09:24:14 +0000
In-reply-to: <20210623071543.171021-4-lkml@jv-coder.de>
Message-ID: <87o86ldb5c.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] cpuset_regression_test: Allow running,
 if groups exist
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


Joerg Vehlow <lkml@jv-coder.de> writes:

> From: Joerg Vehlow <joerg.vehlow@aox-tech.de>
>
> Even if groups with a set cpuset.cpus exist, the original bug can still be
> in the kernel. It was possible to create a group, set cpuset.cpus and only
> then set cpuset.cpu_exclusive to 1. This did not trigger the bug.
>
> This patche sets cpuset.cpus for all groups to an empty value, before
> running the test and resets them to their original value after the test.
>
> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

> ---
>  .../cpuset/cpuset_regression_test.sh          | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> index 369fbedae..de1d6e649 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> @@ -19,12 +19,54 @@ TST_MIN_KVER="3.18"
>  . cgroup_lib.sh
>  
>  LOCAL_MOUNTPOINT="cpuset_test"
> +BACKUP_DIRECTORY="cpuset_backup"
>  
>  root_cpuset_dir=
>  cpu_exclusive="cpuset.cpu_exclusive"
>  cpus="cpuset.cpus"
>  old_cpu_exclusive_value=1
>  
> +# cpuset_backup_and_update <backup_dir> <what> <value>
> +# Create backup of the values of a specific file (<what>)
> +# in all cpuset groups and set the value to <value>
> +# The backup is written to <backup_dir> in the same structure
> +# as in the cpuset filesystem
> +cpuset_backup_and_update()
> +{
> +	local backup_dir=$1
> +	local what=$2
> +	local value=$3
> +	local old_dir=$PWD
> +
> +	cd ${root_cpuset_dir}
> +	find . -mindepth 2 -name ${what} -print0 |
> +	while IFS= read -r -d '' file; do
> +		mkdir -p "$(dirname "${backup_dir}/${file}")"
> +		cat "${file}" > "${backup_dir}/${file}"
> +		echo "${value}" > "${file}"
> +	done
> +
> +	cd $old_dir
> +}
> +
> +# cpuset_restore <backup_dir> <what>
> +# Restores the value of a file (<what>) in all cpuset
> +# groups from the backup created by cpuset_backup_and_update
> +cpuset_restore()
> +{
> +	local backup_dir=$1
> +	local what=$2
> +	local old_dir=$PWD
> +
> +	cd ${backup_dir}
> +	find . -mindepth 2 -name ${what} -print0 |
> +	while IFS= read -r -d '' file; do
> +		cat "${file}" > "${root_cpuset_dir}/${file}"
> +	done
> +
> +	cd $old_dir
> +}
> +
>  setup()
>  {
>  	if ! is_cgroup_subsystem_available_and_enabled "cpuset"; then
> @@ -49,6 +91,11 @@ setup()
>  		tst_brk TBROK "Both cpuset.cpu_exclusive and cpu_exclusive do not exist"
>  	fi
>  
> +	# Ensure that no group explicitely uses a cpu,
> +	# otherwise setting cpuset.cpus for the testgroup will fail
> +	mkdir ${BACKUP_DIRECTORY}
> +	cpuset_backup_and_update "${PWD}/${BACKUP_DIRECTORY}" ${cpus} ""
> +
>  	old_cpu_exclusive_value=$(cat ${root_cpuset_dir}/${cpu_exclusive})
>  	if [ "${old_cpu_exclusive_value}" != "1" ];then
>  		echo 1 > ${root_cpuset_dir}/${cpu_exclusive}
> @@ -62,6 +109,10 @@ cleanup()
>  		rmdir ${root_cpuset_dir}/testdir
>  	fi
>  
> +	if [ -d "${BACKUP_DIRECTORY}" ]; then
> +		cpuset_restore "${PWD}/${BACKUP_DIRECTORY}" ${cpus}
> +	fi
> +
>  	if [ "$old_cpu_exclusive_value" != 1 ]; then
>  		# Need to flush, or write may fail with: "Device or resource busy"
>  		sync


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
