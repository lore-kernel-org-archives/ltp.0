Return-Path: <SRS0=zuCx=QD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258B5C433EF
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 10:10:06 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 837536187F
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 10:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 837536187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B23F43C875C
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 11:10:03 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 898913C278D
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 11:09:54 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 57ECF6008EA
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 11:09:53 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 92B591FCA1;
 Tue, 16 Nov 2021 10:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637057392;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pI9+P6ekzkh2Z6Us9u9+ClRgcWQzibeCFNkRsJZy958=;
 b=vJcr6EC2MilV4D9/XQDUoS+o2Jo2yQAzf1C4QmfJt/WYuui8HI1WlJpioC2igl2PwyeIM+
 z7iUPDbu0eOJJXP+EsfaqfexSFM9XoU7pvq9rQu6kgwqFCokvKYJNyX88TWZn035B1If/T
 w53wtYYkucB7P81esYtUAHrdSRLEOaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637057392;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pI9+P6ekzkh2Z6Us9u9+ClRgcWQzibeCFNkRsJZy958=;
 b=FDybzcLKCDHJaLQNtQM1omMA8IRZOiXWy63Ujm36nHmJGa6v39v7LwHGc/4kAHcNrlfl9/
 B/mF2hrhejDgNfCg==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 43BC3A3B84;
 Tue, 16 Nov 2021 10:09:52 +0000 (UTC)
References: <20211115182613.38151-1-luke.nowakowskikrijger@canonical.com>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Tue, 16 Nov 2021 10:03:29 +0000
In-reply-to: <20211115182613.38151-1-luke.nowakowskikrijger@canonical.com>
Message-ID: <87h7ccbeds.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] controllers/memcg: update regression tests to
 work under cgroup2
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

