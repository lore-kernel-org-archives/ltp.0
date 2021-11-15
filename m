Return-Path: <SRS0=J9GY=QC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBAAC433F5
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 09:24:16 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEA296321F
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 09:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AEA296321F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 675983C8157
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 10:24:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B5593C7F5A
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 10:24:05 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B3B956011EA
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 10:24:04 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id E6DEB1FD58;
 Mon, 15 Nov 2021 09:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636968243;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=26zUCO9z1FQVvQvFPfjJhhJMVWWsSIy40BzjJ9JiY9Y=;
 b=Ob/K/sPIVhVUmSE1ldTakiruDmjFZpRO+UIt30GK26uLoUWCm4eCyisUp3f7Dz/t2R06I6
 L5vFnsy/zwlqxhCjyAdNHU3G4wu0eV0gJYi1msU8ewMj05KVB5X2C1nxU7gyE51xrPIwfU
 I3op4Rv/gkiKUDdVC31Tjc3dpAu0APo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636968243;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=26zUCO9z1FQVvQvFPfjJhhJMVWWsSIy40BzjJ9JiY9Y=;
 b=bi69EAv5K+eUt2Kyc+YYsnKXnJS9bJvHQY3ybskkJa8R4IMwN2gjTEkKax7vju5i+q3PpL
 1vAZNgn/jKV32tAQ==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A724AA3B85;
 Mon, 15 Nov 2021 09:24:03 +0000 (UTC)
References: <20210623071543.171021-1-lkml@jv-coder.de>
 <20210623071543.171021-3-lkml@jv-coder.de>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 15 Nov 2021 09:23:56 +0000
In-reply-to: <20210623071543.171021-3-lkml@jv-coder.de>
Message-ID: <87sfvxdb64.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] cpuset_regression_test: Drop min cpu
 requirement
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
> The bug can also be reproduced with only one cpu.
>
> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  .../controllers/cpuset/cpuset_regression_test.sh  | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> index 1dda19704..369fbedae 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
> @@ -27,13 +27,6 @@ old_cpu_exclusive_value=1
>  
>  setup()
>  {
> -	local cpu_num
> -
> -	cpu_num=$(tst_getconf _NPROCESSORS_ONLN)
> -	if [ $cpu_num -lt 2 ]; then
> -		tst_brk TCONF "We need 2 cpus at least to have test"
> -	fi
> -
>  	if ! is_cgroup_subsystem_available_and_enabled "cpuset"; then
>  		tst_brk TCONF "Either kernel does not support cpuset controller or feature not enabled"
>  	fi
> @@ -101,12 +94,12 @@ test()
>  	fi
>  
>  	# This may trigger the kernel crash
> -	echo 0-1 > ${root_cpuset_dir}/testdir/${cpus}
> -	[ $? -ne 0 ] && tst_brk TFAIL "'echo 0-1 > ${root_cpuset_dir}/testdir/${cpus}' failed"
> +	echo 0 > ${root_cpuset_dir}/testdir/${cpus}
> +	[ $? -ne 0 ] && tst_brk TFAIL "'echo 0 > ${root_cpuset_dir}/testdir/${cpus}' failed"
>  
>  	cpus_value=$(cat ${root_cpuset_dir}/testdir/${cpus})
> -	if [ "${cpus_value}" != "0-1" ]; then
> -		tst_brk TFAIL "${cpus} is '${cpus_value}', expected '0-1'"
> +	if [ "${cpus_value}" != "0" ]; then
> +		tst_brk TFAIL "${cpus} is '${cpus_value}', expected '0'"
>  	fi
>  
>  	tst_res TPASS "Bug is not reproducible"


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
