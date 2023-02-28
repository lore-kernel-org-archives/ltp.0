Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD45CC64ED6
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 14:07:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 488603CBA26
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 15:07:00 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 840603CAFCE
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 15:06:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 85776200744
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 15:06:47 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 7BD2E1FDC1;
 Tue, 28 Feb 2023 14:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1677593207;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=np2N1O/6qCsdVk9C6U43n2MD5wDfmXp58MIbhw0qS64=;
 b=fDecB5DSUDVekTlkf5zBmzZHQ7DUm09A5JES5EvS3F+TPqN6fhheXyrHF6HQzFIxzTolkX
 Ayx3U/EPQmnJ5FneRCtTN9M2y5Lu7mjEAvwKHAHW4AHIIflz4MdaelZzllLl/YlhnTdpB/
 qxEejcm3XU3Q1YPOBAY2KRc+7E1miow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1677593207;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=np2N1O/6qCsdVk9C6U43n2MD5wDfmXp58MIbhw0qS64=;
 b=RlsHHCgBJO2zUSJButLB+9kafo0g2IN6Vn/B7tc5cv1vU2a8grXc+i+vRgO4j8NWTCx/mp
 ntYRgyhdLqfJZQCQ==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 2B5A12C141;
 Tue, 28 Feb 2023 14:06:47 +0000 (UTC)
References: <20230215145440.78482-1-teo.coupriediaz@arm.com>
 <20230215145440.78482-2-teo.coupriediaz@arm.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Date: Tue, 28 Feb 2023 13:50:39 +0000
Organization: Linux Private Site
In-reply-to: <20230215145440.78482-2-teo.coupriediaz@arm.com>
Message-ID: <87k001ubnw.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] lib/tst_pid: Find cgroup pid.max
 programmatically
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

Hello,

Teo Couprie Diaz <teo.coupriediaz@arm.com> writes:

> In some distributions, the two files used in lib/tst_pid.c are not
> available, but cgroups still imposes a task limit far smaller than
> the kernel pid_max.
> If the cgroup sysfs is mounted, we can use it to retrieve the current task
> limit imposed to the process. Implement the retrieval of this limit.
>
> This can be done by first checking /proc/self/cgroup to get the cgroup
> the process is in, which will be a path under the cgroup sysfs.
> To get the path to the cgroup sysfs, check /proc/self/mountinfo.
> Finally, concatenate those two paths with pid.max to get the full path
> to the file containing the limit.
>
> This patch changes the way read_session_pids_limit is called, not passing
> a format string to be completed anymore, but is still used the same way.
> A following patch will update this function.
>
> This fixes failures for msgstress04.
>
> Signed-off-by: Teo Couprie Diaz <teo.coupriediaz@arm.com>
> ---
>  lib/tst_pid.c | 53 +++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 43 insertions(+), 10 deletions(-)
>
> diff --git a/lib/tst_pid.c b/lib/tst_pid.c
> index 5595e79bd..3d0be6dcd 100644
> --- a/lib/tst_pid.c
> +++ b/lib/tst_pid.c
> @@ -32,8 +32,6 @@
>  
>  #define PID_MAX_PATH "/proc/sys/kernel/pid_max"
>  #define THREADS_MAX_PATH "/proc/sys/kernel/threads-max"
> -#define CGROUPS_V1_SLICE_FMT "/sys/fs/cgroup/pids/user.slice/user-%d.slice/pids.max"
> -#define CGROUPS_V2_SLICE_FMT "/sys/fs/cgroup/user.slice/user-%d.slice/pids.max"
>  /* Leave some available processes for the OS */
>  #define PIDS_RESERVE 50
>  
> @@ -97,18 +95,53 @@ static int read_session_pids_limit(const char *path_fmt, int uid,
>  
>  static int get_session_pids_limit(void (*cleanup_fn) (void))
>  {
> -	int max_pids, uid;
> +	char path[PATH_MAX + 1];
> +	char cgroup_pids[PATH_MAX + 1];
> +	char catchall;
> +	int uid, ret = 0;
>  
>  	uid = get_session_uid();
> -	max_pids = read_session_pids_limit(CGROUPS_V2_SLICE_FMT, uid, cleanup_fn);
> -	if (max_pids < 0)
> -		max_pids = read_session_pids_limit(CGROUPS_V1_SLICE_FMT, uid,
> -						   cleanup_fn);
> +	/* Check for generic cgroup v1 pid.max */
> +	ret = FILE_LINES_SCANF(cleanup_fn, "/proc/self/cgroup",
> +						   "%*d:pids:%s\n", cgroup_pids);
> +	/*
> +	 * This is a bit of a hack of scanf format strings. Indeed, if all
> +	 * conversion specifications have been matched the return of scanf will be
> +	 * the same whether any outstanding literal characters match or not.
> +	 * As we want to match the literal part, we can add a catchall after it
> +	 * so that it won't be counted if the literal part doesn't match.
> +	 * This makes the macro go to the next line until the catchall, thus
> +	 * the literal parts, is matched.
> +	 *
> +	 * Assume that the root of the mount is '/'. It can be anything,
> +	 * but it should be '/' on any normal system.
> +	 */
> +	if (!ret)
> +		ret = FILE_LINES_SCANF(cleanup_fn, "/proc/self/mountinfo",
> +							   "%*s %*s %*s %*s %s %*[^-] - cgroup %*s %*[rw],pid%c",
> +							   path,
>  	&catchall);

Uhhff, I already implemented this logic in tst_cg_scan in tst_cgroup. In
there we scan the current CGroup hierarchy and build a data structure
which represents it.

I guess you are not aware of tst_cgroup?

> +
> +	if (!ret) {
> +		strncat(path, cgroup_pids, PATH_MAX);
> +		strncat(path, "/pids.max", PATH_MAX);
> +		return read_session_pids_limit(path, uid, cleanup_fn);
> +	}
>  
> -	if (max_pids < 0)
> -		return -1;
> +	/* Check for generic cgroup v2 pid.max */
> +	ret = FILE_LINES_SCANF(cleanup_fn, "/proc/self/cgroup",
> +						   "%*d::%s\n",
> cgroup_pids);

This has not been added to tst_cgroup because usually tests that need a
cgroup feature are moved to a cgroup created by LTP. We also check that
any required CGroups are available and mount them if necessary.

I suppose in this case we do not care if there is no CGroup hierarchy or
the pids controller is absent?

In any case I think tst_cgroup should be used or extended.

> +	if (!ret)
> +		ret = FILE_LINES_SCANF(cleanup_fn, "/proc/self/mountinfo",
> +							   "%*s %*s %*s %*s %s %*[^-] - cgroup2 %c",
> +							   path, &catchall);
> +
> +	if (!ret) {
> +		strncat(path, cgroup_pids, PATH_MAX);
> +		strncat(path, "/pids.max", PATH_MAX);
> +		return read_session_pids_limit(path, uid, cleanup_fn);
> +	}
>  
> -	return max_pids;
> +	return -1;
>  }
>  
>  int tst_get_free_pids_(void (*cleanup_fn) (void))
> -- 
> 2.25.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
