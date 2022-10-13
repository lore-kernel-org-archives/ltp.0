Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD44C433FE
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 07:41:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 851C83CAED2
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 09:41:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF6D83CA9C7
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 09:41:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 83F54600D21
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 09:41:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BDE521F38A;
 Thu, 13 Oct 2022 07:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665646898;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kt548TUKVXVMb/Ob5Gm8YteplvYMwfIcRq8yJDxckEg=;
 b=JQJ5c0eK4uMce8fk5ciR9QccGuxP8iZi1xW/0WS4WjuKtCHI5FeJenFxgautBU0HY6+GlI
 7AKnEmnCagGgsHoXRgFYRm0zX++GUV/sgqMH2KdeucGH1da2f8sfsLlobKcBWWiuaOM+pE
 jruKKy/6Mxw52B66juzuTUdlpwNHpUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665646898;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kt548TUKVXVMb/Ob5Gm8YteplvYMwfIcRq8yJDxckEg=;
 b=nXRf8Eu2jTaAwAvaeTyAGIC/n4O4LVTkF0BbXNXTQmWdNf6SBOMWgsXvNmEA9A41D9PGzh
 hDb8CmPq2FkB0TAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 857CE139F3;
 Thu, 13 Oct 2022 07:41:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id e9eYHjLBR2MkTgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 13 Oct 2022 07:41:38 +0000
Date: Thu, 13 Oct 2022 09:41:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Message-ID: <Y0fBMGxUQpZhz0AE@pevik>
References: <20221012091526.35373-1-zhaogongyi@huawei.com>
 <20221012091526.35373-3-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221012091526.35373-3-zhaogongyi@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] needs_root: Add setting of needs_root
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

Hi Zhao,

> Add setting of  needs_root, otherwise run the test without root
> will fail and report EACCESS or EPERM.
...
>  testcases/kernel/syscalls/bind/bind06.c                       | 1 +
>  testcases/kernel/syscalls/cma/process_vm_readv02.c            | 1 +
>  testcases/kernel/syscalls/cma/process_vm_readv03.c            | 1 +
>  testcases/kernel/syscalls/cma/process_vm_writev02.c           | 1 +
>  testcases/kernel/syscalls/copy_file_range/copy_file_range01.c | 1 +
>  testcases/kernel/syscalls/ipc/msgget/msgget03.c               | 1 +
>  testcases/kernel/syscalls/preadv/preadv03.c                   | 1 +
>  testcases/kernel/syscalls/pwritev/pwritev03.c                 | 1 +
>  testcases/kernel/syscalls/sendto/sendto03.c                   | 1 +
>  testcases/kernel/syscalls/setsockopt/setsockopt05.c           | 1 +
>  testcases/kernel/syscalls/setsockopt/setsockopt06.c           | 1 +
>  testcases/kernel/syscalls/setsockopt/setsockopt07.c           | 1 +
>  testcases/kernel/syscalls/setsockopt/setsockopt08.c           | 1 +
>  testcases/kernel/syscalls/setsockopt/setsockopt09.c           | 1 +
>  testcases/kernel/syscalls/swapon/swapon01.c                   | 1 +
>  15 files changed, 15 insertions(+)
...
> +++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> @@ -72,6 +72,7 @@ static void cleanup(void)

>  static struct tst_test test = {
>  	.needs_tmpdir = 1,
> +	.needs_root = 1,
>  	.setup = setup,
>  	.cleanup = cleanup,
>  	.test_all = verify_msgget,

At least this one is working without root:

$ ./testcases/kernel/syscalls/ipc/msgget/msgget03
tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
msgget03.c:41: TINFO: Current environment 0 message queues are already in use
msgget03.c:55: TINFO: The maximum number of message queues (32000) reached
msgget03.c:30: TPASS: msgget(1629588886, 1536) : ENOSPC (28)

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
