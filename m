Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426B0C61DB3
	for <ltp@archiver.kernel.org>; Fri, 13 Jan 2023 09:41:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0FDC3CDC59
	for <ltp@archiver.kernel.org>; Fri, 13 Jan 2023 10:41:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E705A3CB643
 for <ltp@lists.linux.it>; Fri, 13 Jan 2023 10:41:00 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9AAC1200C33
 for <ltp@lists.linux.it>; Fri, 13 Jan 2023 10:40:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ABE3F22209;
 Fri, 13 Jan 2023 09:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1673602858;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ofi/JLxm1Bo2No5svXu8P7fOPAp7q85Cqg2eOkgcNE=;
 b=nkaUhB27XnlbNNNd6YMw+K1PDFTjtgqrgNZu5EhTsZ+eXKsK6PkMcevzz7qROKFY24steS
 +U3G32esa6fdMA9Y/bVSVRw4PjWhE3usDXogqdKpfsRFEZqGkcF056s0MaP9pra/f+DeYR
 WeSGDC8QC4QxFxPSq9NyOfybWfEQ40U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1673602858;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ofi/JLxm1Bo2No5svXu8P7fOPAp7q85Cqg2eOkgcNE=;
 b=ZiKX53E8x5zfgpgiAFEdy2K4fc4qpeh1giGXUscUhj6AVZy4MIYiFrgQJ0gFbDqzRvNR+o
 H6hX5puD44AjQCAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 765A31358A;
 Fri, 13 Jan 2023 09:40:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GVQpGSonwWN4fAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 13 Jan 2023 09:40:58 +0000
Date: Fri, 13 Jan 2023 10:40:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: WEI GAO <wegao@suse.com>
Message-ID: <Y8EnKACJtJJ80uw+@pevik>
References: <20230106113126.5304-1-wegao@suse.com>
 <20230111195231.23596-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230111195231.23596-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Add PATH to tst_rhost_run.sh
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei, all,

> From: coolgw <wegao@suse.com>
NOTE: could you run this command to fix your setup:
git config --global user.name "Wei Gao"

> When run single test case use command such as:
> LTP_SHELL_API_TESTS=shell/net/tst_rhost_run.sh make test-shell
> Error msg such as "ns_create: command not found" will popup, so
> need update PATH before call ns_create etc..

> More important:
> 1) LTP shell API tests depend on properly compiled LTP.
> Therefore this is just a workaround to make visible that some tool is missing.

> 2) I wonder if there is way to properly fix this dependency in make.
> I guess test-shell target should depend on (at least): ns_create ns_exec
> ns_ifmove.

@Li, @Richie, @Xu, @Cyril: anything against moving
testcases/kernel/containers/share/ content to testcases/lib? They are used
mainly for container tests, but since tst_net.sh depends on it, IMHO they should
be in library. This helps to fix make dependency for tst_rhost_run.sh.

Current LTP build system does not allow to add ns_exec as make dependency for
test-shell. Tests depends on lib-all, which does not include testcases/lib,
thus make dependency for tst_rhost_run.sh will not be solved, but at least it
will be on a common place. I wonder if testcases/lib/ could be somehow added as
a dependency to test make target.

---

@Wei I was going to improve the commit message and merged. But there is actually
much better solution for this problem (unless anybody from LTP maintainers is
against it).

Because these helpers are needed also for all LTP shell network tests
(everything which uses tst_net.sh), they should be moved to testcases/lib
directory (whole content of testcases/kernel/containers/share/), where are all
shell helpers.  Files there require to have tst_ prefix (e.g. ns_exec.c =>
tst_ns_exec.c, ...).

This will include to add these names without '.c' suffix to MAKE_TARGETS in
testcases/lib/Makefile and update paths everywhere (e.g runtest/containers,
netns_sysfs.sh, ...). This needs to be in a single commit.

Kind regards,
Petr

> Signed-off-by: WEI GAO <wegao@suse.com>
> ---
> v3 -> v4: update base Vorel's latest comments, remove unrelated change
> V2 -> V3: move path to test case itself 
> V1 -> V2: add tst_require_cmds for init_ltp_netspace()

>  lib/newlib_tests/shell/net/tst_rhost_run.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/lib/newlib_tests/shell/net/tst_rhost_run.sh b/lib/newlib_tests/shell/net/tst_rhost_run.sh
> index 773b8dd33..951551514 100755
> --- a/lib/newlib_tests/shell/net/tst_rhost_run.sh
> +++ b/lib/newlib_tests/shell/net/tst_rhost_run.sh
> @@ -3,7 +3,8 @@
>  # Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>

>  TST_TESTFUNC=do_test
> -PATH="$(dirname $0)/../../../../testcases/lib/:$PATH"
> +root="$(dirname $0)/../../../../"
> +PATH="$root/testcases/lib/:$root/testcases/kernel/containers/share/:$PATH"

>  export TST_NET_RHOST_RUN_DEBUG=1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
