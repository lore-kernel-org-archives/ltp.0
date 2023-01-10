Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20E4C54EBE
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 08:20:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CB933CCB42
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 09:20:17 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02C833CB576
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 09:20:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 557651A00900
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 09:20:06 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0375722933;
 Tue, 10 Jan 2023 08:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1673338806;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yTrxUWnKlogfA9wbXqBMMJlclPkxxw+mKdzgBJ5rBk0=;
 b=Qbr3p/HWOo5+V7JI/k7dEy5mDj3pNsK3cn0+LjTZrFCdBHdwdxA6ushmLMtNzgb02Yu0P9
 vLfPZpkXtrkuHTQCqkuov6Th2UvBsO8U/xYU1vfYox1PIldUpgCXBt/SQX2OjuvztC0xiQ
 Z9TLH3HGTNfbumoTPgYsG4ym7Vx4CeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1673338806;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yTrxUWnKlogfA9wbXqBMMJlclPkxxw+mKdzgBJ5rBk0=;
 b=YQtynqMsKYOScNSWlSVQQQzpV+0Y1jwBA6YrPh+ZeC41apu+mCgwsZm+QGlOMaLcUOkWR8
 dfcRVJOFvRk6tbCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA66B1358A;
 Tue, 10 Jan 2023 08:20:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JHefM7UfvWMGDgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 10 Jan 2023 08:20:05 +0000
Date: Tue, 10 Jan 2023 09:20:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: coolgw <coolgw1126@gmail.com>
Message-ID: <Y70ftLpcLzdV32O9@pevik>
References: <20230106113126.5304-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230106113126.5304-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add containers/share to PATH when call
 init_ltp_netspace
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

Hi Wei,

There are 2 unrelated changes, they should be separated (in 2 commits).
We are sometimes benevolent on this, if the other change is tiny,
but these are 2 functional changes, they should really be separated.

Also, the subject (first line of the patch) is too long and describe only one
change.

> When run single test case use command such as:
> LTP_SHELL_API_TESTS=shell/net/tst_rhost_run.sh make test-shell
Instead of the description how to run tst_rhost_run.sh
(which now with the PATH can be run simply as
./lib/newlib_tests/shell/net/tst_rhost_run.sh)
more important is to say:
1) LTP shell API tests depend on properly compiled LTP.
Therefore this is just a workaround to make visible that some tool is missing.

2) I wonder if there is way to properly fix this dependency in make.
I guess test-shell target should depend on (at least): ns_create ns_exec
ns_ifmove.

> Error msg such as "ns_create: command not found" will popup, so
> need update PATH before call ns_create etc..

> Signed-off-by: WEI GAO <wegao@suse.com>
> ---
> V2 -> V3: move path to test case itself 
> V1 -> V2: add tst_require_cmds for init_ltp_netspace()

>  lib/newlib_tests/shell/net/tst_rhost_run.sh | 2 +-
>  testcases/lib/tst_net.sh                    | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)

> diff --git a/lib/newlib_tests/shell/net/tst_rhost_run.sh b/lib/newlib_tests/shell/net/tst_rhost_run.sh
> index 773b8dd33..70087aa61 100755
> --- a/lib/newlib_tests/shell/net/tst_rhost_run.sh
> +++ b/lib/newlib_tests/shell/net/tst_rhost_run.sh
> @@ -3,7 +3,7 @@
>  # Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>

>  TST_TESTFUNC=do_test
> -PATH="$(dirname $0)/../../../../testcases/lib/:$PATH"
> +PATH="$(dirname $0)/../../../../testcases/lib/:$(dirname $0)/../../../../testcases/kernel/containers/share/:$PATH"
PATH line will get quite long, I'd use variable for path to root.
It will be also more readable (similar to Makefiles, which have top_srcdir
variable).

root="$(dirname $0)/../../../../"
PATH="$root/testcases/lib/:$root/testcases/kernel/containers/share/:$PATH"

>  export TST_NET_RHOST_RUN_DEBUG=1

> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index ceb45c98d..2849f6bc6 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -128,10 +128,11 @@ tst_net_require_ipv6()

>  init_ltp_netspace()
>  {
> +
Please avoid added extra blank lines like this one.
>  	local pid

Kind regards,
Petr

>  	if [ ! -f /var/run/netns/ltp_ns -a -z "$LTP_NETNS" ]; then
> -		tst_require_cmds ip
> +		tst_require_cmds ip ns_create ns_exec ns_ifmove
>  		tst_require_root

>  		tst_require_drivers veth

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
