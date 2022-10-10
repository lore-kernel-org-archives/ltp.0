Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87763C433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 09:44:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B92D3CAE80
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 11:44:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37B133CA514
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 11:43:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2ED0B1A0068E
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 11:43:50 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 24968218EF;
 Mon, 10 Oct 2022 09:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665395030;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=98wXng18g3v8oG4JTe1rk6OL4YNqjpRvImbGY5OjhYI=;
 b=BS4X4mxxS7/xNcEHI81IK/B5bzep6p7lybNKR/we/uSSTaYk9qFLTPDGVcGJZT+agWOB0I
 7TLhlkhQDYgNCh25JtMJ/LGZ1FZnH4WoGMixvxULrhO77MRLH96IMsia0U2oxM7riKGgf4
 VUcEkP1L/fd4RfD+Mv5XpFHv355KxI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665395030;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=98wXng18g3v8oG4JTe1rk6OL4YNqjpRvImbGY5OjhYI=;
 b=aHLakzN6uc8bO+sIL3aIJ96fVlXNni9mSvAwwCUCvtK6eNOWoT8MNKBKA/e4aXIBWrmie2
 777WBmNutYoI4/Aw==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 311FE2C142;
 Mon, 10 Oct 2022 09:43:49 +0000 (UTC)
References: <20220310123355.26596-1-zhanglianjie@uniontech.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Lianjie Zhang <zhanglianjie@uniontech.com>
Date: Mon, 10 Oct 2022 10:32:23 +0100
In-reply-to: <20220310123355.26596-1-zhanglianjie@uniontech.com>
Message-ID: <87v8os9fot.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/clock_settime03: Fix testcases have
 been waiting, timeout failure
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

Lianjie Zhang <zhanglianjie@uniontech.com> writes:

> From: zhanglianjie <zhanglianjie@uniontech.com>
>
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
> index f196a257c..ce0e7b4c4 100644
> --- a/testcases/kernel/syscalls/clock_settime/clock_settime03.c
> +++ b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
> @@ -31,6 +31,7 @@ static struct time64_variants variants[] = {
>  static void setup(void)
>  {
>  	struct time64_variants *tv = &variants[tst_variant];
> +	int ret;
>
>  	tst_res(TINFO, "Testing variant: %s", tv->desc);
>  	start.type = end.type = its.type = tv->ts_type;
> @@ -40,6 +41,10 @@ static void setup(void)
>  	    sizeof(start.ts.kern_old_ts.tv_sec) == 4) {
>  		tst_brk(TCONF, "Not Y2038 safe to run test");
>  	}
> +
> +	ret = tst_system("timedatectl set-ntp false");

This still requires that systemd is being used to set the time.

Possibly we could setup a second timer which uses CLOCK_MONOTONIC. If
that expires before the other then we can check if the time was reset to
the present and signal TCONF.

> +	if (ret)
> +		tst_res(TINFO, "failed to timedatectl set-ntp");
>  }
>
>  static void run(void)
> --
> 2.20.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
