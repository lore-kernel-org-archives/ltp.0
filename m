Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F5EC433EF
	for <ltp@archiver.kernel.org>; Wed, 13 Jul 2022 05:39:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0192A3CA77A
	for <ltp@archiver.kernel.org>; Wed, 13 Jul 2022 07:39:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94DF63CA2FF
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 07:39:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CFF901000A11
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 07:39:40 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 2C9E61FD00
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 05:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657690780;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kwg1u3+Y+pbRPZ3OIYKb8b80llvaewHAZnSURyedUGs=;
 b=vSIeijI6HXmfG6/lAQklmfpLFziscY1ckzE5VLhfn2ibL8oz7D0kZ4hksT5gfbo4f2Fs6W
 3XmHd8WLqvsKfzenwszPnblKOWON80CUQbf5BIRsDO98O/jAb/6TrtsoTAe7AajQsnO3uC
 HuPbll1HgBjE/BDyxdXCY6PUOb2u4ck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657690780;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kwg1u3+Y+pbRPZ3OIYKb8b80llvaewHAZnSURyedUGs=;
 b=B/acP7AVxwuFchebA09EaxVII1C4uQQm/glY38qIv3+xF41Df7OMq7+WJQWBgtgU8YxnUE
 zyTlRTNPSNyKoJCA==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id F0CCD2C141;
 Wed, 13 Jul 2022 05:39:39 +0000 (UTC)
References: <20220712153417.14551-1-akumar@suse.de>
 <20220712153417.14551-5-akumar@suse.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Wed, 13 Jul 2022 06:36:37 +0100
In-reply-to: <20220712153417.14551-5-akumar@suse.de>
Message-ID: <87lesxmuzo.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/9] Rewrite rename04.c using new LTP API
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

Avinesh Kumar <akumar@suse.de> writes:

> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - */
> -void setup(void)
> +static void run(void)
>  {
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	/* Create a temporary directory and make it current. */
> -	tst_tmpdir();
> -
> -	sprintf(fdir, "./tdir_%d", getpid());
> -	sprintf(mdir, "./rndir_%d", getpid());
> -	sprintf(tstfile, "%s/tstfile_%d", mdir, getpid());
> -
> -	/* create "old" directory */
> -	SAFE_MKDIR(cleanup, fdir, 00770);
> -
> -	SAFE_STAT(cleanup, fdir, &buf1);
> -
> -	/* save "old"'s dev and ino */
> -	olddev = buf1.st_dev;
> -	oldino = buf1.st_ino;
> -
> -	/* create another directory */
> -	SAFE_MKDIR(cleanup, mdir, 00770);
> -
> -	SAFE_TOUCH(cleanup, tstfile, 0700, NULL);
> -
> -	SAFE_STAT(cleanup, mdir, &buf2);
> -
> -	/* save "new"'s dev and ino */
> -	olddev1 = buf2.st_dev;
> -	oldino1 = buf2.st_ino;
> +	TEST(rename(DIR1, DIR2));
> +
> +	if (TST_RET == -1 && (TST_ERR == ENOTEMPTY || TST_ERR == EEXIST))
> +		tst_res(TPASS | TERRNO, "rename() failed as expected");

To print TST_ERR you need to use TTERRNO not TERRNO

> +	else if (TST_RET == 0)
> +		tst_res(TFAIL, "rename() succeeded unexpectedly");
> +	else
> +		tst_res(TFAIL | TERRNO, "rename() failed, but not with
> expected errno");

Here as well

With that change:

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
