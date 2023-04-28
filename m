Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3434C77B61
	for <ltp@archiver.kernel.org>; Fri, 28 Apr 2023 13:06:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96D0C3CBA5D
	for <ltp@archiver.kernel.org>; Fri, 28 Apr 2023 15:06:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F04783CBA25
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 15:06:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4FBAB1A003EC
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 15:06:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9C68421B40;
 Fri, 28 Apr 2023 13:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682687175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VWy69ovS00ypTNvLoesyfBAcRF7OGjVIPTSfNopHiB4=;
 b=mJjeUNFYL1jgsiIuMuHyfakFrpHDw7XyRegJcodo7zuqoIKuz8I2iwBhMF58qBwRC/VeLM
 +hToN/qfXcsmiiOMFmFfIYHsNlHHksO1YVOSdFo1Ry9CI5T69QpJf3FTC/NP0HJtKMt+yp
 HqkRzAXKG7W8xWi3jTRXwqfq4z3KrZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682687175;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VWy69ovS00ypTNvLoesyfBAcRF7OGjVIPTSfNopHiB4=;
 b=0sZSjKwWNAPeXWhaTaiR+BWjgqEiVgQtapIG4EdiNFKs5ik5nHjeNMCwg7LmrI5QegmdCE
 PKU+uB9zluUkMzCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89915138FA;
 Fri, 28 Apr 2023 13:06:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZddwIMfES2QVEQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 28 Apr 2023 13:06:15 +0000
Date: Fri, 28 Apr 2023 15:07:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZEvFCTEO1mAxN5tB@yuki>
References: <20230314134242.9203-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230314134242.9203-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Remove ltp_clone_quick usage from pidns suite
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/testcases/kernel/containers/pidns/pidns02.c b/testcases/kernel/containers/pidns/pidns02.c
> index b8913d3f6..5372aeef9 100644
> --- a/testcases/kernel/containers/pidns/pidns02.c
> +++ b/testcases/kernel/containers/pidns/pidns02.c
> @@ -7,7 +7,7 @@
>  /*\
>   * [Description]
>   *
> - * Clone a process with CLONE_NEWNS flag and check:
> + * Clone a process with CLONE_NEWPID flag and check:
>   *
>   * - child session ID must be 1
>   * - parent process group ID must be 1
> @@ -16,29 +16,35 @@
>  #include "tst_test.h"
>  #include "lapi/sched.h"
>  
> -static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
> +static void child_func(void)
>  {
>  	pid_t sid, pgid;
>  
> +	SAFE_SETSID();

Can we please avoid the setsid() here? Once we do that we do not
actually test that the sid and pgid are initialized to something
meaningful. It makes much more sense to check if sid and pgid are 0,
since init process has no parent and ppid is 0 then also the sid and
pgid may make sense to be initialized to 0 since they are "inherited"
from nonexistent parent.

Or we can as well do:

	TST_EXP_EQ_LI(getsid(0), 0);
	TST_EXP_EQ_LI(getpgid(0), 0);

	tst_res(TINFO, "setsid()");
	SAFE_SETSID();

	TST_EXP_EQ_LI(getsid(0), 1);
	TST_EXP_EQ_LI(getpgid(0), 1);

That way we check both the initial values and that setsid works as
expected.

The rest looks good. With the pidns02.c fixed:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
