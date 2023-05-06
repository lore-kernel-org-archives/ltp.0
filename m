Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E588C77B7F
	for <ltp@archiver.kernel.org>; Sat,  6 May 2023 18:55:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 418BB3CD818
	for <ltp@archiver.kernel.org>; Sat,  6 May 2023 20:55:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9AB23C9BF5
 for <ltp@lists.linux.it>; Sat,  6 May 2023 20:55:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CA78A10004BA
 for <ltp@lists.linux.it>; Sat,  6 May 2023 20:55:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AD52022731;
 Sat,  6 May 2023 18:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683399324;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gb9NGsgzALxaHxtuQmozkFfUkuskCQz/PF1NJq1NVL4=;
 b=VQ5ngD5d8YZHJwk4+tQ8CuOrqFcM0iqoF6+hfMbYUsGBpoRakKl78uwPH2sao9Pq0orTCE
 OP7zGeJCrf/drtjudMmeykN42goXZh3gnZGQH9S6uBLp2KXEe+tkjzDTujP7lq15n1bDJa
 vXWGH8vy93sVq7Ek6077aiT2Jm2wzVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683399324;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gb9NGsgzALxaHxtuQmozkFfUkuskCQz/PF1NJq1NVL4=;
 b=sjDf7A38dWDkC5bj7Eg+9UKp5jmQXtV5izDmSqCI+UPterhXXLfTqq2IMzypki9VbLBXCc
 MIXL3B5eCgaBFKAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56C07134FB;
 Sat,  6 May 2023 18:55:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id o/hiEJyiVmRmJQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sat, 06 May 2023 18:55:24 +0000
Date: Sat, 6 May 2023 20:55:22 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Hao Zeng <zenghao@kylinos.cn>
Message-ID: <20230506185522.GA105601@pevik>
References: <20230506092702.203395-1-zenghao@kylinos.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230506092702.203395-1-zenghao@kylinos.cn>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] testcases:Fix the failure of shell script to
 get path
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Hao,

> For example:
> in the file testcases/kernel/controllers/cpuset/cpuset_funcs.sh,
> if the path is obtained by
> find "$CPUSET" -type d | sort | sed -n '2,$p' | tac | while read subdir,
> the escaped characters will be lost,and by adding the -r option,
> the escaped characters will be kept as they are without escaping
> The errors are as follows:
> /opt/ltp/testcases/bin/cpuset_funcs.sh:line178:
> /dev/cpuset/machine.slice/machine-qemux2d157x2dzhx2dsxf.scope/vcpu7/tasks:
> The file or directory is not available
> rmdir: delete
> '/dev/cpuset/machine.slice/machine-qemux2d157x2dzhx2dsxf.scope/vcpu7'
> Failure: The file or directory is not available
> cpuset_memory_pressure 1 TFAIL: Couldn't remove subdir -
> /opt/ltp/testcases/bin/cpuset_funcs.sh:line178:
> /dev/cpuset/machine.slice/machine-qemux2d157x2dzhx2dsxf.scope/vcpu7/tasks:
> The file or directory is not available
> rmdir: delete
> '/dev/cpuset/machine.slice/machine-qemux2d157x2dzhx2dsxf.scope/vcpu7'
> Failure: The file or directory is not available
> cpuset_memory_pressure 1 TFAIL: Couldn't remove subdir -

> Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
> Suggested-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/controllers/cpuset/cpuset_funcs.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> index 87ba7da1f..0cfa0c17e 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> @@ -184,7 +184,7 @@ cleanup()
>  	echo $CHILDREN_VALUE > $CLONE_CHILDREN
>  	echo $SCHED_LB_VALUE > $SCHED_LB

> -	find "$CPUSET" -type d | sort | sed -n '2,$p' | tac | while read subdir
> +	find "$CPUSET" -type d | sort | sed -n '2,$p' | tac | while read -r subdir

Is it testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh working
without -r ? I'd expect it'd be also needed (it was in your v1 patch [1]).

I only didn't want to take
testcases/open_posix_testsuite/scripts/generate-makefiles.sh because it does not
work with /dev/cpuset/.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/6b2a7ceb.4466.1874a537430.Coremail.crawler2015@163.com/
>  	do
>  		while read pid
>  		do

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