> Some tests no longer make sense under cgroup2, while other tests just
> needed to be updated to use new parameters introduced by the cgroup2
> interface.
>
> Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
> ---
>  .../memcg/regression/memcg_regression_test.sh | 41 ++++++++++++++++---
>  .../memcg/regression/memcg_test_1.c           | 12 +++++-
>  .../memcg/regression/memcg_test_3.c           |  8 ++++
>  .../memcg/regression/memcg_test_4.sh          | 18 ++++++--
>  4 files changed, 68 insertions(+), 11 deletions(-)
>
> diff --git a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
> index c91a4069e..ad88d49d1 100755
> --- a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
> +++ b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
> @@ -103,7 +103,12 @@ check_kernel_bug()
>  test_1()
>  {
>  	mkdir memcg/0/
> -	echo 0 > memcg/0/memory.limit_in_bytes
> +
> +	if [ "$cgroup_ver" = "cgroup2" ]; then
> +		echo 0 > memcg/0/memory.max
> +	else
> +		echo 0 > memcg/0/memory.limit_in_bytes
> +	fi
>  
>  	./memcg_test_1
>  
> @@ -124,6 +129,16 @@ test_1()
>  #---------------------------------------------------------------------------
>  test_2()
>  {
> +	# for cgroup2 the default behaivor is to check the new memory limit and
> +	# then to start killing processes if oom. This test then doesen't
> +	# make sense as we don't expect EBUSY to be returned. The shrink
> +	# operation (write to memory.max in cgroup2) would kill the pid1 process
> +	# and exit.
> +	if [ "$cgroup_ver" = "cgroup2" ]; then
> +		tst_resm TCONF "cgroup2 found, skipping test"
> +		return
> +	fi
> +
>  	./memcg_test_2 &
>  	pid1=$!
>  	sleep 1
> @@ -177,12 +192,20 @@ test_2()
>  test_3()
>  {
>  	mkdir memcg/0
> -	for pid in `cat memcg/tasks`; do
> -		echo $pid > memcg/0/tasks 2> /dev/null
> +	if [ "$cgroup_ver" = "cgroup2" ]; then
> +		memcg_procs=memcg/cgroup.procs
> +		memcg_subprocs=memcg/0/cgroup.procs
> +	else
> +		memcg_procs=memcg/tasks
> +		memcg_subprocs=memcg/0/tasks
> +	fi
> +
> +	for pid in `cat $memcg_procs`; do
> +		echo $pid > $memcg_subprocs 2> /dev/null
>  	done
>  
> -	for pid in `cat memcg/0/tasks`; do
> -		echo $pid > memcg/tasks 2> /dev/null
> +	for pid in `cat $memcg_subprocs`; do
> +		echo $pid > $memcg_procs 2> /dev/null
>  	done
>  	rmdir memcg/0
>  
> @@ -218,13 +241,19 @@ test_4()
>  }
>  
>  # main
> +cgroup_ver=$(grep "/sys/fs/cgroup" /proc/mounts | cut -d' ' -f1)
>  failed=0
>  mkdir memcg/
>  
>  for cur in $(seq 1 $TST_TOTAL); do
>  	export TST_COUNT=$cur
>  
> -	mount -t cgroup -o memory xxx memcg/
> +	if [ "$cgroup_ver" = "cgroup2" ]; then
> +		mount -t cgroup2 xxx memcg/
> +	else
> +		mount -t cgroup -o memory xxx memcg/
> +	fi
> +
>  	if [ $? -ne 0 ]; then
>  		tst_resm TFAIL "failed to mount memory subsystem"
>  		failed=1
> diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_1.c b/testcases/kernel/controllers/memcg/regression/memcg_test_1.c
> index c7fb948fe..b9277e633 100644
> --- a/testcases/kernel/controllers/memcg/regression/memcg_test_1.c
> +++ b/testcases/kernel/controllers/memcg/regression/memcg_test_1.c
> @@ -33,6 +33,16 @@
>  
>  #define FORKED_PROC_COUNT	10
>  
> +static int open_cgroup_procs(void)
> +{
> +	int fd = open("memcg/0/tasks", O_WRONLY);
> +	if (fd >= 0)
> +		return fd;
> +
> +	fd = open("memcg/0/cgroup.procs", O_WRONLY);
> +	return fd;
> +}
> +
>  int main(void)
>  {
>  	char buf[10];
> @@ -40,7 +50,7 @@ int main(void)
>  	int loop;
>  	int pid;
>  	int size = getpagesize();
> -	int fd = open("memcg/0/tasks", O_WRONLY);
> +	int fd = open_cgroup_procs();
>  
>  	if (fd < 0)
>  		return 1;
> diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_3.c b/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
> index 75a6e1545..d5531fe87 100644
> --- a/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
> +++ b/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
> @@ -66,6 +66,14 @@ static void setup(void)
>  	SAFE_MKDIR(MNTPOINT, 0644);
>  
>  	ret = mount("memcg", MNTPOINT, "cgroup", 0, "memory");
> +
> +	if (!ret) {
> +		mount_flag = 1;
> +		return;
> +	}
> +
> +	ret = mount("memcg", MNTPOINT, "cgroup2", 0, NULL);
> +
>  	if (ret) {
>  		if (errno == ENOENT)
>  			tst_brk(TCONF | TERRNO, "memcg not supported");
> diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh b/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
> index 620031366..287864b81 100755
> --- a/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
> +++ b/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
> @@ -22,9 +22,19 @@
>  ##                                                                            ##
>  ################################################################################
>  
> +cgroup_ver=$(grep "/sys/fs/cgroup" /proc/mounts | cut -d' ' -f1)

Unfortunately this doesn't work when both V1 and V2 hierarchies are
mounted. You need to check that the memory controller is enabled on
V2. Also it's possible to mount CGroups at alternate locations.

Please see the recent patch from Masayoshi:
https://patchwork.ozlabs.org/project/ltp/patch/20211113041706.12893-1-msys.mizuma@gmail.com/

> +
> +if [ "$cgroup_ver" = 'cgroup2' ]; then
> +	cgroup_proc=cgroup.procs
> +	cgroup_mem_limit=memory.max
> +else
> +	cgroup_proc=tasks
> +	cgroup_mem_limit=memory.limit_in_bytes
> +fi
> +
>  # attach current task to memcg/0/
>  mkdir memcg/0
> -echo $$ > memcg/0/tasks
> +echo $$ > memcg/0/${cgroup_proc}
>  
>  ./memcg_test_4 &
>  pid=$!
> @@ -35,13 +45,13 @@ sleep 1
>  sleep 1
>  
>  # shrink memory, and then 80M will be swapped
> -echo 40M > memcg/0/memory.limit_in_bytes
> +echo 40M > memcg/0/${cgroup_mem_limit}
>  
>  # turn off swap, and swapoff will be killed
>  swapoff -a
>  sleep 1
> -echo $pid > memcg/tasks 2> /dev/null
> -echo $$ > memcg/tasks 2> /dev/null
> +echo $pid > memcg/${cgroup_proc} 2> /dev/null
> +echo $$ > memcg/${cgroup_proc} 2> /dev/null
>  
>  # now remove the cgroup
>  rmdir memcg/0
> -- 
> 2.32.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
