Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5193BC05027
	for <ltp@archiver.kernel.org>; Fri, 20 Jan 2023 14:06:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 558913CD73B
	for <ltp@archiver.kernel.org>; Fri, 20 Jan 2023 15:06:12 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFA483C4D1C
 for <ltp@lists.linux.it>; Fri, 20 Jan 2023 15:06:02 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3D7C6600F90
 for <ltp@lists.linux.it>; Fri, 20 Jan 2023 15:06:01 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 7D9F35FA78
 for <ltp@lists.linux.it>; Fri, 20 Jan 2023 14:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1674223561;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EU7Cqa0XhiC1ohQQPcbpFZ8g9m8W2NmzZBUenNOSRyc=;
 b=gROfguEDj4eJhwAsARCyoB00+Fi/F4RZ5Z5zRcyi/XLC9Knsq8E83ebVfMSMj/C5XzTqYI
 i+7C0Du4K6B9eGuiPvw+/cwfQOmIgXSFD4LMpZDeWE3d5rgy5wA60ATPepr9LDVf/ylX0r
 0UAgLyZI6UV1TCo+ZneKxfqkA7FQ1oA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1674223561;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EU7Cqa0XhiC1ohQQPcbpFZ8g9m8W2NmzZBUenNOSRyc=;
 b=Y0pAC+fIeJpPUbTlgrChzokMBieag95LXEGpeNgUWYK50WwRv5OS27fUw0aSVQMRSx4sbd
 P8XwAjcpjzz2I5Aw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 52F022C141;
 Fri, 20 Jan 2023 14:06:01 +0000 (UTC)
References: <20230117181657.20932-1-pvorel@suse.cz>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 20 Jan 2023 14:05:53 +0000
Organization: Linux Private Site
In-reply-to: <20230117181657.20932-1-pvorel@suse.cz>
Message-ID: <873585s3lj.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] containers: Remove setns_check
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


Petr Vorel <pvorel@suse.cz> writes:

> setns_check.c was used to verify __NR_setns support.
> It was added in Linux 3.0 and SYSCALL_DEFINE2(setns, int, fd, int,
> flags) is not guarded by any configuration variable.
>
> => safe to remove the helper.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

> ---
>  doc/namespaces-helper-tools.txt               |  2 --
>  .../kernel/containers/netns/netns_lib.sh      |  3 --
>  .../kernel/containers/netns/netns_sysfs.sh    |  5 ---
>  testcases/kernel/containers/share/.gitignore  |  1 -
>  .../kernel/containers/share/setns_check.c     | 32 -------------------
>  5 files changed, 43 deletions(-)
>  delete mode 100644 testcases/kernel/containers/share/setns_check.c
>
> diff --git a/doc/namespaces-helper-tools.txt b/doc/namespaces-helper-tools.txt
> index 6990e0155a..81eec4d6ca 100644
> --- a/doc/namespaces-helper-tools.txt
> +++ b/doc/namespaces-helper-tools.txt
> @@ -14,8 +14,6 @@ located in ltp/testcases/kernel/containers/share directory and include:
>  ** PID of the daemonized child process is printed on the stdout
>  ** the new namespace(s) is(are) maintained by the daemonized child process
>  ** namespace(s) can be removed by killing the daemonized process
> -* setns_check
> -** check for setns() availability, should be called before using ns_exec
>  * ns_exec
>  ** enters the namespace(s) of a process specified by a PID
>  ** then executes the indicated program inside that namespace(s)
> diff --git a/testcases/kernel/containers/netns/netns_lib.sh b/testcases/kernel/containers/netns/netns_lib.sh
> index 79e90336a8..039631e9f6 100755
> --- a/testcases/kernel/containers/netns/netns_lib.sh
> +++ b/testcases/kernel/containers/netns/netns_lib.sh
> @@ -72,9 +72,6 @@ netns_setup()
>  	if [ "$NS_EXEC" = "ip" ]; then
>  		netns_ip_setup
>  	else
> -		setns_check
> -		[ $? -eq 32 ] && tst_brk TCONF "setns not supported"
> -
>  		NS_TYPE="net"
>  		netns_ns_exec_setup
>  	fi
> diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
> index 1792427210..34ef3b8eef 100755
> --- a/testcases/kernel/containers/netns/netns_sysfs.sh
> +++ b/testcases/kernel/containers/netns/netns_sysfs.sh
> @@ -18,11 +18,6 @@ do_setup()
>  	DUMMYDEV_HOST="dummy_test0"
>  	DUMMYDEV="dummy_test1"
>  
> -	setns_check
> -	if [ $? -eq 32 ]; then
> -		tst_brk TCONF "setns not supported"
> -	fi
> -
>  	NS_HANDLE=$(ns_create $NS_TYPE)
>  	if [ $? -eq 1 ]; then
>  		tst_res TINFO "$NS_HANDLE"
> diff --git a/testcases/kernel/containers/share/.gitignore b/testcases/kernel/containers/share/.gitignore
> index 06615d9ea2..0d5ecf069d 100644
> --- a/testcases/kernel/containers/share/.gitignore
> +++ b/testcases/kernel/containers/share/.gitignore
> @@ -1,4 +1,3 @@
>  /ns_ifmove
>  /ns_create
>  /ns_exec
> -/setns_check
> diff --git a/testcases/kernel/containers/share/setns_check.c b/testcases/kernel/containers/share/setns_check.c
> deleted file mode 100644
> index 75aad17f3a..0000000000
> --- a/testcases/kernel/containers/share/setns_check.c
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -/* Copyright (c) 2015 Fujitsu Ltd.
> - * Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> - *
> - * This program is free software: you can redistribute it and/or modify
> - * it under the terms of version 2 the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> - *
> - ***********************************************************************
> - * Check for setns() availability, should be called before ns_exec.
> - *
> - */
> -
> -#include "test.h"
> -#include "lapi/syscalls.h"
> -
> -char *TCID = "setns_check";
> -
> -int main(void)
> -{
> -	if (syscall(__NR_setns, -1, 0) == -1 && errno == ENOSYS)
> -		tst_brkm(TCONF, NULL, "setns is not supported in the kernel");
> -	else
> -		return 0;
> -}
> -- 
> 2.39.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
