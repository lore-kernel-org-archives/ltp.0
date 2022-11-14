Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED711C4332F
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 11:35:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E22633CD22E
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 12:35:23 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B7C93C2306
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 12:35:13 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3456360004C
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 12:35:12 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 710662286B;
 Mon, 14 Nov 2022 11:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668425712;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qpNuiAybYuTz/wkmyeHzbLUo+xM9Dq0aMS20HG6fxk8=;
 b=v3u6Fd6lnPbojRkNaafjchLeUnjqguP6urQsXOj94AcLO049oPh1Gh+jXIVCpZFul/BIEI
 9cmJiv0TmwiFKhm8ogJNbdEr8DW6gM90Ww4b9jcgSCIqd8g2ziIOpNqUHjc2xAKXxn7XYb
 GGEw6R9qUZfm/dbIqC5bKVHuL3fwRk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668425712;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qpNuiAybYuTz/wkmyeHzbLUo+xM9Dq0aMS20HG6fxk8=;
 b=8cbuFtOFOo9EmU/3M4oa7Tx7WnHa8BiDYsKmbPCwfWiQW26zk5Sh4REJVVEPmAzLIZVL3I
 qXKLK/MUdNCOclCw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3C4D22C141;
 Mon, 14 Nov 2022 11:35:12 +0000 (UTC)
References: <20221101112621.20031-1-rpalethorpe@suse.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: ltp@lists.linux.it
Date: Mon, 14 Nov 2022 11:34:22 +0000
Organization: Linux Private Site
In-reply-to: <20221101112621.20031-1-rpalethorpe@suse.com>
Message-ID: <87bkp9u5u8.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pidns12: Avoid write in sig handler
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Richard Palethorpe <rpalethorpe@suse.com> writes:

> It is best to avoid doing any kind of unecessary work in a signal
> handler.

No review after 2 weeks. Merged!

>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Cc: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/containers/pidns/pidns12.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/containers/pidns/pidns12.c b/testcases/kernel/containers/pidns/pidns12.c
> index 65e2a0836..0e6b17142 100644
> --- a/testcases/kernel/containers/pidns/pidns12.c
> +++ b/testcases/kernel/containers/pidns/pidns12.c
> @@ -18,9 +18,11 @@
>  #include "tst_test.h"
>  #include "lapi/namespaces_constants.h"
>  
> +static volatile pid_t sig_pid = -1;
> +
>  static void child_signal_handler(LTP_ATTRIBUTE_UNUSED int sig, siginfo_t *si, LTP_ATTRIBUTE_UNUSED void *unused)
>  {
> -	TST_EXP_EQ_LI(si->si_pid, 0);
> +	sig_pid = si->si_pid;
>  }
>  
>  static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
> @@ -38,6 +40,8 @@ static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
>  
>  	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>  
> +	TST_EXP_EQ_LI(sig_pid, 0);
> +
>  	return 0;
>  }


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
