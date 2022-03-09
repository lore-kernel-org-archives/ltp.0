Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FD2C433F5
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 13:23:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BF053C698E
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 14:23:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF7D73C0FBC
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 14:23:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 58A3B14010D2
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 14:23:14 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 484471F380;
 Wed,  9 Mar 2022 13:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646832194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6JltHgdTCByOUx6FWWLYdfc3RWCPlSs8+jGMgYdbrvM=;
 b=PMF9icW5hrZrWxympj4STDDJ56OoZeIWyP4Qd9cXNtiR7Llmjb8kFl9mG27TFlxIvmeO5c
 QR7GowGwbQLuLFpz3l6N6YwMjU9vRrm6/96AMQ+cKxAwXE8wcrEeJk6lo7NeTVQhrBzZkg
 s+cNCcFPLbMCBzORQHOgP5A0NeXMBQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646832194;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6JltHgdTCByOUx6FWWLYdfc3RWCPlSs8+jGMgYdbrvM=;
 b=UP9xK1e7u0jOd6yA0jd5W8DF/Eve9EZP56lcElt4SEqBI5K5SpgiWddfeZ4E4rrE2Nk6sS
 O9gcyqhycQFxr4CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25DB413D7A;
 Wed,  9 Mar 2022 13:23:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7pZLCEKqKGJuIAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 09 Mar 2022 13:23:14 +0000
Date: Wed, 9 Mar 2022 14:25:33 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: zhanglianjie <zhanglianjie@uniontech.com>
Message-ID: <YiiqzRFzIr+Zttc8@yuki>
References: <20220304065210.28591-1-zhanglianjie@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220304065210.28591-1-zhanglianjie@uniontech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/clock_settime03: Fix testcases have been
 waiting, timeout failure
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
> If the system enables auto-synchronization time configuration,
> this test case will wait until the timeout. Therefore,
> the automatic synchronization time configuration of the system needs to be turned off in the setup phase.
> 
> message:
> tst_test.c:1457: TINFO: Timeout per run is 0h 05m 00s
> clock_settime03.c:35: TINFO: Testing variant: syscall with old kernel spec
> tst_test.c:1506: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> tst_test.c:1507: TBROK: Test killed! (timeout?)
> 
> Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>
> 
> diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime03.c b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
> index f196a257c..e783f1d3f 100644
> --- a/testcases/kernel/syscalls/clock_settime/clock_settime03.c
> +++ b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
> @@ -14,9 +14,11 @@
> 
>  #define TIMER_DELTA	3
>  #define ALLOWED_DELTA	(50 * 1000) /* 50 ms */
> +#define BUFF_SIZE PATH_MAX
> 
>  static struct tst_ts start, end;
>  static struct tst_its its;
> +static char cmd[BUFF_SIZE];
> 
>  static struct time64_variants variants[] = {
>  #if (__NR_clock_settime != __LTP__NR_INVALID_SYSCALL)
> @@ -31,6 +33,7 @@ static struct time64_variants variants[] = {
>  static void setup(void)
>  {
>  	struct time64_variants *tv = &variants[tst_variant];
> +	int ret;
> 
>  	tst_res(TINFO, "Testing variant: %s", tv->desc);
>  	start.type = end.type = its.type = tv->ts_type;
> @@ -40,6 +43,11 @@ static void setup(void)
>  	    sizeof(start.ts.kern_old_ts.tv_sec) == 4) {
>  		tst_brk(TCONF, "Not Y2038 safe to run test");
>  	}
> +
> +	snprintf(cmd, sizeof(cmd), "timedatectl set-ntp false");

There is no reason to print the command into a temporary buffer.

> +	ret = tst_system(cmd);
> +	if (ret)
> +		tst_brk(TBROK | TST_ERR, "failed to timedatectl set-ntp");

And this is certainly wrong too.

- The TST_ERR is not correct flag to be passed to tst_brk().

- The test must continue even if the timedatectl is not present on the
  system, otherwise the test will be broken on systems without systemd

So at least we shouldn't exit the test if the tst_system() returned
command-not-found.

>  }
> 
>  static void run(void)
> @@ -109,4 +117,8 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.needs_root = 1,
>  	.restore_wallclock = 1,
> +	.needs_cmds = (const char *[]) {
> +		"timedatectl",
> +		NULL
> +	},

And this is wrong too, again the test should be able to run on systems
without systemd.

>  };
> --
> 2.20.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
